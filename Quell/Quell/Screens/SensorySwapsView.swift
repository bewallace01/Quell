import SwiftUI

struct SensorySwapsView: View {

    let category: SensoryCategory
    let onDismiss: () -> Void

    @StateObject private var store = SensorySwapStore.shared
    @State private var selected: SensorySwap? = nil
    @State private var visible = false

    var body: some View {
        ZStack {
            Color.quellAbyss
                .ignoresSafeArea()

            BioluminescentField()
                .ignoresSafeArea()

            if let swap = selected {
                detailView(swap)
                    .transition(.opacity)
            } else {
                listView
                    .transition(.opacity)
            }
        }
        .animation(.quellEaseSlow(duration: .quellDurSlow), value: selected)
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.3)) {
                visible = true
            }
        }
    }

    private var listView: some View {
        VStack(spacing: .quellSpace7) {
            Text(category.label)
                .font(.quellTitle)
                .foregroundStyle(Color.quellCream)

            VStack(spacing: .quellSpace4) {
                ForEach(store.swaps(in: category)) { swap in
                    Button {
                        selected = swap
                    } label: {
                        HStack {
                            Text(swap.title)
                                .font(.quellBody)
                                .foregroundStyle(Color.quellCream)
                                .multilineTextAlignment(.leading)
                            Spacer()
                            if !swap.isFood {
                                Text("non-food")
                                    .font(.quellCaption)
                                    .foregroundStyle(Color.quellWhisper)
                            }
                        }
                        .padding(.vertical, .quellSpace3)
                        .padding(.horizontal, .quellSpace5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.quellShade.opacity(0.6))
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, .quellSpace7)

            WordStone(label: "back") { onDismiss() }
        }
        .opacity(visible ? 1 : 0)
    }

    private func detailView(_ swap: SensorySwap) -> some View {
        VStack(spacing: .quellSpace7) {
            Text(swap.title)
                .font(.quellDisplay)
                .foregroundStyle(Color.quellCream)
                .multilineTextAlignment(.center)
                .padding(.horizontal, .quellSpace7)

            Text(swap.why)
                .font(.quellBody)
                .foregroundStyle(Color.quellMist)
                .multilineTextAlignment(.center)
                .lineSpacing(.quellBodyLineSpacing)
                .padding(.horizontal, .quellSpace7)

            HStack(spacing: .quellSpace6) {
                WordStone(label: "back") { selected = nil }
                WordStone(label: "i'll try this") { onDismiss() }
            }
        }
    }
}

#Preview {
    SensorySwapsView(category: .crunch, onDismiss: {})
}
