//
//  DSPriceAppearance.swift
//  DSKit
//
//  Created by Borinschi Ivan on 01.12.2020.
//

import SwiftUI

public protocol DSPriceAppearanceProtocol {
    var regularAmount: DSUIColor { get set }
    var badgeBackground: DSUIColor { get set }
    var badgeText: DSUIColor { get set }
    var badgeCornerRadius: CGFloat { get set }
}

public enum DSPriceColorKey {
    case regularAmount
    case badgeBackground
    case badgeText
}

public extension DSPriceAppearanceProtocol {
    func color(key: DSPriceColorKey) -> Color {
        switch key {
        case .regularAmount:
            Color(regularAmount)
        case .badgeBackground:
            Color(badgeBackground)
        case .badgeText:
            Color(badgeText)
        }
    }
}

public struct DSPriceAppearance: DSPriceAppearanceProtocol {
    public init(
        regularAmount: DSUIColor = .dynamic(light: 0x5B7083, dark: 0x8899A6),
        badgeBackground: DSUIColor = .red,
        badgeText: DSUIColor = .white,
        badgeCornerRadius: CGFloat = 4.0
    ) {
        self.regularAmount = regularAmount
        self.badgeBackground = badgeBackground
        self.badgeText = badgeText
        self.badgeCornerRadius = badgeCornerRadius
    }

    public var regularAmount: DSUIColor
    public var badgeBackground: DSUIColor
    public var badgeText: DSUIColor
    public var badgeCornerRadius: CGFloat
}
