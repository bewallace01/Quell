import SwiftUI

struct ClosingLineView: View {

    let line: String
    let onComplete: () -> Void

    @State private var visible = false

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            JellyfishField()
                .ignoresSafeArea()

            BioluminescentField()
                .ignoresSafeArea()

            Text(line)
                .font(.quellDisplay)
                .foregroundStyle(Color.quellCream)
                .multilineTextAlignment(.center)
                .padding(.horizontal, .quellSpace7)
                .opacity(visible ? 1 : 0)
        }
        .onAppear {
            LogStore.shared.log("close")
            WrenSpeaker.shared.speak(line)
            withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
                visible = true
            }
            Task { @MainActor in
                try? await Task.sleep(for: .seconds(3.5))
                onComplete()
            }
        }
    }
}

#Preview {
    ClosingLineView(line: "thanks for showing up.") {}
}
