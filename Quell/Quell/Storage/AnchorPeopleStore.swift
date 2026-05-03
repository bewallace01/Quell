import Foundation
import Combine

struct AnchorPerson: Codable, Identifiable, Equatable, Hashable {
    let id: UUID
    let name: String
    let phoneNumber: String
}

@MainActor
final class AnchorPeopleStore: ObservableObject {

    static let shared = AnchorPeopleStore()

    @Published private(set) var people: [AnchorPerson] = []

    private let key = "quell.anchorPeople"
    private let maxCount = 3

    init() { load() }

    var canAddMore: Bool { people.count < maxCount }
    var hasAnyone: Bool { !people.isEmpty }

    func add(name: String, phoneNumber: String) {
        guard canAddMore else { return }
        let person = AnchorPerson(id: UUID(), name: name, phoneNumber: phoneNumber)
        people.append(person)
        save()
    }

    func remove(_ person: AnchorPerson) {
        people.removeAll { $0.id == person.id }
        save()
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(people) else { return }
        UserDefaults.standard.set(data, forKey: key)
    }

    private func load() {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let loaded = try? JSONDecoder().decode([AnchorPerson].self, from: data)
        else { return }
        people = loaded
    }
}
