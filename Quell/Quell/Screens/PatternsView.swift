import SwiftUI

struct PatternsView: View {

    let onDismiss: () -> Void

    @StateObject private var store = LogStore.shared
    @State private var visible = false

    private let weeks = 5
    private let cellSize: CGFloat = 30
    private let cellSpacing: CGFloat = 6

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            VStack(spacing: .quellSpace7) {
                Text("showing up.")
                    .font(.quellTitle)
                    .foregroundStyle(Color.quellCream)

                Text(reflection)
                    .font(.quellBody)
                    .foregroundStyle(Color.quellMist)
                    .multilineTextAlignment(.center)
                    .lineSpacing(.quellBodyLineSpacing)
                    .padding(.horizontal, .quellSpace7)

                grid

                WordStone(label: "back") { onDismiss() }
                    .padding(.top, .quellSpace5)
            }
            .padding(.horizontal, .quellSpace7)
            .opacity(visible ? 1 : 0)
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.2)) {
                visible = true
            }
        }
    }

    private var grid: some View {
        let rows = store.calendarGrid(weeks: weeks)
        let engaged = store.engagedDays()
        let today = Calendar.current.startOfDay(for: Date())

        return VStack(spacing: cellSpacing) {
            ForEach(rows.indices, id: \.self) { i in
                HStack(spacing: cellSpacing) {
                    ForEach(rows[i], id: \.self) { day in
                        cell(day: day, engaged: engaged.contains(day), isFuture: day > today)
                    }
                }
            }
        }
    }

    private func cell(day: Date, engaged: Bool, isFuture: Bool) -> some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(fillFor(engaged: engaged, isFuture: isFuture))
            .frame(width: cellSize, height: cellSize)
            .shadow(color: Color.quellGlow.opacity(engaged ? 0.5 : 0), radius: 6)
    }

    private func fillFor(engaged: Bool, isFuture: Bool) -> Color {
        if engaged { return .quellGlow }
        if isFuture { return Color.quellShade.opacity(0.2) }
        return Color.quellShade.opacity(0.5)
    }

    private var reflection: String {
        let weekCount = store.thisWeek.count
        let totalCount = store.events.count
        if totalCount == 0 {
            return "nothing here yet.\nthat's okay too."
        }
        if weekCount == 0 {
            return "you've shown up before.\nbe here when you can."
        }
        if weekCount >= 5 {
            return "you've been here a lot this week.\nthat counts."
        }
        return "you've been showing up.\nthat counts."
    }
}

#Preview {
    PatternsView {}
}
