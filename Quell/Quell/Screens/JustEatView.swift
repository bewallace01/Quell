import SwiftUI
import UserNotifications

struct JustEatView: View {

    let onComplete: () -> Void

    @State private var promptVisible = false
    @State private var orbVisible = false

    private let notificationID = "quell.eatJust.checkIn"

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            VStack(spacing: .quellSpace8) {
                Text("i'm here when you're ready.\nno pressure.")
                    .font(.quellTitle)
                    .foregroundStyle(Color.quellCream)
                    .multilineTextAlignment(.center)
                    .opacity(promptVisible ? 1 : 0)

                BreathingShape(size: 220)
                    .opacity(orbVisible ? 1 : 0)
            }
            .padding(.horizontal, .quellSpace7)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            cancelCheckIn()
            onComplete()
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.3)) {
                orbVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.9)) {
                promptVisible = true
            }
            Task { await scheduleCheckIn() }
        }
    }

    private func scheduleCheckIn() async {
        let center = UNUserNotificationCenter.current()
        let granted = (try? await center.requestAuthorization(options: [.alert, .sound])) ?? false
        guard granted else { return }

        let content = UNMutableNotificationContent()
        content.title = "checking back."
        content.body = "still here when you want me."

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20 * 60, repeats: false)
        let request = UNNotificationRequest(
            identifier: notificationID,
            content: content,
            trigger: trigger
        )
        try? await center.add(request)
    }

    private func cancelCheckIn() {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [notificationID])
    }
}

#Preview {
    JustEatView(onComplete: {})
}
