//
//  DSTabbarAppearance.swift
//  DSKit
//
//  Created by Borinschi Ivan on 01.12.2020.
//

import SwiftUI

public protocol DSTabBarAppearanceProtocol {
    var barTint: DSUIColor { get set }
    var itemTint: DSUIColor { get set }
    var unselectedItemTint: DSUIColor { get set }
    var badge: DSUIColor { get set }
    var translucent: Bool { get set }
}

public enum DSTabBarColorKey {
    case tint
    case itemTint
    case unselectedItemTint
    case badge
}

public extension DSTabBarAppearanceProtocol {
    func color(key: DSTabBarColorKey) -> Color {
        switch key {
        case .tint:
            Color(barTint)
        case .itemTint:
            Color(itemTint)
        case .unselectedItemTint:
            Color(unselectedItemTint)
        case .badge:
            Color(badge)
        }
    }
}

public struct DSTabBarAppearance: DSTabBarAppearanceProtocol {
    public init(
        barTint: DSUIColor = .dynamic(light: 0xFEFFFE, dark: 0x15202B),
        itemTint: DSUIColor = .dynamic(light: 0x1DA1F2, dark: 0x1DA1F2),
        unselectedItemTint: DSUIColor = .dynamic(light: 0x5B7083, dark: 0x8899A6),
        badge: DSUIColor = .dynamic(light: 0x1DA1F2, dark: 0x1DA1F2),
        translucent: Bool = false
    ) {
        self.barTint = barTint
        self.itemTint = itemTint
        self.unselectedItemTint = unselectedItemTint
        self.badge = badge
        self.translucent = translucent
    }

    public var barTint: DSUIColor
    public var itemTint: DSUIColor
    public var unselectedItemTint: DSUIColor
    public var badge: DSUIColor
    public var translucent: Bool
}
