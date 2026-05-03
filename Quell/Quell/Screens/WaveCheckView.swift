import SwiftUI

enum WaveResult: Equatable {
    case bigger
    case same
    case smaller
}

struct WaveCheckView: View {

    let onComplete: (WaveResult) -> Void

    @State private var value: Double = 0.5
    @State private var promptVisible = false
    @State private var sliderVisible = false
    @State private var committed: WaveResult? = nil
    @State private var resultLineVisible = false

    var body: some View {
        ZStack {
            Color.quellMidnight
                .ignoresSafeArea()

            VStack(spacing: .quellSpace7) {
                Text("where is it now?")
                    .font(.quellTitle)
                    .foregroundStyle(Color.quellCream)
                    .opacity(promptVisible ? 1 : 0)

                if let result = committed {
                    Text(line(for: result))
                        .font(.quellDisplay)
                        .foregroundStyle(Color.quellCream)
                        .multilineTextAlignment(.center)
                        .opacity(resultLineVisible ? 1 : 0)
                        .padding(.horizontal, .quellSpace7)
                } else {
                    VStack(spacing: .quellSpace3) {
                        SoftSlider(value: $value) {
                            commit()
                        }
                        .padding(.horizontal, .quellSpace7)

                        HStack {
                            Text("bigger")
                                .font(.quellCaption)
                                .foregroundStyle(Color.quellWhisper)
                            Spacer()
                            Text("smaller")
                                .font(.quellCaption)
                                .foregroundStyle(Color.quellWhisper)
                        }
                        .padding(.horizontal, .quellSpace7)
                    }
                    .opacity(sliderVisible ? 1 : 0)
                }
            }
        }
        .onAppear {
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.3)) {
                promptVisible = true
            }
            withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.9)) {
                sliderVisible = true
            }
        }
    }

    private func commit() {
        let result: WaveResult
        if value < 0.33 {
            result = .bigger
        } else if value > 0.67 {
            result = .smaller
        } else {
            result = .same
        }

        LogStore.shared.log("wave-\(kindFor(result))")

        withAnimation(.quellEaseSlow(duration: .quellDurSlow)) {
            committed = result
        }
        withAnimation(.quellEaseSlow(duration: .quellDurSlow).delay(0.4)) {
            resultLineVisible = true
        }

        Task { @MainActor in
            try? await Task.sleep(for: .seconds(2.5))
            onComplete(result)
        }
    }

    private func line(for result: WaveResult) -> String {
        switch result {
        case .bigger:
            return "okay. we can get more help."
        case .same:
            return "let's try something else."
        case .smaller:
            return "you're still here. nice work staying."
        }
    }

    private func kindFor(_ result: WaveResult) -> String {
        switch result {
        case .bigger: return "bigger"
        case .same: return "same"
        case .smaller: return "smaller"
        }
    }
}

#Preview {
    WaveCheckView { result in
        print("result: \(result)")
    }
}
