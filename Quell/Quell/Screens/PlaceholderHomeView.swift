import SwiftUI

struct PlaceholderHomeView: View {

    @State private var visible = false

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            BreathingShape()
                .opacity(visible ? 1 : 0)
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
                visible = true
            }
        }
    }
}

#Preview {
    PlaceholderHomeView()
}
