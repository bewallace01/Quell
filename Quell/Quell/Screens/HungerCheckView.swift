import SwiftUI

enum HungerOutcome: Equatable {
    case hungry
    case somethingElse
}

struct HungerCheckView: View {

    let onComplete: (HungerOutcome) -> Void

    @State private var step = 0
    @State private var visible = false

    private let prompts = WrenVoice.hungerCheck

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            JellyfishField()
                .ignoresSafeArea()

            BioluminescentField()
                .ignoresSafeArea()

            if step < prompts.count {
                Text(prompts[step])
                    .font(.quellTitle)
                    .foregroundStyle(Color.quellCream)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, .quellSpace7)
                    .opacity(visible ? 1 : 0)
                    .contentShape(Rectangle())
                    .onTapGesture { advance() }
                    .accessibilityElement(children: .combine)
                    .accessibilityHint("tap to continue.")
            } else {
                VStack(spacing: .quellSpace8) {
                    Text("what is it?")
                        .font(.quellTitle)
                        .foregroundStyle(Color.quellCream)

                    HStack(spacing: .quellSpace6) {
                        WordStone(label: "hungry") { onComplete(.hungry) }
                        WordStone(label: "something else") { onComplete(.somethingElse) }
                    }
                }
                .opacity(visible ? 1 : 0)
                .padding(.horizontal, .quellSpace7)
            }
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.3)) {
                visible = true
            }
        }
    }

    private func advance() {
        withAnimation(.quellEaseSlow(duration: .quellDurMid)) {
            visible = false
        }
        Task { @MainActor in
            try? await Task.sleep(for: .milliseconds(700))
            step += 1
            withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
                visible = true
            }
        }
    }
}

#Preview {
    HungerCheckView { _ in }
}
