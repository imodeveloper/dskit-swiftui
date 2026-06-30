//
//  DSStatusView.swift
//  DSKit
//
//  Created by Ivan Borinschi on 30.06.2026.
//

import SwiftUI

/*
## DSStatusView

`DSStatusView` is a reusable success, empty, permission, or informational state. It supports an optional SF Symbol, title, message, action, and either plain centered presentation or a compact card presentation.

#### Initialization:
Initializes `DSStatusView` with optional status content and styling.
- Parameters:
- `systemName`: Optional SF Symbol shown above the text.
- `title`: Optional status title.
- `message`: Optional supporting message.
- `style`: `.plain` for centered screen states or `.card` for compact message cards.
- `alignment`: Horizontal content alignment.
- `textAlignment`: Text alignment for title and message.
- `actionTitle`: Optional button title.
- `action`: Optional button action.

#### Usage:
Use `DSStatusView` for confirmation states, empty lists, permission prompts, or compact single-message cards. When no icon or title is provided, `.card` keeps vertical and horizontal padding balanced for simple empty messages.
*/

public enum DSStatusViewStyle: Hashable, Sendable {
    case plain
    case card
}

public struct DSStatusView: View {
    private let systemName: String?
    private let title: String?
    private let message: String?
    private let style: DSStatusViewStyle
    private let alignment: HorizontalAlignment
    private let textAlignment: TextAlignment
    private let spacing: DSSpatialToken
    private let iconSize: DSSize
    private let iconTint: DSColorToken
    private let titleStyle: DSTypographyToken
    private let messageStyle: DSTypographyToken
    private let actionTitle: String?
    private let action: (() -> Void)?

    public init(
        systemName: String? = nil,
        title: String? = nil,
        message: String? = nil,
        style: DSStatusViewStyle = .plain,
        alignment: HorizontalAlignment = .center,
        textAlignment: TextAlignment = .center,
        spacing: DSSpatialToken = .space12,
        iconSize: DSSize = 70,
        iconTint: DSColorToken = .icon(.success),
        titleStyle: DSTypographyToken = .title1,
        messageStyle: DSTypographyToken = .subheadline,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.systemName = systemName
        self.title = title
        self.message = message
        self.style = style
        self.alignment = alignment
        self.textAlignment = textAlignment
        self.spacing = spacing
        self.iconSize = iconSize
        self.iconTint = iconTint
        self.titleStyle = titleStyle
        self.messageStyle = messageStyle
        self.actionTitle = actionTitle
        self.action = action
    }

    public var body: some View {
        switch style {
        case .plain:
            content
        case .card:
            content
                .dsCardStyle(horizontalPadding: .space16, verticalPadding: .space16)
        }
    }

    private var content: some View {
        DSVStack(alignment: alignment, spacing: spacing) {
            if let systemName {
                DSImageView(
                    systemName: systemName,
                    size: iconSize,
                    tint: iconTint
                )
            }

            if let title {
                DSText(title, alignment: textAlignment)
                    .dsTextStyle(titleStyle)
            }

            if let message {
                DSText(message, alignment: textAlignment)
                    .dsTextStyle(messageStyle)
            }

            if let actionTitle, let action {
                DSButton(title: actionTitle, action: action)
            }
        }
        .frame(maxWidth: .infinity, alignment: frameAlignment)
    }

    private var frameAlignment: Alignment {
        switch alignment {
        case .leading:
            .leading
        case .trailing:
            .trailing
        default:
            .center
        }
    }
}

struct Testable_DSStatusView: View {
    var body: some View {
        DSVStack(spacing: .space16) {
            DSStatusView(
                systemName: "checkmark.circle.fill",
                title: "It's Ordered",
                message: "Thanks for your order. We hope you enjoyed shopping with us.",
                actionTitle: "Continue Shopping",
                action: {}
            )

            DSStatusView(
                message: "No accounts available. Maybe you've hidden the account you're looking for.",
                style: .card,
                alignment: .leading,
                textAlignment: .leading,
                messageStyle: .bodyLarge
            )
        }
    }
}

struct DSStatusView_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSStatusView()
            }
        }
    }
}
