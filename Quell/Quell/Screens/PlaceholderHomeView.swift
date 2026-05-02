import SwiftUI

struct PlaceholderHomeView: View {

    private enum Destination: Equatable {
        case stone(String)
        case coRegulation
        case fork
        case mood
        case anxiousProtocol
        case waveCheck
        case coPilot
    }

    @State private var orbVisible = false
    @State private var promptVisible = false
    @State private var stonesVisible = false

    @State private var destination: Destination? = nil

    var body: some View {
        ZStack {
            home
                .opacity(destination == nil ? 1 : 0)
                .allowsHitTesting(destination == nil)

            if let dest = destination {
                Group {
                    switch dest {
                    case .stone(let word):
                        StoneDestinationView(word: word, onDismiss: dismiss)
                    case .coRegulation:
                        CoRegulationView(onAdvance: advanceToFork)
                    case .fork:
                        ForkView(onCommit: commitFork)
                    case .mood:
                        MoodView(onCommit: commitMood)
                    case .anxiousProtocol:
                        AnxiousProtocolView(onTryElse: advanceToFork, onAdvance: advanceToWaveCheck)
                    case .waveCheck:
                        WaveCheckView(onComplete: completeWave)
                    case .coPilot:
                        CoPilotPlaceholderView(onDismiss: dismiss)
                    }
                }
                .transition(.opacity)
            }
        }
        .animation(.quellEaseSlow(duration: .quellDurSlow), value: destination)
    }

    private var home: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            VStack(spacing: .quellSpace8) {
                Text("right now i'm…")
                    .font(.quellTitle)
                    .foregroundStyle(Color.quellCream)
                    .opacity(promptVisible ? 1 : 0)

                BreathingShape()
                    .opacity(orbVisible ? 1 : 0)

                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: .quellSpace6),
                        GridItem(.flexible(), spacing: .quellSpace6),
                    ],
                    spacing: .quellSpace5
                ) {
                    WordStone(label: "Steady") { select("Steady") }
                    WordStone(label: "Wobbling") { select("Wobbling") }
                    WordStone(label: "In it") { select("In it") }
                    WordStone(label: "Need company") { select("Need company") }
                }
                .padding(.horizontal, .quellSpace7)
                .opacity(stonesVisible ? 1 : 0)
            }
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
                orbVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.6)) {
                promptVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(1.2)) {
                stonesVisible = true
            }
        }
    }

    private func select(_ word: String) {
        let dest: Destination = (word == "In it") ? .coRegulation : .stone(word)
        withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
            destination = dest
        }
    }

    private func dismiss() {
        withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
            destination = nil
        }
    }

    private func advanceToFork() {
        withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
            destination = .fork
        }
    }

    private func commitFork(_ choice: ForkChoice) {
        withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
            switch choice {
            case .mood:
                destination = .mood
            case .body, .dontKnow:
                destination = .stone(choice.rawValue)
            }
        }
    }

    private func commitMood(_ choice: MoodChoice) {
        withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
            switch choice {
            case .anxious:
                destination = .anxiousProtocol
            case .lonely, .tired, .bored, .numb, .rage:
                destination = .stone(choice.rawValue)
            }
        }
    }

    private func advanceToWaveCheck() {
        withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
            destination = .waveCheck
        }
    }

    private func completeWave(_ result: WaveResult) {
        withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
            switch result {
            case .smaller:
                destination = nil
            case .same:
                destination = .fork
            case .bigger:
                destination = .coPilot
            }
        }
    }
}

#Preview {
    PlaceholderHomeView()
}
