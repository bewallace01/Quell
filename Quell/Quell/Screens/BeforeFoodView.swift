import SwiftUI

struct BeforeFoodView: View {

    let onHungerCheck: () -> Void
    let onPreMeal: () -> Void
    let onDismiss: () -> Void

    @State private var promptVisible = false
    @State private var actionsVisible = false

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            JellyfishField()
                .ignoresSafeArea()

            BioluminescentField()
                .ignoresSafeArea()

            VStack(spacing: .quellSpace8) {
                Text("before food.")
                    .font(.quellTitle)
                    .foregroundStyle(Color.quellCream)
                    .opacity(promptVisible ? 1 : 0)

                VStack(spacing: .quellSpace5) {
                    WordStone(label: "am i hungry?") { onHungerCheck() }
                    WordStone(label: "ground before eating") { onPreMeal() }
                    WordStone(label: "back") { onDismiss() }
                }
                .opacity(actionsVisible ? 1 : 0)
            }
            .padding(.horizontal, .quellSpace7)
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.3)) {
                promptVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.9)) {
                actionsVisible = true
            }
        }
    }
}

#Preview {
    BeforeFoodView(onHungerCheck: {}, onPreMeal: {}, onDismiss: {})
}
