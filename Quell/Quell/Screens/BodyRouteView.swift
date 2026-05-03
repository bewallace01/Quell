import SwiftUI

struct BodyRouteView: View {

    let onCategory: (SensoryCategory) -> Void
    let onWantFood: () -> Void

    @State private var promptVisible = false
    @State private var squaresVisible = false
    @State private var foodVisible = false

    var body: some View {
        ZStack {
            Color.quellAbyss
                .ignoresSafeArea()

            BioluminescentField()
                .ignoresSafeArea()

            VStack(spacing: .quellSpace7) {
                Text("what does your body actually want?")
                    .font(.quellTitle)
                    .foregroundStyle(Color.quellCream)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, .quellSpace7)
                    .opacity(promptVisible ? 1 : 0)

                VStack(spacing: .quellSpace5) {
                    HStack(spacing: .quellSpace5) {
                        SensorySquare(category: .crunch) { onCategory(.crunch) }
                        SensorySquare(category: .cold) { onCategory(.cold) }
                        SensorySquare(category: .warm) { onCategory(.warm) }
                    }
                    HStack(spacing: .quellSpace5) {
                        SensorySquare(category: .sweet) { onCategory(.sweet) }
                        SensorySquare(category: .salty) { onCategory(.salty) }
                    }
                }
                .opacity(squaresVisible ? 1 : 0)

                WordStone(label: "i want food") { onWantFood() }
                    .opacity(foodVisible ? 1 : 0)
            }
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.3)) {
                promptVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.9)) {
                squaresVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(1.5)) {
                foodVisible = true
            }
        }
    }
}

private struct SensorySquare: View {

    let category: SensoryCategory
    let onTap: () -> Void

    private let size: CGFloat = 90

    var body: some View {
        Button(action: onTap) {
            VStack(spacing: .quellSpace3) {
                RoundedRectangle(cornerRadius: 18)
                    .fill(
                        LinearGradient(
                            colors: category.gradientColors,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: size, height: size)
                    .blur(radius: 0.5)
                    .shadow(color: Color.quellMidnight.opacity(0.6), radius: 8, y: 4)

                Text(category.label)
                    .font(.quellStone)
                    .foregroundStyle(Color.quellCream)
                    .fixedSize(horizontal: true, vertical: false)
            }
        }
        .buttonStyle(SquarePressStyle())
    }
}

private struct SquarePressStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1.0)
            .animation(.quellEaseGentle(duration: .quellDurFast), value: configuration.isPressed)
    }
}

#Preview {
    BodyRouteView(onCategory: { _ in }, onWantFood: {})
}
