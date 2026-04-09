//
//  DSPriceAppearance.swift
//  DSKit
//
//  Created by Borinschi Ivan on 01.12.2020.
//

import SwiftUI

public protocol DSPriceAppearanceProtocol {
    var badgeCornerRadius: CGFloat { get set }
}

public struct DSPriceAppearance: DSPriceAppearanceProtocol {
    public init(badgeCornerRadius: CGFloat = 4.0) {
        self.badgeCornerRadius = badgeCornerRadius
    }

    public var badgeCornerRadius: CGFloat
}
