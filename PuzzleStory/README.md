# Kids Story Game 🧩📖

A gentle iOS game for young children. Each story is a **big horizontal
scrolling scene** dotted with **holes**. The things that belong in the
holes wait in a tray at the bottom of the screen.

- 👆 **Pick up a thing** → the app says its name out loud ("Sun", "Dog", "Boat"…).
- 🎯 **Drop it in the right hole** → the app reads the next simple sentence of the story.
- 🎉 **Fill every hole** → the story ends with a happy closing line and a celebration.

There is no reading required and no way to "lose" — a wrong drop just gives a
soft red nudge and lets the child try again.

## Stories included

| Story | Things to place |
|-------|-----------------|
| 🌳 **A Day at the Park** | Sun, Tree, Bird, Dog, Ball |
| 🏖️ **At the Beach** | Sun, Cloud, Boat, Crab, Shell |
| 🚜 **On the Farm** | Sun, Tractor, Cow, Sheep, Pig |

## Built with

- **SwiftUI** for the whole interface (iOS 16+).
- **AVSpeechSynthesizer** for the spoken names and story sentences — no audio
  files needed.
- **Emoji + gradients/shapes** for all artwork — the app ships with **zero
  image assets**, so it's tiny and easy to extend.

## Running it

1. Open `KidsStoryGame.xcodeproj` in Xcode 16 or newer.
2. Select an iPhone or iPad simulator (or a device).
3. Press **Run** (⌘R).

> The project uses Xcode's *file-system synchronized groups*, so any Swift
> file you add inside the `KidsStoryGame/` folder is picked up automatically —
> no need to edit the project file.

## Project structure

```
KidsStoryGame/
├── KidsStoryGameApp.swift      App entry point + audio session setup
├── Models/
│   ├── Story.swift             Story, Hole, StoryItem, SceneBackdrop types
│   └── StoryLibrary.swift      The three built-in stories
├── Speech/
│   └── SpeechManager.swift     Friendly text-to-speech for kids
└── Views/
    ├── StoryListView.swift     Home screen / story picker
    ├── GameView.swift          Drag-and-drop gameplay + celebration
    ├── SceneBackdropView.swift Painted scrolling backdrops
    ├── HoleView.swift          Holes + drag hit-testing
    └── ItemChipView.swift      Draggable item chips
```

## Adding a new story

Add another `Story` to `StoryLibrary.all`. Give it a backdrop, a list of
`StoryItem`s, and a list of `Hole`s whose `position` (a `UnitPoint` from
`0...1`) places them anywhere in the scrolling scene. Each hole's `sentence`
is read aloud when its item lands. That's it.
