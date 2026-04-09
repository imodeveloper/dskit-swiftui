//
//  RetroAppearance.swift
//  DSKit
//
//  Created by Borinschi Ivan on 30.11.2020.
//

import Foundation

public final class RetroAppearance: DSAppearance {

    public var title: String
    public var colors: DSColorTheme
    public var spacing: DSSpacingProtocol = DSSpacingSystem()
    public var padding: DPaddingsProtocol = DSPaddingSystem()
    public var margins: CGFloat = 15
    public var groupMargins: CGFloat = 10
    public var interItemSpacing: CGFloat = 7
    public var tabBar: DSTabBarAppearanceProtocol = DSTabBarAppearance()
    public var navigationBar: DSNavigationBarAppearanceProtocol = DSNavigationBarAppearance()
    public var price: DSPriceAppearanceProtocol = DSPriceAppearance()
    public var typography: DSTypographyProtocol = DSFuturaFont()
    public var actionElementHeight: CGFloat = 45
    public var screenMargins: CGFloat = 16
    public var cornerRadius: CGFloat = 13

    public init(brandColor: DSUIColor? = nil, title: String = "Retro") {
        self.title = title
        self.colors = DSColorTheme.fromLegacy(
            canvas: .dynamic(light: 0xFFFCF8, dark: 0x383443),
            surface: .dynamic(light: 0xF4F2EA, dark: 0x4E4A57),
            brand: brandColor ?? .dynamic(light: 0xFC8F0F, dark: 0xFC8F0F),
            textPrimary: .dynamic(light: 0x2A2732, dark: 0xE8E7E6),
            textSecondary: .dynamic(light: 0x595465, dark: 0x999DB1),
            borderSubtle: .dynamic(light: 0xDFDCD3, dark: 0x111111),
            borderDefault: .dynamic(light: 0xFBEFE0, dark: 0x464154)
        )
    }
}
