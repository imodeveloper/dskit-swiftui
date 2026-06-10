//
//  DSEntityCardRow.swift
//  DSKit
//
//  Created by Ivan Borinschi on 09.06.2026.
//

import SwiftUI

public struct DSEntityCardRow: View {
    private let title: String
    private let subtitle: String?
    private let imageURL: URL?
    private let placeholderSystemName: String
    private let badgeText: String?
    private let accessorySystemName: String?
    private let onTap: (() -> Void)?

    public init(
        title: String,
        subtitle: String? = nil,
        imageURL: URL? = nil,
        placeholderSystemName: String = "person.circle",
        badgeText: String? = nil,
        accessorySystemName: String? = nil,
        onTap: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.placeholderSystemName = placeholderSystemName
        self.badgeText = badgeText
        self.accessorySystemName = accessorySystemName
        self.onTap = onTap
    }

    public var body: some View {
        DSHStack(alignment: .center) {
            if let imageURL {
                DSImageView(
                    url: imageURL,
                    style: .none,
                    size: .size(width: 40, height: 50)
                )
                .dsCornerRadius()
            } else {
                DSImageView(
                    systemName: placeholderSystemName,
                    size: .size(width: 40, height: 50),
                    tint: .text(.caption2)
                )
                .dsCornerRadius()
            }

            DSVStack(spacing: .space4) {
                DSText(title, alignment: .leading)
                    .dsTextStyle(.label)
                if let subtitle, subtitle.isEmpty == false {
                    DSText(subtitle)
                        .dsTextStyle(.caption1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            if let badgeText, badgeText.isEmpty == false {
                DSBadgeText(badgeText)
            }

            if let accessorySystemName {
                DSImageView(
                    systemName: accessorySystemName,
                    size: .font(.caption2),
                    tint: .text(.caption2)
                )
            }
        }
        .dsMaxWidthCentered()
        .dsCardStyle(padding: .space8)
        .onTap {
            onTap?()
        }
    }
}
