//
//  DSTabbarAppearance.swift
//  DSKit
//
//  Created by Borinschi Ivan on 01.12.2020.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
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

extension DSTabBarAppearanceProtocol {
    /// Returns a SwiftUI Color based on the DSTabBarColorKey
    func color(key: DSTabBarColorKey) -> Color {
        switch key {
        case .tint:
            return Color(barTint)
        case .itemTint:
            return Color(itemTint)
        case .unselectedItemTint:
            return Color(unselectedItemTint)
        case .badge:
            return Color(badge)
        }
    }
}

public struct DSTabBarAppearance: DSTabBarAppearanceProtocol {

    /// Initialize tab bar colors
    /// - Parameters:
    ///   - barTint: DSUIColor
    ///   - itemTint: DSUIColor
    ///   - unselectedItemTint: DSUIColor
    ///   - badge: DSUIColor
    ///   - translucent: Bool
    public init(
        barTint: DSUIColor,
        itemTint: DSUIColor,
        unselectedItemTint: DSUIColor,
        badge: DSUIColor,
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
