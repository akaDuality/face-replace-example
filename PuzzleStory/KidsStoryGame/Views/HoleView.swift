import SwiftUI

/// Collects the on-screen frame of every hole (in the shared "game"
/// coordinate space) so the drag logic can hit-test against them even
/// while the scene scrolls.
struct HoleFramePreferenceKey: PreferenceKey {
    static var defaultValue: [String: CGRect] = [:]
    static func reduce(value: inout [String: CGRect], nextValue: () -> [String: CGRect]) {
        value.merge(nextValue()) { _, new in new }
    }
}

/// A target spot in the scene. Shows a faint hint of the expected item
/// until it is filled, then pops the real emoji into place.
struct HoleView: View {
    let hole: Hole
    let hintEmoji: String
    let isFilled: Bool
    let isWrong: Bool

    private let size: CGFloat = 84

    var body: some View {
        ZStack {
            if isFilled {
                Text(hintEmoji)
                    .font(.system(size: size * 0.78))
                    .transition(.scale.combined(with: .opacity))
                    .shadow(color: .black.opacity(0.15), radius: 4, y: 3)
            } else {
                Circle()
                    .strokeBorder(style: StrokeStyle(lineWidth: 4, dash: [9, 7]))
                    .foregroundStyle(.white.opacity(0.9))
                    .background(Circle().fill(.black.opacity(0.10)))
                    .overlay(
                        Text(hintEmoji)
                            .font(.system(size: size * 0.5))
                            .opacity(0.35)
                            .grayscale(0.8)
                    )
                    .frame(width: size, height: size)
                    .scaleEffect(isWrong ? 1.12 : 1.0)
                    .overlay(
                        Circle()
                            .stroke(Color.red, lineWidth: isWrong ? 4 : 0)
                            .frame(width: size, height: size)
                    )
            }
        }
        .frame(width: size, height: size)
        .background(
            GeometryReader { geo in
                Color.clear.preference(
                    key: HoleFramePreferenceKey.self,
                    value: [hole.id: geo.frame(in: .named("game"))]
                )
            }
        )
        .animation(.spring(response: 0.4, dampingFraction: 0.55), value: isFilled)
        .animation(.default, value: isWrong)
    }
}
