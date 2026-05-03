import SwiftUI
import AVFoundation

struct CoRegulationView: View {

    let onAdvance: () -> Void

    @StateObject private var store = VoiceNoteStore.shared

    @State private var promptVisible = false
    @State private var orbVisible = false
    @State private var actionsVisible = false
    @State private var player: AVAudioPlayer? = nil
    @State private var playing = false

    var body: some View {
        ZStack {
            Color.quellAbyss
                .ignoresSafeArea()

            BioluminescentField()
                .ignoresSafeArea()

            VStack(spacing: .quellSpace8) {
                WrenLine(phrases: WrenVoice.coRegulation, interval: .seconds(22))
                    .opacity(promptVisible ? 1 : 0)

                BreathingShape(size: 280)
                    .opacity(orbVisible ? 1 : 0)

                VStack(spacing: .quellSpace5) {
                    if store.hasNotes {
                        WordStone(label: playing ? "stop" : "your voice") {
                            togglePlay()
                        }
                    }
                    HStack(spacing: .quellSpace6) {
                        WordStone(label: "stay") {
                            withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
                                actionsVisible = false
                            }
                            Task { @MainActor in
                                try? await Task.sleep(for: .seconds(12))
                                withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
                                    actionsVisible = true
                                }
                            }
                        }
                        WordStone(label: "skip ahead") {
                            stopPlayback()
                            onAdvance()
                        }
                    }
                }
                .opacity(actionsVisible ? 1 : 0)
            }
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(1.0)) {
                promptVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(1.6)) {
                orbVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(8.0)) {
                actionsVisible = true
            }
        }
        .onDisappear { stopPlayback() }
    }

    private func togglePlay() {
        if playing {
            stopPlayback()
            return
        }
        guard let note = store.random else { return }
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default)
            try session.setActive(true)
            let p = try AVAudioPlayer(contentsOf: note.fileURL)
            p.play()
            player = p
            playing = true
            let duration = p.duration
            Task { @MainActor in
                try? await Task.sleep(for: .seconds(duration))
                if player === p { stopPlayback() }
            }
        } catch {
            playing = false
        }
    }

    private func stopPlayback() {
        player?.stop()
        player = nil
        playing = false
    }
}

#Preview {
    CoRegulationView(onAdvance: {})
}
