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
    var spacing: DSSpacingProtocol { get set }
    var padding: DPaddingsProtocol { get set }
    var tabBar: DSTabBarAppearanceProtocol { get set }
    var navigationBar: DSNavigationBarAppearanceProtocol { get set }
    var price: DSPriceAppearanceProtocol { get set }
    var typography: DSTypographyProtocol { get set }
    var actionElementHeight: CGFloat { get set }
    var screenMargins: CGFloat { get set }
    var cornerRadius: CGFloat { get set }
}

extension DSAppearance {
    func color(for colorToken: DSColorToken, surfaceStyle: DSSurfaceStyle) -> Color {
        colorToken.color(for: self, in: surfaceStyle)
    }

    func uiColor(for colorToken: DSColorToken, surfaceStyle: DSSurfaceStyle) -> DSUIColor {
        colorToken.uiColor(for: self, in: surfaceStyle)
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
            navigationBarAppearance.backgroundColor = uiColor(for: .background(.canvas), surfaceStyle: .canvas)
        }

        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: uiColor(for: .text(.primary), surfaceStyle: .canvas),
            .font: typography.headline
        ]

        navigationBarAppearance.backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor: uiColor(for: .icon(.brand), surfaceStyle: .canvas),
            .font: typography.headline
        ]

        navigationBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: uiColor(for: .text(.primary), surfaceStyle: .canvas),
            .font: DSTypographyToken.custom(size: 30, weight: .semibold, relativeTo: .headline).uiFont(for: self)
        ]

        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance

        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = uiColor(for: .icon(.secondary), surfaceStyle: .canvas)
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: uiColor(for: .text(.secondary), surfaceStyle: .canvas)]
        itemAppearance.selected.iconColor = uiColor(for: .icon(.brand), surfaceStyle: .canvas)
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: uiColor(for: .text(.brand), surfaceStyle: .canvas)]

        let tabBarAppearance = UITabBarAppearance()
        if useNativeLiquidGlassBehavior {
            tabBarAppearance.configureWithDefaultBackground()
        } else {
            if opaqueTabBar {
                tabBarAppearance.configureWithOpaqueBackground()
            } else {
                tabBarAppearance.configureWithDefaultBackground()
            }
            tabBarAppearance.backgroundColor = uiColor(for: .background(.canvas), surfaceStyle: .canvas)
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
