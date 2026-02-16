//
//  DSCustomUITextField.swift
//  DSKit
//
//  Created by Ivan Borinschi on 29.12.2022.
//

import SwiftUI

struct DSCustomUITextField: DSViewRepresentable {

    @Environment(\.appearance) var appearance: DSAppearance
    @Environment(\.viewStyle) var viewStyle: DSViewStyle

    @Binding var text: String
    @Binding var isSecureEntry: Bool
    @Binding var isEditing: Bool

    var placeholder: String

    // Use the cross-platform types
    var keyboardType: DSKeyboardType
    var textContentType: DSTextContentType?
    var autocapitalizationType: DSAutocapitalizationType
    var onCommit: (() -> Void)?

    // MARK: - iOS Implementation
    #if canImport(UIKit)
    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        configureUITextField(textField, context: context)
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.isSecureTextEntry = isSecureEntry
    }

    private func configureUITextField(_ textField: UITextField, context: Context) {
        textField.placeholder = placeholder
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: viewStyle.colors(from: appearance).textField.placeHolder]
        )
        textField.font = appearance.fonts.subheadline
        textField.adjustsFontForContentSizeCategory = true
        textField.isSecureTextEntry = isSecureEntry
        textField.keyboardType = keyboardType
        textField.textContentType = textContentType
        textField.autocapitalizationType = autocapitalizationType
        textField.delegate = context.coordinator
        textField.textColor = viewStyle.colors(from: appearance).textField.text
    }
    #elseif canImport(AppKit)
    func makeNSView(context: Context) -> NSTextField {
        let textField = NSTextField()
        configureNSTextField(textField, context: context)
        return textField
    }

    func updateNSView(_ nsView: NSTextField, context: Context) {
        nsView.stringValue = text
    }

    private func configureNSTextField(_ textField: NSTextField, context: Context) {
        textField.placeholderString = placeholder
        textField.font = NSFont.systemFont(ofSize: 14)
        textField.delegate = context.coordinator
        textField.textColor = viewStyle.colors(from: appearance).textField.text
        textField.isBezeled = true
        textField.isBordered = true
        textField.isEditable = true
        textField.isSelectable = true
        if #available(macOS 14.0, *) {
            textField.contentType = .addressCity
        } else {
            // Fallback on earlier versions
        }
    }
    #endif

    // MARK: - Coordinator
    func makeCoordinator() -> DSCustomUITextFieldCoordinator {
        DSCustomUITextFieldCoordinator(self)
    }
}

final class DSCustomUITextFieldCoordinator: NSObject {
    var parent: DSCustomUITextField
    init(_ textField: DSCustomUITextField) {
        self.parent = textField
    }
}

#if canImport(UIKit)
extension DSCustomUITextFieldCoordinator: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        parent.text = textField.text ?? ""
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        parent.onCommit?()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        parent.isEditing = true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        parent.isEditing = false
    }
}
#elseif canImport(AppKit)
extension DSCustomUITextFieldCoordinator: NSTextFieldDelegate {
    func controlTextDidChange(_ obj: Notification) {
        guard let textField = obj.object as? NSTextField else { return }
        parent.text = textField.stringValue
    }

    func controlTextDidBeginEditing(_ obj: Notification) {
        parent.isEditing = true
    }

    func controlTextDidEndEditing(_ obj: Notification) {
        parent.isEditing = false
        parent.onCommit?()
    }
}
#endif
