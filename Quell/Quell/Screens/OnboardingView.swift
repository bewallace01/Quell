import SwiftUI

struct OnboardingView: View {

    let onComplete: () -> Void

    @State private var step = 0
    @State private var visible = false

    private let lines = WrenVoice.onboarding

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            Text(lines[min(step, lines.count - 1)])
                .font(.quellDisplay)
                .foregroundStyle(Color.quellCream)
                .multilineTextAlignment(.center)
                .padding(.horizontal, .quellSpace7)
                .opacity(visible ? 1 : 0)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            advance()
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.4)) {
                visible = true
            }
        }
    }

    private func advance() {
        if step >= lines.count - 1 {
            onComplete()
            return
        }
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
    OnboardingView {}
}
