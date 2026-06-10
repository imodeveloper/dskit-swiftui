//
//  DSMetadataRow.swift
//  DSKit
//
//  Created by Ivan Borinschi on 09.06.2026.
//

import SwiftUI

public struct DSMetadataTag: View {
    private let systemName: String?
    private let text: String
    private let textStyle: DSTypographyToken
    private let color: DSColorToken

    public init(
        _ text: String,
        systemName: String? = nil,
        textStyle: DSTypographyToken = .caption1,
        color: DSColorToken = .text(.caption1)
    ) {
        self.systemName = systemName
        self.text = text
        self.textStyle = textStyle
        self.color = color
    }

    public var body: some View {
        if let systemName {
            DSInlineTagView(
                systemName: systemName,
                text: text,
                color: color,
                textStyle: textStyle
            )
        } else {
            DSText(text)
                .dsTextStyle(textStyle, color)
        }
    }
}

public struct DSMetadataRow<Content: View>: View {
    private let spacing: DSSpatialToken
    private let content: Content

    public init(
        spacing: DSSpatialToken = .space8,
        @ViewBuilder content: () -> Content
    ) {
        self.spacing = spacing
        self.content = content()
    }

    public var body: some View {
        DSHStack(spacing: spacing) {
            content
        }
    }
}
