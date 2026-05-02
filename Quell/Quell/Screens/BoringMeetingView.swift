import SwiftUI

struct BoringMeetingView: View {

    let onDismiss: () -> Void

    private struct Section: Identifiable {
        let id = UUID()
        let title: String
        let items: [String]
    }

    private let sections: [Section] = [
        Section(title: "hand fidgets", items: [
            "press your thumbs into your palms.",
            "trace the shape of your fingers under the table.",
            "make a fist. hold for 5. release.",
            "feel the texture of your sleeve, slowly.",
            "press your knuckles together.",
        ]),
        Section(title: "desk exercises", items: [
            "press your feet into the floor.",
            "press your palms into the desk for 10 seconds.",
            "tense your thighs. hold for 5. release.",
            "roll your shoulders back, slowly.",
            "tuck your chin. hold for 3. release.",
        ]),
        Section(title: "breath (silent)", items: [
            "in for 4. hold for 4. out for 6.",
            "no one will know.",
            "again.",
        ]),
    ]

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.quellMidnight
                .ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: .quellSpace7) {
                    ForEach(sections) { section in
                        VStack(alignment: .leading, spacing: .quellSpace4) {
                            Text(section.title)
                                .font(.quellHeadline)
                                .foregroundStyle(Color.quellMist)

                            VStack(alignment: .leading, spacing: .quellSpace3) {
                                ForEach(section.items, id: \.self) { item in
                                    Text("· \(item)")
                                        .font(.quellBody)
                                        .foregroundStyle(Color.quellCream)
                                        .lineSpacing(.quellBodyLineSpacing)
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, .quellSpace7)
                .padding(.top, .quellSpace8)
                .padding(.bottom, .quellSpace7)
            }

            Button {
                onDismiss()
            } label: {
                Text("done")
                    .font(.quellLabel)
                    .foregroundStyle(Color.quellWhisper)
                    .padding(.horizontal, .quellSpace5)
                    .padding(.vertical, .quellSpace4)
            }
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    BoringMeetingView {}
}
