//
//  DSEntityCardListView.swift
//  DSKit
//
//  Created by Ivan Borinschi on 06.07.2026.
//

import SwiftUI

/*
## DSEntityCardListView

`DSEntityCardListView` renders a vertical list of entity cards with optional loading placeholders. It is a display-only component for people, organizations, sources, categories, or any named entity list.

#### Initialization:
Initializes the card list with display-ready items and optional placeholder state.
- Parameters:
- `items`: Stable entity display items.
- `isLoading`: Forces placeholder rendering.
- `placeholderCount`: Number of placeholder rows to show when loading or empty.
- `onItemTap`: Optional tap callback for a visible item.

#### Usage:
Map app domain models into `DSEntityCardListItem` values at the screen boundary, then render this component. Keep fetching, filtering, and model-specific behavior outside DSKit.
*/

public struct DSEntityCardListItem: Identifiable, Equatable, Sendable {
    public let id: String
    public let title: String
    public let subtitle: String?
    public let imageURL: URL?
    public let countText: String?
    public let countAccessibilityLabel: String?
    public let accessorySystemName: String?

    public init(
        id: String,
        title: String,
        subtitle: String? = nil,
        imageURL: URL? = nil,
        countText: String? = nil,
        countAccessibilityLabel: String? = nil,
        accessorySystemName: String? = nil
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.countText = countText
        self.countAccessibilityLabel = countAccessibilityLabel
        self.accessorySystemName = accessorySystemName
    }
}

public struct DSEntityCardListView: View {
    private let items: [DSEntityCardListItem]
    private let isLoading: Bool
    private let placeholderCount: Int
    private let onItemTap: ((DSEntityCardListItem) -> Void)?

    public init(
        items: [DSEntityCardListItem],
        isLoading: Bool = false,
        placeholderCount: Int = 0,
        onItemTap: ((DSEntityCardListItem) -> Void)? = nil
    ) {
        self.items = items
        self.isLoading = isLoading
        self.placeholderCount = placeholderCount
        self.onItemTap = onItemTap
    }

    public var body: some View {
        DSVStack(spacing: .space4) {
            if shouldShowPlaceholders {
                ForEach(Self.placeholderItems(count: max(placeholderCount, 1))) { item in
                    DSEntityCardListRow(item: item)
                        .redacted(reason: .placeholder)
                }
            } else {
                ForEach(items) { item in
                    DSEntityCardListRow(item: item) {
                        onItemTap?(item)
                    }
                }
            }
        }
    }

    private var shouldShowPlaceholders: Bool {
        isLoading || (items.isEmpty && placeholderCount > 0)
    }

    private static func placeholderItems(count: Int) -> [DSEntityCardListItem] {
        (0 ..< count).map { index in
            DSEntityCardListItem(
                id: "placeholder-\(index)",
                title: "Entity",
                subtitle: "Loading"
            )
        }
    }
}

private struct DSEntityCardListRow: View {
    let item: DSEntityCardListItem
    var onTap: (() -> Void)?

    var body: some View {
        DSEntityListRow(
            title: item.title,
            subtitle: item.subtitle,
            countText: item.countText,
            countAccessibilityLabel: item.countAccessibilityLabel,
            leadingSize: DSEntityListRowLayout.peopleAvatarSize,
            accessorySystemName: item.accessorySystemName,
            leading: {
                DSEntityAvatarView(
                    imageURL: item.imageURL,
                    title: item.title,
                    colorSeed: item.title,
                    initialsMode: .forceTwo,
                    size: DSEntityListRowLayout.peopleAvatarSize,
                    shape: .roundedRectangle(cornerRadius: 8)
                )
            },
            onTap: onTap
        )
    }
}

struct Testable_DSEntityCardListView: View {
    var body: some View {
        DSVStack(spacing: .space12) {
            DSEntityCardListView(
                items: [
                    DSEntityCardListItem(
                        id: "maia-sandu",
                        title: "Maia Sandu",
                        subtitle: "President",
                        countText: "24",
                        countAccessibilityLabel: "24 mentions",
                        accessorySystemName: "chevron.right"
                    ),
                    DSEntityCardListItem(
                        id: "igor-grosu",
                        title: "Igor Grosu",
                        subtitle: "Speaker",
                        countText: "16",
                        countAccessibilityLabel: "16 mentions",
                        accessorySystemName: "chevron.right"
                    )
                ]
            )

            DSEntityCardListView(
                items: [],
                isLoading: true,
                placeholderCount: 2
            )
        }
    }
}

struct DSEntityCardListView_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSEntityCardListView()
            }
        }
    }
}
