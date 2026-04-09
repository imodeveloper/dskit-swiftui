//
//  DSKitAppearance.swift
//  DSKit
//
//  Created by Borinschi Ivan on 30.11.2020.
//

import Foundation

public struct LightBlueAppearance: DSAppearance {

    public var title: String
    public var colors: DSColorTheme
    public var spacing: DSSpacingProtocol = DSSpacingSystem()
    public var padding: DPaddingsProtocol = DSPaddingSystem()
    public var tabBar: DSTabBarAppearanceProtocol = DSTabBarAppearance(translucent: false)
    public var navigationBar: DSNavigationBarAppearanceProtocol = DSNavigationBarAppearance(translucent: false)
    public var price: DSPriceAppearanceProtocol = DSPriceAppearance(badgeCornerRadius: 4)
    public var typography: DSTypographyProtocol = DSTypographySystem()
    public var actionElementHeight: CGFloat = 48
    public var screenMargins: CGFloat = 16
    public var cornerRadius: CGFloat = 10

    public init(brandColor: DSUIColor? = nil) {
        self.title = "Light Blue"
        self.colors = DSColorTheme.fromLegacy(
            canvas: .dynamic(light: 0xFEFFFE, dark: 0x15202B),
            surface: .dynamic(light: 0xF3F4F2, dark: 0x101A24),
            brand: brandColor ?? .dynamic(light: 0x1DA1F2, dark: 0x1DA1F2),
            textPrimary: .dynamic(light: 0x14171A, dark: 0xFEFFFE),
            textSecondary: .dynamic(light: 0x5B7083, dark: 0x8899A6),
            borderSubtle: .dynamic(light: 0xD0DBE3, dark: 0x38444D)
        )
    }
}
