import SwiftUI

struct TokenPreview: View {

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: .quellSpace7) {
                header
                colorsSection
                typographySection
                spacingSection
                motionSection
            }
            .padding(.horizontal, .quellSpace5)
            .padding(.top, .quellSpace7)
            .padding(.bottom, .quellSpace8)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color.quellMidnight.ignoresSafeArea())
        .foregroundStyle(Color.quellCream)
    }

    // MARK: - Sections

    private var header: some View {
        VStack(alignment: .leading, spacing: .quellSpace2) {
            Text("design tokens")
                .font(.quellDisplay)
                .foregroundStyle(Color.quellCream)
            Text("a visual roll call of every quell primitive.")
                .font(.quellBody)
                .foregroundStyle(Color.quellMist)
        }
    }

    private var colorsSection: some View {
        SectionContainer(title: "colors") {
            VStack(alignment: .leading, spacing: .quellSpace5) {
                ColorGroup(title: "bases", swatches: [
                    .init(name: "quellMidnight", hex: "#0B1220", color: .quellMidnight),
                    .init(name: "quellDeep",     hex: "#131C2E", color: .quellDeep),
                    .init(name: "quellShade",    hex: "#1C2638", color: .quellShade),
                ])
                ColorGroup(title: "text", swatches: [
                    .init(name: "quellCream",   hex: "#F2EBDD", color: .quellCream),
                    .init(name: "quellMist",    hex: "#A0AAC0", color: .quellMist),
                    .init(name: "quellWhisper", hex: "#565F76", color: .quellWhisper),
                ])
                ColorGroup(title: "cool", swatches: [
                    .init(name: "quellMoon", hex: "#4A8FB5", color: .quellMoon),
                    .init(name: "quellGlow", hex: "#2585D4", color: .quellGlow),
                ])
                ColorGroup(title: "warm", swatches: [
                    .init(name: "quellEmber", hex: "#D85A30", color: .quellEmber),
                    .init(name: "quellDawn",  hex: "#E8946A", color: .quellDawn),
                ])
                ColorGroup(title: "functional", swatches: [
                    .init(name: "quellCalm",  hex: "= quellMoon",  color: .quellCalm),
                    .init(name: "quellAlert", hex: "= quellEmber", color: .quellAlert),
                ])
            }
        }
    }

    private var typographySection: some View {
        SectionContainer(title: "typography") {
            VStack(alignment: .leading, spacing: .quellSpace5) {
                TypeSample(name: "quellDisplay",  font: .quellDisplay,  sample: "for when it's loud.")
                TypeSample(name: "quellTitle",    font: .quellTitle,    sample: "right now i'm")
                TypeSample(name: "quellHeadline", font: .quellHeadline, sample: "wave check")
                TypeSample(
                    name: "quellBody",
                    font: .quellBody,
                    lineSpacing: .quellBodyLineSpacing,
                    sample: "wave's gonna pass. it always does. you're doing the work by being here."
                )
                TypeSample(name: "quellLabel",   font: .quellLabel,   sample: "stay")
                TypeSample(name: "quellCaption", font: .quellCaption, sample: "no verdict. just data.")
            }
        }
    }

    private var spacingSection: some View {
        SectionContainer(title: "spacing") {
            VStack(alignment: .leading, spacing: .quellSpace3) {
                SpaceBar(name: "quellSpace1", value: .quellSpace1)
                SpaceBar(name: "quellSpace2", value: .quellSpace2)
                SpaceBar(name: "quellSpace3", value: .quellSpace3)
                SpaceBar(name: "quellSpace4", value: .quellSpace4)
                SpaceBar(name: "quellSpace5", value: .quellSpace5)
                SpaceBar(name: "quellSpace6", value: .quellSpace6)
                SpaceBar(name: "quellSpace7", value: .quellSpace7)
                SpaceBar(name: "quellSpace8", value: .quellSpace8)
            }
        }
    }

    private var motionSection: some View {
        SectionContainer(title: "motion") {
            VStack(alignment: .leading, spacing: .quellSpace5) {
                BreathingDemo()
                TapMotionDemo(
                    name: "quellEaseGentle / quellDurMid",
                    animation: .quellEaseGentle(duration: .quellDurMid)
                )
                TapMotionDemo(
                    name: "quellEaseSlow / quellDurSlow",
                    animation: .quellEaseSlow(duration: .quellDurSlow)
                )
            }
        }
    }
}

// MARK: - Section container

private struct SectionContainer<Content: View>: View {
    let title: String
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: .quellSpace4) {
            Text(title)
                .font(.quellTitle)
                .foregroundStyle(Color.quellCream)
            content()
        }
    }
}

// MARK: - Colors

private struct ColorGroup: View {
    struct Swatch: Identifiable {
        let name: String
        let hex: String
        let color: Color
        var id: String { name }
    }

    let title: String
    let swatches: [Swatch]

    private let columns = [GridItem(.adaptive(minimum: 140), spacing: .quellSpace3)]

    var body: some View {
        VStack(alignment: .leading, spacing: .quellSpace3) {
            Text(title)
                .font(.quellLabel)
                .foregroundStyle(Color.quellMist)
            LazyVGrid(columns: columns, alignment: .leading, spacing: .quellSpace3) {
                ForEach(swatches) { swatch in
                    ColorSwatch(name: swatch.name, hex: swatch.hex, color: swatch.color)
                }
            }
        }
    }
}

private struct ColorSwatch: View {
    let name: String
    let hex: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: .quellSpace2) {
            RoundedRectangle(cornerRadius: 12)
                .fill(color)
                .frame(height: 80)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.quellShade, lineWidth: 1)
                )
            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.quellLabel)
                    .foregroundStyle(Color.quellCream)
                Text(hex)
                    .font(.quellCaption)
                    .foregroundStyle(Color.quellMist)
            }
        }
    }
}

// MARK: - Typography

private struct TypeSample: View {
    let name: String
    let font: Font
    var lineSpacing: CGFloat = 0
    let sample: String

    var body: some View {
        VStack(alignment: .leading, spacing: .quellSpace2) {
            Text(sample)
                .font(font)
                .lineSpacing(lineSpacing)
                .foregroundStyle(Color.quellCream)
            Text(name)
                .font(.quellCaption)
                .foregroundStyle(Color.quellWhisper)
        }
    }
}

// MARK: - Spacing

private struct SpaceBar: View {
    let name: String
    let value: CGFloat

    var body: some View {
        HStack(spacing: .quellSpace3) {
            Text(name)
                .font(.quellLabel)
                .foregroundStyle(Color.quellMist)
                .frame(width: 110, alignment: .leading)
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.quellMoon)
                .frame(width: value, height: 16)
            Text("\(Int(value))pt")
                .font(.quellCaption)
                .foregroundStyle(Color.quellWhisper)
            Spacer(minLength: 0)
        }
    }
}

// MARK: - Motion

private struct BreathingDemo: View {
    @State private var inhaled = false

    var body: some View {
        VStack(alignment: .leading, spacing: .quellSpace3) {
            Text("breathing — quellEaseSlow / quellDurBreath ↔ quellDurExhale")
                .font(.quellLabel)
                .foregroundStyle(Color.quellMist)
            HStack {
                Spacer()
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [Color.quellMoon, Color.quellMidnight],
                            center: .center,
                            startRadius: 0,
                            endRadius: inhaled ? 90 : 45
                        )
                    )
                    .frame(width: inhaled ? 180 : 90, height: inhaled ? 180 : 90)
                    .opacity(inhaled ? 0.95 : 0.45)
                Spacer()
            }
            .frame(height: 200)
            .task {
                while !Task.isCancelled {
                    withAnimation(.quellEaseSlow(duration: .quellDurBreath)) {
                        inhaled = true
                    }
                    try? await Task.sleep(for: .seconds(Double.quellDurBreath))
                    withAnimation(.quellEaseSlow(duration: .quellDurExhale)) {
                        inhaled = false
                    }
                    try? await Task.sleep(for: .seconds(Double.quellDurExhale))
                }
            }
        }
    }
}

private struct TapMotionDemo: View {
    let name: String
    let animation: Animation
    @State private var moved = false

    var body: some View {
        VStack(alignment: .leading, spacing: .quellSpace2) {
            Text(name)
                .font(.quellLabel)
                .foregroundStyle(Color.quellMist)
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.quellShade)
                        .frame(height: 4)
                    Circle()
                        .fill(Color.quellGlow)
                        .frame(width: 24, height: 24)
                        .offset(x: moved ? max(0, geo.size.width - 24) : 0)
                }
                .frame(height: 24)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(animation) { moved.toggle() }
                }
            }
            .frame(height: 24)
            Text("tap to play")
                .font(.quellCaption)
                .foregroundStyle(Color.quellWhisper)
        }
    }
}

#Preview {
    TokenPreview()
}
