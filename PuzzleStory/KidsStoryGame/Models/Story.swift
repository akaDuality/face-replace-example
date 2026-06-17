import SwiftUI

/// A single draggable object the child places into the scene.
struct StoryItem: Identifiable, Equatable {
    let id: String
    /// Word spoken aloud when the child picks the item up.
    let name: String
    /// Emoji used to draw the item (no custom artwork required).
    let emoji: String
}

/// A spot in the scene that accepts one specific item.
struct Hole: Identifiable, Equatable {
    let id: String
    /// The `StoryItem.id` that belongs in this hole.
    let acceptsItemID: String
    /// Position inside the scene, expressed in 0...1 of the scene's
    /// width and height so the layout scales to any device size.
    let position: UnitPoint
    /// Sentence of the story spoken aloud once the item is placed correctly.
    let sentence: String
}

/// The painted backdrop styles the scene can use. Drawn with plain
/// SwiftUI shapes and gradients, so the app ships with zero image assets.
enum SceneBackdrop {
    case park
    case beach
    case farm
}

/// One complete mini-story: a wide scrolling scene, the holes inside it,
/// the items that fill them, and a closing line.
struct Story: Identifiable {
    let id: String
    let title: String
    let emoji: String
    let backdrop: SceneBackdrop
    /// How many screen-widths the scene spans horizontally.
    let widthFactor: CGFloat
    let holes: [Hole]
    let items: [StoryItem]
    /// Spoken once every hole is filled.
    let endingSentence: String
}
