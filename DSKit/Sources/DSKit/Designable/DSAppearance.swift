//
//  Designable.swift
//  DSKit
//
//  Created by Borinschi Ivan on 30.11.2020.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
//

import SwiftUI

// MARK: - Environment Key for DSAppearance

struct AppearanceEnvironment: EnvironmentKey {
    static let defaultValue: DSAppearance = LightBlueAppearance()
}

public extension EnvironmentValues {
    var appearance: DSAppearance {
        get { self[AppearanceEnvironment.self] }
        set { self[AppearanceEnvironment.self] = newValue }
    }
}

// MARK: - DSAppearance Protocol

public protocol DSAppearance {
    var title: String { get set }
    var primaryView: DSViewAppearanceProtocol { get set }
    var secondaryView: DSViewAppearanceProtocol { get set }
    var spacing: DSSpacingProtocol { get set }
    var padding: DPaddingsProtocol { get set }
    var tabBar: DSTabBarAppearanceProtocol { get set }
    var navigationBar: DSNavigationBarAppearanceProtocol { get set }
    var price: DSPriceAppearanceProtocol { get set }
    var fonts: DSFontsProtocol { get set }
    var actionElementHeight: CGFloat { get set }
    var screenMargins: CGFloat { get set }
    func style(for viewStyle: DSViewStyle) -> DSViewAppearanceProtocol
}

extension DSAppearance {
    func color(for colorKey: DSColorKey, viewStyle: DSViewStyle) -> Color {
        colorKey.color(for: self, and: viewStyle)
    }
}

public extension DSAppearance {
    /// Override the system appearance settings (iOS only)
    func overrideTheSystemAppearance() {
        overrideTheSystemAppearance(opaqueNavigationBar: true, opaqueTabBar: true)
    }

    /// Override the system appearance settings (iOS only)
    func overrideTheSystemAppearance(opaqueNavigationBar: Bool, opaqueTabBar: Bool) {
        #if canImport(UIKit)
        // Configure Navigation Bar Appearance
        let navigationBarAppearance = UINavigationBarAppearance()
        if opaqueNavigationBar {
            navigationBarAppearance.configureWithOpaqueBackground()
        } else {
            navigationBarAppearance.configureWithDefaultBackground()
        }
        navigationBarAppearance.backgroundColor = self.navigationBar.bar
        
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: self.navigationBar.text,
            NSAttributedString.Key.font: self.fonts.headline
        ]
        
        navigationBarAppearance.backButtonAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: self.navigationBar.buttons,
            NSAttributedString.Key.font: self.fonts.headline
        ]
        
        navigationBarAppearance.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: self.primaryView.text.title1,
            NSAttributedString.Key.font: self.fonts.headline.withSize(30)
        ]
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = self.tabBar.unselectedItemTint
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: self.tabBar.unselectedItemTint]
        itemAppearance.selected.iconColor =  self.tabBar.itemTint
        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: self.tabBar.itemTint]
        
        let tabBarAppearance = UITabBarAppearance()
        if opaqueTabBar {
            tabBarAppearance.configureWithOpaqueBackground()
        } else {
            tabBarAppearance.configureWithDefaultBackground()
        }
        tabBarAppearance.backgroundColor = self.tabBar.barTint
        tabBarAppearance.stackedLayoutAppearance = itemAppearance
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        #endif
    }
}

// MARK: - SwiftUI View Extension

public extension View {
    /// Apply the `DSAppearance` to the SwiftUI view
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
