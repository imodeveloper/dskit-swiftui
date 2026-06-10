//
//  DSContentCard.swift
//  DSKit
//
//  Created by Ivan Borinschi on 09.06.2026.
//

import SwiftUI

public enum DSContentCardMediaPlacement: Hashable, Sendable {
    case top
    case bottom
}

public struct DSContentCard<Content: View, Media: View>: View {
    private let spacing: DSSpatialToken
    private let mediaPlacement: DSContentCardMediaPlacement
    private let content: Content
    private let media: Media

    public init(
        spacing: DSSpatialToken = .custom(0),
        mediaPlacement: DSContentCardMediaPlacement = .bottom,
        @ViewBuilder content: () -> Content,
        @ViewBuilder media: () -> Media
    ) {
        self.spacing = spacing
        self.mediaPlacement = mediaPlacement
        self.content = content()
        self.media = media()
    }

    public var body: some View {
        DSVStack(spacing: spacing) {
            if mediaPlacement == .top {
                media
                content
            } else {
                content
                media
            }
        }
        .dsSecondaryBackground()
        .dsCornerRadius()
    }
}

struct Testable_DSContentCardComponents: View {
    private let fixedDate = Date(timeIntervalSince1970: 1_780_000_000)

    var body: some View {
        DSVStack(spacing: .space12) {
            DSContentCard {
                DSVStack(spacing: .space8) {
                    DSText("Barbershop Broadway")
                        .dsTextStyle(.headline)
                    DSMetadataRow {
                        DSMetadataTag("325 Broadway", systemName: "house")
                        DSRelativeTimeTag(
                            date: fixedDate.addingTimeInterval(-3600),
                            locale: Locale(identifier: "en_US"),
                            referenceDate: fixedDate
                        )
                    }
                }
                .dsPadding()
            } media: {
                Rectangle()
                    .fill(Color.blue.opacity(0.2))
                    .dsHeight(90)
            }

            DSCardSurface {
                DSEntityRow(
                    title: "Service",
                    subtitle: "Select service",
                    accessory: .chevron
                ) {
                    DSSymbolIconView(systemName: "scissors", textStyle: .headline)
                }
            }

            DSInfoCallout(
                lines: [
                    "Use one card for one topic.",
                    "Keep actions clear and predictable."
                ],
                systemName: "sparkles"
            )

            DSEntityCardRow(
                title: "Maia Sandu",
                subtitle: "President",
                badgeText: "2",
                accessorySystemName: "chevron.right"
            )
        }
    }
}

struct Testable_DSArticleThreadComponents: View {
    private let fixedDate = Date(timeIntervalSince1970: 1_780_000_000)

    var body: some View {
        DSVStack(alignment: .leading, spacing: .space12) {
            DSArticleAuthorLabel(
                name: "Moldova 1",
                textStyle: .custom(size: 15, weight: .semibold, relativeTo: .headline)
            )

            DSArticleThreadRow(
                title: "Guvernul anunta un nou calendar pentru proiectele de infrastructura",
                titleTextStyle: .bodyLarge
            ) {
                Rectangle()
                    .fill(Color.blue.opacity(0.2))
                    .frame(width: 64, height: 64)
                    .dsCornerRadius()
                    .padding(.top, 4)
            }

            DSArticleAuthorLabel(
                name: "NewsMaker",
                textStyle: .custom(size: 12, weight: .semibold, relativeTo: .headline)
            )

            DSArticleThreadRow(
                title: "Ministerul spune ca primele contracte vor fi semnate in urmatoarele saptamani.",
                titleTextStyle: .bodySmall
            )

            DSArticleMetadataFooter {
                DSMetadataRow(spacing: .space16) {
                    DSRelativeTimeTag(
                        date: fixedDate.addingTimeInterval(-7200),
                        locale: Locale(identifier: "en_US"),
                        referenceDate: fixedDate
                    )
                    DSMetadataTag("Politics", systemName: "building.columns", textStyle: .caption1)
                    DSMetadataTag("3 sources", systemName: "line.3.horizontal.decrease.circle", textStyle: .caption1)
                }
            }
        }
        .dsPadding()
    }
}

struct DSContentCardComponents_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSContentCardComponents()
                Testable_DSArticleThreadComponents()
            }
        }
    }
}
