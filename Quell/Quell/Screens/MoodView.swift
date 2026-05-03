import SwiftUI

enum MoodChoice: String, Equatable {
    case anxious = "Anxious"
    case lonely = "Lonely"
    case tired = "Tired"
    case bored = "Bored"
    case numb = "Numb"
    case rage = "Rage"
}

struct MoodView: View {

    let onCommit: (MoodChoice) -> Void

    @State private var promptVisible = false
    @State private var moodsVisible = false

    private let moods: [MoodChoice] = [.anxious, .lonely, .tired, .bored, .numb, .rage]

    var body: some View {
        ZStack {
            Color.quellAbyss
                .ignoresSafeArea()

            BioluminescentField()
                .ignoresSafeArea()

            VStack(spacing: .quellSpace8) {
                Text("what is it?")
                    .font(.quellTitle)
                    .foregroundStyle(Color.quellCream)
                    .opacity(promptVisible ? 1 : 0)

                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: .quellSpace6),
                        GridItem(.flexible(), spacing: .quellSpace6),
                    ],
                    spacing: .quellSpace5
                ) {
                    ForEach(moods, id: \.self) { mood in
                        WordStone(label: mood.rawValue) {
                            onCommit(mood)
                        }
                    }
                }
                .padding(.horizontal, .quellSpace7)
                .opacity(moodsVisible ? 1 : 0)
            }
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.3)) {
                promptVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.9)) {
                moodsVisible = true
            }
        }
    }
}

#Preview {
    MoodView { mood in
        print("mood: \(mood)")
    }
}
