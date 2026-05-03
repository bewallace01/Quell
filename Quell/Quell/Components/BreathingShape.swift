import SwiftUI

struct BreathingShape: View {

    /// Maximum diameter at peak inhale. The view occupies a `size × size` frame
    /// and the orb scales within it.
    var size: CGFloat = 200

    @AppStorage("quell.manualBreath") private var manualBreath = false
    @State private var inhaled = false
    @State private var manualHolding = false
    @State private var task: Task<Void, Never>? = nil

    private var expanded: Bool {
        manualBreath ? manualHolding : inhaled
    }

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
            .scaleEffect(expanded ? 1.05 : 0.72)
            .opacity(expanded ? 0.95 : 0.5)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        guard manualBreath else { return }
                        if !manualHolding {
                            withAnimation(.quellEaseGentle(duration: .quellDurBreath)) {
                                manualHolding = true
                            }
                        }
                    }
                    .onEnded { _ in
                        guard manualBreath else { return }
                        withAnimation(.quellEaseGentle(duration: .quellDurExhale)) {
                            manualHolding = false
                        }
                    }
            )
            .accessibilityLabel(manualBreath
                ? "breath orb. tap and hold to inhale, release to exhale."
                : "breath orb")
            .onAppear { startCycleIfNeeded() }
            .onDisappear { task?.cancel() }
            .onChange(of: manualBreath) { _, _ in startCycleIfNeeded() }
    }

    private func startCycleIfNeeded() {
        task?.cancel()
        guard !manualBreath else { return }
        task = Task { @MainActor in
            while !Task.isCancelled {
                withAnimation(.quellEaseGentle(duration: .quellDurBreath)) {
                    inhaled = true
                }
                try? await Task.sleep(for: .seconds(Double.quellDurBreath + 0.4))
                if Task.isCancelled { return }
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
