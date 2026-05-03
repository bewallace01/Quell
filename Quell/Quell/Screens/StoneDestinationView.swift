import SwiftUI

struct StoneDestinationView: View {

    let word: String
    let onDismiss: () -> Void

    @State private var wordVisible = false

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            BioluminescentField()
                .ignoresSafeArea()

            Text(word)
                .font(.quellDisplay)
                .foregroundStyle(Color.quellCream)
                .opacity(wordVisible ? 1 : 0)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onDismiss()
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.2)) {
                wordVisible = true
            }
        }
    }
}

#Preview {
    StoneDestinationView(word: "Steady") {}
}
