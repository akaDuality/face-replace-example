import SwiftUI

/// The playable screen: a wide scrolling scene with holes on top and a
/// tray of draggable items at the bottom.
struct GameView: View {
    let story: Story

    @Environment(\.dismiss) private var dismiss

    /// Hole ids that have been correctly filled.
    @State private var filledHoleIDs: Set<String> = []
    /// Live frames of every hole in the shared "game" coordinate space.
    @State private var holeFrames: [String: CGRect] = [:]

    /// The item currently being dragged, and where the finger is.
    @State private var draggingItem: StoryItem?
    @State private var dragLocation: CGPoint = .zero

    /// A hole that briefly shakes red when the wrong item is dropped on it.
    @State private var wrongHoleID: String?

    @State private var showCelebration = false

    private var placedItemIDs: Set<String> {
        Set(story.holes.filter { filledHoleIDs.contains($0.id) }.map(\.acceptsItemID))
    }

    private var trayItems: [StoryItem] {
        story.items.filter { !placedItemIDs.contains($0.id) }
    }

    var body: some View {
        ZStack {
            Color(red: 0.97, green: 0.97, blue: 1.0).ignoresSafeArea()

            VStack(spacing: 0) {
                topBar
                sceneArea
                trayArea
            }

            // The piece that follows the child's finger.
            if let item = draggingItem {
                ItemChipView(item: item)
                    .scaleEffect(1.15)
                    .position(dragLocation)
                    .allowsHitTesting(false)
            }

            if showCelebration {
                celebrationOverlay
            }
        }
        .coordinateSpace(name: "game")
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .onPreferenceChange(HoleFramePreferenceKey.self) { holeFrames = $0 }
    }

    // MARK: - Top bar

    private var topBar: some View {
        HStack {
            Button {
                SpeechManager.shared.stop()
                dismiss()
            } label: {
                Image(systemName: "chevron.left.circle.fill")
                    .font(.system(size: 34))
                    .foregroundStyle(.tint)
            }

            Spacer()

            Text(story.title)
                .font(.system(size: 24, weight: .heavy, design: .rounded))

            Spacer()

            Button {
                resetStory()
            } label: {
                Image(systemName: "arrow.counterclockwise.circle.fill")
                    .font(.system(size: 34))
                    .foregroundStyle(.tint)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }

    // MARK: - Scrolling scene with holes

    private var sceneArea: some View {
        GeometryReader { outer in
            let sceneHeight = outer.size.height
            let sceneWidth = outer.size.width * story.widthFactor

            ScrollView(.horizontal, showsIndicators: false) {
                ZStack(alignment: .topLeading) {
                    SceneBackdropView(backdrop: story.backdrop)
                        .frame(width: sceneWidth, height: sceneHeight)

                    ForEach(story.holes) { hole in
                        HoleView(
                            hole: hole,
                            hintEmoji: emoji(forItemID: hole.acceptsItemID),
                            isFilled: filledHoleIDs.contains(hole.id),
                            isWrong: wrongHoleID == hole.id
                        )
                        .position(
                            x: hole.position.x * sceneWidth,
                            y: hole.position.y * sceneHeight
                        )
                    }
                }
                .frame(width: sceneWidth, height: sceneHeight)
            }
        }
    }

    // MARK: - Item tray

    private var trayArea: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(trayItems) { item in
                    ItemChipView(item: item, isGhost: draggingItem?.id == item.id)
                        .gesture(dragGesture(for: item))
                }
                if trayItems.isEmpty {
                    Text("All done! 🎉")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(.secondary)
                        .frame(height: 92)
                }
            }
            .padding(.horizontal, 20)
        }
        .frame(height: 116)
        .background(.white.opacity(0.6))
    }

    // MARK: - Drag handling

    private func dragGesture(for item: StoryItem) -> some Gesture {
        DragGesture(coordinateSpace: .named("game"))
            .onChanged { value in
                if draggingItem?.id != item.id {
                    draggingItem = item
                    SpeechManager.shared.speakName(item.name)
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
                dragLocation = value.location
            }
            .onEnded { value in
                handleDrop(of: item, at: value.location)
                draggingItem = nil
            }
    }

    private func handleDrop(of item: StoryItem, at location: CGPoint) {
        // Find the closest hole within a comfortable radius.
        let target = story.holes
            .filter { !filledHoleIDs.contains($0.id) }
            .compactMap { hole -> (Hole, CGFloat)? in
                guard let frame = holeFrames[hole.id] else { return nil }
                let center = CGPoint(x: frame.midX, y: frame.midY)
                let distance = hypot(center.x - location.x, center.y - location.y)
                return distance < 80 ? (hole, distance) : nil
            }
            .min { $0.1 < $1.1 }?
            .0

        guard let hole = target else { return }

        if hole.acceptsItemID == item.id {
            withAnimation { _ = filledHoleIDs.insert(hole.id) }
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            SpeechManager.shared.speakSentence(hole.sentence)
            checkForCompletion()
        } else {
            // Wrong spot: a gentle red nudge, no scolding.
            wrongHoleID = hole.id
            UINotificationFeedbackGenerator().notificationOccurred(.error)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if wrongHoleID == hole.id { wrongHoleID = nil }
            }
        }
    }

    private func checkForCompletion() {
        guard filledHoleIDs.count == story.holes.count else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
            SpeechManager.shared.speakSentence(story.endingSentence)
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                showCelebration = true
            }
        }
    }

    private func resetStory() {
        SpeechManager.shared.stop()
        withAnimation {
            filledHoleIDs.removeAll()
            showCelebration = false
        }
    }

    private func emoji(forItemID id: String) -> String {
        story.items.first { $0.id == id }?.emoji ?? "❓"
    }

    // MARK: - Celebration

    private var celebrationOverlay: some View {
        ZStack {
            Color.black.opacity(0.45).ignoresSafeArea()

            VStack(spacing: 24) {
                Text(story.emoji)
                    .font(.system(size: 96))
                Text("The End!")
                    .font(.system(size: 40, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                Text(story.endingSentence)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                HStack(spacing: 16) {
                    Button(action: resetStory) {
                        Label("Play Again", systemImage: "arrow.counterclockwise")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .padding(.vertical, 14).padding(.horizontal, 22)
                            .background(.white, in: Capsule())
                    }
                    Button {
                        SpeechManager.shared.stop()
                        dismiss()
                    } label: {
                        Label("More Stories", systemImage: "books.vertical.fill")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .padding(.vertical, 14).padding(.horizontal, 22)
                            .background(.tint, in: Capsule())
                    }
                }
            }
        }
        .transition(.opacity)
    }
}

#Preview {
    NavigationStack {
        GameView(story: StoryLibrary.park)
    }
}
