import SwiftUI

struct PlaceholderHomeView: View {

    private enum Destination: Equatable {
        case stone(String)
        case coRegulation
        case fork
        case mood
        case moodProtocol(MoodChoice)
        case dontKnowScan
        case ragePad
        case waveCheck
        case eatAnywayEntry
        case eatMindful
        case eatJust
        case closingLine(String)
        case voiceNotes
        case voiceRecord
        case bodyRoute
        case sensorySwaps(SensoryCategory)
        case wobbling
        case needCompany
        case boringMeeting
        case settings
        case crisis
        case about
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
                    case .moodProtocol(let mood):
                        MoodProtocolView(
                            mood: mood,
                            onTryElse: advanceToFork,
                            onAdvance: advanceToWaveCheck,
                            onRagePad: { route(to: .ragePad) }
                        )
                    case .dontKnowScan:
                        DontKnowScanView(onComplete: completeScan)
                    case .ragePad:
                        RagePadView(onDismiss: { route(to: .moodProtocol(.rage)) })
                    case .waveCheck:
                        WaveCheckView(onComplete: completeWave)
                    case .settings:
                        SettingsView(
                            onCrisis: { route(to: .crisis) },
                            onAbout: { route(to: .about) },
                            onDismiss: dismiss
                        )
                    case .crisis:
                        CrisisResourcesView(onDismiss: dismiss)
                    case .about:
                        AboutView(onDismiss: dismiss)
                    case .eatAnywayEntry:
                        EatAnywayEntryView(
                            onMindful: { route(to: .eatMindful) },
                            onJustEat: { route(to: .eatJust) }
                        )
                    case .eatMindful:
                        MindfulEatView {
                            route(to: .closingLine("still here."))
                        }
                    case .eatJust:
                        JustEatView {
                            route(to: .closingLine("still here."))
                        }
                    case .closingLine(let line):
                        ClosingLineView(line: line, onComplete: dismiss)
                    case .voiceNotes:
                        VoiceNotesListView(
                            onRecord: { route(to: .voiceRecord) },
                            onDismiss: dismiss
                        )
                    case .voiceRecord:
                        RecordVoiceNoteView {
                            route(to: .voiceNotes)
                        }
                    case .bodyRoute:
                        BodyRouteView(
                            onCategory: { cat in route(to: .sensorySwaps(cat)) },
                            onWantFood: { route(to: .eatAnywayEntry) }
                        )
                    case .sensorySwaps(let cat):
                        SensorySwapsView(category: cat, onDismiss: dismiss)
                    case .wobbling:
                        BreathingMomentView(
                            phrases: [
                                "the day's a little off.",
                                "you don't have to fix it.",
                                "still here with you.",
                                "no big deal.",
                                "let your shoulders drop.",
                                "okay. just be here.",
                            ],
                            onComplete: dismiss
                        )
                    case .needCompany:
                        BreathingMomentView(
                            phrases: [
                                "you're not alone in this minute.",
                                "i'm here.",
                                "want to text someone you trust?",
                                "or just sit with me.",
                                "no need to perform.",
                                "still here.",
                            ],
                            onComplete: dismiss,
                            extra: ("text someone", openMessages)
                        )
                    case .boringMeeting:
                        BoringMeetingView(onDismiss: dismiss)
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

                HStack(spacing: .quellSpace5) {
                    homeLink("future-you.") { route(to: .voiceNotes) }
                    homeLink("in a meeting.") { route(to: .boringMeeting) }
                    homeLink("settings.") { route(to: .settings) }
                }
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
        let dest: Destination
        switch word {
        case "In it": dest = .coRegulation
        case "Steady": dest = .closingLine("good. nice to see you.")
        case "Wobbling": dest = .wobbling
        case "Need company": dest = .needCompany
        default: dest = .stone(word)
        }
        withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
            destination = dest
        }
    }

    @Environment(\.openURL) private var openURL

    private func openMessages() {
        if let url = URL(string: "sms:") {
            openURL(url)
        }
    }

    private func homeLink(_ label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(label)
                .font(.quellCaption)
                .foregroundStyle(Color.quellWhisper)
                .padding(.vertical, .quellSpace3)
                .padding(.horizontal, .quellSpace3)
        }
        .buttonStyle(.plain)
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
            case .body:
                destination = .bodyRoute
            case .dontKnow:
                destination = .dontKnowScan
            }
        }
    }

    private func commitMood(_ choice: MoodChoice) {
        withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
            destination = .moodProtocol(choice)
        }
    }

    private func completeScan(_ suggestion: ScanSuggestion) {
        withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
            switch suggestion {
            case .eatAnyway:
                destination = .eatAnywayEntry
            case .coRegulation:
                destination = .coRegulation
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
                destination = .closingLine("thanks for showing up.")
            case .same:
                destination = .fork
            case .bigger:
                destination = .crisis
            }
        }
    }

    private func route(to next: Destination) {
        withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
            destination = next
        }
    }
}

#Preview {
    PlaceholderHomeView()
}
