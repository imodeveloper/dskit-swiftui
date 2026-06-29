//
//  SignUpScreen2.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct SignUpScreen2: View {
    let viewModel = SignUpScreen2Model()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        DSVStack {
            DSImageView(url: profileImage, style: .circle, size: 100)
                .frame(maxWidth: .infinity, alignment: .center)
                .overlay {
                    DSImageView(systemName: "camera.fill", size: .smallIcon, tint: .icon(.brandOnBold))
                        .dsPadding(.space8)
                        .dsBackground(.background(.brand))
                        .clipShape(Circle())
                        .onTap { dismiss() }
                        .offset(x: 35, y: 35)
                }
                .dsPadding(.top, .space16)
                .hideWhenKeyboardIsDisplayed()

            Spacer()

            DSVStack(spacing: .space4) {
                DSTextField.name(value: viewModel.fullName)
                DSTextField.email(value: viewModel.email)
                DSTextField.password(value: viewModel.password)
            }

            DSButton(title: "Create an Account") {
                viewModel.submit()
            }

            DSTermsAndConditions(message: "By signing up, you agree to our")

            Spacer()

            Group {
                Spacer()
                Spacer()
                Spacer()
            }.hideWhenKeyboardIsDisplayed()

            DSButton(title: "I have an account", style: .borderedLight, action: {
                dismiss()
            })
            .dsPadding(.bottom)
        }
        .navigationTitle("Sign Up")
        .hideKeyboardWhenTappedOutside()
        .dsScreen()
    }
}

// MARK: - Model

final class SignUpScreen2Model: ObservableObject {
    var fullName = DSTextFieldValue()
    var email = DSTextFieldValue()
    var phone = DSTextFieldValue()
    var password = DSTextFieldValue()

    func submit() {
        for field in [fullName, email, phone, password] {
            let isValid = field.validate()
            if !isValid {
                break
            }
        }
    }
}

// MARK: - Testable

struct Testable_SignUpScreen2: View {
    var body: some View {
        Group {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    SignUpScreen2()
                        .platformBasedNavigationBarTitleDisplayModeInline()
                }
            } else {
                NavigationView {
                    SignUpScreen2()
                        .platformBasedNavigationBarTitleDisplayModeInline()
                }
            }
        }
    }
}

// MARK: - Preview

struct SignUpScreen2_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_SignUpScreen2() }
    }
}

// MARK: - Image Links

private let profileImage = ExplorerImageAssets.url(named: "web_sign_up_screen2_profile_image_9d270ce662")
