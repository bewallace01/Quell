import SwiftUI
import UIKit

struct SettingsView: View {

    let onCrisis: () -> Void
    let onAbout: () -> Void
    let onPatterns: () -> Void
    let onDismiss: () -> Void

    @AppStorage("quell.audioEnabled") private var audioEnabled = true
    @AppStorage("quell.hapticEnabled") private var hapticEnabled = true
    @AppStorage("quell.manualBreath") private var manualBreath = false
    @AppStorage("quell.hasOnboarded") private var hasOnboarded = true

    @Environment(\.openURL) private var openURL

    @State private var visible = false

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            JellyfishField()
                .ignoresSafeArea()

            BioluminescentField()
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: .quellSpace7) {
                    Text("settings")
                        .font(.quellTitle)
                        .foregroundStyle(Color.quellCream)
                        .padding(.top, .quellSpace7)

                    sectionGroup(title: "feedback") {
                        toggleRow("haptic", isOn: $hapticEnabled)
                        Divider().background(Color.quellWhisper.opacity(0.3))
                        toggleRow("audio", isOn: $audioEnabled)
                        Divider().background(Color.quellWhisper.opacity(0.3))
                        toggleRow("manual breath", isOn: $manualBreath)
                    }

                    sectionGroup(title: "system") {
                        rowButton("notifications") {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                openURL(url)
                            }
                        }
                    }

                    sectionGroup(title: "your patterns") {
                        rowButton("showing up") { onPatterns() }
                    }

                    sectionGroup(title: "safety") {
                        rowButton("crisis resources") { onCrisis() }
                        Divider().background(Color.quellWhisper.opacity(0.3))
                        rowButton("about") { onAbout() }
                    }

                    sectionGroup(title: "debug") {
                        rowButton("reset onboarding") {
                            hasOnboarded = false
                            onDismiss()
                        }
                    }

                    HStack {
                        Spacer()
                        WordStone(label: "back") { onDismiss() }
                        Spacer()
                    }
                    .padding(.top, .quellSpace5)
                }
                .padding(.horizontal, .quellSpace7)
                .padding(.bottom, .quellSpace7)
            }
            .opacity(visible ? 1 : 0)
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.2)) {
                visible = true
            }
        }
    }

    @ViewBuilder
    private func sectionGroup<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: .quellSpace3) {
            Text(title)
                .font(.quellCaption)
                .foregroundStyle(Color.quellWhisper)
                .padding(.leading, .quellSpace4)

            VStack(spacing: 0) {
                content()
            }
            .padding(.horizontal, .quellSpace4)
            .padding(.vertical, .quellSpace3)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.quellShade.opacity(0.5))
            )
        }
    }

    private func toggleRow(_ label: String, isOn: Binding<Bool>) -> some View {
        Toggle(isOn: isOn) {
            Text(label)
                .font(.quellBody)
                .foregroundStyle(Color.quellCream)
        }
        .tint(Color.quellGlow)
        .padding(.vertical, .quellSpace3)
    }

    private func rowButton(_ label: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(label)
                    .font(.quellBody)
                    .foregroundStyle(Color.quellCream)
                Spacer()
                Text("›")
                    .font(.quellBody)
                    .foregroundStyle(Color.quellWhisper)
                    .accessibilityHidden(true)
            }
            .padding(.vertical, .quellSpace3)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(label)
    }
}

#Preview {
    SettingsView(onCrisis: {}, onAbout: {}, onPatterns: {}, onDismiss: {})
}
