import SwiftUI

enum ForkChoice: String, Equatable {
    case body = "Body"
    case mood = "Mood"
    case dontKnow = "Don't know"
}

struct ForkView: View {

    let onCommit: (ForkChoice) -> Void

    @State private var optionsVisible = false
    @State private var glowing: ForkChoice? = nil
    @State private var tapCount = 0

    var body: some View {
        ZStack {
            Color.quellAbyss
                .ignoresSafeArea()

            ZStack {
                ForkOption(
                    choice: .body,
                    isGlowing: glowing == .body
                ) {
                    handleTap(.body)
                }
                .offset(x: 0, y: -120)

                ForkOption(
                    choice: .mood,
                    isGlowing: glowing == .mood
                ) {
                    handleTap(.mood)
                }
                .offset(x: -90, y: 80)

                ForkOption(
                    choice: .dontKnow,
                    isGlowing: glowing == .dontKnow
                ) {
                    handleTap(.dontKnow)
                }
                .offset(x: 90, y: 80)
            }
            .opacity(optionsVisible ? 1 : 0)
        }
        .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.6), trigger: tapCount)
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.3)) {
                optionsVisible = true
            }
        }
    }

    private func handleTap(_ choice: ForkChoice) {
        tapCount += 1
        withAnimation(.quellEaseGentle(duration: .quellDurFast)) {
            glowing = choice
        }
        onCommit(choice)
    }
}

private struct ForkOption: View {

    let choice: ForkChoice
    let isGlowing: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: .quellSpace4) {
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(stops: [
                                .init(color: .quellMoon, location: 0.0),
                                .init(color: .quellMidnight, location: 1.0),
                            ]),
                            center: .center,
                            startRadius: 0,
                            endRadius: 50
                        )
                    )
                    .frame(width: 100, height: 100)
                    .blur(radius: 3)
                    .shadow(
                        color: Color.quellGlow.opacity(isGlowing ? 0.5 : 0),
                        radius: 14
                    )

                Text(choice.rawValue)
                    .font(.quellStone)
                    .foregroundStyle(Color.quellCream)
                    .fixedSize(horizontal: true, vertical: false)
            }
        }
        .buttonStyle(ForkPressStyle())
    }
}

private struct ForkPressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1.0)
            .animation(.quellEaseGentle(duration: .quellDurFast), value: configuration.isPressed)
    }
}

#Preview {
    ForkView { choice in
        print("committed: \(choice)")
    }
}
