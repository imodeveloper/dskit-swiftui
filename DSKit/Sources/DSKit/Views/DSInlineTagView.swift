//
//  DSInlineTagView.swift
//  DSKit
//
//  Created by Ivan Borinschi on 09.04.2026.
//

import SwiftUI

/*
## DSInlineTagView

`DSInlineTagView` is a small layout primitive for inline metadata tags made of a leading icon and trailing content.

#### Usage:
- Keep icon and label alignment consistent across multiple tag rows.
- Provide either a system icon or any custom icon view.
- Optionally reserve a fixed-width icon slot so symbols with different metrics still align visually.
*/

public struct DSInlineTagView: View {
    private let spacing: DSSpatialToken
    private let icon: AnyView
    private let content: AnyView

    public init(
        spacing: DSSpatialToken = .space4,
        iconOffset: CGSize? = nil,
        @ViewBuilder icon: () -> some View,
        @ViewBuilder content: () -> some View
    ) {
        self.spacing = spacing
        let resolvedOffset = iconOffset ?? .zero
        self.icon = AnyView(
            icon()
                .offset(x: resolvedOffset.width, y: resolvedOffset.height)
        )
        self.content = AnyView(content())
    }

    public init(
        systemName: String,
        text: String,
        color: DSColorToken,
        textStyle: DSTypographyToken = .caption1,
        additionalScale: CGFloat = 0,
        spacing: DSSpatialToken = .space4,
        iconOffset: CGSize? = nil
    ) {
        self.spacing = spacing
        self.icon = AnyView(
            InlineSystemIconView(
                systemName: systemName,
                textStyle: textStyle,
                color: color,
                additionalScale: additionalScale,
                iconOffsetOverride: iconOffset
            )
        )
        self.content = AnyView(
            DSText(text)
                .dsTextStyle(textStyle, color)
        )
    }

    public var body: some View {
        DSHStack(spacing: spacing) {
            icon
            content
        }
    }
}

private struct InlineSystemIconView: View {
    @Environment(\.appearance) private var appearance

    let systemName: String
    let textStyle: DSTypographyToken
    let color: DSColorToken
    let additionalScale: CGFloat
    let iconOffsetOverride: CGSize?

    var body: some View {
        DSImageView(
            systemName: systemName,
            size: .size(.custom(requestedPointSize)),
            tint: color
        )
        .frame(width: iconSlotWidth, alignment: .center)
        .offset(x: resolvedIconOffset.width, y: resolvedIconOffset.height)
    }

    private var requestedPointSize: CGFloat {
        let baseSize = textStyle.pointSize(for: appearance)
        return max(0, baseSize + (baseSize * additionalScale))
    }

    private var iconSlotWidth: CGFloat {
        let baseSize = textStyle.pointSize(for: appearance)
        return baseSize + max(2, baseSize * 0.2)
    }

    private var resolvedIconOffset: CGSize {
        iconOffsetOverride ?? .zero
    }
}

private struct DSInlineTagViewPreview: View {
    var body: some View {
        DSVStack(spacing: .space16) {
            previewSection(
                title: "Common Tags",
                tags: {
                    DSInlineTagView(
                        systemName: "clock",
                        text: "Actual",
                        color: .text(.caption1)
                    )
                    DSInlineTagView(
                        systemName: "chart.pie",
                        text: "Economie",
                        color: .text(.caption1)
                    )
                    DSInlineTagView(
                        systemName: "bookmark",
                        text: "Salvat",
                        color: .text(.caption1)
                    )
                    DSInlineTagView(
                        systemName: "square.stack.3d.down.forward",
                        text: "10 surse",
                        color: .text(.caption1),
                        additionalScale: 0.25,
                        iconOffset: CGSize(width: 0.8, height: 0.8)
                    )
                }
            )

            previewSection(
                title: "Scaled Symbols",
                tags: {
                    DSInlineTagView(
                        systemName: "square.stack.3d.down.forward",
                        text: "12 surse",
                        color: .text(.caption1),
                        additionalScale: 0.25,
                        iconOffset: CGSize(width: 0.8, height: 0.8)
                    )
                    DSInlineTagView(
                        systemName: "bookmark",
                        text: "Important",
                        color: .text(.caption1)
                    )
                    DSInlineTagView(
                        systemName: "bookmark",
                        text: "Manual Override",
                        color: .text(.caption1)
                    )
                }
            )

            previewSection(
                title: "Typography Slots",
                tags: {
                    DSInlineTagView(
                        systemName: "clock",
                        text: "Caption 1",
                        color: .text(.caption1),
                        textStyle: .caption1
                    )
                    DSInlineTagView(
                        systemName: "clock",
                        text: "Subheadline",
                        color: .text(.subheadline),
                        textStyle: .subheadline
                    )
                }
            )

            previewSection(
                title: "Custom Content",
                tags: {
                    DSInlineTagView(spacing: .space4) {
                        DSImageView(systemName: "clock", size: .font(.caption1), tint: .text(.caption1))
                    } content: {
                        DSText("Acum 5 minute")
                            .dsTextStyle(.caption1)
                    }

                    DSInlineTagView(spacing: .space4) {
                        Circle()
                            .fill(Color.orange)
                            .frame(width: 8, height: 8)
                    } content: {
                        DSText("Live")
                            .dsTextStyle(.caption1)
                    }
                }
            )
        }
        .dsPadding()
    }

    private func previewSection<Content: View>(
        title: String,
        @ViewBuilder tags: @escaping () -> Content
    ) -> some View {
        DSVStack(alignment: .leading, spacing: .space8) {
            DSText(title)
                .dsTextStyle(.subheadline)

            DSVStack(alignment: .leading, spacing: .space8) {
                tags()
            }
        }
    }
}

struct DSInlineTagView_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                DSInlineTagViewPreview()
            }.dsLayoutDebug()
        }
    }
}
