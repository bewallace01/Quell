import SwiftUI

/// Two ethereal jellyfish tucked into opposite corners. Tentacles flow as
/// curving Bezier ribbons biased away from the corner, with compound-wave
/// undulation per tentacle for organic asymmetry. Halos fall off in 5 layers
/// with very low alphas so the glow blends seamlessly into the dark field.
struct JellyfishField: View {

    private struct Jelly {
        /// Starting angle on the elliptical orbit (radians).
        var startAngle: Double
        /// Radians per second.
        var orbitSpeed: Double
        /// +1 = clockwise, -1 = counterclockwise.
        var direction: Double
        /// How far the orbit ellipse is inset from the screen edge.
        var orbitInset: CGFloat
        var bellWidth: CGFloat
        var bellHeight: CGFloat
        var pulseSpeed: Double
        var tentacleCount: Int
        var phase: Double
        var warm: Bool
        var alpha: Double
        var sparkleOffsets: [CGSize]
    }

    private static let jellies: [Jelly] = [
        // Cool moon — counterclockwise around the perimeter, starting upper-right
        Jelly(
            startAngle: -.pi * 0.45,
            orbitSpeed: 0.018,
            direction: -1,
            orbitInset: 36,
            bellWidth: 56, bellHeight: 42,
            pulseSpeed: 0.42,
            tentacleCount: 8,
            phase: 0,
            warm: false,
            alpha: 0.16,
            sparkleOffsets: [
                CGSize(width: -36, height: -16),
                CGSize(width: -28, height: 26),
            ]
        ),
        // Warm glow — clockwise around the perimeter, starting lower-left
        Jelly(
            startAngle: .pi * 0.55,
            orbitSpeed: 0.014,
            direction: 1,
            orbitInset: 42,
            bellWidth: 64, bellHeight: 48,
            pulseSpeed: 0.36,
            tentacleCount: 9,
            phase: 1.7,
            warm: true,
            alpha: 0.16,
            sparkleOffsets: [
                CGSize(width: 44, height: -20),
                CGSize(width: 52, height: 16),
            ]
        ),
    ]

    var body: some View {
        TimelineView(.animation) { context in
            let t = context.date.timeIntervalSinceReferenceDate
            Canvas { ctx, size in
                for jelly in Self.jellies {
                    drawJelly(jelly, t: t, in: ctx, size: size)
                }
            }
        }
        .allowsHitTesting(false)
    }

    private func drawJelly(_ jelly: Jelly, t: TimeInterval, in ctx: GraphicsContext, size: CGSize) {
        // Elliptical orbit around the screen perimeter — drifts like ocean currents.
        let s = t * jelly.orbitSpeed * jelly.direction + jelly.startAngle
        let screenCx = size.width / 2
        let screenCy = size.height / 2
        let rx = max(0, screenCx - jelly.orbitInset)
        let ry = max(0, screenCy - jelly.orbitInset)
        // Slow current perturbation so the orbit isn't a perfect ellipse
        let currentX = sin(t * 0.05 + jelly.phase) * 14
        let currentY = cos(t * 0.04 + jelly.phase) * 10
        let macroX = screenCx + cos(s) * rx + currentX
        let macroY = screenCy + sin(s) * ry + currentY
        // Tiny wobble on top, like the jelly is swimming
        let wobbleX = sin(t * 0.32 + jelly.phase * 1.3) * 4
        let wobbleY = cos(t * 0.27 + jelly.phase * 0.8) * 3
        let cx = macroX + wobbleX
        let cy = macroY + wobbleY

        let pulseT = t * jelly.pulseSpeed + jelly.phase
        let pulse = 1.0 + 0.10 * sin(pulseT)
        let bellW = jelly.bellWidth * pulse
        let bellH = jelly.bellHeight * pulse

        let baseColor: Color = jelly.warm ? .quellGlow : .quellMoon
        let bottomY = cy + bellH * 0.30

        // Tentacles always bend away from the nearest vertical edge (toward
        // screen center). Computed dynamically since the jelly is moving.
        let dynamicBias: Double = cx > screenCx ? -1.0 : 1.0

        // Single radial-gradient halo — smooth alpha falloff to transparent,
        // no visible rings. Halo drifts slightly off the bell center.
        let haloPulse = 1.0 + 0.14 * sin(t * 0.26 + jelly.phase)
        let haloDriftX = sin(t * 0.18 + jelly.phase * 0.5) * 4
        let haloDriftY = cos(t * 0.14 + jelly.phase * 0.5) * 3
        let hcx = cx + haloDriftX
        let hcy = cy + haloDriftY
        let haloR = bellW * 1.9 * haloPulse
        ctx.fill(
            Path(ellipseIn: CGRect(
                x: hcx - haloR,
                y: hcy - haloR * 0.75,
                width: haloR * 2,
                height: haloR * 1.5
            )),
            with: .radialGradient(
                Gradient(stops: [
                    .init(color: baseColor.opacity(jelly.alpha * 0.55), location: 0.0),
                    .init(color: baseColor.opacity(jelly.alpha * 0.30), location: 0.25),
                    .init(color: baseColor.opacity(jelly.alpha * 0.12), location: 0.55),
                    .init(color: baseColor.opacity(jelly.alpha * 0.04), location: 0.80),
                    .init(color: baseColor.opacity(0), location: 1.0),
                ]),
                center: CGPoint(x: hcx, y: hcy),
                startRadius: 0,
                endRadius: haloR
            )
        )

        for offset in jelly.sparkleOffsets {
            drawSparkle(
                at: CGPoint(x: cx + offset.width, y: cy + offset.height),
                t: t,
                phase: jelly.phase + Double(offset.width) * 0.01,
                color: baseColor,
                alpha: jelly.alpha,
                in: ctx
            )
        }

        // Tentacles — curving ribbons with compound waves and per-index
        // parameter variation so no two look the same.
        let tentacleSpread = bellW * 0.55
        let tentacleStartX = cx - tentacleSpread * 0.5
        let tentacleSpacing = jelly.tentacleCount > 1
            ? tentacleSpread / Double(jelly.tentacleCount - 1)
            : 0

        for i in 0..<jelly.tentacleCount {
            let xStart = tentacleStartX + Double(i) * tentacleSpacing

            // Per-tentacle deterministic variation via prime-modulo offsets
            let lengthFactor = 1.3 + Double((i * 7 + 3) % 7) * 0.55
            let length = bellH * lengthFactor

            let centerOffset = Double(i) - Double(jelly.tentacleCount - 1) / 2.0
            let curveBase = 16 + abs(centerOffset) * 7
            let curveJitter = Double((i * 11 + 5) % 5) * 7
            // Some tentacles slightly buck the bias (small back-curl)
            let biasMul: Double = (i * 3) % 7 == 0 ? 0.4 : 1.0
            let curveStrength = (curveBase + curveJitter) * biasMul

            let endX = xStart + dynamicBias * curveStrength * (length / bellH)
            let endY = bottomY + length

            let cp1Y = bottomY + length * (0.30 + Double((i * 17 + 1) % 4) * 0.05)
            let cp2Y = bottomY + length * (0.70 + Double((i * 23 + 4) % 4) * 0.04)
            let cp1X = xStart + dynamicBias * curveStrength * (0.2 + Double((i * 13 + 2) % 4) * 0.10)
            let cp2X = endX - dynamicBias * curveStrength * (0.15 + Double((i * 19 + 8) % 4) * 0.10)

            // Compound-wave parameters
            let waveBase = t * (0.85 + Double(i % 4) * 0.18) + Double(i) * 0.55 + jelly.phase
            let waveAmp1 = 4.5 + Double((i * 5 + 1) % 5) * 3.0
            let waveAmp2 = 1.8 + Double((i * 11 + 7) % 4) * 1.6
            let waveFreq1 = 3.0 + Double((i * 7 + 3) % 6) * 1.2
            let waveFreq2 = 7.0 + Double((i * 13 + 5) % 5) * 1.8
            let wavePhase2 = Double((i * 31 + 9) % 7) * 0.5
            let widthBase = 1.4 + Double((i * 5 + 2) % 4) * 0.25

            let paired = (i * 3 + 1) % 4 == 0
            let ribbonStrokes: [Double] = paired ? [-2.5, 2.5] : [0]

            for offset in ribbonStrokes {
                drawTentacle(
                    start: CGPoint(x: xStart, y: bottomY),
                    cp1: CGPoint(x: cp1X, y: cp1Y),
                    cp2: CGPoint(x: cp2X, y: cp2Y),
                    end: CGPoint(x: endX, y: endY),
                    waveBase: waveBase,
                    waveAmp1: waveAmp1,
                    waveAmp2: waveAmp2,
                    waveFreq1: waveFreq1,
                    waveFreq2: waveFreq2,
                    wavePhase2: wavePhase2,
                    parallelOffset: offset,
                    widthBase: widthBase,
                    color: baseColor,
                    alpha: jelly.alpha,
                    bias: dynamicBias,
                    in: ctx
                )
            }
        }

        // Bell — domed top with frilled skirt
        var bell = Path()
        let leftX = cx - bellW * 0.5
        let rightX = cx + bellW * 0.5
        let topControlY = cy - bellH * 1.0
        let frillBaseY = bottomY + 3 * sin(t * 0.7 + jelly.phase)

        bell.move(to: CGPoint(x: leftX, y: bottomY))
        bell.addQuadCurve(
            to: CGPoint(x: rightX, y: bottomY),
            control: CGPoint(x: cx, y: topControlY)
        )
        bell.addQuadCurve(
            to: CGPoint(x: leftX, y: bottomY),
            control: CGPoint(x: cx, y: frillBaseY + bellH * 0.18)
        )
        bell.closeSubpath()

        let gradient = Gradient(colors: [
            baseColor.opacity(jelly.alpha * 1.4),
            baseColor.opacity(jelly.alpha * 0.55),
            baseColor.opacity(0),
        ])
        ctx.fill(
            bell,
            with: .radialGradient(
                gradient,
                center: CGPoint(x: cx, y: cy - bellH * 0.2),
                startRadius: 0,
                endRadius: bellW * 0.65
            )
        )

        ctx.stroke(
            bell,
            with: .color(baseColor.opacity(jelly.alpha * 0.6)),
            lineWidth: 0.7
        )

        // Inner glow — pulses out of phase
        let innerPulseT = t * jelly.pulseSpeed * 1.35 + jelly.phase + .pi / 2
        let innerSize = bellW * (0.32 + 0.06 * sin(innerPulseT))
        ctx.fill(
            Path(ellipseIn: CGRect(
                x: cx - innerSize * 0.5,
                y: cy - bellH * 0.25 - innerSize * 0.3,
                width: innerSize,
                height: innerSize * 0.65
            )),
            with: .color(baseColor.opacity(jelly.alpha * 0.45))
        )
    }

    private func drawTentacle(
        start: CGPoint,
        cp1: CGPoint,
        cp2: CGPoint,
        end: CGPoint,
        waveBase: Double,
        waveAmp1: Double,
        waveAmp2: Double,
        waveFreq1: Double,
        waveFreq2: Double,
        wavePhase2: Double,
        parallelOffset: Double,
        widthBase: Double,
        color: Color,
        alpha: Double,
        bias: Double,
        in ctx: GraphicsContext
    ) {
        let dx = end.x - start.x
        let dy = end.y - start.y
        let approxLength = sqrt(dx * dx + dy * dy)
        let segmentCount = max(8, Int(approxLength / 4))

        var prev = start
        for s in 1...segmentCount {
            let p = Double(s) / Double(segmentCount)
            let omp = 1 - p

            // Cubic Bezier
            let bx = omp * omp * omp * start.x
                + 3 * omp * omp * p * cp1.x
                + 3 * omp * p * p * cp2.x
                + p * p * p * end.x
            let by = omp * omp * omp * start.y
                + 3 * omp * omp * p * cp1.y
                + 3 * omp * p * p * cp2.y
                + p * p * p * end.y

            // Compound wave — two sines added, each with its own freq and amp
            let wave1 = sin(waveBase + p * waveFreq1) * waveAmp1 * (1 - p * 0.25)
            let wave2 = sin(waveBase * 0.7 + p * waveFreq2 + wavePhase2) * waveAmp2 * (1 - p * 0.4)
            let wave = wave1 + wave2

            let xWithWave = bx + wave * (-bias) + parallelOffset
            let yWithWave = by + wave * 0.25

            var seg = Path()
            seg.move(to: prev)
            seg.addLine(to: CGPoint(x: xWithWave, y: yWithWave))

            let lineWidth = widthBase * (1 - p * 0.85)
            let segAlpha = alpha * (0.85 - p * 0.7)
            ctx.stroke(
                seg,
                with: .color(color.opacity(segAlpha)),
                lineWidth: max(0.25, lineWidth)
            )

            prev = CGPoint(x: xWithWave, y: yWithWave)
        }
    }

    private func drawSparkle(
        at point: CGPoint,
        t: TimeInterval,
        phase: Double,
        color: Color,
        alpha: Double,
        in ctx: GraphicsContext
    ) {
        let twinkle = 0.4 + 0.6 * (0.5 + 0.5 * sin(t * 1.2 + phase))
        let armLong: CGFloat = 7
        let armShort: CGFloat = 4

        var path = Path()
        path.move(to: CGPoint(x: point.x, y: point.y - armLong))
        path.addLine(to: CGPoint(x: point.x, y: point.y + armLong))
        path.move(to: CGPoint(x: point.x - armShort, y: point.y))
        path.addLine(to: CGPoint(x: point.x + armShort, y: point.y))

        ctx.stroke(
            path,
            with: .color(color.opacity(alpha * twinkle * 0.9)),
            lineWidth: 0.7
        )

        let dotR: CGFloat = 1.2
        ctx.fill(
            Path(ellipseIn: CGRect(
                x: point.x - dotR,
                y: point.y - dotR,
                width: dotR * 2,
                height: dotR * 2
            )),
            with: .color(color.opacity(alpha * twinkle))
        )
    }
}

#Preview {
    ZStack {
        Color.quellMidnight.ignoresSafeArea()
        JellyfishField()
            .ignoresSafeArea()
    }
}
