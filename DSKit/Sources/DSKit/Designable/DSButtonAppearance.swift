//
//  DSButtonAppearance.swift
//  DSKit
//
//  Created by Borinschi Ivan on 01.12.2020.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
//

import SwiftUI

public protocol DSButtonAppearanceProtocol {
    var accentColor: DSUIColor { get set }
    var supportColor: DSUIColor { get set }
}

public extension DSButtonAppearanceProtocol {
    /// Returns a SwiftUI `Color` based on the given `DSButtonColorKey`
    func color(key: DSButtonColorKey) -> Color {
        switch key {
        case .accentColor:
            return Color(accentColor)
        case .supportColor:
            return Color(supportColor)
        }
    }
}

public enum DSButtonColorKey {
    case accentColor
    case supportColor
}

public struct DSButtonAppearance: DSButtonAppearanceProtocol {

    public var accentColor: DSUIColor
    public var supportColor: DSUIColor

    /// Initialize `DSButtonAppearance` with colors
    public init(
        accentColor: DSUIColor,
        supportColor: DSUIColor
    ) {
        self.accentColor = accentColor
        self.supportColor = supportColor
    }
}
