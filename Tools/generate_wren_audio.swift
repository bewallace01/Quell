#!/usr/bin/env swift

import Foundation
import CryptoKit

// MARK: - Phrases (keep in sync with WrenVoice.swift)

let phrases: [String] = [
    // Onboarding
    "hi.",
    "quell is for the loud moments —\nwhen the urge to eat is rising,\nwhen you're already in it,\nor you're after the wave.",
    "you don't have to be alone with it.",
    "i'm wren. i'll sit with you.\nno fixing. just presence.",
    "we have breath.\nsmall movements.\nsensory things.\nnotes for future-you.",
    "no calorie tracking.\nno streaks. no shame.",
    "if it gets too big,\n988 is always one tap away.",
    "ready when you are.",

    // Co-regulation
    "still here.",
    "yeah, this is hard.",
    "no rush.",
    "we can wait.",
    "it'll pass. it always does.",
    "just this.",

    // Anxious mood protocol
    "double inhale through your nose.",
    "long exhale through your mouth.",
    "again. another sigh.",
    "feel your feet on the floor.",
    "name three things you can see.",
    "the spike is coming down.",

    // Lonely
    "the lonely is real.",
    "i'm here while you wait.",
    "no one fills this. but i can sit.",
    "want to text someone you trust?",
    "you're not the only one feeling this tonight.",

    // Tired
    "this is permission to rest.",
    "no fixing right now.",
    "you don't have to push through.",
    "let your shoulders drop.",
    "rest is the work.",
    "close your eyes if you want.",

    // Bored
    "boredom is information.",
    "what's actually here right now?",
    "notice three things in the room.",
    "the urge isn't really hunger.",
    "what would happen if you waited?",
    "curiosity over comfort.",

    // Numb
    "the numb is a wall. we'll go around it.",
    "feel your feet.",
    "hand on your chest. feel it rise.",
    "name a color you can see.",
    "you're allowed to feel slow.",
    "pressure on your forehead. notice it.",

    // Rage
    "the rage is real.",
    "what's underneath?",
    "shake your hands out.",
    "stomp your feet if you need to.",
    "you can hate this.",
    "rage pad is open if you need it.",

    // Wobbling
    "the day's a little off.",
    "you don't have to fix it.",
    "still here with you.",
    "no big deal.",
    "okay. just be here.",

    // Need company
    "you're not alone in this minute.",
    "i'm here.",
    "or just sit with me.",
    "no need to perform.",

    // Eat anyway
    "take it somewhere you can sit.",
    "phone face-down.",
    "eyes on the food.",
    "first three bites — just notice.",
    "sounds good.\nwant to slow it down?",
    "i'm here when you're ready.\nno pressure.",

    // Before food
    "okay. close your eyes if you want.",
    "find your stomach. just notice it.",
    "is there a hollow asking? a real hunger?",
    "or is it tight? restless? something else?",
    "you're about to eat. nothing wrong with that.",
    "arrive at the table first.",
    "feel your seat. your feet on the floor.",
    "look at the food. smell it.",
    "no rush. begin when you're ready.",

    // Wave check
    "where is it now?",
    "okay. we can get more help.",
    "let's try something else.",
    "you're still here. nice work staying.",

    // Closings
    "thanks for showing up.",
    "still here.",
    "good. nice to see you.",
    "done.",
]

// MARK: - Config

guard let apiKey = ProcessInfo.processInfo.environment["ELEVENLABS_API_KEY"] else {
    fputs("ERROR: Set ELEVENLABS_API_KEY env var.\n", stderr)
    exit(1)
}

guard let voiceId = ProcessInfo.processInfo.environment["ELEVENLABS_VOICE_ID"] else {
    fputs("ERROR: Set ELEVENLABS_VOICE_ID env var.\n", stderr)
    exit(1)
}

// Allow override of output dir via arg
let outputDir = CommandLine.arguments.count > 1
    ? CommandLine.arguments[1]
    : "Quell/Quell/WrenAudio"

try? FileManager.default.createDirectory(
    atPath: outputDir,
    withIntermediateDirectories: true
)

// MARK: - Helpers

func filename(for phrase: String) -> String {
    // Match WrenSpeaker's hash function exactly: SHA256, first 8 bytes, hex
    let digest = SHA256.hash(data: Data(phrase.utf8))
    let hex = digest.prefix(8).map { String(format: "%02x", $0) }.joined()
    return "wren-\(hex).mp3"
}

func generate(_ phrase: String) async throws -> Data {
    let url = URL(string: "https://api.elevenlabs.io/v1/text-to-speech/\(voiceId)")!
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue(apiKey, forHTTPHeaderField: "xi-api-key")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("audio/mpeg", forHTTPHeaderField: "Accept")

    let body: [String: Any] = [
        "text": phrase,
        "model_id": "eleven_multilingual_v2",
        "voice_settings": [
            "stability": 0.55,
            "similarity_boost": 0.75,
            "style": 0.0,
            "use_speaker_boost": true,
        ],
    ]
    request.httpBody = try JSONSerialization.data(withJSONObject: body)

    let (data, response) = try await URLSession.shared.data(for: request)
    if let http = response as? HTTPURLResponse, http.statusCode != 200 {
        let body = String(data: data, encoding: .utf8) ?? ""
        throw NSError(
            domain: "ElevenLabs",
            code: http.statusCode,
            userInfo: [NSLocalizedDescriptionKey: "HTTP \(http.statusCode): \(body)"]
        )
    }
    return data
}

// MARK: - Run

let semaphore = DispatchSemaphore(value: 0)

Task {
    var generated = 0
    var skipped = 0
    var errors = 0

    for phrase in phrases {
        let name = filename(for: phrase)
        let path = "\(outputDir)/\(name)"
        if FileManager.default.fileExists(atPath: path) {
            skipped += 1
            continue
        }
        do {
            let data = try await generate(phrase)
            FileManager.default.createFile(atPath: path, contents: data)
            generated += 1
            let preview = phrase.replacingOccurrences(of: "\n", with: " ⏎ ").prefix(60)
            print("✓ \(name) → \"\(preview)\"")
            // Gentle rate-limit so we don't hammer the API
            try? await Task.sleep(for: .milliseconds(250))
        } catch {
            errors += 1
            let preview = phrase.replacingOccurrences(of: "\n", with: " ⏎ ").prefix(60)
            fputs("✗ \(name) → \"\(preview)\" — \(error.localizedDescription)\n", stderr)
        }
    }

    print("\nDone. Generated: \(generated)  Skipped: \(skipped)  Errors: \(errors)")
    semaphore.signal()
}

semaphore.wait()
