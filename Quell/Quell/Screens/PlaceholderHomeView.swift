import SwiftUI

struct PlaceholderHomeView: View {

    @State private var orbVisible = false
    @State private var promptVisible = false
    @State private var stonesVisible = false

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            VStack(spacing: .quellSpace8) {
                Text("right now i'm…")
                    .font(.quellTitle)
                    .foregroundStyle(Color.quellCream)
                    .opacity(promptVisible ? 1 : 0)

                BreathingShape()
                    .opacity(orbVisible ? 1 : 0)

                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: .quellSpace6),
                        GridItem(.flexible(), spacing: .quellSpace6),
                    ],
                    spacing: .quellSpace5
                ) {
                    WordStone(label: "Steady") {}
                    WordStone(label: "Wobbling") {}
                    WordStone(label: "In it") {}
                    WordStone(label: "Need company") {}
                }
                .padding(.horizontal, .quellSpace7)
                .opacity(stonesVisible ? 1 : 0)
            }
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
                orbVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.6)) {
                promptVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(1.2)) {
                stonesVisible = true
            }
        }
    }
}

#Preview {
    PlaceholderHomeView()
}
