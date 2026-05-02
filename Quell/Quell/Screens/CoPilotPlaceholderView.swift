import SwiftUI

struct CoPilotPlaceholderView: View {

    let onDismiss: () -> Void

    @Environment(\.openURL) private var openURL

    @State private var promptVisible = false
    @State private var actionsVisible = false

    var body: some View {
        ZStack {
            Color.quellAbyss
                .ignoresSafeArea()

            VStack(spacing: .quellSpace8) {
                Text("let's escalate.")
                    .font(.quellDisplay)
                    .foregroundStyle(Color.quellCream)
                    .multilineTextAlignment(.center)
                    .opacity(promptVisible ? 1 : 0)

                VStack(spacing: .quellSpace5) {
                    WordStone(label: "988 — call") {
                        if let url = URL(string: "tel:988") {
                            openURL(url)
                        }
                    }

                    WordStone(label: "back to home") {
                        onDismiss()
                    }
                }
                .opacity(actionsVisible ? 1 : 0)
            }
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.4)) {
                promptVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(1.0)) {
                actionsVisible = true
            }
        }
    }
}

#Preview {
    CoPilotPlaceholderView {}
}
