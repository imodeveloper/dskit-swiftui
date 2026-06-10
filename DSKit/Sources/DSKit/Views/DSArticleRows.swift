//
//  DSArticleRows.swift
//  DSKit
//
//  Created by Ivan Borinschi on 09.06.2026.
//

import SwiftUI

public struct DSArticleSummaryRow<Metadata: View>: View {
    private let authorName: String?
    private let authorTextStyle: DSTypographyToken
    private let title: String
    private let titleTextStyle: DSTypographyToken
    private let imageURL: URL?
    private let imageSize: DSSize
    private let imageTopPadding: CGFloat
    private let metadata: Metadata

    public init(
        authorName: String?,
        authorTextStyle: DSTypographyToken = .label,
        title: String,
        titleTextStyle: DSTypographyToken = .body,
        imageURL: URL? = nil,
        imageSize: DSSize = .size(.token(.space64)),
        imageTopPadding: CGFloat = 0,
        @ViewBuilder metadata: () -> Metadata
    ) {
        self.authorName = authorName
        self.authorTextStyle = authorTextStyle
        self.title = title
        self.titleTextStyle = titleTextStyle
        self.imageURL = imageURL
        self.imageSize = imageSize
        self.imageTopPadding = imageTopPadding
        self.metadata = metadata()
    }

    public var body: some View {
        DSHStack(alignment: .center, spacing: .space16) {
            DSVStack(spacing: .space8) {
                if let authorName {
                    DSAuthorView(
                        name: authorName,
                        badgeColor: DSLetterBadgeView.generatedColor(for: authorName),
                        textStyle: authorTextStyle,
                        textColor: .text(.primary)
                    )
                }

                DSText(title.trimmingCharacters(in: .newlines))
                    .dsTextStyle(titleTextStyle)
                    .dsFullWidth()
                    .fixedSize(horizontal: false, vertical: true)

                metadata
            }

            if let imageURL {
                DSImageView(url: imageURL, style: .none, size: imageSize)
                    .dsCornerRadius()
                    .padding(Edge.Set.top, imageTopPadding)
            }
        }
    }
}

public struct DSArticleAuthorLabel: View {
    private let name: String?
    private let textStyle: DSTypographyToken
    private let textColor: DSColorToken

    public init(
        name: String?,
        textStyle: DSTypographyToken = .label,
        textColor: DSColorToken = .text(.primary)
    ) {
        self.name = name
        self.textStyle = textStyle
        self.textColor = textColor
    }

    public var body: some View {
        if let name, name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            DSAuthorView(
                name: name,
                badgeColor: DSLetterBadgeView.generatedColor(for: name),
                textStyle: textStyle,
                textColor: textColor
            )
        }
    }
}

public struct DSArticleThreadRow<Trailing: View>: View {
    private let title: String
    private let titleTextStyle: DSTypographyToken
    private let spacing: DSSpatialToken
    private let onTap: (() -> Void)?
    private let trailing: Trailing

    public init(
        title: String,
        titleTextStyle: DSTypographyToken,
        spacing: DSSpatialToken = .space16,
        onTap: (() -> Void)? = nil,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.title = title
        self.titleTextStyle = titleTextStyle
        self.spacing = spacing
        self.onTap = onTap
        self.trailing = trailing()
    }

    public var body: some View {
        DSHStack(alignment: .center, spacing: spacing) {
            DSVStack(spacing: .space8) {
                DSText(title.trimmingCharacters(in: .newlines))
                    .dsTextStyle(titleTextStyle)
                    .dsFullWidth()
                    .fixedSize(horizontal: false, vertical: true)
            }

            trailing
        }
        .onTap {
            onTap?()
        }
    }
}

public extension DSArticleThreadRow where Trailing == EmptyView {
    init(
        title: String,
        titleTextStyle: DSTypographyToken,
        spacing: DSSpatialToken = .space16,
        onTap: (() -> Void)? = nil
    ) {
        self.init(
            title: title,
            titleTextStyle: titleTextStyle,
            spacing: spacing,
            onTap: onTap,
            trailing: { EmptyView() }
        )
    }
}

public struct DSArticleMetadataFooter<Metadata: View>: View {
    private let spacing: DSSpatialToken
    private let metadata: Metadata

    public init(
        spacing: DSSpatialToken = .space4,
        @ViewBuilder metadata: () -> Metadata
    ) {
        self.spacing = spacing
        self.metadata = metadata()
    }

    public var body: some View {
        DSHStack(spacing: spacing) {
            metadata
                .fixedSize(horizontal: true, vertical: false)

            Spacer()
        }
    }
}
