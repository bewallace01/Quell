import SwiftUI

private let quellDisplayFamily = "Fraunces"
private let quellUIFamily = "Geist"

extension Font {

    // MARK: - Display (Fraunces)

    /// Hero phrases and presence moments. Light, large, generous.
    static let quellDisplay = Font.custom(quellDisplayFamily, size: 36, relativeTo: .largeTitle).weight(.light)

    /// Screen titles in the display voice.
    static let quellTitle = Font.custom(quellDisplayFamily, size: 24, relativeTo: .title).weight(.light)

    // MARK: - UI / Body (Geist)

    /// Section headers and prominent UI text.
    static let quellHeadline = Font.custom(quellUIFamily, size: 18, relativeTo: .headline).weight(.medium)

    /// Long-form reading. Pair with `.quellBodyLineSpacing` for 1.6+ line height.
    static let quellBody = Font.custom(quellUIFamily, size: 16, relativeTo: .body).weight(.regular)

    /// Buttons, navigation labels, small UI.
    static let quellLabel = Font.custom(quellUIFamily, size: 14, relativeTo: .subheadline).weight(.medium)

    /// Tertiary text and captions.
    static let quellCaption = Font.custom(quellUIFamily, size: 13, relativeTo: .caption).weight(.regular)
}

extension CGFloat {

    // SwiftUI's `.lineSpacing()` adds the gap *between* lines, not total leading.
    // These values target the line-height ratios the brief calls out:
    // Display = generous, Body = 1.6+.

    /// Pairs with `.quellDisplay`. Roomy breathing space around hero phrases.
    static let quellDisplayLineSpacing: CGFloat = 12

    /// Pairs with `.quellHeadline`.
    static let quellHeadlineLineSpacing: CGFloat = 6

    /// Pairs with `.quellBody`. 16pt × 1.6 ≈ 26pt total leading → ~10pt between lines.
    static let quellBodyLineSpacing: CGFloat = 10

    /// Pairs with `.quellLabel` and `.quellCaption`.
    static let quellCaptionLineSpacing: CGFloat = 4
}
