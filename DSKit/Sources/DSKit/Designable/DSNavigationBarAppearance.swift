//
//  DSNavigationBarAppearance.swift
//  DSKit
//
//  Created by Borinschi Ivan on 01.12.2020.
//

import SwiftUI

public protocol DSNavigationBarAppearanceProtocol {
    var buttons: DSUIColor { get set }
    var text: DSUIColor { get set }
    var bar: DSUIColor { get set }
    var translucent: Bool { get set }
}

public enum DSNavigationBarColor {
    case button
    case text
    case bar
}

public extension DSNavigationBarAppearanceProtocol {
    func color(key: DSNavigationBarColor) -> Color {
        switch key {
        case .button:
            buttons.color
        case .text:
            text.color
        case .bar:
            bar.color
        }
    }
}

public struct DSNavigationBarAppearance: DSNavigationBarAppearanceProtocol {
    public init(
        buttons: DSUIColor = .dynamic(light: 0x1DA1F2, dark: 0x1DA1F2),
        text: DSUIColor = .dynamic(light: 0x14171A, dark: 0xFEFFFE),
        bar: DSUIColor = .dynamic(light: 0xFEFFFE, dark: 0x15202B),
        translucent: Bool = false
    ) {
        self.buttons = buttons
        self.text = text
        self.bar = bar
        self.translucent = translucent
    }

    public var buttons: DSUIColor
    public var text: DSUIColor
    public var bar: DSUIColor
    public var translucent: Bool
}
