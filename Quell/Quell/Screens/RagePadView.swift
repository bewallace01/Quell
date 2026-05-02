import SwiftUI

struct RagePadView: View {

    let onDismiss: () -> Void

    @State private var text = ""
    @State private var visible = false
    @FocusState private var focused: Bool

    var body: some View {
        ZStack {
            Color.quellAbyss
                .ignoresSafeArea()

            VStack(spacing: .quellSpace7) {
                Text("type. nothing saves.")
                    .font(.quellCaption)
                    .foregroundStyle(Color.quellWhisper)

                TextField("", text: $text, axis: .vertical)
                    .font(.quellTitle)
                    .foregroundStyle(Color.quellCream)
                    .tint(Color.quellGlow)
                    .multilineTextAlignment(.leading)
                    .lineLimit(20...)
                    .padding(.horizontal, .quellSpace7)
                    .focused($focused)

                WordStone(label: "done") {
                    text = ""
                    focused = false
                    onDismiss()
                }
            }
            .opacity(visible ? 1 : 0)
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.2)) {
                visible = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                focused = true
            }
        }
    }
}

#Preview {
    RagePadView {}
}
