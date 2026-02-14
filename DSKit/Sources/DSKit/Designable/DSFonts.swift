//
//  Fonts.swift
//  DSKit
//
//  Created by Borinschi Ivan on 01.12.2020.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
//

public protocol DSFontsProtocol {
    var body: DSFont { get }
    var callout: DSFont { get }
    var caption1: DSFont { get }
    var caption2: DSFont { get }
    var footnote: DSFont { get }
    var headline: DSFont { get }
    var subheadline: DSFont { get }
    var largeTitle: DSFont { get }
    var title1: DSFont { get }
    var title2: DSFont { get }
    var title3: DSFont { get }
}

public class DSFonts: DSFontsProtocol {
    
    var fontName: String
    
    public init(fontName: String = "") {
        self.fontName = fontName
    }
    
    private lazy var scaledFont: DSScaledFont = {
        DSScaledFont(fontName: fontName)
    }()
    
    lazy public var body: DSFont = {
        return scaledFont.font(forTextStyle: .body)
    }()
    
    lazy public var callout: DSFont = {
        return scaledFont.font(forTextStyle: .callout)
    }()
    
    lazy public var caption1: DSFont = {
        return scaledFont.font(forTextStyle: .caption1)
    }()
    
    lazy public var caption2: DSFont = {
        return scaledFont.font(forTextStyle: .caption2)
    }()
    
    lazy public var footnote: DSFont  = {
        return scaledFont.font(forTextStyle: .footnote)
    }()
    
    lazy public var headline: DSFont = {
        return scaledFont.font(forTextStyle: .headline)
    }()
    
    lazy public var subheadline: DSFont = {
        return scaledFont.font(forTextStyle: .subheadline)
    }()
    
    lazy public var largeTitle: DSFont = {
        return scaledFont.font(forTextStyle: .largeTitle)
    }()
    
    lazy public var title1: DSFont = {
        return scaledFont.font(forTextStyle: .title1)
    }()
    
    lazy public var title2: DSFont = {
        return scaledFont.font(forTextStyle: .title2)
    }()
    
    lazy public var title3: DSFont = {
        return scaledFont.font(forTextStyle: .title3)
    }()
}
