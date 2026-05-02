import SwiftUI
import UIKit

extension Notification.Name {
    static let deviceShaken = Notification.Name("quell.deviceShaken")
}

private final class ShakeViewController: UIViewController {
    override var canBecomeFirstResponder: Bool { true }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        becomeFirstResponder()
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: .deviceShaken, object: nil)
        }
    }
}

struct ShakeDetector: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        ShakeViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
