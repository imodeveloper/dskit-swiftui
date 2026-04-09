//
//  DSDesignable.swift
//  DSKit
//
//  Created by Ivan Borinschi on 14.03.2023.
//

import SwiftUI

public protocol DSDesignable {
    var appearance: DSAppearance { get }
    var surfaceStyle: DSSurfaceStyle { get }
}

public extension DSDesignable {
    func color(for colorToken: DSColorToken) -> Color {
        appearance.color(for: colorToken, surfaceStyle: surfaceStyle)
    }

    func uiColor(for colorToken: DSColorToken) -> DSUIColor {
        appearance.uiColor(for: colorToken, surfaceStyle: surfaceStyle)
    }
}
