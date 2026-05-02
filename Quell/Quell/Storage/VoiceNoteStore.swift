import Foundation
import Combine

struct VoiceNote: Codable, Identifiable, Equatable {
    let id: UUID
    let date: Date
    let filename: String

    var fileURL: URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)
    }

    var displayDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: date).lowercased()
    }
}

@MainActor
final class VoiceNoteStore: ObservableObject {

    static let shared = VoiceNoteStore()

    @Published private(set) var notes: [VoiceNote] = []

    private let key = "quell.voiceNotes"
    private let maxCount = 5

    init() { load() }

    var canAddMore: Bool { notes.count < maxCount }
    var hasNotes: Bool { !notes.isEmpty }
    var random: VoiceNote? { notes.randomElement() }

    func add(filename: String) {
        let note = VoiceNote(id: UUID(), date: Date(), filename: filename)
        notes.append(note)
        save()
    }

    func delete(_ note: VoiceNote) {
        try? FileManager.default.removeItem(at: note.fileURL)
        notes.removeAll { $0.id == note.id }
        save()
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(notes) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }

    private func load() {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let loaded = try? JSONDecoder().decode([VoiceNote].self, from: data)
        else { return }
        notes = loaded
    }
}
