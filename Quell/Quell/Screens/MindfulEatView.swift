import SwiftUI

struct MindfulEatView: View {

    let onComplete: () -> Void
    var timerDuration: Duration = .seconds(600)

    @State private var started = false
    @State private var guidanceVisible = false
    @State private var actionsVisible = false
    @State private var ambientVisible = false
    @State private var timerTask: Task<Void, Never>? = nil

    private let lines = WrenVoice.mindfulGuidance

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            if started {
                ambientScreen
            } else {
                guidanceScreen
            }
        }
    }

    private var guidanceScreen: some View {
        VStack(spacing: .quellSpace8) {
            VStack(alignment: .leading, spacing: .quellSpace5) {
                ForEach(lines, id: \.self) { line in
                    Text(line)
                        .font(.quellTitle)
                        .foregroundStyle(Color.quellCream)
                }
            }
            .opacity(guidanceVisible ? 1 : 0)

            HStack(spacing: .quellSpace6) {
                WordStone(label: "skip timer") {
                    onComplete()
                }
                WordStone(label: "ten minutes") {
                    begin()
                }
            }
            .opacity(actionsVisible ? 1 : 0)
        }
        .padding(.horizontal, .quellSpace7)
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.3)) {
                guidanceVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(1.4)) {
                actionsVisible = true
            }
        }
    }

    private var ambientScreen: some View {
        ZStack {
            BreathingShape(size: 220)
                .opacity(ambientVisible ? 1 : 0)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            timerTask?.cancel()
            onComplete()
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
                ambientVisible = true
            }
        }
    }

    private func begin() {
        withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
            started = true
        }
        timerTask = Task { @MainActor in
            try? await Task.sleep(for: timerDuration)
            if !Task.isCancelled {
                onComplete()
            }
        }
    }
}

#Preview {
    MindfulEatView(onComplete: {})
}
