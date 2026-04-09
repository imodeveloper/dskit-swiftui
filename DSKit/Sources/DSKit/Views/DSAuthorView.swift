//
//  DSAuthorView.swift
//  DSKit
//
//  Created by Ivan Borinschi on 09.04.2026.
//

import SwiftUI

/*
## DSAuthorView

`DSAuthorView` is a reusable inline author/source label composed of an initial badge and a text label.

#### Usage:
- Use for article authors, sources, or any compact labeled identity row.
- Keep text and badge sizing tied to a shared `DSTypographyToken`.
- Override label color when the surrounding surface needs a stronger or softer emphasis.
*/

public struct DSAuthorView: View {
    @Environment(\.appearance) public var appearance: DSAppearance

    private let name: String
    private let badgeColor: Color
    private let textStyle: DSTypographyToken
    private let textColor: DSColorToken

    public init(
        name: String,
        badgeColor: Color,
        textStyle: DSTypographyToken = .label,
        textColor: DSColorToken? = nil
    ) {
        self.name = name
        self.badgeColor = badgeColor
        self.textStyle = textStyle
        self.textColor = textColor ?? .text(textStyle)
    }

    public var body: some View {
        DSHStack(spacing: resolvedSpacing) {
            DSLetterBadgeView(
                text: initialText,
                backgroundColor: badgeColor,
                textStyle: textStyle
            )

            DSText(name)
                .dsTextStyle(textStyle, textColor)
        }
    }

    private var initialText: String {
        String(name.trimmingCharacters(in: .whitespacesAndNewlines).prefix(1)).uppercased()
    }

    private var resolvedSpacing: DSSpatialToken {
        DSSpatialToken.custom(max(4, textStyle.pointSize(for: appearance) * 0.4))
    }
}

private struct DSAuthorViewPreview: View {
    var body: some View {
        DSVStack(alignment: .leading, spacing: .space12) {
            DSAuthorView(name: "Caption 2", badgeColor: .pink, textStyle: .caption2)
            DSAuthorView(name: "Caption 1", badgeColor: .blue, textStyle: .caption1)
            DSAuthorView(name: "Footnote", badgeColor: .indigo, textStyle: .footnote)
            DSAuthorView(name: "Subheadline", badgeColor: .orange, textStyle: .subheadline)
            DSAuthorView(name: "Callout", badgeColor: .mint, textStyle: .callout)
            DSAuthorView(name: "Label", badgeColor: .green, textStyle: .label)
            DSAuthorView(name: "Body Small", badgeColor: .yellow, textStyle: .bodySmall)
            DSAuthorView(name: "Body", badgeColor: .cyan, textStyle: .body)
            DSAuthorView(name: "Headline", badgeColor: .teal, textStyle: .headline)
            DSAuthorView(name: "Body Large", badgeColor: .purple, textStyle: .bodyLarge)
            DSAuthorView(name: "Title 3", badgeColor: .red, textStyle: .title3)
            DSAuthorView(name: "Title 2", badgeColor: .brown, textStyle: .title2)
            DSAuthorView(name: "Title 1", badgeColor: .gray, textStyle: .title1)
            DSAuthorView(name: "Large Title", badgeColor: .black, textStyle: .largeTitle)
            DSAuthorView(
                name: "Custom 20 Semibold",
                badgeColor: .secondary,
                textStyle: .custom(size: 20, weight: .semibold, relativeTo: .headline)
            )
        }
        .dsPadding()
    }
}

struct DSAuthorView_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                DSAuthorViewPreview()
            }
        }
    }
}
