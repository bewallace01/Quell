import SwiftUI

struct AnchorPeopleView: View {

    let onDismiss: () -> Void

    @StateObject private var store = AnchorPeopleStore.shared
    @State private var showPicker = false
    @State private var visible = false

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            JellyfishField()
                .ignoresSafeArea()

            BioluminescentField()
                .ignoresSafeArea()

            VStack(spacing: .quellSpace7) {
                Text("your people.")
                    .font(.quellTitle)
                    .foregroundStyle(Color.quellCream)
                    .padding(.top, .quellSpace7)

                Text("up to three. surface during need-company moments.")
                    .font(.quellCaption)
                    .foregroundStyle(Color.quellMist)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, .quellSpace7)

                if store.people.isEmpty {
                    Text("nobody yet. that's okay too.")
                        .font(.quellBody)
                        .foregroundStyle(Color.quellWhisper)
                        .padding(.top, .quellSpace5)
                } else {
                    VStack(spacing: .quellSpace4) {
                        ForEach(store.people) { person in
                            row(person)
                        }
                    }
                    .padding(.horizontal, .quellSpace7)
                }

                VStack(spacing: .quellSpace5) {
                    if store.canAddMore {
                        WordStone(label: "add someone") { showPicker = true }
                    } else {
                        Text("three saved. remove one to add more.")
                            .font(.quellCaption)
                            .foregroundStyle(Color.quellWhisper)
                    }
                    WordStone(label: "back") { onDismiss() }
                }
                .padding(.top, .quellSpace5)

                Spacer()
            }
            .opacity(visible ? 1 : 0)
        }
        .sheet(isPresented: $showPicker) {
            ContactPickerView(
                onPick: { name, phone in
                    store.add(name: name, phoneNumber: phone)
                    showPicker = false
                },
                onCancel: { showPicker = false }
            )
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.2)) {
                visible = true
            }
        }
    }

    private func row(_ person: AnchorPerson) -> some View {
        HStack {
            Text(person.name.lowercased())
                .font(.quellBody)
                .foregroundStyle(Color.quellCream)
            Spacer()
            Button {
                store.remove(person)
            } label: {
                Text("remove")
                    .font(.quellLabel)
                    .foregroundStyle(Color.quellWhisper)
                    .frame(minWidth: 44, minHeight: 44)
            }
            .accessibilityLabel("remove \(person.name)")
        }
        .padding(.horizontal, .quellSpace5)
        .padding(.vertical, .quellSpace3)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.quellShade.opacity(0.5))
        )
    }
}

#Preview {
    AnchorPeopleView(onDismiss: {})
}
