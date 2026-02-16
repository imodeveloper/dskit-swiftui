// Copyright © 2020 Flinesoft. All rights reserved.

import SwiftUI

// MARK: - DSUIColor Extensions
public extension DSUIColor {

    /// Initialize `DSUIColor` with RGB values
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    /// Initialize `DSUIColor` with a hex integer value
    convenience init(_ netHex: Int) {
        self.init(
            red: (netHex >> 16) & 0xFF,
            green: (netHex >> 8) & 0xFF,
            blue: netHex & 0xFF
        )
    }

    /// Create a dynamic color that adapts to light and dark mode
    static func dynamic(light: Int, dark: Int) -> DSUIColor {
        #if canImport(UIKit)
        return DSUIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? DSUIColor(dark) : DSUIColor(light)
        }
        #elseif canImport(AppKit)
        return DSUIColor(name: nil, dynamicProvider: { appearance in
            return appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua ? DSUIColor(dark) : DSUIColor(light)
        }) ?? DSUIColor(light)
        #endif
    }

    /// Convert `DSUIColor` to `SwiftUI.Color`
    var color: Color {
        Color(self)
    }
}
