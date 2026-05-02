import SwiftUI

struct WordStone: View {

    let label: String
    let action: () -> Void

    @AppStorage("quell.hapticEnabled") private var hapticEnabled = true
    @State private var glowing = false
    @State private var tapCount = 0

    var body: some View {
        Button {
            if hapticEnabled { tapCount += 1 }
            withAnimation(.quellEaseGentle(duration: .quellDurFast)) {
                glowing = true
            }
            withAnimation(.quellEaseGentle(duration: .quellDurSlow).delay(.quellDurFast)) {
                glowing = false
            }
            action()
        } label: {
            Text(label)
                .font(.quellStone)
                .foregroundStyle(Color.quellCream)
                .fixedSize(horizontal: true, vertical: false)
                .padding(.horizontal, .quellSpace5)
                .padding(.vertical, .quellSpace3)
                .frame(minWidth: 44, minHeight: 44)
                .background {
                    Capsule()
                        .fill(Color.quellGlow.opacity(glowing ? 0.18 : 0))
                        .blur(radius: 14)
                }
                .shadow(color: Color.quellGlow.opacity(glowing ? 0.5 : 0), radius: 16)
        }
        .buttonStyle(StonePressStyle())
        .sensoryFeedback(.impact(flexibility: .soft, intensity: 0.6), trigger: tapCount)
    }
}

private struct StonePressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.quellEaseGentle(duration: .quellDurFast), value: configuration.isPressed)
    }
}

#Preview {
    VStack(spacing: 24) {
        HStack(spacing: 32) {
            WordStone(label: "Steady") {}
            WordStone(label: "Wobbling") {}
        }
        HStack(spacing: 32) {
            WordStone(label: "In it") {}
            WordStone(label: "Need company") {}
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.quellMidnight.ignoresSafeArea())
}
