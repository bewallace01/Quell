import SwiftUI

struct MovementLibraryView: View {

    let onSelect: (Exercise) -> Void
    let onDismiss: () -> Void

    @State private var visible = false

    private let library = MovementLibrary.shared

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            JellyfishField()
                .ignoresSafeArea()

            BioluminescentField()
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: .quellSpace5) {
                    Text("move.")
                        .font(.quellTitle)
                        .foregroundStyle(Color.quellCream)
                        .padding(.top, .quellSpace7)

                    Text("a minute of body, when the mind is loud.")
                        .font(.quellCaption)
                        .foregroundStyle(Color.quellMist)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, .quellSpace7)
                        .padding(.bottom, .quellSpace5)

                    VStack(spacing: .quellSpace4) {
                        ForEach(library.exercises) { exercise in
                            row(for: exercise)
                        }
                    }
                    .padding(.horizontal, .quellSpace7)

                    WordStone(label: "back") { onDismiss() }
                        .padding(.top, .quellSpace5)
                        .padding(.bottom, .quellSpace7)
                }
            }
            .opacity(visible ? 1 : 0)
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.2)) {
                visible = true
            }
        }
    }

    private func row(for exercise: Exercise) -> some View {
        Button {
            onSelect(exercise)
        } label: {
            HStack {
                Text(exercise.title)
                    .font(.quellBody)
                    .foregroundStyle(Color.quellCream)
                Spacer()
                Text(durationLabel(exercise.totalSeconds))
                    .font(.quellCaption)
                    .foregroundStyle(Color.quellWhisper)
            }
            .padding(.horizontal, .quellSpace5)
            .padding(.vertical, .quellSpace4)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.quellShade.opacity(0.5))
            )
        }
        .buttonStyle(.plain)
    }

    private func durationLabel(_ seconds: Double) -> String {
        let s = Int(seconds.rounded())
        if s < 60 { return "\(s)s" }
        let m = s / 60
        let r = s % 60
        return r == 0 ? "\(m) min" : "\(m):\(String(format: "%02d", r))"
    }
}

#Preview {
    MovementLibraryView(onSelect: { _ in }, onDismiss: {})
}
