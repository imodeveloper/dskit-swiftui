//
//  PhotosPermissionScreen.swift
//  DSKit
//
//  Created by Ivan Borinschi on 06.07.2026.
//

import DSKit
import SwiftUI

struct PhotosPermissionScreen: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        DSPermissionPromptView(
            heroSystemName: "photo.on.rectangle.angled",
            title: "Allow photo access?",
            message: "Choose pictures for profiles, posts, and collections while keeping the flow fast and familiar.",
            benefits: [
                DSPermissionPromptBenefit(
                    systemName: "person.crop.square.fill",
                    title: "Personal profiles",
                    subtitle: "Use existing photos for avatars and account details."
                ),
                DSPermissionPromptBenefit(
                    systemName: "square.grid.2x2.fill",
                    title: "Richer content",
                    subtitle: "Attach images to posts, products, or collections."
                )
            ],
            note: "Only the photos you select are used; access can be updated later in Settings.",
            primaryTitle: "Allow Photo Access",
            secondaryTitle: "Maybe later",
            primaryAction: { dismiss() },
            secondaryAction: { dismiss() }
        )
    }
}

// MARK: - Testable

struct Testable_PhotosPermissionScreen: View {
    var body: some View {
        PhotosPermissionScreen()
    }
}

// MARK: - Preview

struct PhotosPermissionScreen_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_PhotosPermissionScreen() }
    }
}
