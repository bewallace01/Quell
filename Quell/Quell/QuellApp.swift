import SwiftUI

@main
struct QuellApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

private struct RootView: View {

    @AppStorage("quell.hasOnboarded") private var hasOnboarded = false
    @State private var splashDone = false
    @State private var disguised = false

    var body: some View {
        ZStack {
            if !splashDone {
                SplashView {
                    withAnimation(.quellEaseSlow(duration: .quellDurMid)) {
                        splashDone = true
                    }
                }
                .transition(.opacity)
            } else if hasOnboarded {
                PlaceholderHomeView()
                    .transition(.opacity)
            } else {
                OnboardingView {
                    withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
                        hasOnboarded = true
                    }
                }
                .transition(.opacity)
            }

            if disguised {
                DisguiseView {
                    withAnimation(.quellEaseGentle(duration: .quellDurMid)) {
                        disguised = false
                    }
                }
                .transition(.opacity)
            }

            ShakeDetector()
                .frame(width: 0, height: 0)
                .allowsHitTesting(false)
        }
        .animation(.quellEaseSlow(duration: .quellDurMid), value: hasOnboarded)
        .animation(.quellEaseSlow(duration: .quellDurMid), value: splashDone)
        .onReceive(NotificationCenter.default.publisher(for: .deviceShaken)) { _ in
            guard !disguised else { return }
            withAnimation(.quellEaseGentle(duration: .quellDurFast)) {
                disguised = true
            }
        }
    }
}
