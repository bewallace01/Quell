import SwiftUI

struct CrisisResourcesView: View {

    let onDismiss: () -> Void

    @Environment(\.openURL) private var openURL

    @State private var visible = false

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            JellyfishField()
                .ignoresSafeArea()

            BioluminescentField()
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: .quellSpace7) {
                    Text("more support is here.")
                        .font(.quellTitle)
                        .foregroundStyle(Color.quellCream)
                        .padding(.top, .quellSpace7)

                    VStack(spacing: .quellSpace4) {
                        resourceRow(
                            title: "988 — call or text",
                            subtitle: "suicide & crisis lifeline · 24/7",
                            action: { open("tel:988") }
                        )
                        resourceRow(
                            title: "text HOME to 741741",
                            subtitle: "crisis text line · 24/7",
                            action: { open("sms:741741&body=HOME") }
                        )
                        resourceRow(
                            title: "911",
                            subtitle: "if you're in immediate danger",
                            action: { open("tel:911") }
                        )
                    }

                    Text("this app is a supplement to professional care.\nnot a replacement.")
                        .font(.quellCaption)
                        .foregroundStyle(Color.quellMist)
                        .multilineTextAlignment(.center)
                        .lineSpacing(.quellCaptionLineSpacing)
                        .padding(.top, .quellSpace4)

                    WordStone(label: "back") { onDismiss() }
                        .padding(.top, .quellSpace5)
                }
                .padding(.horizontal, .quellSpace7)
                .padding(.bottom, .quellSpace7)
            }
            .opacity(visible ? 1 : 0)
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.2)) {
                visible = true
            }
        }
    }

    private func resourceRow(title: String, subtitle: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.quellBody)
                    .foregroundStyle(Color.quellCream)
                Text(subtitle)
                    .font(.quellCaption)
                    .foregroundStyle(Color.quellMist)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, .quellSpace5)
            .padding(.vertical, .quellSpace4)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.quellShade.opacity(0.5))
            )
        }
        .buttonStyle(.plain)
    }

    private func open(_ raw: String) {
        guard let url = URL(string: raw) else { return }
        openURL(url)
    }
}

#Preview {
    CrisisResourcesView {}
}
