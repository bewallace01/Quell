import Foundation

struct MovementPhase: Equatable, Hashable {
    let text: String
    let duration: Double
}

struct Exercise: Identifiable, Equatable, Hashable {
    let id: UUID
    let title: String
    let phases: [MovementPhase]

    var totalSeconds: Double { phases.reduce(0) { $0 + $1.duration } }
}

@MainActor
final class MovementLibrary {

    static let shared = MovementLibrary()

    let exercises: [Exercise] = [
        Exercise(
            id: UUID(),
            title: "shoulder release",
            phases: [
                .init(text: "drop your shoulders.", duration: 4),
                .init(text: "now press them back, slow.", duration: 5),
                .init(text: "hold there.", duration: 5),
                .init(text: "release. let them fall.", duration: 4),
                .init(text: "again.", duration: 3),
                .init(text: "press back. slow.", duration: 5),
                .init(text: "hold.", duration: 5),
                .init(text: "release.", duration: 4),
                .init(text: "feel the space in your chest.", duration: 6),
            ]
        ),
        Exercise(
            id: UUID(),
            title: "hand fidget",
            phases: [
                .init(text: "press your thumbs into your palms.", duration: 5),
                .init(text: "hold for five.", duration: 5),
                .init(text: "release.", duration: 3),
                .init(text: "make a fist.", duration: 3),
                .init(text: "tighter.", duration: 4),
                .init(text: "hold.", duration: 4),
                .init(text: "open.", duration: 4),
                .init(text: "spread your fingers wide.", duration: 5),
                .init(text: "soften.", duration: 5),
            ]
        ),
        Exercise(
            id: UUID(),
            title: "jaw release",
            phases: [
                .init(text: "notice your jaw.", duration: 5),
                .init(text: "is it tight?", duration: 4),
                .init(text: "drop it open. softly.", duration: 5),
                .init(text: "wider. like a small yawn.", duration: 5),
                .init(text: "hold.", duration: 4),
                .init(text: "close, slowly.", duration: 5),
                .init(text: "let your tongue rest behind your teeth.", duration: 6),
                .init(text: "stay.", duration: 6),
            ]
        ),
        Exercise(
            id: UUID(),
            title: "feet on floor",
            phases: [
                .init(text: "press your feet into the ground.", duration: 5),
                .init(text: "harder. push down.", duration: 5),
                .init(text: "hold.", duration: 5),
                .init(text: "release.", duration: 4),
                .init(text: "feel the contact, even when you stop pressing.", duration: 7),
                .init(text: "again.", duration: 3),
                .init(text: "press.", duration: 4),
                .init(text: "release.", duration: 4),
                .init(text: "you're here.", duration: 5),
            ]
        ),
        Exercise(
            id: UUID(),
            title: "full body squeeze",
            phases: [
                .init(text: "squeeze every muscle. all at once.", duration: 5),
                .init(text: "tighter. fists, jaw, shoulders, legs.", duration: 5),
                .init(text: "hold.", duration: 5),
                .init(text: "tighter still.", duration: 3),
                .init(text: "release. all the way.", duration: 5),
                .init(text: "let your body go heavy.", duration: 6),
                .init(text: "feel the after.", duration: 8),
            ]
        ),
        Exercise(
            id: UUID(),
            title: "physiological sigh",
            phases: [
                .init(text: "in through your nose.", duration: 4),
                .init(text: "now a smaller second sip in.", duration: 3),
                .init(text: "out through your mouth, long.", duration: 7),
                .init(text: "again.", duration: 2),
                .init(text: "in.", duration: 4),
                .init(text: "second sip.", duration: 3),
                .init(text: "long out.", duration: 7),
                .init(text: "one more.", duration: 2),
                .init(text: "in.", duration: 4),
                .init(text: "sip.", duration: 3),
                .init(text: "out.", duration: 8),
            ]
        ),
        Exercise(
            id: UUID(),
            title: "eye rest",
            phases: [
                .init(text: "close your eyes.", duration: 5),
                .init(text: "or rest them on something neutral.", duration: 5),
                .init(text: "soften the muscles around them.", duration: 6),
                .init(text: "your forehead too.", duration: 5),
                .init(text: "the bridge of your nose.", duration: 5),
                .init(text: "stay.", duration: 8),
            ]
        ),
        Exercise(
            id: UUID(),
            title: "hand on chest",
            phases: [
                .init(text: "put one hand on your chest.", duration: 5),
                .init(text: "feel it rise.", duration: 6),
                .init(text: "feel it fall.", duration: 6),
                .init(text: "no need to deepen the breath. just notice.", duration: 8),
                .init(text: "stay with it.", duration: 10),
            ]
        ),
        Exercise(
            id: UUID(),
            title: "neck stretch",
            phases: [
                .init(text: "drop your right ear toward your right shoulder.", duration: 5),
                .init(text: "let it hang. don't push.", duration: 5),
                .init(text: "breathe.", duration: 6),
                .init(text: "lift your head, slow.", duration: 4),
                .init(text: "now the other side.", duration: 3),
                .init(text: "left ear toward left shoulder.", duration: 5),
                .init(text: "hang.", duration: 6),
                .init(text: "lift.", duration: 4),
                .init(text: "neutral. notice.", duration: 5),
            ]
        ),
        Exercise(
            id: UUID(),
            title: "standing reset",
            phases: [
                .init(text: "stand up if you can.", duration: 5),
                .init(text: "feet hip-width.", duration: 4),
                .init(text: "roll your shoulders back, slowly.", duration: 6),
                .init(text: "look at the horizon. or anything far.", duration: 6),
                .init(text: "take a breath in.", duration: 4),
                .init(text: "out.", duration: 5),
                .init(text: "again, slower.", duration: 4),
                .init(text: "in.", duration: 4),
                .init(text: "out.", duration: 6),
                .init(text: "you're back.", duration: 5),
            ]
        ),
    ]
}
