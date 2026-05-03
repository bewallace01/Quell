import Foundation

/// All of Wren's voice in one place. The principle: friend-on-the-floor, not
/// calm-presenter. Plainspoken, observational, no therapy-stock affirmations,
/// fewer self-announcing "i" frames. Iterate copy here — the views just read.
enum WrenVoice {

    // MARK: - Onboarding (first-launch sequence)

    static let onboarding: [String] = [
        "hi.",
        "i'm wren.",
        "i'm here when the urge is loud,\nwhen the wave is rising,\nwhen you need a minute.",
        "no fixing. just presence.",
        "if it gets too big,\n988 is always one tap away.",
        "ready when you are.",
    ]

    // MARK: - Co-regulation (urge-flow breathing screen)

    static let coRegulation: [String] = [
        "still here.",
        "yeah, this is hard.",
        "no rush.",
        "we can wait.",
        "it'll pass. it always does.",
        "just this.",
    ]

    // MARK: - Mood protocols

    static func phrases(for mood: MoodChoice) -> [String] {
        switch mood {
        case .anxious: return anxious
        case .lonely: return lonely
        case .tired: return tired
        case .bored: return bored
        case .numb: return numb
        case .rage: return rage
        }
    }

    static let anxious: [String] = [
        "double inhale through your nose.",
        "long exhale through your mouth.",
        "again. another sigh.",
        "feel your feet on the floor.",
        "name three things you can see.",
        "the spike is coming down.",
    ]

    static let lonely: [String] = [
        "the lonely is real.",
        "i'm here while you wait.",
        "no one fills this. but i can sit.",
        "want to text someone you trust?",
        "you're not the only one feeling this tonight.",
        "still here.",
    ]

    static let tired: [String] = [
        "this is permission to rest.",
        "no fixing right now.",
        "you don't have to push through.",
        "let your shoulders drop.",
        "rest is the work.",
        "close your eyes if you want.",
    ]

    static let bored: [String] = [
        "boredom is information.",
        "what's actually here right now?",
        "notice three things in the room.",
        "the urge isn't really hunger.",
        "what would happen if you waited?",
        "curiosity over comfort.",
    ]

    static let numb: [String] = [
        "the numb is a wall. we'll go around it.",
        "feel your feet.",
        "hand on your chest. feel it rise.",
        "name a color you can see.",
        "you're allowed to feel slow.",
        "pressure on your forehead. notice it.",
    ]

    static let rage: [String] = [
        "the rage is real.",
        "what's underneath?",
        "shake your hands out.",
        "stomp your feet if you need to.",
        "you can hate this.",
        "rage pad is open if you need it.",
    ]

    // MARK: - Soft presence (Wobbling, Need Company on home)

    static let wobbling: [String] = [
        "the day's a little off.",
        "you don't have to fix it.",
        "still here with you.",
        "no big deal.",
        "let your shoulders drop.",
        "okay. just be here.",
    ]

    static let needCompany: [String] = [
        "you're not alone in this minute.",
        "i'm here.",
        "want to text someone you trust?",
        "or just sit with me.",
        "no need to perform.",
        "still here.",
    ]

    // MARK: - Eat Anyway

    static let mindfulGuidance: [String] = [
        "take it somewhere you can sit.",
        "phone face-down.",
        "eyes on the food.",
        "first three bites — just notice.",
    ]

    static let eatAnywayEntryPrompt = "sounds good.\nwant to slow it down?"
    static let justEatPrompt = "i'm here when you're ready.\nno pressure."
    static let justEatNotificationTitle = "checking back."
    static let justEatNotificationBody = "still here when you want me."

    // MARK: - Before food (preventive)

    /// Hunger-check sequence. Tap-to-advance through these, then commit "hungry"
    /// or "something else."
    static let hungerCheck: [String] = [
        "okay. close your eyes if you want.",
        "find your stomach. just notice it.",
        "is there a hollow asking? a real hunger?",
        "or is it tight? restless? something else?",
    ]

    /// Pre-meal grounding phrases — rotate during a 60s breath moment before eating.
    static let preMeal: [String] = [
        "you're about to eat. nothing wrong with that.",
        "arrive at the table first.",
        "feel your seat. your feet on the floor.",
        "look at the food. smell it.",
        "no rush. begin when you're ready.",
    ]

    // MARK: - Wave Check

    static let waveCheckPrompt = "where is it now?"

    static func waveResultLine(_ result: WaveResult) -> String {
        switch result {
        case .bigger: return "okay. we can get more help."
        case .same: return "let's try something else."
        case .smaller: return "you're still here. nice work staying."
        }
    }

    // MARK: - Closing lines

    static let closingThanks = "thanks for showing up."
    static let closingStillHere = "still here."
    static let closingSteady = "good. nice to see you."

    // MARK: - Patterns reflection

    static func patternsReflection(thisWeekCount: Int, totalCount: Int) -> String {
        if totalCount == 0 {
            return "nothing here yet.\nthat's okay too."
        }
        if thisWeekCount == 0 {
            return "you've shown up before.\nbe here when you can."
        }
        if thisWeekCount >= 5 {
            return "you've been here a lot this week.\nthat counts."
        }
        return "you've been showing up.\nthat counts."
    }
}
