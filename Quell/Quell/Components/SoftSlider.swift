import SwiftUI

struct SoftSlider: View {

    @Binding var value: Double
    let onCommit: () -> Void

    @State private var dragging = false

    private let thumbSize: CGFloat = 28
    private let touchHeight: CGFloat = 60
    private let maxAmplitude: CGFloat = 18

    var body: some View {
        GeometryReader { geo in
            let trackWidth = geo.size.width
            let span = max(trackWidth - thumbSize, 0)
            let thumbX = value * span
            let amplitude = maxAmplitude * (1 - CGFloat(value))

            ZStack(alignment: .leading) {
                Wave(amplitude: amplitude, frequency: 1.6, phase: 0)
                    .stroke(Color.quellMoon.opacity(0.55), lineWidth: 2)

                Wave(amplitude: amplitude * 0.7, frequency: 1.6, phase: .pi / 3)
                    .stroke(Color.quellGlow.opacity(0.3), lineWidth: 1.5)

                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(stops: [
                                .init(color: .quellGlow, location: 0.0),
                                .init(color: .quellMoon, location: 1.0),
                            ]),
                            center: .center,
                            startRadius: 0,
                            endRadius: thumbSize / 2
                        )
                    )
                    .frame(width: thumbSize, height: thumbSize)
                    .shadow(
                        color: Color.quellGlow.opacity(dragging ? 0.6 : 0.3),
                        radius: dragging ? 14 : 8
                    )
                    .scaleEffect(dragging ? 1.1 : 1.0)
                    .offset(x: thumbX, y: 0)
                    .frame(maxHeight: .infinity, alignment: .center)
                    .animation(.quellEaseGentle(duration: .quellDurFast), value: dragging)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        if !dragging { dragging = true }
                        let x = min(max(gesture.location.x - thumbSize / 2, 0), span)
                        value = span > 0 ? x / span : 0
                    }
                    .onEnded { _ in
                        dragging = false
                        onCommit()
                    }
            )
        }
        .frame(height: touchHeight)
        .accessibilityElement()
        .accessibilityLabel("the wave")
        .accessibilityValue(accessibilityValueText)
        .accessibilityHint("adjust to report whether the urge is bigger, the same, or smaller. release to commit.")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value = min(value + 0.1, 1)
            case .decrement:
                value = max(value - 0.1, 0)
            @unknown default:
                break
            }
            onCommit()
        }
    }

    private var accessibilityValueText: String {
        if value < 0.33 { return "bigger" }
        if value > 0.67 { return "smaller" }
        return "the same"
    }
}

private struct Wave: Shape {

    var amplitude: CGFloat
    var frequency: CGFloat
    var phase: CGFloat

    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(amplitude, phase) }
        set {
            amplitude = newValue.first
            phase = newValue.second
        }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let midY = rect.midY
        let width = rect.width

        path.move(to: CGPoint(x: 0, y: midY))
        for x in stride(from: 0, through: width, by: 1) {
            let relativeX = x / width
            let y = midY + sin(relativeX * frequency * 2 * .pi + phase) * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        return path
    }
}

#Preview {
    @Previewable @State var v: Double = 0.5

    SoftSlider(value: $v) {
        print("committed: \(v)")
    }
    .padding()
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.quellMidnight.ignoresSafeArea())
}
