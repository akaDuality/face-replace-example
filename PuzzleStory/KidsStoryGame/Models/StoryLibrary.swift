import SwiftUI

/// The built-in collection of simple stories for kids.
enum StoryLibrary {

    static let all: [Story] = [park, beach, farm]

    // MARK: - A Day at the Park

    static let park = Story(
        id: "park",
        title: "A Day at the Park",
        emoji: "🌳",
        backdrop: .park,
        widthFactor: 2.4,
        holes: [
            Hole(id: "park.sun",  acceptsItemID: "sun",  position: UnitPoint(x: 0.10, y: 0.16),
                 sentence: "The warm sun shines high in the big blue sky."),
            Hole(id: "park.tree", acceptsItemID: "tree", position: UnitPoint(x: 0.32, y: 0.52),
                 sentence: "A tall green tree grows next to the path."),
            Hole(id: "park.bird", acceptsItemID: "bird", position: UnitPoint(x: 0.30, y: 0.24),
                 sentence: "A little bird sings a happy song in the tree."),
            Hole(id: "park.dog",  acceptsItemID: "dog",  position: UnitPoint(x: 0.62, y: 0.72),
                 sentence: "A friendly dog runs and plays on the soft grass."),
            Hole(id: "park.ball", acceptsItemID: "ball", position: UnitPoint(x: 0.86, y: 0.78),
                 sentence: "The children kick a bright red ball together.")
        ],
        items: [
            StoryItem(id: "sun",  name: "Sun",  emoji: "☀️"),
            StoryItem(id: "tree", name: "Tree", emoji: "🌳"),
            StoryItem(id: "bird", name: "Bird", emoji: "🐦"),
            StoryItem(id: "dog",  name: "Dog",  emoji: "🐶"),
            StoryItem(id: "ball", name: "Ball", emoji: "⚽️")
        ],
        endingSentence: "What a fun day at the park! Hooray!"
    )

    // MARK: - At the Beach

    static let beach = Story(
        id: "beach",
        title: "At the Beach",
        emoji: "🏖️",
        backdrop: .beach,
        widthFactor: 2.4,
        holes: [
            Hole(id: "beach.sun",   acceptsItemID: "sun",   position: UnitPoint(x: 0.12, y: 0.15),
                 sentence: "The bright sun warms the soft, sandy beach."),
            Hole(id: "beach.cloud", acceptsItemID: "cloud", position: UnitPoint(x: 0.40, y: 0.18),
                 sentence: "A fluffy white cloud floats slowly across the sky."),
            Hole(id: "beach.boat",  acceptsItemID: "boat",  position: UnitPoint(x: 0.58, y: 0.42),
                 sentence: "A little boat sails far out on the deep blue sea."),
            Hole(id: "beach.crab",  acceptsItemID: "crab",  position: UnitPoint(x: 0.74, y: 0.82),
                 sentence: "A red crab walks sideways along the warm sand."),
            Hole(id: "beach.shell", acceptsItemID: "shell", position: UnitPoint(x: 0.90, y: 0.85),
                 sentence: "We find a pretty shell right beside the water.")
        ],
        items: [
            StoryItem(id: "sun",   name: "Sun",   emoji: "☀️"),
            StoryItem(id: "cloud", name: "Cloud", emoji: "☁️"),
            StoryItem(id: "boat",  name: "Boat",  emoji: "⛵️"),
            StoryItem(id: "crab",  name: "Crab",  emoji: "🦀"),
            StoryItem(id: "shell", name: "Shell", emoji: "🐚")
        ],
        endingSentence: "We love playing at the beach all day!"
    )

    // MARK: - On the Farm

    static let farm = Story(
        id: "farm",
        title: "On the Farm",
        emoji: "🚜",
        backdrop: .farm,
        widthFactor: 2.4,
        holes: [
            Hole(id: "farm.sun",     acceptsItemID: "sun",     position: UnitPoint(x: 0.11, y: 0.17),
                 sentence: "The sun rises slowly over the green farm."),
            Hole(id: "farm.tractor", acceptsItemID: "tractor", position: UnitPoint(x: 0.34, y: 0.74),
                 sentence: "A big tractor drives down the bumpy farm road."),
            Hole(id: "farm.cow",     acceptsItemID: "cow",     position: UnitPoint(x: 0.55, y: 0.70),
                 sentence: "The brown cow eats fresh grass in the field."),
            Hole(id: "farm.sheep",   acceptsItemID: "sheep",   position: UnitPoint(x: 0.72, y: 0.78),
                 sentence: "A soft white sheep says baa, baa, baa."),
            Hole(id: "farm.pig",     acceptsItemID: "pig",     position: UnitPoint(x: 0.89, y: 0.80),
                 sentence: "A happy pink pig plays in the cool mud.")
        ],
        items: [
            StoryItem(id: "sun",     name: "Sun",     emoji: "☀️"),
            StoryItem(id: "tractor", name: "Tractor", emoji: "🚜"),
            StoryItem(id: "cow",     name: "Cow",     emoji: "🐄"),
            StoryItem(id: "sheep",   name: "Sheep",   emoji: "🐑"),
            StoryItem(id: "pig",     name: "Pig",     emoji: "🐷")
        ],
        endingSentence: "Good morning to everyone on the farm!"
    )
}
