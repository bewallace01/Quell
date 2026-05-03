import Foundation
import AVFoundation

/// Speaks Wren's lines via iOS TTS. Respects the `quell.audioEnabled`
/// AppStorage flag — if audio is off, calls are no-ops. Each new utterance
/// interrupts the previous so phrases don't overlap.
///
/// Voice quality tiers — Apple's default voices (Samantha etc.) are robotic.
/// The "Enhanced" and "Premium" English voices (downloadable in iOS Settings
/// → Accessibility → Spoken Content → Voices) are dramatically more natural;
/// this picks the highest tier available to the user.
@MainActor
final class WrenSpeaker {

    static let shared = WrenSpeaker()

    private let synthesizer = AVSpeechSynthesizer()
    private lazy var voice: AVSpeechSynthesisVoice? = bestEnglishVoice()

    func speak(_ text: String) {
        guard audioEnabled else { return }
        let cleaned = text
            .replacingOccurrences(of: "—", with: ",")
            .replacingOccurrences(of: "\n", with: " ")
        synthesizer.stopSpeaking(at: .immediate)
        let utterance = AVSpeechUtterance(string: cleaned)
        utterance.voice = voice
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.95
        utterance.pitchMultiplier = 1.0
        utterance.volume = 1.0
        synthesizer.speak(utterance)
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }

    private func bestEnglishVoice() -> AVSpeechSynthesisVoice? {
        let voices = AVSpeechSynthesisVoice.speechVoices()
            .filter { $0.language.hasPrefix("en") }
        // Prefer premium > enhanced > default
        if let premium = voices.first(where: { $0.quality == .premium }) {
            return premium
        }
        if let enhanced = voices.first(where: { $0.quality == .enhanced }) {
            return enhanced
        }
        return voices.first ?? AVSpeechSynthesisVoice(language: "en-US")
    }

    private var audioEnabled: Bool {
        let defaults = UserDefaults.standard
        if defaults.object(forKey: "quell.audioEnabled") == nil {
            return true
        }
        return defaults.bool(forKey: "quell.audioEnabled")
    }
}
