import SwiftUI
import ContactsUI

struct ContactPickerView: UIViewControllerRepresentable {

    /// Called with (display name, phone number) when the user picks a contact.
    let onPick: (String, String) -> Void
    let onCancel: () -> Void

    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator
        picker.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")
        picker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        return picker
    }

    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(onPick: onPick, onCancel: onCancel)
    }

    final class Coordinator: NSObject, CNContactPickerDelegate {
        let onPick: (String, String) -> Void
        let onCancel: () -> Void

        init(onPick: @escaping (String, String) -> Void, onCancel: @escaping () -> Void) {
            self.onPick = onPick
            self.onCancel = onCancel
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            let name = [contact.givenName, contact.familyName]
                .filter { !$0.isEmpty }
                .joined(separator: " ")
            let displayName = name.isEmpty ? contact.organizationName : name
            let phone = contact.phoneNumbers.first?.value.stringValue ?? ""
            if !phone.isEmpty {
                onPick(displayName, phone)
            } else {
                onCancel()
            }
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {
            let contact = contactProperty.contact
            let name = [contact.givenName, contact.familyName]
                .filter { !$0.isEmpty }
                .joined(separator: " ")
            let displayName = name.isEmpty ? contact.organizationName : name
            if let phone = contactProperty.value as? CNPhoneNumber {
                onPick(displayName, phone.stringValue)
            } else {
                onCancel()
            }
        }

        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            onCancel()
        }
    }
}
