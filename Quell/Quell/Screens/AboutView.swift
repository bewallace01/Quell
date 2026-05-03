import SwiftUI

struct AboutView: View {

    let onDismiss: () -> Void

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
                VStack(alignment: .leading, spacing: .quellSpace6) {
                    Text("quell.")
                        .font(.quellDisplay)
                        .foregroundStyle(Color.quellCream)
                        .padding(.top, .quellSpace7)

                    Text("no fixing. just presence.")
                        .font(.quellTitle)
                        .foregroundStyle(Color.quellMoon)

                    paragraph("we're not here to interrupt the urge or argue with it. we're here to sit with you while it passes — or while you eat anyway.")

                    paragraph("everything you save stays on your device. no cloud sync. no tracking. no analytics. your patterns are yours.")

                    paragraph("this app is a supplement to professional care, not a replacement. if you're struggling, please reach out to a clinician.")

                    paragraph("a note on wren's voice. wren reads aloud using ios speech. for a much more human-sounding voice, install a premium english voice in ios settings → accessibility → spoken content → voices. without one, wren will sound a bit robotic.")
                        .foregroundStyle(Color.quellMist)

                    paragraph("clinical advisor: tbd.")
                        .foregroundStyle(Color.quellWhisper)

                    HStack {
                        Spacer()
                        WordStone(label: "back") { onDismiss() }
                        Spacer()
                    }
                    .padding(.top, .quellSpace7)
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

    private func paragraph(_ text: String) -> some View {
        Text(text)
            .font(.quellBody)
            .foregroundStyle(Color.quellCream)
            .lineSpacing(.quellBodyLineSpacing)
    }
}

#Preview {
    AboutView {}
}
