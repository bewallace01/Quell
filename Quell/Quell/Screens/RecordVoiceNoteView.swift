import SwiftUI
import AVFoundation
import Combine

struct RecordVoiceNoteView: View {

    let onComplete: () -> Void

    @StateObject private var recorder = VoiceRecorder()
    @State private var phase: Phase = .initial
    @State private var pendingURL: URL? = nil

    private enum Phase {
        case initial
        case recording
        case review
        case denied
    }

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            BioluminescentField()
                .ignoresSafeArea()

            switch phase {
            case .initial:
                initialView
            case .recording:
                recordingView
            case .review:
                reviewView
            case .denied:
                deniedView
            }
        }
    }

    private var initialView: some View {
        VStack(spacing: .quellSpace8) {
            Text("record up to 60 seconds for future-you.")
                .font(.quellTitle)
                .foregroundStyle(Color.quellCream)
                .multilineTextAlignment(.center)

            HStack(spacing: .quellSpace6) {
                WordStone(label: "cancel") { onComplete() }
                WordStone(label: "record") { Task { await beginRecording() } }
            }
        }
        .padding(.horizontal, .quellSpace7)
    }

    private var recordingView: some View {
        VStack(spacing: .quellSpace8) {
            BreathingShape(size: 200)

            Text(timeString(recorder.elapsed))
                .font(.quellHeadline)
                .foregroundStyle(Color.quellCream)
                .monospacedDigit()

            WordStone(label: "stop") {
                stopRecording()
            }
        }
    }

    private var reviewView: some View {
        VStack(spacing: .quellSpace8) {
            Text("save it?")
                .font(.quellTitle)
                .foregroundStyle(Color.quellCream)

            HStack(spacing: .quellSpace6) {
                WordStone(label: "redo") { redo() }
                WordStone(label: "save") { save() }
            }

            WordStone(label: "discard") { discard() }
        }
        .padding(.horizontal, .quellSpace7)
    }

    private var deniedView: some View {
        VStack(spacing: .quellSpace8) {
            Text("microphone access is off.\nyou can turn it on in settings.")
                .font(.quellTitle)
                .foregroundStyle(Color.quellCream)
                .multilineTextAlignment(.center)

            WordStone(label: "ok") { onComplete() }
        }
        .padding(.horizontal, .quellSpace7)
    }

    private func beginRecording() async {
        let granted = await recorder.requestPermission()
        guard granted else {
            withAnimation(.quellEaseSlow(duration: .quellDurMid)) {
                phase = .denied
            }
            return
        }
        guard let url = recorder.start() else {
            withAnimation(.quellEaseSlow(duration: .quellDurMid)) {
                phase = .denied
            }
            return
        }
        pendingURL = url
        recorder.onAutoStop = {
            withAnimation(.quellEaseSlow(duration: .quellDurMid)) {
                phase = .review
            }
        }
        withAnimation(.quellEaseSlow(duration: .quellDurMid)) {
            phase = .recording
        }
    }

    private func stopRecording() {
        recorder.stop()
        withAnimation(.quellEaseSlow(duration: .quellDurMid)) {
            phase = .review
        }
    }

    private func redo() {
        if let url = pendingURL {
            try? FileManager.default.removeItem(at: url)
        }
        pendingURL = nil
        withAnimation(.quellEaseSlow(duration: .quellDurMid)) {
            phase = .initial
        }
    }

    private func save() {
        guard let url = pendingURL else {
            onComplete()
            return
        }
        VoiceNoteStore.shared.add(filename: url.lastPathComponent)
        onComplete()
    }

    private func discard() {
        if let url = pendingURL {
            try? FileManager.default.removeItem(at: url)
        }
        onComplete()
    }

    private func timeString(_ seconds: Double) -> String {
        let secs = Int(seconds)
        return String(format: "0:%02d", secs)
    }
}

@MainActor
private final class VoiceRecorder: ObservableObject {

    @Published var elapsed: Double = 0

    var onAutoStop: (() -> Void)? = nil

    private var recorder: AVAudioRecorder?
    private var timer: Timer?
    private var currentURL: URL?

    func requestPermission() async -> Bool {
        await AVAudioApplication.requestRecordPermission()
    }

    func start() -> URL? {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playAndRecord, mode: .default, options: [.defaultToSpeaker])
            try session.setActive(true)
        } catch {
            return nil
        }

        let filename = "voicenote-\(UUID().uuidString).m4a"
        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)

        let settings: [String: Any] = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.medium.rawValue,
        ]

        do {
            let recorder = try AVAudioRecorder(url: url, settings: settings)
            recorder.record(forDuration: 60.0)
            self.recorder = recorder
            self.currentURL = url
            startTimer()
            return url
        } catch {
            return nil
        }
    }

    func stop() {
        recorder?.stop()
        timer?.invalidate()
        timer = nil
    }

    private func startTimer() {
        elapsed = 0
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            DispatchQueue.main.async {
                guard let self else { return }
                self.elapsed += 0.1
                if self.elapsed >= 60.0 {
                    self.stop()
                    self.onAutoStop?()
                }
            }
        }
    }
}
