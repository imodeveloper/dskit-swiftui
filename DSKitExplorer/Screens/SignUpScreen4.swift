//
//  SignUpScreen4.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct SignUpScreen4: View {
    @Environment(\.dismiss) var dismiss
    let viewModel = SignUpScreen4Model()

    var body: some View {
        DSVStack(spacing: .medium) {
            Spacer()
            DSVStack(spacing: .medium) {
                DSText("Enter secure\ncode to verify").dsTextStyle(.largeHeadline)
                    .dsFullWidth()
                    .overlay(alignment: .trailing) {
                        DSImageView(systemName: "checkmark.circle.fill", size: 60, tint: .viewStyle(.secondary, .background))
                    }
                DSText("Please enter your mobile number to\nget sms to activate your account")
                DSTextField.password(value: viewModel.code)
                DSHStack {
                    DSText("Valid for 45 seconds").dsTextStyle(.smallSubheadline)
                    Spacer()
                    DSButton(title: "Resend Code", style: .clear, maxWidth: false, action: {
                        dismiss()
                    })
                }.dsHeight(20)
            }

            DSButton(title: "Subbmit") { dismiss() }

            Spacer()
            Spacer()
        }
        .dsScreen()
        .navigationTitle("Sign Up")
        .toolbar {
            ToolbarItem(placement: .platformBasedTrailing) {
                DSToolbarSFSymbolButton(name: "xmark")
                    .onTap { dismiss() }
            }
        }
    }
}

// MARK: - Model

final class SignUpScreen4Model: ObservableObject {
    var code = DSTextFieldValue(value: "000")
    func submit() {
        for field in [code] {
            let isValid = field.validate()
            if !isValid {
                break
            }
        }
    }
}

// MARK: - Testable

struct Testable_SignUpScreen4: View {
    var body: some View {
        Group {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    SignUpScreen4()
                        .platformBasedNavigationBarTitleDisplayModeInline()
                }
            } else {
                NavigationView {
                    SignUpScreen4()
                        .platformBasedNavigationBarTitleDisplayModeInline()
                }
            }
        }
    }
}

// MARK: - Preview

struct SignUpScreen4_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_SignUpScreen4() }
    }
}
