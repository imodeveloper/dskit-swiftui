//
//  RetroFont.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.05.2024.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

public class DSFuturaFont: DSFontsProtocol {

    public var body: DSFont {
        return regularFont(size: 17.0)
    }

    public var callout: DSFont {
        return regularFont(size: 16.0)
    }

    public var caption1: DSFont {
        return regularFont(size: 12.0)
    }

    public var caption2: DSFont {
        return regularFont(size: 11.0)
    }

    public var footnote: DSFont {
        return regularFont(size: 13.0)
    }

    public var headline: DSFont {
        return boldFont(size: 17.0)
    }

    public var subheadline: DSFont {
        return regularFont(size: 15.0)
    }

    public var largeTitle: DSFont {
        return regularFont(size: 34.0)
    }

    public var title1: DSFont {
        return regularFont(size: 28.0)
    }

    public var title2: DSFont {
        return regularFont(size: 22.0)
    }

    public var title3: DSFont {
        return regularFont(size: 20.0)
    }

    public init() {}

    // MARK: - Private Helpers

    private func regularFont(size: CGFloat) -> DSFont {
        return scaledFont(for: "Futura-Medium", textStyle: .body, defaultSize: size)
    }

    private func boldFont(size: CGFloat) -> DSFont {
        return scaledFont(for: "Futura-Bold", textStyle: .body, defaultSize: size)
    }

    private func scaledFont(for fontName: String, textStyle: DSFont.TextStyle, defaultSize: CGFloat) -> DSFont {
        let font = DSFont(name: fontName, size: defaultSize) ?? DSFont.systemFont(ofSize: defaultSize)
        #if canImport(UIKit)
        return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
        #elseif canImport(AppKit)
        return font
        #endif
    }
}
