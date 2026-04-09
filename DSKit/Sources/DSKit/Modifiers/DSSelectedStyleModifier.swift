//
//  DSSpatialToken.swift
//  DSKit
//
//  Created by Ivan Borinschi on 14.12.2022.
//

import SwiftUI

public struct DSSelectedStyleModifier: ViewModifier, DSDesignable {

    @Environment(\.appearance) public var appearance: DSAppearance
    @Environment(\.surfaceStyle) public var surfaceStyle: DSSurfaceStyle

    let isSelected: Bool

    init(isSelected: Bool) {
        self.isSelected = isSelected
    }

    public func body(content: Content) -> some View {
        content
            .dsCornerRadius()
            .overlay(alignment: .center, content: {
                RoundedRectangle(cornerRadius: appearance.cornerRadius - 3)
                    .stroke(appearance.color(for: .background(.canvas), surfaceStyle: .canvas), lineWidth: isSelected ? 2 : 0)
                    .padding(3)
            })
            .overlay(alignment: .center, content: {
                RoundedRectangle(cornerRadius: appearance.cornerRadius - 1)
                    .stroke(color(for: .border(.brand)), lineWidth: isSelected ? 2 : 0)
                    .padding(1)
            })
            .transition(.opacity)
    }
}

public extension View {
    func dsSelectedStyle(isSelected: Bool) -> some View {
        let modifier = DSSelectedStyleModifier(isSelected: isSelected)
        return self.modifier(modifier)
    }
}
