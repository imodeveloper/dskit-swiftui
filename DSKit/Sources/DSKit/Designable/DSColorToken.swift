//
//  DSColorToken.swift
//  DSKit
//
//  Created by Ivan Borinschi on 08.04.2026.
//

import SwiftUI

public enum DSColorToken: Equatable, Hashable {
    case background(DSBackgroundColorToken)
    case text(DSTextColorToken)
    case icon(DSIconColorToken)
    case border(DSBorderColorToken)
    case custom(Color)

    public func color(for appearance: DSAppearance, in surfaceStyle: DSSurfaceStyle) -> Color {
        switch self {
        case .custom(let color):
            return color
        default:
            return Color(uiColor(for: appearance, in: surfaceStyle))
        }
    }

    public func uiColor(for appearance: DSAppearance, in surfaceStyle: DSSurfaceStyle) -> DSUIColor {
        appearance.resolvedUIColor(for: self, in: surfaceStyle)
    }
}

public extension DSColorToken {
    static func color(_ color: Color) -> DSColorToken {
        .custom(color)
    }

    static func text(_ typographyToken: DSTypographyToken) -> DSColorToken {
        .text(typographyToken.semanticTextColorToken)
    }

    static func icon(_ typographyToken: DSTypographyToken) -> DSColorToken {
        .icon(typographyToken.semanticIconColorToken)
    }
}

public enum DSBackgroundColorToken: Equatable, Hashable, Sendable {
    case canvas
    case surface
    case surfaceRaised
    case surfaceSunken
    case overlay
    case brand
    case brandHover
    case brandPressed
    case neutral
    case neutralHover
    case neutralPressed
    case selected
    case selectedHover
    case selectedPressed
    case success
    case successSubtle
    case warning
    case warningSubtle
    case danger
    case dangerSubtle
    case info
    case infoSubtle
    case disabled
    case scrim
}

public enum DSTextColorToken: Equatable, Hashable, Sendable {
    case primary
    case secondary
    case tertiary
    case inverse
    case brand
    case brandOnBold
    case success
    case warning
    case danger
    case info
    case disabled
}

public enum DSIconColorToken: Equatable, Hashable, Sendable {
    case primary
    case secondary
    case tertiary
    case inverse
    case brand
    case brandOnBold
    case success
    case warning
    case danger
    case info
    case disabled
}

public enum DSBorderColorToken: Equatable, Hashable, Sendable {
    case subtle
    case `default`
    case strong
    case inverse
    case brand
    case focused
    case success
    case warning
    case danger
    case disabled
}

public struct DSBackgroundColorValues {
    public var canvas: DSUIColor
    public var surface: DSUIColor
    public var surfaceRaised: DSUIColor
    public var surfaceSunken: DSUIColor
    public var overlay: DSUIColor
    public var brand: DSUIColor
    public var brandHover: DSUIColor
    public var brandPressed: DSUIColor
    public var neutral: DSUIColor
    public var neutralHover: DSUIColor
    public var neutralPressed: DSUIColor
    public var selected: DSUIColor
    public var selectedHover: DSUIColor
    public var selectedPressed: DSUIColor
    public var success: DSUIColor
    public var successSubtle: DSUIColor
    public var warning: DSUIColor
    public var warningSubtle: DSUIColor
    public var danger: DSUIColor
    public var dangerSubtle: DSUIColor
    public var info: DSUIColor
    public var infoSubtle: DSUIColor
    public var disabled: DSUIColor
    public var scrim: DSUIColor
}

public struct DSTextColorValues {
    public var primary: DSUIColor
    public var secondary: DSUIColor
    public var tertiary: DSUIColor
    public var inverse: DSUIColor
    public var brand: DSUIColor
    public var brandOnBold: DSUIColor
    public var success: DSUIColor
    public var warning: DSUIColor
    public var danger: DSUIColor
    public var info: DSUIColor
    public var disabled: DSUIColor
}

public struct DSIconColorValues {
    public var primary: DSUIColor
    public var secondary: DSUIColor
    public var tertiary: DSUIColor
    public var inverse: DSUIColor
    public var brand: DSUIColor
    public var brandOnBold: DSUIColor
    public var success: DSUIColor
    public var warning: DSUIColor
    public var danger: DSUIColor
    public var info: DSUIColor
    public var disabled: DSUIColor
}

public struct DSBorderColorValues {
    public var subtle: DSUIColor
    public var `default`: DSUIColor
    public var strong: DSUIColor
    public var inverse: DSUIColor
    public var brand: DSUIColor
    public var focused: DSUIColor
    public var success: DSUIColor
    public var warning: DSUIColor
    public var danger: DSUIColor
    public var disabled: DSUIColor
}

public struct DSColorTheme {
    public var background: DSBackgroundColorValues
    public var text: DSTextColorValues
    public var icon: DSIconColorValues
    public var border: DSBorderColorValues

    public init(
        background: DSBackgroundColorValues,
        text: DSTextColorValues,
        icon: DSIconColorValues,
        border: DSBorderColorValues
    ) {
        self.background = background
        self.text = text
        self.icon = icon
        self.border = border
    }

    public func uiColor(for token: DSColorToken, in surfaceStyle: DSSurfaceStyle) -> DSUIColor {
        switch token {
        case .background(let token):
            return backgroundColor(for: token)
        case .text(let token):
            return textColor(for: token)
        case .icon(let token):
            return iconColor(for: token)
        case .border(let token):
            return borderColor(for: token)
        case .custom:
            return backgroundColor(for: surfaceStyle.backgroundToken)
        }
    }

    public func backgroundColor(for surfaceStyle: DSSurfaceStyle) -> DSUIColor {
        backgroundColor(for: surfaceStyle.backgroundToken)
    }

    public func defaultTextColorToken(for typographyToken: DSTypographyToken, in surfaceStyle: DSSurfaceStyle) -> DSColorToken {
        if surfaceStyle == .inverse {
            return .text(.inverse)
        }

        return .text(typographyToken.semanticTextColorToken)
    }

    // swiftlint:disable:next function_parameter_count
    public static func fromLegacy(
        canvas: DSUIColor,
        surface: DSUIColor,
        surfaceRaised: DSUIColor? = nil,
        surfaceSunken: DSUIColor? = nil,
        brand: DSUIColor,
        textPrimary: DSUIColor,
        textSecondary: DSUIColor,
        borderSubtle: DSUIColor,
        borderDefault: DSUIColor? = nil,
        inverseSurface: DSUIColor = .dynamic(light: 0x14171A, dark: 0xF3F4F2),
        inverseText: DSUIColor = .dynamic(light: 0xFFFFFF, dark: 0x14171A),
        success: DSUIColor = .dynamic(light: 0x1F845A, dark: 0x4BCE97),
        warning: DSUIColor = .dynamic(light: 0xA15C07, dark: 0xF5CD47),
        danger: DSUIColor = .dynamic(light: 0xC9372C, dark: 0xF87168),
        info: DSUIColor? = nil,
        disabled: DSUIColor = .dynamic(light: 0xB3B9C4, dark: 0x5E6C84)
    ) -> DSColorTheme {
        let resolvedSurfaceRaised = surfaceRaised ?? canvas
        let resolvedSurfaceSunken = surfaceSunken ?? surface
        let resolvedInfo = info ?? brand
        let resolvedBorderDefault = borderDefault ?? borderSubtle

        let background = DSBackgroundColorValues(
            canvas: canvas,
            surface: surface,
            surfaceRaised: resolvedSurfaceRaised,
            surfaceSunken: resolvedSurfaceSunken,
            overlay: resolvedSurfaceRaised,
            brand: brand,
            brandHover: brand,
            brandPressed: brand,
            neutral: surface,
            neutralHover: resolvedSurfaceRaised,
            neutralPressed: resolvedSurfaceSunken,
            selected: resolvedSurfaceRaised,
            selectedHover: resolvedSurfaceRaised,
            selectedPressed: resolvedSurfaceSunken,
            success: success,
            successSubtle: resolvedSurfaceRaised,
            warning: warning,
            warningSubtle: resolvedSurfaceRaised,
            danger: danger,
            dangerSubtle: resolvedSurfaceRaised,
            info: resolvedInfo,
            infoSubtle: resolvedSurfaceRaised,
            disabled: disabled,
            scrim: .dynamic(light: 0x14171A, dark: 0x000000)
        )

        let text = DSTextColorValues(
            primary: textPrimary,
            secondary: textSecondary,
            tertiary: textSecondary,
            inverse: inverseText,
            brand: brand,
            brandOnBold: inverseText,
            success: success,
            warning: warning,
            danger: danger,
            info: resolvedInfo,
            disabled: disabled
        )

        let icon = DSIconColorValues(
            primary: text.primary,
            secondary: text.secondary,
            tertiary: text.tertiary,
            inverse: text.inverse,
            brand: text.brand,
            brandOnBold: text.brandOnBold,
            success: text.success,
            warning: text.warning,
            danger: text.danger,
            info: text.info,
            disabled: text.disabled
        )

        let border = DSBorderColorValues(
            subtle: borderSubtle,
            default: resolvedBorderDefault,
            strong: textPrimary,
            inverse: inverseSurface,
            brand: brand,
            focused: brand,
            success: success,
            warning: warning,
            danger: danger,
            disabled: disabled
        )

        return DSColorTheme(
            background: background,
            text: text,
            icon: icon,
            border: border
        )
    }

    private func backgroundColor(for token: DSBackgroundColorToken) -> DSUIColor {
        switch token {
        case .canvas: return background.canvas
        case .surface: return background.surface
        case .surfaceRaised: return background.surfaceRaised
        case .surfaceSunken: return background.surfaceSunken
        case .overlay: return background.overlay
        case .brand: return background.brand
        case .brandHover: return background.brandHover
        case .brandPressed: return background.brandPressed
        case .neutral: return background.neutral
        case .neutralHover: return background.neutralHover
        case .neutralPressed: return background.neutralPressed
        case .selected: return background.selected
        case .selectedHover: return background.selectedHover
        case .selectedPressed: return background.selectedPressed
        case .success: return background.success
        case .successSubtle: return background.successSubtle
        case .warning: return background.warning
        case .warningSubtle: return background.warningSubtle
        case .danger: return background.danger
        case .dangerSubtle: return background.dangerSubtle
        case .info: return background.info
        case .infoSubtle: return background.infoSubtle
        case .disabled: return background.disabled
        case .scrim: return background.scrim
        }
    }

    private func textColor(for token: DSTextColorToken) -> DSUIColor {
        switch token {
        case .primary: return text.primary
        case .secondary: return text.secondary
        case .tertiary: return text.tertiary
        case .inverse: return text.inverse
        case .brand: return text.brand
        case .brandOnBold: return text.brandOnBold
        case .success: return text.success
        case .warning: return text.warning
        case .danger: return text.danger
        case .info: return text.info
        case .disabled: return text.disabled
        }
    }

    private func iconColor(for token: DSIconColorToken) -> DSUIColor {
        switch token {
        case .primary: return icon.primary
        case .secondary: return icon.secondary
        case .tertiary: return icon.tertiary
        case .inverse: return icon.inverse
        case .brand: return icon.brand
        case .brandOnBold: return icon.brandOnBold
        case .success: return icon.success
        case .warning: return icon.warning
        case .danger: return icon.danger
        case .info: return icon.info
        case .disabled: return icon.disabled
        }
    }

    private func borderColor(for token: DSBorderColorToken) -> DSUIColor {
        switch token {
        case .subtle: return border.subtle
        case .default: return border.default
        case .strong: return border.strong
        case .inverse: return border.inverse
        case .brand: return border.brand
        case .focused: return border.focused
        case .success: return border.success
        case .warning: return border.warning
        case .danger: return border.danger
        case .disabled: return border.disabled
        }
    }
}

private extension DSTypographyToken {
    var semanticTextColorToken: DSTextColorToken {
        switch baseColorRoleToken {
        case .largeTitle, .title1, .title2, .title3, .headline, .body, .bodyLarge, .custom, .label:
            return .primary
        case .subheadline, .callout, .caption1, .footnote, .bodySmall:
            return .secondary
        case .caption2:
            return .tertiary
        }
    }

    var semanticIconColorToken: DSIconColorToken {
        switch semanticTextColorToken {
        case .primary: return .primary
        case .secondary: return .secondary
        case .tertiary: return .tertiary
        case .inverse: return .inverse
        case .brand: return .brand
        case .brandOnBold: return .brandOnBold
        case .success: return .success
        case .warning: return .warning
        case .danger: return .danger
        case .info: return .info
        case .disabled: return .disabled
        }
    }
}
