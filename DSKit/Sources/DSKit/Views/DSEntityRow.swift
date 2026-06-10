//
//  DSEntityRow.swift
//  DSKit
//
//  Created by Ivan Borinschi on 09.06.2026.
//

import SwiftUI

public struct DSEntityRow<Leading: View, Accessory: View>: View {
    private let title: String
    private let subtitle: String?
    private let titleStyle: DSTypographyToken
    private let subtitleStyle: DSTypographyToken
    private let textSpacing: DSSpatialToken
    private let spacing: DSSpatialToken
    private let leading: Leading
    private let accessory: Accessory

    public init(
        title: String,
        subtitle: String? = nil,
        titleStyle: DSTypographyToken = .label,
        subtitleStyle: DSTypographyToken = .caption1,
        textSpacing: DSSpatialToken = .custom(0),
        spacing: DSSpatialToken = .space16,
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder accessory: () -> Accessory
    ) {
        self.title = title
        self.subtitle = subtitle
        self.titleStyle = titleStyle
        self.subtitleStyle = subtitleStyle
        self.textSpacing = textSpacing
        self.spacing = spacing
        self.leading = leading()
        self.accessory = accessory()
    }

    public var body: some View {
        DSHStack(spacing: spacing) {
            leading
            DSVStack(spacing: textSpacing) {
                DSText(title)
                    .dsTextStyle(titleStyle)
                if let subtitle {
                    DSText(subtitle)
                        .dsTextStyle(subtitleStyle)
                }
            }
            .dsFullWidth()
            accessory
        }
    }
}

public extension DSEntityRow where Accessory == DSCardAccessory {
    init(
        title: String,
        subtitle: String? = nil,
        titleStyle: DSTypographyToken = .label,
        subtitleStyle: DSTypographyToken = .caption1,
        textSpacing: DSSpatialToken = .custom(0),
        spacing: DSSpatialToken = .space16,
        accessory: DSCardAccessoryKind = .none,
        @ViewBuilder leading: () -> Leading
    ) {
        self.init(
            title: title,
            subtitle: subtitle,
            titleStyle: titleStyle,
            subtitleStyle: subtitleStyle,
            textSpacing: textSpacing,
            spacing: spacing,
            leading: leading,
            accessory: { DSCardAccessory(accessory) }
        )
    }
}
