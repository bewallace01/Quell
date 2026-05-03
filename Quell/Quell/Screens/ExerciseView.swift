import SwiftUI

struct ExerciseView: View {

    let exercise: Exercise
    let onComplete: () -> Void

    @State private var phaseIndex = 0
    @State private var phaseStart: Date = Date()
    @State private var elapsedTotal: Double = 0
    @State private var visible = false
    @State private var task: Task<Void, Never>? = nil

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            JellyfishField()
                .ignoresSafeArea()

            BioluminescentField()
                .ignoresSafeArea()

            VStack {
                Spacer()

                if phaseIndex < exercise.phases.count {
                    Text(exercise.phases[phaseIndex].text)
                        .font(.quellDisplay)
                        .foregroundStyle(Color.quellCream)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, .quellSpace7)
                        .opacity(visible ? 1 : 0)
                        .id(phaseIndex) // force re-animate on phase change
                } else {
                    Text("done.")
                        .font(.quellDisplay)
                        .foregroundStyle(Color.quellCream)
                        .opacity(visible ? 1 : 0)
                }

                Spacer()

                progressBar

                WordStone(label: phaseIndex < exercise.phases.count ? "stop" : "okay") {
                    end()
                }
                .padding(.bottom, .quellSpace7)
            }
        }
        .onAppear { begin() }
        .onDisappear { task?.cancel() }
    }

    private var progressBar: some View {
        GeometryReader { geo in
            let total = exercise.totalSeconds
            let progress = min(1.0, elapsedTotal / total)
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.quellWhisper.opacity(0.18))
                    .frame(height: 2)
                Capsule()
                    .fill(Color.quellGlow.opacity(0.5))
                    .frame(width: geo.size.width * CGFloat(progress), height: 2)
            }
        }
        .frame(height: 2)
        .padding(.horizontal, .quellSpace7)
        .padding(.bottom, .quellSpace5)
    }

    private func begin() {
        withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.2)) {
            visible = true
        }
        phaseStart = Date()
        task = Task { @MainActor in
            await runExercise()
        }
    }

    private func runExercise() async {
        for (i, phase) in exercise.phases.enumerated() {
            if Task.isCancelled { return }
            phaseIndex = i

            // fade text out then in for the new phase
            if i > 0 {
                withAnimation(.quellEaseSlow(duration: .quellDurMid)) { visible = false }
                try? await Task.sleep(for: .milliseconds(400))
                withAnimation(.quellEaseSlow(duration: .quellDurSlow)) { visible = true }
            }

            phaseStart = Date()
            let until = Date().addingTimeInterval(phase.duration)
            while Date() < until {
                if Task.isCancelled { return }
                elapsedTotal = exercise.phases.prefix(i).reduce(0) { $0 + $1.duration }
                    + Date().timeIntervalSince(phaseStart)
                try? await Task.sleep(for: .milliseconds(100))
            }
        }
        // Done — show the "done" line for a moment
        if !Task.isCancelled {
            withAnimation(.quellEaseSlow(duration: .quellDurMid)) { visible = false }
            try? await Task.sleep(for: .milliseconds(400))
            phaseIndex = exercise.phases.count
            withAnimation(.quellEaseSlow(duration: .quellDurSlow)) { visible = true }
            elapsedTotal = exercise.totalSeconds
        }
    }

    private func end() {
        task?.cancel()
        onComplete()
    }
}

#Preview {
    ExerciseView(
        exercise: MovementLibrary.shared.exercises[0],
        onComplete: {}
    )
}
