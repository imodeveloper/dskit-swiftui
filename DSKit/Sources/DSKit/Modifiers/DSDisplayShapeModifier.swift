//
//  DSDisplayShapeModifier.swift
//  DSKit
//
//  Created by Ivan Borinschi on 19.12.2022.
//

import SwiftUI

public enum DSDisplayShape {
    case none
    case circle
    case capsule
}

struct DSDisplayShapeModifier: ViewModifier {

    @Environment(\.appearance) var appearance: DSAppearance
    let shape: DSDisplayShape

    @ViewBuilder
    func body(content: Content) -> some View {
        switch shape {
        case .none:
            content.clipped()
        case .circle:
            content.clipShape(Circle())
        case .capsule:
            content.cornerRadius(appearance.cornerRadius)
        }
    }
}

extension View {
    func setDisplayShape(shape: DSDisplayShape) -> some View {
        self.modifier(DSDisplayShapeModifier(shape: shape))
    }
}
