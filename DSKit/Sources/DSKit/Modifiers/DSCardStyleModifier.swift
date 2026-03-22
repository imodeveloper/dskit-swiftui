//
//  DSCardStyleModifier.swift
//  DSKit
//
//  Created by Ivan Borinschi on 14.12.2022.
//

import SwiftUI

public struct DSCardStyleModifier: ViewModifier {

    let horizontalPadding: DSPadding
    let verticalPadding: DSPadding

    public init(padding: DSPadding) {
        self.horizontalPadding = padding
        self.verticalPadding = padding
    }

    public init(horizontalPadding: DSPadding, verticalPadding: DSPadding) {
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
    }

    public func body(content: Content) -> some View {
        content
            .dsPadding(.horizontal, horizontalPadding)
            .dsPadding(.vertical, verticalPadding)
            .dsSecondaryBackground()
            .dsCornerRadius()
    }
}

public extension View {
    func dsCardStyle(padding: DSPadding = .medium) -> some View {
        return self.modifier(DSCardStyleModifier(padding: padding))
    }

    func dsCardStyle(
        horizontalPadding: DSPadding,
        verticalPadding: DSPadding
    ) -> some View {
        return self.modifier(
            DSCardStyleModifier(
                horizontalPadding: horizontalPadding,
                verticalPadding: verticalPadding
            )
        )
    }
}
