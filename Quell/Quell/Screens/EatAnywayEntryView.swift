import SwiftUI

struct EatAnywayEntryView: View {

    let onMindful: () -> Void
    let onJustEat: () -> Void

    @State private var promptVisible = false
    @State private var actionsVisible = false

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            VStack(spacing: .quellSpace8) {
                Text("sounds good.\nwant to slow it down?")
                    .font(.quellDisplay)
                    .foregroundStyle(Color.quellCream)
                    .multilineTextAlignment(.center)
                    .opacity(promptVisible ? 1 : 0)

                VStack(spacing: .quellSpace5) {
                    WordStone(label: "yes, walk me through") {
                        onMindful()
                    }
                    WordStone(label: "just eat. i'll check back.") {
                        onJustEat()
                    }
                }
                .opacity(actionsVisible ? 1 : 0)
            }
            .padding(.horizontal, .quellSpace7)
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.3)) {
                promptVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(1.0)) {
                actionsVisible = true
            }
        }
    }
}

#Preview {
    EatAnywayEntryView(onMindful: {}, onJustEat: {})
}
