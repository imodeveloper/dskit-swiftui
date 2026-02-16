//
//  TextFieldColor.swift
//  DSKit
//
//  Created by Borinschi Ivan on 01.12.2020.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
//

protocol DSTextFieldColorsProtocol {
    var border: DSUIColor { get set }
    var background: DSUIColor { get set }
    var text: DSUIColor { get set }
    var placeHolder: DSUIColor { get set }
}

public struct DSTextFieldColors: DSTextFieldColorsProtocol {

    public init(
        border: DSUIColor,
        background: DSUIColor,
        text: DSUIColor,
        placeHolder: DSUIColor
    ) {
        self.border = border
        self.background = background
        self.text = text
        self.placeHolder = placeHolder
    }

    public var border: DSUIColor
    public var background: DSUIColor
    public var text: DSUIColor
    public var placeHolder: DSUIColor
}
