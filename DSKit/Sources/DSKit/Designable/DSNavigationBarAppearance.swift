//
//  DSNavigationBarAppearance.swift
//  DSKit
//
//  Created by Borinschi Ivan on 01.12.2020.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
//

import SwiftUI

public protocol DSNavigationBarAppearanceProtocol {
    var buttons: DSUIColor { get set }
    var text: DSUIColor { get set }
    var bar: DSUIColor { get set }
    var translucent: Bool { get set }
}

extension DSNavigationBarAppearanceProtocol {
    /// Returns a SwiftUI Color based on the DSNavigationBarColor key
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

public enum DSNavigationBarColor {
    case button
    case text
    case bar
}

public struct DSNavigationBarAppearance: DSNavigationBarAppearanceProtocol {
    public init(
        buttons: DSUIColor,
        text: DSUIColor,
        bar: DSUIColor,
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
