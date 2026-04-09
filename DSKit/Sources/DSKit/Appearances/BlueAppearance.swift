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
    public var primaryView: DSViewAppearanceProtocol
    public var secondaryView: DSViewAppearanceProtocol
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
        let primaryText = DSTextAppearance.textColors(
            main: .dynamic(light: 0x484848, dark: 0xE0E0E0),
            secondary: .dynamic(light: 0x767676, dark: 0xA0A0A0)
        )
        let button = DSButtonAppearance(
            accentColor: brandColor ?? .dynamic(light: 0x006EB9, dark: 0x006EB8),
            supportColor: .dynamic(light: 0xFFFFFF, dark: 0xFFFFFF)
        )
        let primaryTextField = DSTextFieldAppearance(
            background: .dynamic(light: 0xF4F4F4, dark: 0x181825),
            text: primaryText.headline,
            placeHolder: primaryText.subheadline
        )
        self.primaryView = DSViewAppearance(
            button: button,
            text: primaryText,
            textField: primaryTextField,
            background: .dynamic(light: 0xFFFFFF, dark: 0x1E1E2E),
            separator: .dynamic(light: 0xD5C5B2, dark: 0x364A5D),
            cornerRadius: 10
        )

        let secondaryText = DSTextAppearance.textColors(
            main: .dynamic(light: 0x222222, dark: 0xDDDDDD),
            secondary: .dynamic(light: 0x717171, dark: 0x999999)
        )
        let secondaryTextField = DSTextFieldAppearance(
            background: .dynamic(light: 0xFFFFFF, dark: 0x1E1E2E),
            text: primaryText.headline,
            placeHolder: primaryText.subheadline
        )
        self.secondaryView = DSViewAppearance(
            button: button,
            text: secondaryText,
            textField: secondaryTextField,
            background: .dynamic(light: 0xF4F4F4, dark: 0x181825),
            separator: .dynamic(light: 0xEBEBEB, dark: 0x1E1E2E),
            cornerRadius: 10
        )
        self.tabBar = DSTabBarAppearance(
            barTint: primaryView.background,
            itemTint: primaryView.button.accentColor,
            unselectedItemTint: secondaryText.subheadline,
            badge: primaryView.button.accentColor,
            translucent: true
        )
        self.navigationBar = DSNavigationBarAppearance(
            buttons: .dynamic(light: 0x3C4856, dark: 0x006EB9),
            text: primaryText.title1,
            bar: primaryView.background,
            translucent: true
        )
        self.price = DSPriceAppearance(
            regularAmount: .dynamic(light: 0xA0ACBD, dark: 0xBCCADC),
            badgeBackground: .dynamic(light: 0x316CAF, dark: 0x4C5866),
            badgeCornerRadius: 6
        )
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
