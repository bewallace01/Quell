import SwiftUI

struct SteadyView: View {

    let onLeaveNote: () -> Void
    let onDismiss: () -> Void

    @State private var lineVisible = false
    @State private var actionsVisible = false

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            JellyfishField()
                .ignoresSafeArea()

            BioluminescentField()
                .ignoresSafeArea()

            VStack(spacing: .quellSpace8) {
                Text(WrenVoice.closingSteady)
                    .font(.quellDisplay)
                    .foregroundStyle(Color.quellCream)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, .quellSpace7)
                    .opacity(lineVisible ? 1 : 0)

                VStack(spacing: .quellSpace5) {
                    WordStone(label: "leave a note for future-you") { onLeaveNote() }
                    WordStone(label: "okay") { onDismiss() }
                }
                .opacity(actionsVisible ? 1 : 0)
            }
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.3)) {
                lineVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(1.4)) {
                actionsVisible = true
            }
        }
    }
}

#Preview {
    SteadyView(onLeaveNote: {}, onDismiss: {})
}
