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
    let background: DSSurfaceStyle

    public init(
        padding: DSSpatialToken,
        background: DSSurfaceStyle = .secondary
    ) {
        self.horizontalPadding = padding
        self.verticalPadding = padding
        self.background = background
    }

    public init(
        horizontalPadding: DSSpatialToken,
        verticalPadding: DSSpatialToken,
        background: DSSurfaceStyle = .secondary
    ) {
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.background = background
    }

    public func body(content: Content) -> some View {
        content
            .dsPadding(.horizontal, horizontalPadding)
            .dsPadding(.vertical, verticalPadding)
            .dsBackground(background)
            .dsCornerRadius()
    }
}

public extension View {
    func dsCardStyle(
        padding: DSSpatialToken = .space16,
        background: DSSurfaceStyle = .secondary
    ) -> some View {
        return self.modifier(
            DSCardStyleModifier(
                padding: padding,
                background: background
            )
        )
    }

    func dsCardStyle(
        horizontalPadding: DSSpatialToken,
        verticalPadding: DSSpatialToken,
        background: DSSurfaceStyle = .secondary
    ) -> some View {
        return self.modifier(
            DSCardStyleModifier(
                horizontalPadding: horizontalPadding,
                verticalPadding: verticalPadding,
                background: background
            )
        )
    }
}
