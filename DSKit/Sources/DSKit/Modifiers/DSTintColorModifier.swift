//
//  DSColorModifier.swift
//  DSKit
//
//  Created by Ivan Borinschi on 19.12.2022.
//

import SwiftUI

struct DSColorModifier: ViewModifier {

    @Environment(\.appearance) var appearance: DSAppearance
    @Environment(\.viewStyle) var viewStyle: DSViewStyle
    let tint: DSColorKey
    func body(content: Content) -> some View {
        content
            .foregroundColor(tint.color(for: appearance, and: viewStyle))
    }
}

extension View {
    func setTint(tint: DSColorKey) -> some View {
        self.modifier(DSColorModifier(tint: tint))
    }
}

extension Image {
    @ViewBuilder
    func setImageTint(tint: DSColorKey?) -> some View {
        if let tint {
            self
                .renderingMode(.template)
                .setTint(tint: tint)
        } else {
            self
        }
    }
}
