import SwiftUI

// Everything moves like water. Slow easing curves, never snappy.
// Transitions dissolve, not slide.

extension Double {

    /// 0.2s. Tap feedback and small element changes.
    static let quellDurFast: Double = 0.2

    /// 0.4s. Standard in-screen transitions.
    static let quellDurMid: Double = 0.4

    /// 0.8s. Screen transitions and major reveals.
    static let quellDurSlow: Double = 0.8

    /// 4.0s. Breathing inhale.
    static let quellDurBreath: Double = 4.0

    /// 6.0s. Breathing exhale — longer than inhale for parasympathetic activation.
    static let quellDurExhale: Double = 6.0
}

extension Animation {

    /// Cubic-bezier(0.4, 0.0, 0.2, 1.0). Smooth decelerate ease.
    /// Pair with a duration token. Defaults to `.quellDurMid`.
    static func quellEaseGentle(duration: Double = .quellDurMid) -> Animation {
        .timingCurve(0.4, 0.0, 0.2, 1.0, duration: duration)
    }

    /// Cubic-bezier(0.25, 0.1, 0.25, 1.0). Longer glide, no snap.
    /// Pair with a duration token. Defaults to `.quellDurSlow`.
    static func quellEaseSlow(duration: Double = .quellDurSlow) -> Animation {
        .timingCurve(0.25, 0.1, 0.25, 1.0, duration: duration)
    }
}
