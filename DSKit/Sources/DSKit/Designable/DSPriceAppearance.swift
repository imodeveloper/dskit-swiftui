//
//  CurrencyColor.swift
//  DSKit
//
//  Created by Borinschi Ivan on 01.12.2020.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
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

extension DSPriceAppearanceProtocol {
    /// Returns a SwiftUI Color based on the DSPriceColorKey
    func color(key: DSPriceColorKey) -> Color {
        switch key {
        case .regularAmount:
            return Color(regularAmount)
        case .badgeBackground:
            return Color(badgeBackground)
        case .badgeText:
            return Color(badgeText)
        }
    }
}

public struct DSPriceAppearance: DSPriceAppearanceProtocol {

    public init(
        regularAmount: DSUIColor,
        badgeBackground: DSUIColor = DSUIColor.red,
        badgeText: DSUIColor = DSUIColor.white,
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
