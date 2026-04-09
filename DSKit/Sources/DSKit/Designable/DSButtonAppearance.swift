//
//  DSButtonAppearance.swift
//  DSKit
//
//  Created by Borinschi Ivan on 01.12.2020.
//

import SwiftUI

public protocol DSButtonAppearanceProtocol {
    var accentColor: DSUIColor { get set }
    var supportColor: DSUIColor { get set }
}

public extension DSButtonAppearanceProtocol {
    func color(key: DSButtonColorKey) -> Color {
        switch key {
        case .accentColor:
            Color(accentColor)
        case .supportColor:
            Color(supportColor)
        }
    }
}

public enum DSButtonColorKey {
    case accentColor
    case supportColor
}

public struct DSButtonAppearance: DSButtonAppearanceProtocol {
    public init(
        accentColor: DSUIColor,
        supportColor: DSUIColor
    ) {
        self.accentColor = accentColor
        self.supportColor = supportColor
    }

    public var accentColor: DSUIColor
    public var supportColor: DSUIColor
}
