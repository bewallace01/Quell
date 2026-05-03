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
        WrenVoice.phrases(for: mood)
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
