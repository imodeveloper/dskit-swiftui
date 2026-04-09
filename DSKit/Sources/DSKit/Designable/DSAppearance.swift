//
//  DSAppearance.swift
//  DSKit
//
//  Created by Borinschi Ivan on 30.11.2020.
//

import SwiftUI

struct AppearanceEnvironment: EnvironmentKey {
    static let defaultValue: DSAppearance = LightBlueAppearance()
}

public extension EnvironmentValues {
    var appearance: DSAppearance {
        get { self[AppearanceEnvironment.self] }
        set { self[AppearanceEnvironment.self] = newValue }
    }
}

public protocol DSAppearance {
    var title: String { get set }
    var colors: DSColorTheme { get set }
    var primaryView: DSViewAppearanceProtocol { get set }
    var secondaryView: DSViewAppearanceProtocol { get set }
    var spacing: DSSpacingProtocol { get set }
    var padding: DPaddingsProtocol { get set }
    var tabBar: DSTabBarAppearanceProtocol { get set }
    var navigationBar: DSNavigationBarAppearanceProtocol { get set }
    var price: DSPriceAppearanceProtocol { get set }
    var typography: DSTypographyProtocol { get set }
    var actionElementHeight: CGFloat { get set }
    var screenMargins: CGFloat { get set }
    var cornerRadius: CGFloat { get set }
    func style(for viewStyle: DSViewStyle) -> DSViewAppearanceProtocol
}

public extension DSAppearance {
    func style(for viewStyle: DSViewStyle) -> DSViewAppearanceProtocol {
        switch viewStyle {
        case .primary:
            primaryView
        case .secondary:
            secondaryView
        }
    }
}

extension DSAppearance {
    func viewAppearance(for surfaceStyle: DSSurfaceStyle) -> DSViewAppearanceProtocol {
        switch surfaceStyle {
        case .canvas, .inverse:
            primaryView
        case .surface, .surfaceRaised, .surfaceSunken:
            secondaryView
        }
    }

    func resolvedUIColor(for colorToken: DSColorToken, in surfaceStyle: DSSurfaceStyle) -> DSUIColor {
        let viewAppearance = viewAppearance(for: surfaceStyle)

        switch colorToken {
        case .background(let token):
            switch token {
            case .canvas:
                return primaryView.background
            case .surface, .surfaceRaised, .surfaceSunken, .overlay,
                 .neutral, .neutralHover, .neutralPressed,
                 .selected, .selectedHover, .selectedPressed:
                return secondaryView.background
            case .brand, .brandHover, .brandPressed:
                return viewAppearance.button.accentColor
            case .success:
                return .dynamic(light: 0x1F845A, dark: 0x4BCE97)
            case .successSubtle:
                return secondaryView.background
            case .warning:
                return .dynamic(light: 0xA15C07, dark: 0xF5CD47)
            case .warningSubtle:
                return secondaryView.background
            case .danger:
                return .dynamic(light: 0xC9372C, dark: 0xF87168)
            case .dangerSubtle:
                return secondaryView.background
            case .info:
                return viewAppearance.button.accentColor
            case .infoSubtle:
                return secondaryView.background
            case .disabled:
                return .dynamic(light: 0xB3B9C4, dark: 0x5E6C84)
            case .scrim:
                return .dynamic(light: 0x14171A, dark: 0x000000)
            }
        case .text(let token):
            switch token {
            case .primary:
                return defaultTextUIColor(for: .body, in: surfaceStyle)
            case .secondary:
                return viewAppearance.text.subheadline
            case .tertiary:
                return viewAppearance.text.caption1
            case .inverse:
                return primaryView.button.supportColor
            case .brand:
                return viewAppearance.button.accentColor
            case .brandOnBold:
                return viewAppearance.button.supportColor
            case .success:
                return .dynamic(light: 0x1F845A, dark: 0x4BCE97)
            case .warning:
                return .dynamic(light: 0xA15C07, dark: 0xF5CD47)
            case .danger:
                return .dynamic(light: 0xC9372C, dark: 0xF87168)
            case .info:
                return viewAppearance.button.accentColor
            case .disabled:
                return .dynamic(light: 0xB3B9C4, dark: 0x5E6C84)
            }
        case .icon(let token):
            switch token {
            case .primary:
                return resolvedUIColor(for: .text(.primary), in: surfaceStyle)
            case .secondary:
                return resolvedUIColor(for: .text(.secondary), in: surfaceStyle)
            case .tertiary:
                return resolvedUIColor(for: .text(.tertiary), in: surfaceStyle)
            case .inverse:
                return resolvedUIColor(for: .text(.inverse), in: surfaceStyle)
            case .brand:
                return resolvedUIColor(for: .text(.brand), in: surfaceStyle)
            case .brandOnBold:
                return resolvedUIColor(for: .text(.brandOnBold), in: surfaceStyle)
            case .success:
                return resolvedUIColor(for: .text(.success), in: surfaceStyle)
            case .warning:
                return resolvedUIColor(for: .text(.warning), in: surfaceStyle)
            case .danger:
                return resolvedUIColor(for: .text(.danger), in: surfaceStyle)
            case .info:
                return resolvedUIColor(for: .text(.info), in: surfaceStyle)
            case .disabled:
                return resolvedUIColor(for: .text(.disabled), in: surfaceStyle)
            }
        case .border(let token):
            switch token {
            case .subtle, .default:
                return viewAppearance.separator
            case .strong:
                return viewAppearance.text.headline
            case .inverse:
                return primaryView.button.supportColor
            case .brand, .focused:
                return viewAppearance.button.accentColor
            case .success:
                return .dynamic(light: 0x1F845A, dark: 0x4BCE97)
            case .warning:
                return .dynamic(light: 0xA15C07, dark: 0xF5CD47)
            case .danger:
                return .dynamic(light: 0xC9372C, dark: 0xF87168)
            case .disabled:
                return .dynamic(light: 0xB3B9C4, dark: 0x5E6C84)
            }
        case .custom:
            return viewAppearance.background
        }
    }

    func defaultTextUIColor(for typographyToken: DSTypographyToken, in surfaceStyle: DSSurfaceStyle) -> DSUIColor {
        if surfaceStyle == .inverse {
            return primaryView.button.supportColor
        }

        let text = viewAppearance(for: surfaceStyle).text

        switch typographyToken.baseColorRoleToken {
        case .largeTitle:
            return text.largeTitle
        case .title1:
            return text.title1
        case .title2:
            return text.title2
        case .title3:
            return text.title3
        case .headline, .label, .custom:
            return text.headline
        case .subheadline:
            return text.subheadline
        case .body, .bodyLarge:
            return text.body
        case .callout:
            return text.callout
        case .caption1:
            return text.caption1
        case .caption2:
            return text.caption2
        case .footnote, .bodySmall:
            return text.footnote
        }
    }

    func defaultTextColorToken(for typographyToken: DSTypographyToken, in surfaceStyle: DSSurfaceStyle) -> DSColorToken {
        .custom(Color(defaultTextUIColor(for: typographyToken, in: surfaceStyle)))
    }

    func color(for colorToken: DSColorToken, surfaceStyle: DSSurfaceStyle) -> Color {
        colorToken.color(for: self, in: surfaceStyle)
    }

    func uiColor(for colorToken: DSColorToken, surfaceStyle: DSSurfaceStyle) -> DSUIColor {
        colorToken.uiColor(for: self, in: surfaceStyle)
    }

    func color(for colorKey: DSColorKey, viewStyle: DSViewStyle) -> Color {
        colorKey.color(for: self, and: viewStyle)
    }
}

public extension DSAppearance {
    func overrideTheSystemAppearance() {
        overrideTheSystemAppearance(opaqueNavigationBar: true, opaqueTabBar: true)
    }

    func overrideTheSystemAppearance(opaqueNavigationBar: Bool, opaqueTabBar: Bool) {
        #if canImport(UIKit)
        let useNativeLiquidGlassBehavior: Bool
        if #available(iOS 26.0, *) {
            useNativeLiquidGlassBehavior = true
        } else {
            useNativeLiquidGlassBehavior = false
        }

        let navigationBarAppearance = UINavigationBarAppearance()
        if useNativeLiquidGlassBehavior {
            navigationBarAppearance.configureWithDefaultBackground()
        } else {
            if opaqueNavigationBar {
                navigationBarAppearance.configureWithOpaqueBackground()
            } else {
                navigationBarAppearance.configureWithDefaultBackground()
            }
            navigationBarAppearance.backgroundColor = navigationBar.bar
        }

        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: navigationBar.text,
            .font: typography.headline
        ]

        navigationBarAppearance.backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor: navigationBar.buttons,
            .font: typography.headline
        ]

        navigationBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: primaryView.text.title1,
            .font: DSTypographyToken.custom(size: 30, weight: .semibold, relativeTo: .headline).uiFont(for: self)
        ]

        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance

        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = tabBar.unselectedItemTint
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: tabBar.unselectedItemTint]
        itemAppearance.selected.iconColor = tabBar.itemTint
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: tabBar.itemTint]

        let tabBarAppearance = UITabBarAppearance()
        if useNativeLiquidGlassBehavior {
            tabBarAppearance.configureWithDefaultBackground()
        } else {
            if opaqueTabBar {
                tabBarAppearance.configureWithOpaqueBackground()
            } else {
                tabBarAppearance.configureWithDefaultBackground()
            }
            tabBarAppearance.backgroundColor = tabBar.barTint
        }
        tabBarAppearance.stackedLayoutAppearance = itemAppearance

        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        #endif
    }
}

public extension View {
    func dsAppearance(
        _ appearance: DSAppearance,
        overrideSystemAppearance: Bool = false,
        opaqueNavigationBar: Bool = false,
        opaqueTabBar: Bool = false
    ) -> some View {
        if overrideSystemAppearance {
            appearance.overrideTheSystemAppearance(
                opaqueNavigationBar: opaqueNavigationBar,
                opaqueTabBar: opaqueTabBar
            )
        }
        return self.environment(\.appearance, appearance)
    }
}
