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
    public var primaryView: DSViewAppearanceProtocol
    public var secondaryView: DSViewAppearanceProtocol
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
        let text = DSTextAppearance(
            largeTitle: .dynamic(light: 0x14171A, dark: 0xFEFFFE),
            title1: .dynamic(light: 0x14171A, dark: 0xFEFFFE),
            title2: .dynamic(light: 0x14171A, dark: 0xFEFFFE),
            title3: .dynamic(light: 0x14171A, dark: 0xFEFFFE),
            headline: .dynamic(light: 0x14171A, dark: 0xFEFFFE),
            subheadline: .dynamic(light: 0x5B7083, dark: 0x8899A6),
            body: .dynamic(light: 0x14171A, dark: 0xFEFFFE),
            callout: .dynamic(light: 0x5B7083, dark: 0x8899A6),
            caption1: .dynamic(light: 0x5B7083, dark: 0x8899A6),
            caption2: .dynamic(light: 0x5B7083, dark: 0x8899A6),
            footnote: .dynamic(light: 0x5B7083, dark: 0x8899A6)
        )
        let primaryButton = DSButtonAppearance(
            accentColor: brandColor ?? .dynamic(light: 0x1DA1F2, dark: 0x1DA1F2),
            supportColor: .dynamic(light: 0xFEFFFE, dark: 0xFEFFFE)
        )
        let primaryTextField = DSTextFieldAppearance(
            background: .dynamic(light: 0xF3F4F2, dark: 0x101A24),
            text: .dynamic(light: 0x14171A, dark: 0xFEFFFE),
            placeHolder: .dynamic(light: 0x5B7083, dark: 0x8899A6)
        )
        self.primaryView = DSViewAppearance(
            button: primaryButton,
            text: text,
            textField: primaryTextField,
            background: .dynamic(light: 0xFEFFFE, dark: 0x15202B),
            separator: .dynamic(light: 0xD0DBE3, dark: 0x38444D),
            cornerRadius: 10
        )

        let secondaryTextField = DSTextFieldAppearance(
            background: .dynamic(light: 0xFEFFFE, dark: 0x15202B),
            text: text.headline,
            placeHolder: text.subheadline
        )
        let secondaryButton = DSButtonAppearance(
            accentColor: .dynamic(light: 0x5B7083, dark: 0x8899A6),
            supportColor: .dynamic(light: 0xFEFFFE, dark: 0xFEFFFE)
        )
        self.secondaryView = DSViewAppearance(
            button: secondaryButton,
            text: text,
            textField: secondaryTextField,
            background: .dynamic(light: 0xF3F4F2, dark: 0x101A24),
            separator: .dynamic(light: 0xD0DBE3, dark: 0x15202B),
            cornerRadius: 10
        )
        self.tabBar = DSTabBarAppearance(
            barTint: primaryView.background,
            itemTint: primaryView.button.accentColor,
            unselectedItemTint: text.subheadline,
            badge: primaryView.button.accentColor,
            translucent: false
        )
        self.navigationBar = DSNavigationBarAppearance(
            buttons: primaryView.button.accentColor,
            text: text.title1,
            bar: primaryView.background,
            translucent: false
        )
        self.price = DSPriceAppearance(
            regularAmount: text.subheadline,
            badgeBackground: DSUIColor(0xFF656B),
            badgeCornerRadius: 4
        )
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
