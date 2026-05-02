import SwiftUI

struct MoodProtocolView: View {

    let mood: MoodChoice
    let onTryElse: () -> Void
    let onAdvance: () -> Void
    let onRagePad: () -> Void

    @State private var orbVisible = false
    @State private var wrenVisible = false
    @State private var actionsVisible = false

    var body: some View {
        ZStack {
            Color.quellAbyss
                .ignoresSafeArea()

            VStack(spacing: .quellSpace8) {
                WrenLine(phrases: phrases, interval: .seconds(30))
                    .opacity(wrenVisible ? 1 : 0)

                BreathingShape(size: 280)
                    .opacity(orbVisible ? 1 : 0)

                VStack(spacing: .quellSpace5) {
                    if mood == .rage {
                        WordStone(label: "rage pad") { onRagePad() }
                    }
                    WordStone(label: "this isn't helping") { onTryElse() }
                }
                .opacity(actionsVisible ? 1 : 0)
            }
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.4)) {
                orbVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(1.0)) {
                wrenVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(1.5)) {
                actionsVisible = true
            }
        }
        .task {
            try? await Task.sleep(for: duration)
            onAdvance()
        }
    }

    private var phrases: [String] {
        switch mood {
        case .anxious:
            return [
                "double inhale through your nose.",
                "long exhale through your mouth.",
                "again. another sigh.",
                "feel your feet on the floor.",
                "name three things you can see.",
                "the spike is coming down.",
            ]
        case .lonely:
            return [
                "the lonely is real.",
                "i'm here while you wait.",
                "no one fills this. but i can sit.",
                "want to text someone you trust?",
                "you're not the only one feeling this tonight.",
                "still here.",
            ]
        case .tired:
            return [
                "this is permission to rest.",
                "no fixing right now.",
                "you don't have to push through.",
                "let your shoulders drop.",
                "rest is the work.",
                "close your eyes if you want.",
            ]
        case .bored:
            return [
                "boredom is information.",
                "what's actually here right now?",
                "notice three things in the room.",
                "the urge isn't really hunger.",
                "what would happen if you waited?",
                "curiosity over comfort.",
            ]
        case .numb:
            return [
                "the numb is a wall. we'll go around it.",
                "feel your feet.",
                "hand on your chest. feel it rise.",
                "name a color you can see.",
                "you're allowed to feel slow.",
                "pressure on your forehead. notice it.",
            ]
        case .rage:
            return [
                "the rage is real.",
                "what's underneath?",
                "shake your hands out.",
                "stomp your feet if you need to.",
                "you can hate this.",
                "rage pad is open if you need it.",
            ]
        }
    }

    private var duration: Duration {
        switch mood {
        case .tired: return .seconds(240)
        case .bored: return .seconds(90)
        case .lonely, .numb, .rage, .anxious: return .seconds(120)
        }
    }
}

#Preview {
    MoodProtocolView(
        mood: .lonely,
        onTryElse: {},
        onAdvance: {},
        onRagePad: {}
    )
}
