//
//  DSPermissionPromptView.swift
//  DSKit
//
//  Created by Ivan Borinschi on 06.07.2026.
//

import SwiftUI

/*
## DSPermissionPromptView

`DSPermissionPromptView` renders a reusable pre-permission screen with a hero symbol, benefit cards, privacy/support note, primary action, and secondary action.

#### Initialization:
Initializes a permission prompt with display-ready permission copy.
- Parameters:
- `heroSystemName`: SF Symbol shown in the hero.
- `title`: Main permission question.
- `message`: Supporting explanation.
- `benefits`: Benefit rows shown as cards.
- `noteSystemName`: SF Symbol for the final note card.
- `note`: Privacy or settings note.
- `primaryTitle`: Primary action title.
- `secondaryTitle`: Secondary action title.
- `primaryAction`: Primary action.
- `secondaryAction`: Secondary action.

#### Usage:
Use `DSPermissionPromptView` before system permission dialogs. Keep OS authorization calls, navigation, and analytics in the host app; DSKit only renders the prompt and forwards actions.
*/

public struct DSPermissionPromptBenefit: Identifiable, Hashable, Sendable {
    public let id: String
    public let systemName: String
    public let title: String
    public let subtitle: String

    public init(
        id: String? = nil,
        systemName: String,
        title: String,
        subtitle: String
    ) {
        self.id = id ?? "\(systemName)-\(title)"
        self.systemName = systemName
        self.title = title
        self.subtitle = subtitle
    }
}

public struct DSPermissionPromptView: View {
    private let heroSystemName: String
    private let title: String
    private let message: String
    private let benefits: [DSPermissionPromptBenefit]
    private let noteSystemName: String
    private let note: String
    private let primaryTitle: String
    private let secondaryTitle: String
    private let primaryAction: () -> Void
    private let secondaryAction: () -> Void

    public init(
        heroSystemName: String,
        title: String,
        message: String,
        benefits: [DSPermissionPromptBenefit],
        noteSystemName: String = "lock.shield.fill",
        note: String,
        primaryTitle: String,
        secondaryTitle: String,
        primaryAction: @escaping () -> Void,
        secondaryAction: @escaping () -> Void
    ) {
        self.heroSystemName = heroSystemName
        self.title = title
        self.message = message
        self.benefits = benefits
        self.noteSystemName = noteSystemName
        self.note = note
        self.primaryTitle = primaryTitle
        self.secondaryTitle = secondaryTitle
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }

    public var body: some View {
        DSVStack(spacing: .space16) {
            Spacer(minLength: 0)

            DSPermissionPromptHero(
                systemName: heroSystemName,
                title: title,
                message: message
            )

            DSVStack(spacing: .space8) {
                ForEach(benefits) { benefit in
                    DSCardSurface(horizontalPadding: .space12, verticalPadding: .space12) {
                        DSEntityRow(
                            title: benefit.title,
                            subtitle: benefit.subtitle,
                            accessory: .none
                        ) {
                            DSPermissionPromptBadge(systemName: benefit.systemName)
                        }
                    }
                }
            }

            DSCardSurface(horizontalPadding: .space12, verticalPadding: .space12) {
                DSHStack(spacing: .space12) {
                    DSPermissionPromptBadge(systemName: noteSystemName)
                    DSText(note)
                        .dsTextStyle(.bodySmall, .text(.secondary))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            Spacer(minLength: 0)
        }
        .dsScreen()
        .safeAreaInset(edge: .bottom, spacing: 0) {
            DSVStack(spacing: .space8) {
                DSButton(title: primaryTitle, action: primaryAction)

                DSButton(title: secondaryTitle, style: .clear, action: secondaryAction)
            }
            .dsPadding(.horizontal, .space24)
            .dsPadding(.top, .space16)
            .dsPadding(.bottom, .space16)
            .frame(maxWidth: .infinity)
            .dsBackground(.primary)
        }
    }
}

private struct DSPermissionPromptHero: View {
    let systemName: String
    let title: String
    let message: String

    var body: some View {
        DSVStack(alignment: .center, spacing: .space12) {
            DSImageView(systemName: systemName, size: 74, tint: .icon(.brand))

            DSText(title, alignment: .center)
                .dsTextStyle(.custom(size: 26, weight: .semibold, relativeTo: .headline))
                .lineLimit(2)
                .minimumScaleFactor(0.9)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity)

            DSText(message, alignment: .center)
                .dsTextStyle(.body)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct DSPermissionPromptBadge: View {
    @Environment(\.appearance) private var appearance
    @Environment(\.surfaceStyle) private var surfaceStyle

    let systemName: String

    var body: some View {
        let color = DSColorToken.icon(.brand).color(for: appearance, in: surfaceStyle)

        ZStack {
            Circle()
                .fill(color.opacity(0.14))

            DSImageView(systemName: systemName, size: .font(.caption1), tint: .icon(.brand))
        }
        .frame(width: 34, height: 34)
    }
}

struct Testable_DSPermissionPromptView: View {
    var body: some View {
        DSPermissionPromptView(
            heroSystemName: "bell.badge.fill",
            title: "Enable notifications?",
            message: "Receive useful updates about messages, reminders, and account activity.",
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
            primaryAction: {},
            secondaryAction: {}
        )
    }
}

struct DSPermissionPromptView_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_DSPermissionPromptView()
        }
    }
}
