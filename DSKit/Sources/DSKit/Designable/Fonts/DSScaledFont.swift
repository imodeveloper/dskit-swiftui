//  Created by Keith Harrison https://useyourloaf.com
//  Copyright (c) 2017 Keith Harrison. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//
//  3. Neither the name of the copyright holder nor the names of its
//  contributors may be used to endorse or promote products derived from
//  this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.

import Foundation
import SwiftUI

public final class DSScaledFont {
    private struct FontDescription: Decodable {
        let fontSize: CGFloat
        let fontName: String
    }
    
    private typealias DSStyleDictionary = [String: FontDescription]
    private var styleDictionary: DSStyleDictionary?
    
    /// Create a `DSScaledFont`
    ///
    /// - Parameter fontName: Name of a plist file (without the extension)
    ///   in the main bundle that contains the style dictionary used to
    ///   scale fonts for each text style.
    public init(fontName: String) {
        let normalizedName = fontName.trimmingCharacters(in: .whitespacesAndNewlines)
        let usesSystemFallback =
            normalizedName.isEmpty ||
            normalizedName.caseInsensitiveCompare("default") == .orderedSame ||
            normalizedName.caseInsensitiveCompare("system") == .orderedSame

        guard !usesSystemFallback else {
            return
        }

        if let url = Bundle(for: DSScaledFont.self).url(forResource: normalizedName, withExtension: "plist"),
           let data = try? Data(contentsOf: url) {
            let decoder = PropertyListDecoder()
            styleDictionary = try? decoder.decode(DSStyleDictionary.self, from: data)
        }
    }
    
    /// Get the scaled font for the given text style using the
    /// style dictionary supplied at initialization.
    ///
    /// - Parameter textStyle: The `DSFont.TextStyle` for the font.
    /// - Returns: A `DSFont` of the custom font that has been scaled
    ///   for the user's currently selected preferred text size.
    ///
    /// - Note: If the style dictionary does not have a font for this
    ///   text style, the default preferred font is returned.
    public func font(forTextStyle textStyle: DSFont.TextStyle) -> DSFont {
        guard let fontDescription = styleDictionary?[textStyle.rawValue] else {
            return defaultFont(for: textStyle)
        }
        
        guard let font = DSFont(name: fontDescription.fontName, size: fontDescription.fontSize) else {
            return defaultFont(for: textStyle)
        }
        
        #if canImport(UIKit)
        let fontMetrics = UIFontMetrics(forTextStyle: textStyle)
        return fontMetrics.scaledFont(for: font)
        #elseif canImport(AppKit)
        return font // macOS does not have `UIFontMetrics`
        #endif
    }
    
    /// Fallback to the default system font for the given text style.
    private func defaultFont(for textStyle: DSFont.TextStyle) -> DSFont {
        #if canImport(UIKit)
        return DSFont.preferredFont(forTextStyle: textStyle)
        #elseif canImport(AppKit)
        switch textStyle {
        case .title1: return DSFont.systemFont(ofSize: 28, weight: .bold)
        case .title2: return DSFont.systemFont(ofSize: 22, weight: .semibold)
        case .title3: return DSFont.systemFont(ofSize: 20, weight: .regular)
        case .headline: return DSFont.systemFont(ofSize: 17, weight: .semibold)
        case .subheadline: return DSFont.systemFont(ofSize: 15, weight: .regular)
        case .body: return DSFont.systemFont(ofSize: 17, weight: .regular)
        case .callout: return DSFont.systemFont(ofSize: 16, weight: .regular)
        case .caption1: return DSFont.systemFont(ofSize: 12, weight: .regular)
        case .caption2: return DSFont.systemFont(ofSize: 11, weight: .regular)
        case .footnote: return DSFont.systemFont(ofSize: 13, weight: .regular)
        default: return DSFont.systemFont(ofSize: 17, weight: .regular)
        }
        #endif
    }
}
