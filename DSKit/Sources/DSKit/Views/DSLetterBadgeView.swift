//
//  DSLetterBadgeView.swift
//  DSKit
//
//  Created by Ivan Borinschi on 09.04.2026.
//

import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

/*
## DSLetterBadgeView

`DSLetterBadgeView` renders a compact initial badge whose size is derived from a typography token.

#### Usage:
- Show a single-letter or short-initial avatar next to names and sources.
- Keep badge sizing tied to `DSTypographyToken` instead of ad-hoc `CGFloat` values.
- Pass an explicit background color so the badge styling is controlled by the caller.
*/

public struct DSLetterBadgeView: View {
    @Environment(\.appearance) public var appearance: DSAppearance

    private let text: String
    private let backgroundColor: Color
    private let textStyle: DSTypographyToken

    public init(
        text: String,
        backgroundColor: Color,
        textStyle: DSTypographyToken = .caption1
    ) {
        self.text = text
        self.backgroundColor = backgroundColor
        self.textStyle = textStyle
    }

    public var body: some View {
        DSText(text)
            .dsTextStyle(badgeTextStyle, .color(.white))
            .lineLimit(1)
            .minimumScaleFactor(0.7)
            .padding(.vertical, verticalPadding)
            .padding(.horizontal, horizontalPadding)
            .frame(minWidth: badgeHeight, minHeight: badgeHeight)
            .background(badgeShape.fill(backgroundColor))
    }

    private var badgeTextStyle: DSTypographyToken {
        .custom(
            size: max(9, min(resolvedFont.pointSize, resolvedFont.capHeight * 1.05)),
            weight: textWeight,
            relativeTo: textStyle
        )
    }

    private var badgeHeight: CGFloat {
        max(16, resolvedFont.lineHeight * 1.08)
    }

    private var resolvedFont: DSFont {
        textStyle.uiFont(for: appearance)
    }

    private var textWeight: DSTypographyWeight {
        switch textStyle {
        case .headline, .label:
            .semibold
        case .custom(_, let weight, _):
            weight
        default:
            .regular
        }
    }

    private var isCircular: Bool {
        text.count <= 1
    }

    private var verticalPadding: CGFloat {
        isCircular ? 0 : max(2, badgeHeight * 0.16)
    }

    private var horizontalPadding: CGFloat {
        isCircular ? 0 : max(verticalPadding * 1.5, badgeHeight * 0.3)
    }

    private var badgeShape: AnyShape {
        if isCircular {
            AnyShape(Circle())
        } else {
            AnyShape(Capsule())
        }
    }

    private static let palette: [Color] = [
        Color(DSUIColor.dynamic(light: 0x4E79A7, dark: 0x6D9EEB)),
        Color(DSUIColor.dynamic(light: 0xE15759, dark: 0xF28B82)),
        Color(DSUIColor.dynamic(light: 0x76B7B2, dark: 0x81C7C2)),
        Color(DSUIColor.dynamic(light: 0x59A14F, dark: 0x81C784)),
        Color(DSUIColor.dynamic(light: 0xEDC948, dark: 0xFFD54F)),
        Color(DSUIColor.dynamic(light: 0xB07AA1, dark: 0xCE93D8)),
        Color(DSUIColor.dynamic(light: 0xFF9DA7, dark: 0xF8BBD0)),
        Color(DSUIColor.dynamic(light: 0x9C755F, dark: 0xBCAAA4)),
        Color(DSUIColor.dynamic(light: 0xBAB0AC, dark: 0xCFD8DC)),
        Color(DSUIColor.dynamic(light: 0x3E7CB1, dark: 0x64B5F6))
    ]

    public static func generatedColor(for seed: String) -> Color {
        if let namedColor = colorFromNamedAsset(seed) {
            return namedColor
        }

        let stableColorIndex = seed.unicodeScalars.reduce(0) { partialResult, scalar in
            ((partialResult * 31) + Int(scalar.value)) & 0x7fffffff
        }
        return palette[stableColorIndex % palette.count]
    }

    private static func colorFromNamedAsset(_ name: String) -> Color? {
        #if canImport(UIKit)
        if let uiColor = UIColor(named: name) {
            return Color(uiColor)
        }
        #elseif canImport(AppKit)
        if let nsColor = NSColor(named: NSColor.Name(name)) {
            return Color(nsColor)
        }
        #endif
        return nil
    }
}

private struct DSLetterBadgeViewPreview: View {
    var body: some View {
        DSVStack(alignment: .leading, spacing: .space12) {
            DSHStack(spacing: .space8) {
                DSLetterBadgeView(text: "A", backgroundColor: .blue, textStyle: .caption1)
                DSLetterBadgeView(text: "M", backgroundColor: .green, textStyle: .label)
                DSLetterBadgeView(text: "ROMA", backgroundColor: .orange, textStyle: .label)
            }

            DSVStack(alignment: .leading, spacing: .space8) {
                DSHStack(spacing: .space8) {
                    DSLetterBadgeView(text: "Go", backgroundColor: .pink, textStyle: .caption2)
                    DSLetterBadgeView(text: "Ai", backgroundColor: .purple, textStyle: .caption1)
                    DSLetterBadgeView(text: "Flux", backgroundColor: .indigo, textStyle: .footnote)
                    DSLetterBadgeView(text: "Nova", backgroundColor: .teal, textStyle: .subheadline)
                    DSLetterBadgeView(text: "Pixel", backgroundColor: .mint, textStyle: .callout)
                }

                DSHStack(spacing: .space8) {
                    DSLetterBadgeView(text: "Bora", backgroundColor: .blue, textStyle: .body)
                    DSLetterBadgeView(text: "Helix", backgroundColor: .cyan, textStyle: .headline)
                    DSLetterBadgeView(text: "Luma", backgroundColor: .green, textStyle: .label)
                    DSLetterBadgeView(text: "Sora", backgroundColor: .yellow, textStyle: .bodySmall)
                    DSLetterBadgeView(text: "Bloom", backgroundColor: .orange, textStyle: .bodyLarge)
                }

                DSHStack(spacing: .space8) {
                    DSLetterBadgeView(text: "Tera", backgroundColor: .red, textStyle: .title3)
                    DSLetterBadgeView(text: "North", backgroundColor: .pink, textStyle: .title2)
                    DSLetterBadgeView(text: "Vector", backgroundColor: .purple, textStyle: .title1)
                    DSLetterBadgeView(text: "Orbit", backgroundColor: .brown, textStyle: .largeTitle)
                }

                DSHStack(spacing: .space8) {
                    DSLetterBadgeView(
                        text: "Custom",
                        backgroundColor: .gray,
                        textStyle: .custom(size: 20, weight: .semibold, relativeTo: .headline)
                    )
                }
            }
        }
        .dsPadding()
    }
}

struct DSLetterBadgeView_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                DSLetterBadgeViewPreview()
            }
        }
    }
}
