//
//  DSTypographyToken.swift
//  DSKit
//
//  Created by Ivan Borinschi on 08.04.2026.
//

import SwiftUI

public indirect enum DSTypographyToken: Equatable, Hashable {
    case largeTitle
    case title1
    case title2
    case title3
    case headline
    case body
    case callout
    case subheadline
    case footnote
    case caption1
    case caption2
    case label
    case bodySmall
    case bodyLarge
    case custom(
        size: CGFloat,
        weight: DSTypographyWeight = .regular,
        relativeTo: DSTypographyToken = .body
    )

    public func pointSize(for appearance: DSAppearance) -> CGFloat {
        pointSize(for: appearance, sizeCategory: nil)
    }

    public func pointSize(
        for appearance: DSAppearance,
        sizeCategory: ContentSizeCategory?
    ) -> CGFloat {
        uiFont(for: appearance, sizeCategory: sizeCategory).pointSize
    }

    public func font(for appearance: DSAppearance) -> Font {
        Font(uiFont(for: appearance))
    }

    public func font(
        for appearance: DSAppearance,
        sizeCategory: ContentSizeCategory?
    ) -> Font {
        Font(uiFont(for: appearance, sizeCategory: sizeCategory))
    }

    public func uiFont(for appearance: DSAppearance) -> DSFont {
        switch self {
        case .largeTitle:
            return appearance.typography.largeTitle
        case .title1:
            return appearance.typography.title1
        case .title2:
            return appearance.typography.title2
        case .title3:
            return appearance.typography.title3
        case .headline:
            return appearance.typography.headline
        case .body:
            return appearance.typography.body
        case .callout:
            return appearance.typography.callout
        case .subheadline:
            return appearance.typography.subheadline
        case .footnote:
            return appearance.typography.footnote
        case .caption1:
            return appearance.typography.caption1
        case .caption2:
            return appearance.typography.caption2
        case .label:
            return appearance.typography.headline.withSize(14)
        case .bodySmall:
            return appearance.typography.body.withSize(14)
        case .bodyLarge:
            return appearance.typography.body.withSize(18)
        case .custom(let size, let weight, let relativeTo):
            let baseFont = relativeTo.baseFont(for: appearance)
            return baseFont.dsAdjusted(size: size, weight: weight)
        }
    }

    public func uiFont(
        for appearance: DSAppearance,
        sizeCategory: ContentSizeCategory?
    ) -> DSFont {
        let baseFont = uiFont(for: appearance)

        #if canImport(UIKit)
        guard let sizeCategory,
              let textStyle = uiTextStyle()
        else {
            return baseFont
        }

        let traits = UITraitCollection(
            preferredContentSizeCategory: sizeCategory.uiContentSizeCategory
        )
        let scaledSize = UIFontMetrics(forTextStyle: textStyle)
            .scaledValue(for: baseFont.pointSize, compatibleWith: traits)
        return baseFont.withSize(scaledSize)
        #else
        return baseFont
        #endif
    }

    var baseColorRoleToken: DSTypographyToken {
        switch self {
        case .label:
            .headline
        case .bodySmall, .bodyLarge:
            .body
        case .custom(_, _, let relativeTo):
            relativeTo.baseColorRoleToken
        default:
            self
        }
    }

    private func baseFont(for appearance: DSAppearance) -> DSFont {
        switch self {
        case .custom(_, _, let relativeTo):
            relativeTo.baseFont(for: appearance)
        default:
            uiFont(for: appearance)
        }
    }
}

#if canImport(UIKit)
private extension ContentSizeCategory {
    var uiContentSizeCategory: UIContentSizeCategory {
        switch self {
        case .extraSmall:
            .extraSmall
        case .small:
            .small
        case .medium:
            .medium
        case .large:
            .large
        case .extraLarge:
            .extraLarge
        case .extraExtraLarge:
            .extraExtraLarge
        case .extraExtraExtraLarge:
            .extraExtraExtraLarge
        case .accessibilityMedium:
            .accessibilityMedium
        case .accessibilityLarge:
            .accessibilityLarge
        case .accessibilityExtraLarge:
            .accessibilityExtraLarge
        case .accessibilityExtraExtraLarge:
            .accessibilityExtraExtraLarge
        case .accessibilityExtraExtraExtraLarge:
            .accessibilityExtraExtraExtraLarge
        @unknown default:
            .large
        }
    }
}

private extension DSTypographyWeight {
    var uiWeight: UIFont.Weight {
        switch self {
        case .regular:
            .regular
        case .medium:
            .medium
        case .semibold:
            .semibold
        case .bold:
            .bold
        }
    }
}

private extension DSTypographyToken {
    func uiTextStyle() -> UIFont.TextStyle? {
        switch self {
        case .largeTitle:
            .largeTitle
        case .title1:
            .title1
        case .title2:
            .title2
        case .title3:
            .title3
        case .headline, .label:
            .headline
        case .body, .bodySmall, .bodyLarge:
            .body
        case .callout:
            .callout
        case .subheadline:
            .subheadline
        case .footnote:
            .footnote
        case .caption1:
            .caption1
        case .caption2:
            .caption2
        case .custom(_, _, let relativeTo):
            relativeTo.uiTextStyle()
        }
    }
}

private extension DSFont {
    func dsAdjusted(size: CGFloat, weight: DSTypographyWeight) -> DSFont {
        let sizedFont = withSize(size)
        let descriptor = sizedFont.fontDescriptor.addingAttributes([
            UIFontDescriptor.AttributeName.traits: [
                UIFontDescriptor.TraitKey.weight: weight.uiWeight
            ]
        ])
        return UIFont(descriptor: descriptor, size: size)
    }
}
#elseif canImport(AppKit)
private extension DSFont {
    func dsAdjusted(size: CGFloat, weight: DSTypographyWeight) -> DSFont {
        let sizedFont = withSize(size)
        let fontManager = NSFontManager.shared

        switch weight {
        case .regular:
            return fontManager.convert(sizedFont, toHaveTrait: [])
        case .medium, .semibold, .bold:
            return fontManager.convert(sizedFont, toHaveTrait: .boldFontMask)
        }
    }
}
#endif
