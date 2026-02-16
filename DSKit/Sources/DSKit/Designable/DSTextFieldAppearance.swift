//
//  TextFieldColor.swift
//  DSKit
//
//  Created by Borinschi Ivan on 01.12.2020.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
//

import SwiftUI

public protocol DSTextFieldAppearanceProtocol {
    var background: DSUIColor { get set }
    var text: DSUIColor { get set }
    var placeHolder: DSUIColor { get set }
}

public extension DSTextFieldAppearanceProtocol {
    /// Returns a SwiftUI Color based on the DSTextFieldColorKey
    func color(key: DSTextFieldColorKey) -> Color {
        switch key {
        case .background:
            return Color(background)
        case .text:
            return Color(text)
        case .placeholder:
            return Color(placeHolder)
        }
    }
}

public enum DSTextFieldColorKey {
    case background
    case text
    case placeholder
}

public struct DSTextFieldAppearance: DSTextFieldAppearanceProtocol {

    public init(
        background: DSUIColor,
        text: DSUIColor,
        placeHolder: DSUIColor
    ) {
        self.background = background
        self.text = text
        self.placeHolder = placeHolder
    }

    public var background: DSUIColor
    public var text: DSUIColor
    public var placeHolder: DSUIColor
}
