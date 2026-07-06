//
//  NotificationsPermissionScreen.swift
//  DSKit
//
//  Created by Ivan Borinschi on 06.07.2026.
//

import DSKit
import SwiftUI

struct NotificationsPermissionScreen: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        DSPermissionPromptView(
            heroSystemName: "bell.badge.fill",
            title: "Enable notifications?",
            message: "Receive useful updates about messages, reminders, and account activity without opening the app.",
            benefits: [
                DSPermissionPromptBenefit(
                    systemName: "message.fill",
                    title: "Relevant alerts",
                    subtitle: "Know when something needs your attention."
                ),
                DSPermissionPromptBenefit(
                    systemName: "calendar.badge.clock",
                    title: "Timely reminders",
                    subtitle: "Keep bookings, deliveries, or events on track."
                )
            ],
            note: "Notifications can be paused or customized from app settings at any time.",
            primaryTitle: "Enable Notifications",
            secondaryTitle: "Maybe later",
            primaryAction: { dismiss() },
            secondaryAction: { dismiss() }
        )
    }
}

// MARK: - Testable

struct Testable_NotificationsPermissionScreen: View {
    var body: some View {
        NotificationsPermissionScreen()
    }
}

// MARK: - Preview

struct NotificationsPermissionScreen_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_NotificationsPermissionScreen() }
    }
}
