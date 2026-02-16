//
//  BackgroundColors.swift
//  DSKit
//
//  Created by Borinschi Ivan on 01.12.2020.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
//

import SwiftUI

public protocol DSViewAppearanceProtocol {
    var button: DSButtonAppearanceProtocol { get }
    var text: DSTextAppearanceProtocol { get }
    var textField: DSTextFieldAppearanceProtocol { get }
    var background: DSUIColor { get }
    var separator: DSUIColor { get }
    var cornerRadius: CGFloat { get }
}

public extension DSViewAppearanceProtocol {
    /// Returns a SwiftUI Color based on the DSViewColorKey
    func color(for viewKey: DSViewColorKey, appearance: DSAppearance, style: DSViewStyle) -> Color {
        switch viewKey {
        case .button(let buttonKey):
            return button.color(key: buttonKey)
        case .background:
            return Color(background)
        case .separator:
            return Color(separator)
        case .textField(let textFieldKey):
            return textField.color(key: textFieldKey)
        case .text(let textKey):
            return textKey.color(for: appearance, and: style)
        }
    }
}

public enum DSViewColorKey: Equatable, Hashable {
    case background
    case separator
    case button(DSButtonColorKey)
    case textField(DSTextFieldColorKey)
    case text(DSTextColorKey)
}

public struct DSViewAppearance: DSViewAppearanceProtocol {

    public init(
        button: DSButtonAppearanceProtocol,
        text: DSTextAppearanceProtocol,
        textField: DSTextFieldAppearanceProtocol,
        background: DSUIColor,
        separator: DSUIColor,
        cornerRadius: CGFloat
    ) {
        self.button = button
        self.text = text
        self.textField = textField
        self.background = background
        self.separator = separator
        self.cornerRadius = cornerRadius
    }

    public var button: DSButtonAppearanceProtocol
    public var text: DSTextAppearanceProtocol
    public var textField: DSTextFieldAppearanceProtocol
    public var background: DSUIColor
    public var separator: DSUIColor
    public var cornerRadius: CGFloat
}
