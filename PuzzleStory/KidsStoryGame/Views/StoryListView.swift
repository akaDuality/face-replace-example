import SwiftUI

/// The home screen: a friendly list of stories to choose from.
struct StoryListView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(StoryLibrary.all) { story in
                        NavigationLink {
                            GameView(story: story)
                        } label: {
                            StoryCard(story: story)
                        }
                        .buttonStyle(.plain)
                        .simultaneousGesture(TapGesture().onEnded {
                            SpeechManager.shared.speakName(story.title)
                        })
                    }
                }
                .padding(20)
            }
            .background(
                LinearGradient(
                    colors: [Color(red: 0.90, green: 0.95, blue: 1.0),
                             Color(red: 1.0, green: 0.96, blue: 0.92)],
                    startPoint: .top, endPoint: .bottom
                ).ignoresSafeArea()
            )
            .navigationTitle("Story Time")
        }
        .tint(Color(red: 0.95, green: 0.45, blue: 0.35))
    }
}

private struct StoryCard: View {
    let story: Story

    var body: some View {
        HStack(spacing: 18) {
            Text(story.emoji)
                .font(.system(size: 64))
            VStack(alignment: .leading, spacing: 6) {
                Text(story.title)
                    .font(.system(size: 26, weight: .heavy, design: .rounded))
                    .foregroundStyle(.primary)
                Text("^[\(story.items.count) thing](inflect: true) to place")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "play.circle.fill")
                .font(.system(size: 40))
                .foregroundStyle(.tint)
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(.white)
                .shadow(color: .black.opacity(0.12), radius: 8, y: 5)
        )
    }
}

#Preview {
    StoryListView()
}
