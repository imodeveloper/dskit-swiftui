//
//  PeachAppearance.swift
//  DSKit
//
//  Created by Borinschi Ivan on 30.11.2020.
//

import Foundation

public class PeachAppearance: DSAppearance {

    public var title: String
    public var colors: DSColorTheme
    public var spacing: DSSpacingProtocol = DSSpacingSystem()
    public var padding: DPaddingsProtocol = DSPaddingSystem()
    public var tabBar: DSTabBarAppearanceProtocol = DSTabBarAppearance(translucent: true)
    public var navigationBar: DSNavigationBarAppearanceProtocol = DSNavigationBarAppearance(translucent: true)
    public var price: DSPriceAppearanceProtocol = DSPriceAppearance(badgeCornerRadius: 6)
    public var typography: DSTypographyProtocol = DSHelveticaNeueFont()
    public var actionElementHeight: CGFloat = 48
    public var screenMargins: CGFloat = 16
    public var cornerRadius: CGFloat = 12

    public init(brandColor: DSUIColor? = nil, title: String = "Peach") {
        self.title = title
        self.colors = DSColorTheme.fromLegacy(
            canvas: .dynamic(light: 0xFFFFFF, dark: 0x1A1A1A),
            surface: .dynamic(light: 0xF4F4F4, dark: 0x2D2D2D),
            brand: brandColor ?? .dynamic(light: 0xE84F3D, dark: 0xE84F3D),
            textPrimary: .dynamic(light: 0x222222, dark: 0xDDDDDD),
            textSecondary: .dynamic(light: 0x717171, dark: 0x999999),
            borderSubtle: .dynamic(light: 0xEBEBEB, dark: 0x555555),
            borderDefault: .dynamic(light: 0xD5C5B2, dark: 0x70635A)
        )
    }
}
