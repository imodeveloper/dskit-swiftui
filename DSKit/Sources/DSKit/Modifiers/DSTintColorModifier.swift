//
//  DSColorModifier.swift
//  DSKit
//
//  Created by Ivan Borinschi on 19.12.2022.
//

import SwiftUI

struct DSColorModifier: ViewModifier {

    @Environment(\.appearance) var appearance: DSAppearance
    @Environment(\.surfaceStyle) var surfaceStyle: DSSurfaceStyle
    let tint: DSColorToken
    func body(content: Content) -> some View {
        content
            .foregroundColor(tint.color(for: appearance, in: surfaceStyle))
    }
}

extension View {
    func setTint(tint: DSColorToken) -> some View {
        self.modifier(DSColorModifier(tint: tint))
    }
}

extension Image {
    @ViewBuilder
    func setImageTint(tint: DSColorToken?) -> some View {
        if let tint {
            self
                .renderingMode(.template)
                .setTint(tint: tint)
        } else {
            self
        }
    }
}
