//
//  DSCardStyleModifier.swift
//  DSKit
//
//  Created by Ivan Borinschi on 14.12.2022.
//

import SwiftUI

public struct DSCardStyleModifier: ViewModifier {

    let horizontalPadding: DSSpatialToken
    let verticalPadding: DSSpatialToken

    public init(padding: DSSpatialToken) {
        self.horizontalPadding = padding
        self.verticalPadding = padding
    }

    public init(horizontalPadding: DSSpatialToken, verticalPadding: DSSpatialToken) {
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
    func dsCardStyle(padding: DSSpatialToken = .space16) -> some View {
        return self.modifier(DSCardStyleModifier(padding: padding))
    }

    func dsCardStyle(
        horizontalPadding: DSSpatialToken,
        verticalPadding: DSSpatialToken
    ) -> some View {
        return self.modifier(
            DSCardStyleModifier(
                horizontalPadding: horizontalPadding,
                verticalPadding: verticalPadding
            )
        )
    }
}
