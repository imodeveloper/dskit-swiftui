//
//  DarkAppearance.swift
//  DSKit
//
//  Created by Borinschi Ivan on 30.11.2020.
//

import Foundation

public class DarkAppearance: DSAppearance {

    public var title: String
    public var colors: DSColorTheme
    public var primaryView: DSViewAppearanceProtocol
    public var secondaryView: DSViewAppearanceProtocol
    public var spacing: DSSpacingProtocol = DSSpacingSystem()
    public var padding: DPaddingsProtocol = DSPaddingSystem()
    public var tabBar: DSTabBarAppearanceProtocol = DSTabBarAppearance(translucent: true)
    public var navigationBar: DSNavigationBarAppearanceProtocol = DSNavigationBarAppearance(translucent: true)
    public var price: DSPriceAppearanceProtocol = DSPriceAppearance(badgeCornerRadius: 6)
    public var typography: DSTypographyProtocol = DSVerdanaFont()
    public var actionElementHeight: CGFloat = 44
    public var screenMargins: CGFloat = 16
    public var cornerRadius: CGFloat = 2

    public init(brandColor: DSUIColor? = nil, title: String = "Dark") {
        self.title = title
        let text = DSTextAppearance.textColors(
            main: .dynamic(light: 0x484848, dark: 0xE0E0E0),
            secondary: .dynamic(light: 0x767676, dark: 0xA0A0A0)
        )
        let button = DSButtonAppearance(
            accentColor: brandColor ?? .dynamic(light: 0x222222, dark: 0xDDDDDD),
            supportColor: .dynamic(light: 0xFFFFFF, dark: 0x333333)
        )
        let primaryTextField = DSTextFieldAppearance(
            background: .dynamic(light: 0xF4F4F4, dark: 0x333333),
            text: text.headline,
            placeHolder: text.subheadline
        )
        self.primaryView = DSViewAppearance(
            button: button,
            text: text,
            textField: primaryTextField,
            background: .dynamic(light: 0xFFFFFF, dark: 0x202020),
            separator: .dynamic(light: 0xD5C5B2, dark: 0x8D7A66),
            cornerRadius: 2
        )

        let secondaryText = DSTextAppearance.textColors(
            main: .dynamic(light: 0x222222, dark: 0xDDDDDD),
            secondary: .dynamic(light: 0x717171, dark: 0x999999)
        )
        let secondaryTextField = DSTextFieldAppearance(
            background: .dynamic(light: 0xFFFFFF, dark: 0x202020),
            text: text.headline,
            placeHolder: text.subheadline
        )
        self.secondaryView = DSViewAppearance(
            button: button,
            text: secondaryText,
            textField: secondaryTextField,
            background: .dynamic(light: 0xF4F4F4, dark: 0x2D2D2D),
            separator: .dynamic(light: 0xEBEBEB, dark: 0x333333),
            cornerRadius: 2
        )
        self.tabBar = DSTabBarAppearance(
            barTint: primaryView.background,
            itemTint: primaryView.button.accentColor,
            unselectedItemTint: secondaryText.subheadline,
            badge: .red,
            translucent: true
        )
        self.navigationBar = DSNavigationBarAppearance(
            buttons: .dynamic(light: 0x666666, dark: 0xAAAAAA),
            text: text.title1,
            bar: primaryView.background,
            translucent: true
        )
        self.price = DSPriceAppearance(
            regularAmount: .dynamic(light: 0x666666, dark: 0xBBBBBB),
            badgeBackground: .dynamic(light: 0xFBB666, dark: 0xDA9350),
            badgeCornerRadius: 6
        )
        self.colors = DSColorTheme.fromLegacy(
            canvas: .dynamic(light: 0xFFFFFF, dark: 0x202020),
            surface: .dynamic(light: 0xF4F4F4, dark: 0x2D2D2D),
            brand: brandColor ?? .dynamic(light: 0x222222, dark: 0xDDDDDD),
            textPrimary: .dynamic(light: 0x222222, dark: 0xDDDDDD),
            textSecondary: .dynamic(light: 0x717171, dark: 0x999999),
            borderSubtle: .dynamic(light: 0xEBEBEB, dark: 0x333333),
            borderDefault: .dynamic(light: 0xD5C5B2, dark: 0x8D7A66)
        )
    }
}
