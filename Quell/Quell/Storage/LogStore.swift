import Foundation
import Combine

struct LogEvent: Codable, Identifiable, Equatable {
    let id: UUID
    let timestamp: Date
    let kind: String
}

@MainActor
final class LogStore: ObservableObject {

    static let shared = LogStore()

    @Published private(set) var events: [LogEvent] = []

    private let key = "quell.log.events"
    private let retentionDays = 365

    init() { load() }

    func log(_ kind: String) {
        let event = LogEvent(id: UUID(), timestamp: Date(), kind: kind)
        events.append(event)
        prune()
        save()
    }

    var thisWeek: [LogEvent] {
        let cutoff = Date().addingTimeInterval(-7 * 86_400)
        return events.filter { $0.timestamp >= cutoff }
    }

    /// The set of day-start dates (calendar midnight) on which any event was logged.
    func engagedDays() -> Set<Date> {
        let calendar = Calendar.current
        return Set(events.map { calendar.startOfDay(for: $0.timestamp) })
    }

    /// Returns rows of weeks (oldest first), each row is 7 day-start dates ending today.
    func calendarGrid(weeks: Int) -> [[Date]] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let totalDays = weeks * 7
        let earliest = calendar.date(byAdding: .day, value: -(totalDays - 1), to: today)!

        var days: [Date] = []
        var cursor = earliest
        for _ in 0..<totalDays {
            days.append(cursor)
            cursor = calendar.date(byAdding: .day, value: 1, to: cursor)!
        }

        return stride(from: 0, to: days.count, by: 7).map {
            Array(days[$0..<min($0 + 7, days.count)])
        }
    }

    private func prune() {
        let cutoff = Date().addingTimeInterval(-Double(retentionDays) * 86_400)
        events.removeAll { $0.timestamp < cutoff }
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(events) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }

    private func load() {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let loaded = try? JSONDecoder().decode([LogEvent].self, from: data)
        else { return }
        events = loaded
    }
}
