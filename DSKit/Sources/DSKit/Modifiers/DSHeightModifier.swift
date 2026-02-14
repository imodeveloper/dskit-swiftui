//
//  DSHeightModifier.swift
//  DSKit
//
//  Created by Ivan Borinschi on 19.12.2022.
//

import Foundation
import SwiftUI

public struct DSHeightModifier: ViewModifier {
    
    let height: DSDimension
    @Environment(\.appearance) var appearance: DSAppearance
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory
    
    public func body(content: Content) -> some View {
        content.frame(height: height.value(appearance: appearance, sizeCategory: sizeCategory))
    }
}

public struct DSMinHeightModifier: ViewModifier {
    let minHeight: DSDimension
    @Environment(\.appearance) var appearance: DSAppearance
    @Environment(\.sizeCategory) var sizeCategory: ContentSizeCategory

    public func body(content: Content) -> some View {
        content.frame(minHeight: minHeight.value(appearance: appearance, sizeCategory: sizeCategory))
    }
}

public extension View {
    func dsHeight(_ height: DSDimension) -> some View {
        self.modifier(DSHeightModifier(height: height))
    }

    func dsMinHeight(_ minHeight: DSDimension) -> some View {
        self.modifier(DSMinHeightModifier(minHeight: minHeight))
    }
}

struct DSHeightModifier_Previews: PreviewProvider {
    static var previews: some View {
        DSPreview {
            Color.blue
                .dsHeight(100)
            Color.blue
                .dsHeight(1.5)
            Color.blue
                .dsHeight(2.5)
        }.dsLayoutDebug()
    }
}
