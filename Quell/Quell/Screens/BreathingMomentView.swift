import SwiftUI

struct BreathingMomentView: View {

    let phrases: [String]
    let onComplete: () -> Void
    var extra: (label: String, perform: () -> Void)? = nil

    @State private var orbVisible = false
    @State private var wrenVisible = false
    @State private var actionsVisible = false

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            BioluminescentField()
                .ignoresSafeArea()

            VStack(spacing: .quellSpace8) {
                WrenLine(phrases: phrases, interval: .seconds(20))
                    .opacity(wrenVisible ? 1 : 0)

                BreathingShape(size: 240)
                    .opacity(orbVisible ? 1 : 0)

                VStack(spacing: .quellSpace5) {
                    if let extra {
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
