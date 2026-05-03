import SwiftUI

enum ScanSuggestion: Equatable {
    case eatAnyway
    case coRegulation
}

struct DontKnowScanView: View {

    let onComplete: (ScanSuggestion) -> Void

    enum Area: String, CaseIterable {
        case head, jaw, chest, stomach, hands, feet
    }

    enum Tension {
        case tight, neutral, open
    }

    @State private var index = 0
    @State private var tensions: [Area: Tension] = [:]
    @State private var visible = false

    var body: some View {
        ZStack {
            Color.quellAbyss
                .ignoresSafeArea()

            BioluminescentField()
                .ignoresSafeArea()

            VStack(spacing: .quellSpace8) {
                Text("your \(Area.allCases[index].rawValue)?")
                    .font(.quellTitle)
                    .foregroundStyle(Color.quellCream)

                HStack(spacing: .quellSpace5) {
                    WordStone(label: "tight") { record(.tight) }
                    WordStone(label: "neutral") { record(.neutral) }
                    WordStone(label: "open") { record(.open) }
                }
            }
            .opacity(visible ? 1 : 0)
            .padding(.horizontal, .quellSpace7)
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.3)) {
                visible = true
            }
        }
    }

    private func record(_ tension: Tension) {
        let area = Area.allCases[index]
        tensions[area] = tension

        if index == Area.allCases.count - 1 {
            let suggestion: ScanSuggestion = tensions[.stomach] == .tight ? .eatAnyway : .coRegulation
            onComplete(suggestion)
        } else {
            withAnimation(.quellEaseGentle(duration: .quellDurMid)) {
                index += 1
            }
        }
    }
}

#Preview {
    DontKnowScanView { suggestion in
        print("suggestion: \(suggestion)")
    }
}
