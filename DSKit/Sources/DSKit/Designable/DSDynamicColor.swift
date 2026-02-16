//
//  DynamicColor.swift
//  DSKit
//
//  Created by Borinschi Ivan on 16.12.2020.
//

public class DSDynamicColor {

    /// Generate light and dark color for dynamic interfaces
    /// - Parameters:
    ///   - light: DSUIColor for light interface
    ///   - dark: DSUIColor for dark interface
    /// - Returns: DSUIColor
    public static func color(light: DSUIColor, dark: DSUIColor) -> DSUIColor {
        #if canImport(UIKit)
        return DSUIColor { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? dark : light
        }
        #elseif canImport(AppKit)
        return DSUIColor(name: nil, dynamicProvider: { appearance in
            appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua ? dark : light
        })
        #endif
    }

    /// Generate light and dark color for dynamic interfaces using hex values
    /// - Parameters:
    ///   - light: Hex color for light interface
    ///   - dark: Hex color for dark interface
    /// - Returns: DSUIColor
    public static func color(light: Int, dark: Int) -> DSUIColor {
        return color(light: DSUIColor(light), dark: DSUIColor(dark))
    }
}
