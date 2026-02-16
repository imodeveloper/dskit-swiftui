//
//  DSTextColor.swift
//  DSKit
//
//  Created by Borinschi Ivan on 21.01.2021.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
//

import SwiftUI

public indirect enum DSTextFontKey: Equatable, Hashable {

    case largeTitle
    case title1
    case title2
    case title3
    case headline
    case subheadline
    case body
    case callout
    case caption1
    case caption2
    case footnote
    case custom(DSFont)
    case fontWithSize(DSTextFontKey, CGFloat)
    case smallHeadline
    case smallSubheadline
    case largeHeadline

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
        let baseFont = uiFont(for: appearance)
        #if canImport(UIKit)
        guard let textStyle = swiftUITextStyle() else {
            return Font(baseFont)
        }
        if isSystemFontName(baseFont.fontName) {
            return Font(baseFont)
        }
        return .custom(baseFont.fontName, size: baseFont.pointSize, relativeTo: textStyle)
        #else
        return Font(baseFont)
        #endif
    }

    public func font(
        for appearance: DSAppearance,
        sizeCategory: ContentSizeCategory?
    ) -> Font {
        Font(uiFont(for: appearance, sizeCategory: sizeCategory))
    }

    private func uiFont(
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

    public func uiFont(for appearance: DSAppearance) -> DSFont {
        return switch self {
        case .title1:
            appearance.fonts.title1
        case .title2:
            appearance.fonts.title2
        case .title3:
            appearance.fonts.title3
        case .headline:
            appearance.fonts.headline
        case .subheadline:
            appearance.fonts.subheadline
        case .body:
            appearance.fonts.body
        case .callout:
            appearance.fonts.callout
        case .caption1:
            appearance.fonts.caption1
        case .caption2:
            appearance.fonts.caption2
        case .footnote:
            appearance.fonts.footnote
        case .largeTitle:
            appearance.fonts.largeTitle
        case .custom(let customFont):
            customFont
        case .fontWithSize(let font, let size):
            font.uiFont(for: appearance).withSize(size)
        case .smallHeadline:
            appearance.fonts.headline.withSize(14)
        case .smallSubheadline:
            appearance.fonts.subheadline.withSize(12)
        case .largeHeadline:
            appearance.fonts.headline.withSize(30)
        }
    }

    func color(for textColors: DSTextAppearance) -> DSUIColor {
        return switch self {
        case .largeTitle:
            textColors.largeTitle
        case .title1:
            textColors.title1
        case .title2:
            textColors.title2
        case .title3:
            textColors.title3
        case .headline:
            textColors.headline
        case .subheadline:
            textColors.subheadline
        case .body:
            textColors.body
        case .callout:
            textColors.callout
        case .caption1:
            textColors.caption1
        case .caption2:
            textColors.caption2
        case .footnote:
            textColors.footnote
        case .custom:
            DSUIColor.black
        case .fontWithSize(let font, _):
            font.color(for: textColors)
        case .smallHeadline:
            textColors.headline
        case .smallSubheadline:
            textColors.subheadline
        case .largeHeadline:
            textColors.headline
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

private extension DSTextFontKey {
    func isSystemFontName(_ name: String) -> Bool {
        name.hasPrefix(".SFUI") ||
        name.hasPrefix(".SFUIText") ||
        name.hasPrefix(".SFUIDisplay") ||
        name.hasPrefix("SFUI") ||
        name.hasPrefix("SFPro")
    }

    func swiftUITextStyle() -> Font.TextStyle? {
        switch self {
        case .largeTitle:
            return .largeTitle
        case .title1:
            return .title
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .headline:
            return .headline
        case .subheadline:
            return .subheadline
        case .body:
            return .body
        case .callout:
            return .callout
        case .caption1:
            return .caption
        case .caption2:
            return .caption2
        case .footnote:
            return .footnote
        case .custom:
            return nil
        case .fontWithSize(let style, _):
            return style.swiftUITextStyle()
        case .smallHeadline, .largeHeadline:
            return .headline
        case .smallSubheadline:
            return .subheadline
        }
    }

    func uiTextStyle() -> UIFont.TextStyle? {
        switch self {
        case .largeTitle:
            return .largeTitle
        case .title1:
            return .title1
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .headline:
            return .headline
        case .subheadline:
            return .subheadline
        case .body:
            return .body
        case .callout:
            return .callout
        case .caption1:
            return .caption1
        case .caption2:
            return .caption2
        case .footnote:
            return .footnote
        case .custom:
            return nil
        case .fontWithSize(let style, _):
            return style.uiTextStyle()
        case .smallHeadline, .largeHeadline:
            return .headline
        case .smallSubheadline:
            return .subheadline
        }
    }
}
#endif
