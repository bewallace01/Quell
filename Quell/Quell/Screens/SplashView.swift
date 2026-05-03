import SwiftUI

/// Brand entry shown briefly on every app launch — "quell." over the dark
/// field with a small breathing orb beneath. ~1.5s total.
struct SplashView: View {

    let onComplete: () -> Void

    @State private var visible = false
    @State private var fadingOut = false

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            JellyfishField()
                .ignoresSafeArea()

            BioluminescentField()
                .ignoresSafeArea()

            VStack(spacing: .quellSpace7) {
                Text("quell.")
                    .font(.quellDisplay)
                    .foregroundStyle(Color.quellCream)

                BreathingShape(size: 110)
                    .opacity(0.75)
            }
            .opacity(visible && !fadingOut ? 1 : 0)
            .scaleEffect(visible ? 1.0 : 0.97)
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
                visible = true
            }
            Task { @MainActor in
                try? await Task.sleep(for: .milliseconds(1600))
                withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
                    fadingOut = true
                }
                try? await Task.sleep(for: .milliseconds(700))
                onComplete()
            }
        }
    }
}

#Preview {
    SplashView {}
}
