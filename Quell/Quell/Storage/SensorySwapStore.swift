import Foundation
import SwiftUI
import Combine

enum SensoryCategory: String, CaseIterable, Codable, Identifiable {
    case crunch, cold, warm, sweet, salty

    var id: String { rawValue }
    var label: String { rawValue }

    var gradientColors: [Color] {
        switch self {
        case .crunch: return [.quellEmber, .quellMidnight]
        case .cold: return [.quellGlow, .quellMidnight]
        case .warm: return [.quellEmber, .quellDawn]
        case .sweet: return [.quellDawn, .quellCream]
        case .salty: return [.quellMist, .quellWhisper]
        }
    }
}

struct SensorySwap: Codable, Identifiable, Equatable, Hashable {
    let id: UUID
    let title: String
    let category: SensoryCategory
    let isFood: Bool
    let why: String
}

@MainActor
final class SensorySwapStore: ObservableObject {

    static let shared = SensorySwapStore()

    let swaps: [SensorySwap]

    init() {
        swaps = SensorySwapStore.seedSwaps()
    }

    func swaps(in category: SensoryCategory) -> [SensorySwap] {
        swaps.filter { $0.category == category }
    }

    private static func seedSwaps() -> [SensorySwap] {
        [
            // CRUNCH
            .init(id: UUID(), title: "carrot sticks",
                  category: .crunch, isFood: true,
                  why: "fresh, loud crunch. water-rich. the bite gives the brain something to focus on."),
            .init(id: UUID(), title: "an apple",
                  category: .crunch, isFood: true,
                  why: "sweet + crunch combo. real food. fills you up."),
            .init(id: UUID(), title: "ice cubes",
                  category: .crunch, isFood: false,
                  why: "the crunch sensation without eating. cold helps too."),
            .init(id: UUID(), title: "a pickle",
                  category: .crunch, isFood: true,
                  why: "intense flavor + texture. shocks the system into the present."),

            // COLD
            .init(id: UUID(), title: "splash cold water on your face",
                  category: .cold, isFood: false,
                  why: "vagal stimulation. drops anxiety quickly."),
            .init(id: UUID(), title: "ice pack on the back of your neck",
                  category: .cold, isFood: false,
                  why: "fast cooling = parasympathetic shift. the body calms."),
            .init(id: UUID(), title: "frozen grapes",
                  category: .cold, isFood: true,
                  why: "cold + sweet + small. a treat without the heaviness."),
            .init(id: UUID(), title: "30-second cold shower",
                  category: .cold, isFood: false,
                  why: "shock-resets the nervous system. wakes you up."),

            // WARM
            .init(id: UUID(), title: "tea — anything warm",
                  category: .warm, isFood: true,
                  why: "the act of holding warmth is comforting. focus on the cup."),
            .init(id: UUID(), title: "warm broth",
                  category: .warm, isFood: true,
                  why: "savory and warm. signals nourishment without a meal."),
            .init(id: UUID(), title: "heating pad on your stomach",
                  category: .warm, isFood: false,
                  why: "physical warmth where the urge lives."),
            .init(id: UUID(), title: "five minutes in the sun",
                  category: .warm, isFood: false,
                  why: "warmth on your skin. no food needed."),

            // SWEET
            .init(id: UUID(), title: "berries — frozen or fresh",
                  category: .sweet, isFood: true,
                  why: "sweet without spike. small, bright, real."),
            .init(id: UUID(), title: "a piece of dark chocolate",
                  category: .sweet, isFood: true,
                  why: "concentrated flavor. slow to eat."),
            .init(id: UUID(), title: "honey on a spoon",
                  category: .sweet, isFood: true,
                  why: "if you're going to have something sweet, make it deliberate."),
            .init(id: UUID(), title: "smell vanilla extract",
                  category: .sweet, isFood: false,
                  why: "the smell can satisfy the craving without eating."),

            // SALTY
            .init(id: UUID(), title: "a small sip of pickle juice",
                  category: .salty, isFood: true,
                  why: "concentrated salt without volume."),
            .init(id: UUID(), title: "a few olives",
                  category: .salty, isFood: true,
                  why: "salty + fatty + small."),
            .init(id: UUID(), title: "a measured handful of salted nuts",
                  category: .salty, isFood: true,
                  why: "salty + protein. takes the edge off."),
            .init(id: UUID(), title: "lick salt off your hand",
                  category: .salty, isFood: false,
                  why: "the body sometimes really does want salt. quick taste — see if that was it."),

            // CRUNCH (extras)
            .init(id: UUID(), title: "celery sticks with hot sauce",
                  category: .crunch, isFood: true,
                  why: "loud crunch + a flavor jolt. hard to do absent-minded."),
            .init(id: UUID(), title: "popcorn — a small bowl",
                  category: .crunch, isFood: true,
                  why: "satisfying crunch with low density. takes a while."),
            .init(id: UUID(), title: "frozen blueberries",
                  category: .crunch, isFood: true,
                  why: "cold + crunch + small. eat them one at a time."),
            .init(id: UUID(), title: "cucumber slices",
                  category: .crunch, isFood: true,
                  why: "fresh crunch, mostly water. resets the palate."),
            .init(id: UUID(), title: "press a textured ball into your palm",
                  category: .crunch, isFood: false,
                  why: "the brain reads texture pressure as 'something to do.' often enough."),

            // COLD (extras)
            .init(id: UUID(), title: "cold sparkling water",
                  category: .cold, isFood: true,
                  why: "the bubbles + cold are a dual sensation. sip slowly."),
            .init(id: UUID(), title: "step outside if it's cool out",
                  category: .cold, isFood: false,
                  why: "the temperature change re-orients. takes seconds."),
            .init(id: UUID(), title: "cold compress on your wrists",
                  category: .cold, isFood: false,
                  why: "vagal — pulse points cool fast. the body calms."),
            .init(id: UUID(), title: "frozen mango chunks",
                  category: .cold, isFood: true,
                  why: "cold + sweet + chewy. small handful, eaten slowly."),
            .init(id: UUID(), title: "cold yogurt — small bowl",
                  category: .cold, isFood: true,
                  why: "cool, real food, easy to slow down with."),

            // WARM (extras)
            .init(id: UUID(), title: "warm honey water",
                  category: .warm, isFood: true,
                  why: "a tiny bit of sweet + warmth. uncomplicated."),
            .init(id: UUID(), title: "warm hands under running water",
                  category: .warm, isFood: false,
                  why: "thirty seconds of warmth on the hands. nothing to consume."),
            .init(id: UUID(), title: "warm towel on the back of your neck",
                  category: .warm, isFood: false,
                  why: "the parasympathetic nerves run there. the body softens."),
            .init(id: UUID(), title: "miso broth or bone broth",
                  category: .warm, isFood: true,
                  why: "savory and warm. signals 'you've eaten' without volume."),
            .init(id: UUID(), title: "a warm shower",
                  category: .warm, isFood: false,
                  why: "five minutes. the urge often shifts."),

            // SWEET (extras)
            .init(id: UUID(), title: "frozen yogurt bites",
                  category: .sweet, isFood: true,
                  why: "small, cold, sweet. eaten one at a time."),
            .init(id: UUID(), title: "fresh fruit — slow bites",
                  category: .sweet, isFood: true,
                  why: "real, simple sweet. fiber and water do real work."),
            .init(id: UUID(), title: "graham cracker with almond butter",
                  category: .sweet, isFood: true,
                  why: "sweet + protein + crunch. takes time to eat."),
            .init(id: UUID(), title: "a flavored herbal tea",
                  category: .sweet, isFood: true,
                  why: "sweet without sugar. holds the warm cup."),
            .init(id: UUID(), title: "smell something sweet — cinnamon, vanilla",
                  category: .sweet, isFood: false,
                  why: "olfactory satisfaction. faster than people expect."),

            // SALTY (extras)
            .init(id: UUID(), title: "edamame with flaky salt",
                  category: .salty, isFood: true,
                  why: "salty + protein + small. shells slow you down."),
            .init(id: UUID(), title: "a piece of cheese",
                  category: .salty, isFood: true,
                  why: "salty + fat + satisfying. real food."),
            .init(id: UUID(), title: "miso broth, by the spoonful",
                  category: .salty, isFood: true,
                  why: "concentrated salt + warmth. tiny portions."),
            .init(id: UUID(), title: "a few salted almonds",
                  category: .salty, isFood: true,
                  why: "salty + crunch + protein. measure a small handful."),
            .init(id: UUID(), title: "smell something savory — bay leaf, soy sauce",
                  category: .salty, isFood: false,
                  why: "smell can pre-empt the craving. takes seconds."),
        ]
    }
}
