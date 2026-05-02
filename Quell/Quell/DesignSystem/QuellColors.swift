import SwiftUI

extension Color {

    // MARK: - Bases

    /// Deeper than midnight. The held interior of the urge flow — a near-black
    /// the home dissolves into when the user enters co-regulation.
    static let quellAbyss = Color(hex: "#040714")

    /// Deep night. The silhouette against the sky.
    static let quellMidnight = Color(hex: "#0B1220")

    /// Water away from the glow.
    static let quellDeep = Color(hex: "#131C2E")

    /// Elevated surfaces.
    static let quellShade = Color(hex: "#1C2638")

    // MARK: - Text

    /// Primary text. Warm cream — never pure white.
    static let quellCream = Color(hex: "#F2EBDD")

    /// Secondary text. Cool gray-blue.
    static let quellMist = Color(hex: "#A0AAC0")

    /// Tertiary text. Very subtle.
    static let quellWhisper = Color(hex: "#565F76")

    // MARK: - Cool

    /// Calm steel-blue. Always-there primary accent.
    static let quellMoon = Color(hex: "#4A8FB5")

    /// Electric bioluminescent blue. Active states only.
    static let quellGlow = Color(hex: "#2585D4")

    // MARK: - Warm

    /// Sunset-band orange. Charged/rare human warmth.
    static let quellEmber = Color(hex: "#D85A30")

    /// Diffused warm. Routine warmth.
    static let quellDawn = Color(hex: "#E8946A")

    // MARK: - Functional

    /// Success and calm states. Aliased to Moon.
    static let quellCalm = quellMoon

    /// Attention without alarm. Aliased to Ember.
    static let quellAlert = quellEmber
}

extension Color {

    /// Build a Color from a hex string like "#0A0F1A" or "0A0F1A".
    init(hex: String) {
        let trimmed = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        var rgb: UInt64 = 0
        Scanner(string: trimmed).scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255
        self.init(.sRGB, red: r, green: g, blue: b, opacity: 1)
    }
}
