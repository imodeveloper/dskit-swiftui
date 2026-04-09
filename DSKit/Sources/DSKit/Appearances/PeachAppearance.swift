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
    public var primaryView: DSViewAppearanceProtocol
    public var secondaryView: DSViewAppearanceProtocol
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
        let text = DSTextAppearance.textColors(
            main: .dynamic(light: 0x484848, dark: 0xFFFFFF),
            secondary: .dynamic(light: 0x767676, dark: 0xD0D0D0)
        )
        let primaryButton = DSButtonAppearance(
            accentColor: brandColor ?? .dynamic(light: 0xE84F3D, dark: 0xE84F3D),
            supportColor: .dynamic(light: 0xFFFFFF, dark: 0xFFFFFF)
        )
        let primaryTextField = DSTextFieldAppearance(
            background: .dynamic(light: 0xF4F4F4, dark: 0x2D2D2D),
            text: text.headline,
            placeHolder: text.subheadline
        )
        self.primaryView = DSViewAppearance(
            button: primaryButton,
            text: text,
            textField: primaryTextField,
            background: .dynamic(light: 0xFFFFFF, dark: 0x1A1A1A),
            separator: .dynamic(light: 0xD5C5B2, dark: 0x70635A),
            cornerRadius: 12
        )

        let secondaryText = DSTextAppearance.textColors(
            main: .dynamic(light: 0x222222, dark: 0xDDDDDD),
            secondary: .dynamic(light: 0x717171, dark: 0x999999)
        )
        let secondaryTextField = DSTextFieldAppearance(
            background: .dynamic(light: 0xFFFFFF, dark: 0x1A1A1A),
            text: text.headline,
            placeHolder: text.subheadline
        )
        let secondaryButton = DSButtonAppearance(
            accentColor: .dynamic(light: 0xE84F3D, dark: 0xE84F3D),
            supportColor: .dynamic(light: 0xFFFFFF, dark: 0xFFFFFF)
        )
        self.secondaryView = DSViewAppearance(
            button: secondaryButton,
            text: secondaryText,
            textField: secondaryTextField,
            background: .dynamic(light: 0xF4F4F4, dark: 0x2D2D2D),
            separator: .dynamic(light: 0xEBEBEB, dark: 0x555555),
            cornerRadius: 12
        )
        self.tabBar = DSTabBarAppearance(
            barTint: .dynamic(light: 0xFFFFFF, dark: 0x1A1A1A),
            itemTint: .dynamic(light: 0xE84F3D, dark: 0xE84F3D),
            unselectedItemTint: .dynamic(light: 0x717171, dark: 0x999999),
            badge: .dynamic(light: 0xE84F3D, dark: 0xE84F3D),
            translucent: true
        )
        self.navigationBar = DSNavigationBarAppearance(
            buttons: .dynamic(light: 0xE84F3D, dark: 0xD0D0D0),
            text: text.title1,
            bar: .dynamic(light: 0xFFFFFF, dark: 0x1A1A1A),
            translucent: true
        )
        self.price = DSPriceAppearance(
            regularAmount: .dynamic(light: 0x4A1F0F, dark: 0x8C8C8C),
            badgeBackground: .dynamic(light: 0xE84F3D, dark: 0xE84F3D),
            badgeCornerRadius: 6
        )
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
