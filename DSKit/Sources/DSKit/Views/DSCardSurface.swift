//
//  DSCardSurface.swift
//  DSKit
//
//  Created by Ivan Borinschi on 09.06.2026.
//

import SwiftUI

public struct DSCardSurface<Content: View>: View {
    private let horizontalPadding: DSSpatialToken
    private let verticalPadding: DSSpatialToken
    private let content: Content

    public init(
        horizontalPadding: DSSpatialToken = .space16,
        verticalPadding: DSSpatialToken = .space16,
        @ViewBuilder content: () -> Content
    ) {
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        self.content = content()
    }

    public var body: some View {
        content
            .dsPadding(.horizontal, horizontalPadding)
            .dsPadding(.vertical, verticalPadding)
            .dsSecondaryBackground()
            .dsCornerRadius()
    }
}
