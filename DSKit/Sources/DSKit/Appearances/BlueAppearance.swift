//
//  BlueAppearance.swift
//  DSKit
//
//  Created by Borinschi Ivan on 30.11.2020.
//

import Foundation

public class BlueAppearance: DSAppearance {

    public var title: String
    public var colors: DSColorTheme
    public var spacing: DSSpacingProtocol = DSSpacingSystem()
    public var padding: DPaddingsProtocol = DSPaddingSystem()
    public var tabBar: DSTabBarAppearanceProtocol = DSTabBarAppearance(translucent: true)
    public var navigationBar: DSNavigationBarAppearanceProtocol = DSNavigationBarAppearance(translucent: true)
    public var price: DSPriceAppearanceProtocol = DSPriceAppearance(badgeCornerRadius: 6)
    public var typography: DSTypographyProtocol = DSTypographySystem()
    public var actionElementHeight: CGFloat = 44
    public var screenMargins: CGFloat = 16
    public var cornerRadius: CGFloat = 10

    public init(brandColor: DSUIColor? = nil, title: String = "Blue") {
        self.title = title
        self.colors = DSColorTheme.fromLegacy(
            canvas: .dynamic(light: 0xFFFFFF, dark: 0x1E1E2E),
            surface: .dynamic(light: 0xF4F4F4, dark: 0x181825),
            brand: brandColor ?? .dynamic(light: 0x006EB9, dark: 0x006EB8),
            textPrimary: .dynamic(light: 0x222222, dark: 0xDDDDDD),
            textSecondary: .dynamic(light: 0x767676, dark: 0xA0A0A0),
            borderSubtle: .dynamic(light: 0xEBEBEB, dark: 0x1E1E2E),
            borderDefault: .dynamic(light: 0xD5C5B2, dark: 0x364A5D)
        )
    }
}
