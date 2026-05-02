import SwiftUI
import AVFoundation

struct VoiceNotesListView: View {

    let onRecord: () -> Void
    let onDismiss: () -> Void

    @StateObject private var store = VoiceNoteStore.shared
    @State private var playingID: UUID? = nil
    @State private var player: AVAudioPlayer? = nil

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            VStack(spacing: .quellSpace7) {
                Text("future-you.")
                    .font(.quellTitle)
                    .foregroundStyle(Color.quellCream)

                if store.notes.isEmpty {
                    Text("nothing saved yet.")
                        .font(.quellBody)
                        .foregroundStyle(Color.quellMist)
                } else {
                    VStack(spacing: .quellSpace4) {
                        ForEach(store.notes) { note in
                            row(note)
                        }
                    }
                    .padding(.horizontal, .quellSpace7)
                }

                VStack(spacing: .quellSpace5) {
                    if store.canAddMore {
                        WordStone(label: "record new") { onRecord() }
                    } else {
                        Text("five saved — delete one to record more.")
                            .font(.quellCaption)
                            .foregroundStyle(Color.quellWhisper)
                    }
                    WordStone(label: "back") { onDismiss() }
                }
            }
        }
    }

    private func row(_ note: VoiceNote) -> some View {
        HStack(spacing: .quellSpace4) {
            Text(note.displayDate)
                .font(.quellBody)
                .foregroundStyle(Color.quellCream)

            Spacer()

            Button {
                togglePlay(note)
            } label: {
                Text(playingID == note.id ? "stop" : "play")
                    .font(.quellLabel)
                    .foregroundStyle(Color.quellGlow)
                    .frame(minWidth: 44, minHeight: 44)
            }

            Button {
                deleteNote(note)
            } label: {
                Text("delete")
                    .font(.quellLabel)
                    .foregroundStyle(Color.quellWhisper)
                    .frame(minWidth: 44, minHeight: 44)
            }
        }
    }

    private func togglePlay(_ note: VoiceNote) {
        if playingID == note.id {
            player?.stop()
            playingID = nil
            return
        }
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default)
            try session.setActive(true)
            let p = try AVAudioPlayer(contentsOf: note.fileURL)
            p.play()
            player = p
            playingID = note.id
        } catch {
            playingID = nil
        }
    }

    private func deleteNote(_ note: VoiceNote) {
        if playingID == note.id {
            player?.stop()
            playingID = nil
        }
        store.delete(note)
    }
}

#Preview {
    VoiceNotesListView(onRecord: {}, onDismiss: {})
}
