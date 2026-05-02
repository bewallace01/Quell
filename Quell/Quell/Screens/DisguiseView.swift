import SwiftUI

struct DisguiseView: View {

    let onDismiss: () -> Void

    private let fakeNotes = [
        ("groceries", "Today"),
        ("ideas", "Yesterday"),
        ("to-do this week", "Mon"),
        ("weekend plans", "Apr 28"),
        ("wifi password", "Apr 21"),
        ("birthday list", "Apr 15"),
    ]

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.white
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                Text("Notes")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundStyle(.black)
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    .padding(.bottom, 8)

                ForEach(fakeNotes, id: \.0) { note in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(note.0)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(.black)
                        Text(note.1)
                            .font(.system(size: 14))
                            .foregroundStyle(Color(white: 0.5))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)

                    Divider()
                        .padding(.leading, 16)
                }

                Spacer()
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            onDismiss()
        }
    }
}

#Preview {
    DisguiseView {}
}
