import AVFoundation

/// Speaks words and sentences aloud with a friendly, slightly slower
/// voice that is easy for young children to follow.
final class SpeechManager {

    static let shared = SpeechManager()

    private let synthesizer = AVSpeechSynthesizer()

    private init() {}

    /// Speaks a single short word (an item's name) with a cheerful pitch.
    func speakName(_ name: String) {
        speak(name, rate: 0.40, pitch: 1.25)
    }

    /// Speaks a story sentence at a calm, easy-to-follow pace.
    func speakSentence(_ sentence: String) {
        speak(sentence, rate: 0.44, pitch: 1.10)
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }

    private func speak(_ text: String, rate: Float, pitch: Float) {
        synthesizer.stopSpeaking(at: .immediate)

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = rate
        utterance.pitchMultiplier = pitch
        utterance.preUtteranceDelay = 0.0
        synthesizer.speak(utterance)
    }
}
