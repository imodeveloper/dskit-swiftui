//
//  DSIconBadgeView.swift
//  DSKit
//
//  Created by Ivan Borinschi on 09.06.2026.
//

import SwiftUI

public struct DSIconBadgeView: View {
    private let systemName: String
    private let size: CGFloat
    private let iconSize: DSSize
    private let foreground: DSColorToken
    private let backgroundOpacity: Double

    public init(
        systemName: String,
        size: CGFloat = 28,
        iconSize: DSSize = .font(.caption1),
        foreground: DSColorToken = .color(.accentColor),
        backgroundOpacity: Double = 0.12
    ) {
        self.systemName = systemName
        self.size = size
        self.iconSize = iconSize
        self.foreground = foreground
        self.backgroundOpacity = backgroundOpacity
    }

    public var body: some View {
        ZStack {
            Circle()
                .fill(Color.accentColor.opacity(backgroundOpacity))

            DSImageView(
                systemName: systemName,
                size: iconSize,
                tint: foreground
            )
        }
        .frame(width: size, height: size)
    }
}

public struct DSSymbolIconView: View {
    private let systemName: String
    private let textStyle: DSTypographyToken
    private let tint: DSColorToken

    public init(
        systemName: String,
        textStyle: DSTypographyToken = .caption2,
        tint: DSColorToken? = nil
    ) {
        self.systemName = systemName
        self.textStyle = textStyle
        self.tint = tint ?? .text(textStyle)
    }

    public var body: some View {
        DSImageView(
            systemName: systemName,
            size: .font(textStyle),
            tint: tint
        )
    }
}

public struct DSBadgeText: View {
    private let text: String

    public init(_ text: String) {
        self.text = text
    }

    public var body: some View {
        DSText(text)
            .dsTextStyle(.caption1, .text(.caption1))
            .dsPadding(.horizontal, 8)
            .dsPadding(.vertical, 4)
            .dsBackground(.secondary)
            .dsCornerRadius()
    }
}
