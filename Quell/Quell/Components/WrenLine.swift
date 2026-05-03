import SwiftUI

struct WrenLine: View {

    let phrases: [String]
    let interval: Duration

    @State private var index = 0
    @State private var visible = true

    var body: some View {
        Text(phrases[index])
            .font(.quellDisplay)
            .foregroundStyle(Color.quellCream)
            .multilineTextAlignment(.center)
            .opacity(visible ? 1 : 0)
            .task {
                while !Task.isCancelled {
                    try? await Task.sleep(for: interval)

                    withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
                        visible = false
                    }
                    try? await Task.sleep(for: .seconds(.quellDurSlow))

                    index = (index + 1) % phrases.count
                    WrenSpeaker.shared.speak(phrases[index])

                    withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
                        visible = true
                    }
                }
            }
            .onAppear {
                WrenSpeaker.shared.speak(phrases[index])
            }
            .onDisappear {
                WrenSpeaker.shared.stop()
            }
    }
}

#Preview {
    WrenLine(
        phrases: [
            "i'm here.",
            "breathe with me.",
            "we can stay here.",
        ],
        interval: .seconds(3)
    )
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.quellAbyss.ignoresSafeArea())
}
