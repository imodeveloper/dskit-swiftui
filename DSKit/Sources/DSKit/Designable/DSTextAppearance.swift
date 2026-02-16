//
//  DSTextColor.swift
//  DSKit
//
//  Created by Borinschi Ivan on 01.12.2020.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
//

import SwiftUI

public protocol DSTextAppearanceProtocol {
    var largeTitle: DSUIColor { get set }
    var title1: DSUIColor { get set }
    var title2: DSUIColor { get set }
    var title3: DSUIColor { get set }
    var headline: DSUIColor { get set }
    var subheadline: DSUIColor { get set }
    var body: DSUIColor { get set }
    var callout: DSUIColor { get set }
    var caption1: DSUIColor { get set }
    var caption2: DSUIColor { get set }
    var footnote: DSUIColor { get set }
}

public struct DSTextAppearance: DSTextAppearanceProtocol {

    public init(
        largeTitle: DSUIColor,
        title1: DSUIColor,
        title2: DSUIColor,
        title3: DSUIColor,
        headline: DSUIColor,
        subheadline: DSUIColor,
        body: DSUIColor,
        callout: DSUIColor,
        caption1: DSUIColor,
        caption2: DSUIColor,
        footnote: DSUIColor
    ) {
        self.largeTitle = largeTitle
        self.title1 = title1
        self.title2 = title2
        self.title3 = title3
        self.headline = headline
        self.subheadline = subheadline
        self.body = body
        self.callout = callout
        self.caption1 = caption1
        self.caption2 = caption2
        self.footnote = footnote
    }

    public var largeTitle: DSUIColor
    public var title1: DSUIColor
    public var title2: DSUIColor
    public var title3: DSUIColor
    public var headline: DSUIColor
    public var subheadline: DSUIColor
    public var body: DSUIColor
    public var callout: DSUIColor
    public var caption1: DSUIColor
    public var caption2: DSUIColor
    public var footnote: DSUIColor
}

public extension DSTextAppearance {

    /// Get DSTextAppearance using only 2 colors to fill all text styles
    /// - Parameters:
    ///   - main: DSUIColor
    ///   - secondary: DSUIColor
    /// - Returns: DSTextAppearance
    static func textColors(
        main: DSUIColor, secondary: DSUIColor
    ) -> DSTextAppearance {
        DSTextAppearance(
            largeTitle: main,
            title1: main,
            title2: main,
            title3: main,
            headline: main,
            subheadline: secondary,
            body: main,
            callout: secondary,
            caption1: secondary,
            caption2: secondary,
            footnote: secondary
        )
    }
}
