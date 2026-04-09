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
    var viewStyle: DSViewStyle {
        switch surfaceStyle {
        case .canvas, .inverse:
            .primary
        case .surface, .surfaceRaised, .surfaceSunken:
            .secondary
        }
    }

    var viewColors: DSViewAppearanceProtocol {
        viewStyle.colors(from: appearance)
    }

    var navigationBarColors: DSNavigationBarAppearanceProtocol {
        appearance.navigationBar
    }

    func color(for colorToken: DSColorToken) -> Color {
        appearance.color(for: colorToken, surfaceStyle: surfaceStyle)
    }

    func uiColor(for colorToken: DSColorToken) -> DSUIColor {
        appearance.uiColor(for: colorToken, surfaceStyle: surfaceStyle)
    }

    func color(for colorKey: DSColorKey) -> Color {
        appearance.color(for: colorKey, viewStyle: viewStyle)
    }
}
