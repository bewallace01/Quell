import SwiftUI

struct BodyTapScanView: View {

    let onComplete: (ScanSuggestion) -> Void

    @State private var taps: [CGPoint] = []
    @State private var visible = false
    @State private var canvasHeight: CGFloat = 1

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            JellyfishField()
                .ignoresSafeArea()

            BioluminescentField()
                .ignoresSafeArea()

            VStack(spacing: .quellSpace7) {
                Text("where do you feel it?")
                    .font(.quellTitle)
                    .foregroundStyle(Color.quellCream)

                ZStack {
                    BodyShape()
                        .fill(
                            LinearGradient(
                                colors: [Color.quellMoon.opacity(0.18), Color.quellMidnight.opacity(0)],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .overlay(
                            BodyShape()
                                .stroke(Color.quellMoon.opacity(0.5), lineWidth: 1.2)
                        )

                    ForEach(taps.indices, id: \.self) { i in
                        Circle()
                            .fill(Color.quellGlow)
                            .frame(width: 18, height: 18)
                            .blur(radius: 3)
                            .position(taps[i])
                            .shadow(color: Color.quellGlow.opacity(0.7), radius: 8)
                    }
                }
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear { canvasHeight = geo.size.height }
                            .onChange(of: geo.size.height) { _, h in canvasHeight = h }
                    }
                )
                .frame(maxWidth: 220, maxHeight: 360)
                .contentShape(Rectangle())
                .onTapGesture { location in
                    taps.append(location)
                }

                VStack(spacing: .quellSpace4) {
                    if !taps.isEmpty {
                        WordStone(label: "done") { commit() }
                    }
                    WordStone(label: "skip") {
                        onComplete(.coRegulation)
                    }
                }
            }
            .opacity(visible ? 1 : 0)
            .padding(.horizontal, .quellSpace7)
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.3)) {
                visible = true
            }
        }
    }

    private func commit() {
        guard !taps.isEmpty else {
            onComplete(.coRegulation)
            return
        }
        // Average tap y position. Stomach zone roughly 35-55% down the body.
        let avgY = taps.map(\.y).reduce(0, +) / CGFloat(taps.count)
        let stomachLower = canvasHeight * 0.30
        let stomachUpper = canvasHeight * 0.55
        let suggestion: ScanSuggestion = (avgY >= stomachLower && avgY <= stomachUpper)
            ? .eatAnyway
            : .coRegulation
        onComplete(suggestion)
    }
}

private struct BodyShape: Shape {

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cx = rect.midX
        let w = rect.width
        let h = rect.height

        // Head — soft circle at top
        let headSize = w * 0.28
        path.addEllipse(in: CGRect(
            x: cx - headSize * 0.5,
            y: h * 0.04,
            width: headSize,
            height: headSize * 1.05
        ))

        // Neck — small rectangle
        path.addRoundedRect(
            in: CGRect(
                x: cx - w * 0.08,
                y: h * 0.18,
                width: w * 0.16,
                height: h * 0.04
            ),
            cornerSize: CGSize(width: w * 0.04, height: h * 0.02)
        )

        // Torso — rounded body
        path.addRoundedRect(
            in: CGRect(
                x: cx - w * 0.20,
                y: h * 0.21,
                width: w * 0.40,
                height: h * 0.38
            ),
            cornerSize: CGSize(width: w * 0.10, height: h * 0.04)
        )

        // Arms — angled rounded rectangles falling from shoulders
        let armW = w * 0.10
        let armH = h * 0.36
        // Left arm
        path.addRoundedRect(
            in: CGRect(
                x: cx - w * 0.34,
                y: h * 0.23,
                width: armW,
                height: armH
            ),
            cornerSize: CGSize(width: armW * 0.5, height: armW * 0.5)
        )
        // Right arm
        path.addRoundedRect(
            in: CGRect(
                x: cx + w * 0.24,
                y: h * 0.23,
                width: armW,
                height: armH
            ),
            cornerSize: CGSize(width: armW * 0.5, height: armW * 0.5)
        )

        // Legs — two rectangles
        let legW = w * 0.14
        let legH = h * 0.34
        path.addRoundedRect(
            in: CGRect(
                x: cx - w * 0.18,
                y: h * 0.61,
                width: legW,
                height: legH
            ),
            cornerSize: CGSize(width: legW * 0.4, height: legW * 0.4)
        )
        path.addRoundedRect(
            in: CGRect(
                x: cx + w * 0.04,
                y: h * 0.61,
                width: legW,
                height: legH
            ),
            cornerSize: CGSize(width: legW * 0.4, height: legW * 0.4)
        )

        return path
    }
}

#Preview {
    BodyTapScanView { _ in }
}
