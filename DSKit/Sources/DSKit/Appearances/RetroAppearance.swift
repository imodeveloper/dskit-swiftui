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
    public var primaryView: DSViewAppearanceProtocol
    public var secondaryView: DSViewAppearanceProtocol
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
        let text = DSTextAppearance(
            largeTitle: .dynamic(light: 0x2B2834, dark: 0xE8E7E6),
            title1: .dynamic(light: 0x2B2834, dark: 0xE8E7E6),
            title2: .dynamic(light: 0x2B2834, dark: 0xE8E7E6),
            title3: .dynamic(light: 0x2B2834, dark: 0xE8E7E6),
            headline: .dynamic(light: 0x2B2834, dark: 0xE8E7E6),
            subheadline: .dynamic(light: 0x4E4A57, dark: 0x9699A8),
            body: .dynamic(light: 0x2B2834, dark: 0xE8E7E6),
            callout: .dynamic(light: 0x4E4A57, dark: 0x9699A8),
            caption1: .dynamic(light: 0x4E4A57, dark: 0x9699A8),
            caption2: .dynamic(light: 0x4E4A57, dark: 0x9699A8),
            footnote: .dynamic(light: 0x4E4A57, dark: 0x9699A8)
        )
        let primaryTextField = DSTextFieldAppearance(
            background: .dynamic(light: 0xF4F2EA, dark: 0x4E4A57),
            text: .dynamic(light: 0x2A2732, dark: 0xE8E7E6),
            placeHolder: .dynamic(light: 0x777777, dark: 0x9699A8)
        )
        let primaryButton = DSButtonAppearance(
            accentColor: brandColor ?? .dynamic(light: 0xFC8F0F, dark: 0xFC8F0F),
            supportColor: .dynamic(light: 0xFFFFFF, dark: 0xFFFFFF)
        )
        self.primaryView = DSViewAppearance(
            button: primaryButton,
            text: text,
            textField: primaryTextField,
            background: .dynamic(light: 0xFFFCF8, dark: 0x383443),
            separator: .dynamic(light: 0xFBEFE0, dark: 0x464154),
            cornerRadius: 13
        )

        let secondaryText = DSTextAppearance(
            largeTitle: .dynamic(light: 0x2A2732, dark: 0xE8E7E6),
            title1: .dynamic(light: 0x2A2732, dark: 0xE8E7E6),
            title2: .dynamic(light: 0x2A2732, dark: 0xE8E7E6),
            title3: .dynamic(light: 0x2A2732, dark: 0xE8E7E6),
            headline: .dynamic(light: 0x000000, dark: 0xE8E7E6),
            subheadline: .dynamic(light: 0x555555, dark: 0x999DB1),
            body: .dynamic(light: 0x2A2732, dark: 0xE8E7E6),
            callout: .dynamic(light: 0x595465, dark: 0x999DB1),
            caption1: .dynamic(light: 0x595465, dark: 0x999DB1),
            caption2: .dynamic(light: 0x595465, dark: 0x999DB1),
            footnote: .dynamic(light: 0x595465, dark: 0x999DB1)
        )
        let secondaryTextField = DSTextFieldAppearance(
            background: .dynamic(light: 0xFFFFFF, dark: 0x383443),
            text: secondaryText.headline,
            placeHolder: secondaryText.subheadline
        )
        self.secondaryView = DSViewAppearance(
            button: DSButtonAppearance(
                accentColor: primaryButton.accentColor,
                supportColor: primaryButton.supportColor
            ),
            text: secondaryText,
            textField: secondaryTextField,
            background: .dynamic(light: 0xF4F2EA, dark: 0x4E4A57),
            separator: .dynamic(light: 0xDFDCD3, dark: 0x111111),
            cornerRadius: 13
        )
        self.tabBar = DSTabBarAppearance(
            barTint: primaryView.background,
            itemTint: primaryView.button.accentColor,
            unselectedItemTint: text.subheadline,
            badge: primaryView.button.accentColor
        )
        self.navigationBar = DSNavigationBarAppearance(
            buttons: primaryView.button.accentColor,
            text: text.title1,
            bar: primaryView.background
        )
        self.price = DSPriceAppearance(
            regularAmount: text.subheadline,
            badgeBackground: primaryView.button.accentColor
        )
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
