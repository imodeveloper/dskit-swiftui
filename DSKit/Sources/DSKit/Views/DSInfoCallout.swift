//
//  DSInfoCallout.swift
//  DSKit
//
//  Created by Ivan Borinschi on 09.06.2026.
//

import SwiftUI

public struct DSInfoCallout: View {
    private let lines: [DSInfoCalloutLine]
    private let systemName: String
    private let textStyle: DSTypographyToken
    private let usesIconBadge: Bool

    public init(
        lines: [String],
        systemName: String = "info.circle",
        textStyle: DSTypographyToken = .caption1,
        usesIconBadge: Bool = false
    ) {
        self.lines = lines.map(DSInfoCalloutLine.init)
        self.systemName = systemName
        self.textStyle = textStyle
        self.usesIconBadge = usesIconBadge
    }

    public init(
        lines: [DSInfoCalloutLine],
        systemName: String = "info.circle",
        textStyle: DSTypographyToken = .caption1,
        usesIconBadge: Bool = false
    ) {
        self.lines = lines
        self.systemName = systemName
        self.textStyle = textStyle
        self.usesIconBadge = usesIconBadge
    }

    public var body: some View {
        if usesIconBadge {
            DSHStack(spacing: .space8) {
                icon
                DSVStack(alignment: .leading, spacing: .custom(2)) {
                    ForEach(lines) { line in
                        lineView(line)
                    }
                }
            }
            .dsCardStyle()
        } else {
            DSCardSurface {
                DSHStack(alignment: .top, spacing: .space12) {
                    icon
                    DSVStack(alignment: .leading, spacing: .space4) {
                        ForEach(lines) { line in
                            lineView(line)
                        }
                    }
                    .dsFullWidth()
                }
            }
        }
    }

    @ViewBuilder
    private var icon: some View {
        if usesIconBadge {
            DSIconBadgeView(systemName: systemName)
        } else {
            DSImageView(systemName: systemName, size: .font(.label), tint: .text(.label))
        }
    }

    @ViewBuilder
    private func lineView(_ line: DSInfoCalloutLine) -> some View {
        if let emphasizedSuffix = line.emphasizedSuffix {
            (Text(line.text).foregroundStyle(.secondary) +
                Text(emphasizedSuffix).foregroundStyle(.primary).bold())
                .font(.caption)
                .frame(maxWidth: .infinity, alignment: .leading)
        } else {
            DSText(line.text)
                .dsTextStyle(textStyle, .text(textStyle))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

public struct DSInfoCalloutLine: Hashable, Identifiable {
    public let id: String
    public let text: String
    public let emphasizedSuffix: String?

    public init(_ text: String) {
        self.id = text
        self.text = text
        self.emphasizedSuffix = nil
    }

    public init(prefix: String, emphasizedSuffix: String) {
        self.id = "\(prefix)|\(emphasizedSuffix)"
        self.text = prefix
        self.emphasizedSuffix = emphasizedSuffix
    }
}
