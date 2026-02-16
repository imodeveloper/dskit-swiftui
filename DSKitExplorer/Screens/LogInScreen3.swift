//
//  LogInScreen3.swift
//  DSKit
//
//  Created by Ivan Borinschi on 31.13.3033.
//

import DSKit
import SwiftUI

struct LogInScreen3: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        DSVStack {
            Spacer()

            DSVStack(alignment: .center, spacing: .medium) {
                DSImageView(
                    systemName: "square.3.layers.3d.top.filled",
                    size: 90,
                    tint: .text(.headline)
                )
                DSText(
                    "Meet new people from over millions of users. Create posts, find friends and more.",
                    alignment: .center
                )
                .dsTextStyle(.subheadline)
                .dsWidth(300)
            }.frame(maxWidth: .infinity)

            Spacer()
            Spacer()
            Spacer()

            DSVStack(alignment: .center) {
                DSText("Log in with social networks").dsTextStyle(.subheadline)

                DSHStack {
                    DSButton(
                        title: "Facebook",
                        rightImageNamed: "facebook",
                        pushContentToSides: true,
                        style: .custom(color: Color(DSUIColor(0x4267B2)))
                    ) {
                        dismiss()
                    }

                    DSButton(
                        title: "Google",
                        rightImageNamed: "google",
                        pushContentToSides: true,
                        style: .custom(color: Color(DSUIColor(0x4285F4)))
                    ) {
                        dismiss()
                    }
                }

                DSText("or sign up with Email").dsTextStyle(.subheadline)

                DSButton(
                    title: "Sign Up",
                    rightSystemName: "envelope.fill",
                    pushContentToSides: true,
                    style: .light
                ) {
                    dismiss()
                }

                DSButton(title: "Log in with Email", style: .clear, action: {
                    dismiss()
                })
            }
        }.dsScreen()
    }
}

// MARK: - Testable

struct Testable_LogInScreen3: View {
    var body: some View {
        LogInScreen3()
    }
}

// MARK: - Preview

struct LogInScreen3_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_LogInScreen3() }
    }
}
