import SwiftUI

struct AnxiousProtocolView: View {

    let onTryElse: () -> Void
    let onAdvance: () -> Void
    var duration: Duration = .seconds(120)

    @State private var orbVisible = false
    @State private var wrenVisible = false
    @State private var exitVisible = false

    var body: some View {
        ZStack {
            Color.quellAbyss
                .ignoresSafeArea()

            VStack(spacing: .quellSpace8) {
                WrenLine(
                    phrases: [
                        "double inhale through your nose.",
                        "long exhale through your mouth.",
                        "again. another sigh.",
                        "feel your feet on the floor.",
                        "name three things you can see.",
                        "the spike is coming down.",
                    ],
                    interval: .seconds(30)
                )
                .opacity(wrenVisible ? 1 : 0)

                BreathingShape(size: 280)
                    .opacity(orbVisible ? 1 : 0)

                WordStone(label: "this isn't helping") {
                    onTryElse()
                }
                .opacity(exitVisible ? 1 : 0)
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
                exitVisible = true
            }
        }
        .task {
            try? await Task.sleep(for: duration)
            onAdvance()
        }
    }
}

#Preview {
    AnxiousProtocolView(onTryElse: {}, onAdvance: {})
}
