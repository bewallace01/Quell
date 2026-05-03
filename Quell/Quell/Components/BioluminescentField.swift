import SwiftUI

/// Drifting glowing points across the dark field — phytoplankton in deep water.
/// Used as an atmosphere overlay on the brand's emotional screens (home,
/// co-regulation, mood protocols, etc). Renders behind content; allows hit
/// testing to pass through.
struct BioluminescentField: View {

    /// Number of particles drawn. Higher = denser field.
    var count: Int = 24

    /// Multiplier on each particle's drift speed. 0 = still, 1 = lively.
    var drift: Double = 0.6

    private static let particles: [Particle] = generate(count: 50)

    var body: some View {
        TimelineView(.animation) { context in
            let t = context.date.timeIntervalSinceReferenceDate
            Canvas { ctx, size in
                for particle in Self.particles.prefix(count) {
                    draw(particle: particle, in: ctx, size: size, t: t)
                }
            }
        }
        .allowsHitTesting(false)
    }

    private func draw(particle: Particle, in ctx: GraphicsContext, size: CGSize, t: TimeInterval) {
        let phaseT = t * particle.driftSpeed * drift + particle.phase
        let x = particle.baseX * size.width + sin(phaseT) * particle.driftRangeX
        let y = particle.baseY * size.height + cos(phaseT * 0.7) * particle.driftRangeY

        let twinkleT = t * particle.twinkleSpeed + particle.phase
        let alpha = particle.baseAlpha * (0.55 + 0.45 * sin(twinkleT))

        let baseColor: Color = particle.warm ? .quellGlow : .quellMoon
        let core = baseColor.opacity(alpha)
        let halo = baseColor.opacity(alpha * 0.25)

        let r = particle.baseRadius
        ctx.fill(
            Path(ellipseIn: CGRect(x: x - r, y: y - r, width: r * 2, height: r * 2)),
            with: .color(core)
        )

        let hr = r * 3
        ctx.fill(
            Path(ellipseIn: CGRect(x: x - hr, y: y - hr, width: hr * 2, height: hr * 2)),
            with: .color(halo)
        )
    }

    private static func generate(count: Int) -> [Particle] {
        var rng = SeededGenerator(seed: 42)
        return (0..<count).map { _ in Particle.random(using: &rng) }
    }
}

private struct Particle {
    var baseX: Double
    var baseY: Double
    var baseRadius: Double
    var driftSpeed: Double
    var driftRangeX: Double
    var driftRangeY: Double
    var phase: Double
    var twinkleSpeed: Double
    var baseAlpha: Double
    var warm: Bool

    static func random<G: RandomNumberGenerator>(using g: inout G) -> Particle {
        Particle(
            baseX: Double.random(in: 0...1, using: &g),
            baseY: Double.random(in: 0...1, using: &g),
            baseRadius: Double.random(in: 1.0...3.0, using: &g),
            driftSpeed: Double.random(in: 0.05...0.18, using: &g),
            driftRangeX: Double.random(in: 8...28, using: &g),
            driftRangeY: Double.random(in: 4...14, using: &g),
            phase: Double.random(in: 0...(2 * .pi), using: &g),
            twinkleSpeed: Double.random(in: 0.3...0.9, using: &g),
            baseAlpha: Double.random(in: 0.18...0.55, using: &g),
            warm: Double.random(in: 0...1, using: &g) > 0.75
        )
    }
}

private struct SeededGenerator: RandomNumberGenerator {
    var state: UInt64
    init(seed: UInt64) { state = seed }
    mutating func next() -> UInt64 {
        state = state &* 6_364_136_223_846_793_005 &+ 1_442_695_040_888_963_407
        return state
    }
}

#Preview {
    ZStack {
        Color.quellMidnight.ignoresSafeArea()
        BioluminescentField()
            .ignoresSafeArea()
    }
}
