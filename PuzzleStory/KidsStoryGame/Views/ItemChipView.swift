import SwiftUI

/// A single item shown in the bottom tray, and also used as the floating
/// piece that follows the child's finger while dragging.
struct ItemChipView: View {
    let item: StoryItem
    var isGhost: Bool = false

    var body: some View {
        VStack(spacing: 2) {
            Text(item.emoji)
                .font(.system(size: 52))
            Text(item.name)
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundStyle(.secondary)
        }
        .frame(width: 92, height: 92)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.white)
                .shadow(color: .black.opacity(0.18), radius: 6, y: 4)
        )
        .opacity(isGhost ? 0.001 : 1)
    }
}
