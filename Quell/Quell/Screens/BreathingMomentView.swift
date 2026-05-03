import SwiftUI

struct ExtraAction: Identifiable {
    let id = UUID()
    let label: String
    let perform: () -> Void
}

struct BreathingMomentView: View {

    let phrases: [String]
    let onComplete: () -> Void
    var extras: [ExtraAction] = []

    @State private var orbVisible = false
    @State private var wrenVisible = false
    @State private var actionsVisible = false

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            JellyfishField()
                .ignoresSafeArea()

            BioluminescentField()
                .ignoresSafeArea()

            VStack(spacing: .quellSpace8) {
                WrenLine(phrases: phrases, interval: .seconds(20))
                    .opacity(wrenVisible ? 1 : 0)

                BreathingShape(size: 240)
                    .opacity(orbVisible ? 1 : 0)

                VStack(spacing: .quellSpace5) {
                    ForEach(extras) { extra in
                        WordStone(label: extra.label) { extra.perform() }
                    }
                    WordStone(label: "okay") {
                        LogStore.shared.log("soft-presence")
                        onComplete()
                    }
                }
                .opacity(actionsVisible ? 1 : 0)
            }
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.3)) {
                orbVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.9)) {
                wrenVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(1.5)) {
                actionsVisible = true
            }
        }
    }
}

#Preview {
    BreathingMomentView(
        phrases: ["the day's a little off.", "you don't have to fix it.", "still here."],
        onComplete: {}
    )
}
