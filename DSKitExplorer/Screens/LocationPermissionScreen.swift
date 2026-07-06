//
//  LocationPermissionScreen.swift
//  DSKit
//
//  Created by Ivan Borinschi on 06.07.2026.
//

import DSKit
import SwiftUI

struct LocationPermissionScreen: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        DSPermissionPromptView(
            heroSystemName: "location.fill",
            title: "Allow location access?",
            message: "Find nearby places, estimate travel time, and keep local recommendations relevant as you browse.",
            benefits: [
                DSPermissionPromptBenefit(
                    systemName: "map.fill",
                    title: "Nearby results",
                    subtitle: "Surface places and services close to you."
                ),
                DSPermissionPromptBenefit(
                    systemName: "location.north.line.fill",
                    title: "Better context",
                    subtitle: "Sort distance-aware content without manual setup."
                )
            ],
            note: "Location is used only while the app is active and can be changed later in Settings.",
            primaryTitle: "Allow Location Access",
            secondaryTitle: "Maybe later",
            primaryAction: { dismiss() },
            secondaryAction: { dismiss() }
        )
    }
}

// MARK: - Testable

struct Testable_LocationPermissionScreen: View {
    var body: some View {
        LocationPermissionScreen()
    }
}

// MARK: - Preview

struct LocationPermissionScreen_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_LocationPermissionScreen() }
    }
}
