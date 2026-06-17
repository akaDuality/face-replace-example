import SwiftUI
import AVFoundation

@main
struct KidsStoryGameApp: App {

    init() {
        configureAudioSession()
    }

    var body: some Scene {
        WindowGroup {
            StoryListView()
        }
    }

    /// Make sure the spoken names and sentences are audible even when the
    /// device's silent switch is on – kids' apps should always be heard.
    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .spokenAudio, options: [])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session setup failed: \(error)")
        }
    }
}
