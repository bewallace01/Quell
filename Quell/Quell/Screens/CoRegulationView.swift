import SwiftUI

struct CoRegulationView: View {

    let onExit: () -> Void

    @State private var promptVisible = false
    @State private var orbVisible = false
    @State private var actionsVisible = false

    var body: some View {
        ZStack {
            Color.quellAbyss
                .ignoresSafeArea()

            VStack(spacing: .quellSpace8) {
                WrenLine(
                    phrases: [
                        "still here.",
                        "yeah, this is hard.",
                        "no rush.",
                        "we can wait.",
                        "it'll pass. it always does.",
                        "just this.",
                    ],
                    interval: .seconds(22)
                )
                .opacity(promptVisible ? 1 : 0)

                BreathingShape(size: 280)
                    .opacity(orbVisible ? 1 : 0)

                HStack(spacing: .quellSpace6) {
                    WordStone(label: "stay") {
                        withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
                            actionsVisible = false
                        }
                        Task { @MainActor in
                            try? await Task.sleep(for: .seconds(12))
                            withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
                                actionsVisible = true
                            }
                        }
                    }
                    WordStone(label: "skip ahead") {
                        onExit()
                    }
                }
                .opacity(actionsVisible ? 1 : 0)
            }
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(1.0)) {
                promptVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(1.6)) {
                orbVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(8.0)) {
                actionsVisible = true
            }
        }
    }
}

#Preview {
    CoRegulationView {}
}
