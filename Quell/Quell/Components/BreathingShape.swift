import SwiftUI

struct BreathingShape: View {

    /// Maximum diameter at peak inhale. The view occupies a `size × size` frame
    /// and the orb scales within it.
    var size: CGFloat = 200

    @State private var inhaled = false

    var body: some View {
        Circle()
            .fill(
                RadialGradient(
                    gradient: Gradient(stops: [
                        .init(color: .quellEmber, location: 0.0),
                        .init(color: .quellDawn, location: 0.22),
                        .init(color: .quellMoon, location: 0.5),
                        .init(color: .quellMidnight, location: 1.0),
                    ]),
                    center: .center,
                    startRadius: 0,
                    endRadius: size / 2
                )
            )
            .frame(width: size, height: size)
            .blur(radius: 6)
            .scaleEffect(inhaled ? 1.05 : 0.72)
            .opacity(inhaled ? 0.95 : 0.5)
            .task {
                while !Task.isCancelled {
                    withAnimation(.quellEaseGentle(duration: .quellDurBreath)) {
                        inhaled = true
                    }
                    try? await Task.sleep(for: .seconds(Double.quellDurBreath + 0.4))

                    withAnimation(.quellEaseGentle(duration: .quellDurExhale)) {
                        inhaled = false
                    }
                    try? await Task.sleep(for: .seconds(Double.quellDurExhale + 1.2))
                }
            }
    }
}

#Preview {
    BreathingShape()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.quellMidnight.ignoresSafeArea())
}
