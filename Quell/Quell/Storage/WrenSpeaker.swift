import Foundation
import AVFoundation
import CryptoKit

/// Speaks Wren's lines. Tries pre-generated audio files (from ElevenLabs via
/// the Tools/generate_wren_audio.swift script) first, falling back to iOS TTS
/// if no file is bundled for a given phrase. Respects the
/// `quell.audioEnabled` AppStorage flag — if audio is off, calls are no-ops.
@MainActor
final class WrenSpeaker {

    static let shared = WrenSpeaker()

    private let synthesizer = AVSpeechSynthesizer()
    private var player: AVAudioPlayer?
    private lazy var voice: AVSpeechSynthesisVoice? = bestEnglishVoice()

    func speak(_ text: String) {
        guard audioEnabled else { return }
        let cleaned = text
            .replacingOccurrences(of: "—", with: ",")
            .replacingOccurrences(of: "\n", with: " ")

        // Stop anything currently playing
        synthesizer.stopSpeaking(at: .immediate)
        player?.stop()

        // Prefer a pre-generated audio file (matches the original phrase
        // verbatim — including newlines — so the hash lines up with the
        // generation script).
        if let url = audioURL(for: text) ?? audioURL(for: cleaned) {
            playFile(at: url)
            return
        }

        // Fall back to TTS
        let utterance = AVSpeechUtterance(string: cleaned)
        utterance.voice = voice
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate * 0.95
        utterance.pitchMultiplier = 1.0
        utterance.volume = 1.0
        synthesizer.speak(utterance)
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        player?.stop()
    }

    // MARK: - File-based playback

    private func audioURL(for phrase: String) -> URL? {
        let name = audioBaseName(for: phrase)
        return Bundle.main.url(forResource: name, withExtension: "mp3")
    }

    private func playFile(at url: URL) {
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.ambient, mode: .default, options: [.mixWithOthers])
            try session.setActive(true)
            let p = try AVAudioPlayer(contentsOf: url)
            p.volume = 1.0
            p.prepareToPlay()
            p.play()
            player = p
        } catch {
            // If file playback fails for any reason, fall through to TTS by
            // routing back through speak() with a flag would loop; instead
            // just bail silently — better to be quiet than crash.
        }
    }

    /// Stable filename base (no extension) for a phrase. Matches the hash
    /// function in `Tools/generate_wren_audio.swift`.
    private func audioBaseName(for phrase: String) -> String {
        let digest = SHA256.hash(data: Data(phrase.utf8))
        let hex = digest.prefix(8).map { String(format: "%02x", $0) }.joined()
        return "wren-\(hex)"
    }

    // MARK: - TTS fallback

    private func bestEnglishVoice() -> AVSpeechSynthesisVoice? {
        let voices = AVSpeechSynthesisVoice.speechVoices()
            .filter { $0.language.hasPrefix("en") }
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
