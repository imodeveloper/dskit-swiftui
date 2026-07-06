//
//  DSEntityListRow.swift
//  DSKit
//
//  Created by Ivan Borinschi on 06.07.2026.
//

import SwiftUI

/*
## DSEntityListRow

`DSEntityListRow` renders a compact tappable entity row with custom leading content, optional subtitle, count pill, and optional accessory symbol. It is intended for people, source, category, search-result, and settings-style lists where the app already has display-ready values.

#### Initialization:
Initializes a list row with title, optional subtitle, count text, accessibility count label, leading content, optional accessory, and tap action.
- Parameters:
- `title`: Main row title.
- `subtitle`: Optional secondary text.
- `countText`: Optional compact count pill text.
- `countAccessibilityLabel`: Optional accessibility label for the count pill.
- `leadingSize`: Fixed DSKit size applied to the leading view.
- `accessorySystemName`: Optional trailing SF Symbol.
- `leading`: Leading icon, avatar, or badge content.
- `onTap`: Optional tap action.

#### Usage:
Use `DSEntityListRow` to standardize entity rows across search, focus, directory, and picker screens. Pair it with `DSEntityAvatarView`, `DSEntityCategoryIconView`, or custom leading content.
*/

public enum DSEntityInitialsMode: Hashable, Sendable {
    case oneOrTwo
    case forceTwo
}

public enum DSEntityAvatarShape: Hashable, Sendable {
    case none
    case circle
    case roundedRectangle(cornerRadius: CGFloat)
}

public enum DSEntityListRowLayout {
    public static var leadingSize: DSSize { .size(.token(.space40)) }
    public static var peopleAvatarSize: DSSize {
        .size(
            width: .token(.space40),
            height: .custom(DSSpatialToken.space48.value + DSSpatialToken.space2.value)
        )
    }
    public static var minHeight: DSDimension { .token(.space64) }
    public static var horizontalPadding: DSSpatialToken { .space16 }
    public static var verticalPadding: DSSpatialToken { .space12 }
    public static var contentSpacing: DSSpatialToken { .space12 }
    public static var pillHorizontalPadding: DSSpatialToken { .space8 }
    public static var pillVerticalPadding: DSSpatialToken { .space4 }
}

public struct DSEntityListRow<Leading: View>: View {
    private let title: String
    private let subtitle: String?
    private let countText: String?
    private let countAccessibilityLabel: String?
    private let leading: Leading
    private let leadingSize: DSSize
    private let accessorySystemName: String?
    private let onTap: (() -> Void)?

    public init(
        title: String,
        subtitle: String? = nil,
        countText: String? = nil,
        countAccessibilityLabel: String? = nil,
        leadingSize: DSSize = DSEntityListRowLayout.leadingSize,
        accessorySystemName: String? = nil,
        @ViewBuilder leading: () -> Leading,
        onTap: (() -> Void)? = nil
    ) {
        self.title = title
        self.subtitle = subtitle
        self.countText = countText
        self.countAccessibilityLabel = countAccessibilityLabel
        self.leadingSize = leadingSize
        self.accessorySystemName = accessorySystemName
        self.leading = leading()
        self.onTap = onTap
    }

    public var body: some View {
        DSHStack(spacing: DSEntityListRowLayout.contentSpacing) {
            leading
                .dsSize(leadingSize)

            DSVStack(spacing: .space2) {
                DSText(title)
                    .dsTextStyle(.label)
                    .lineLimit(1)
                    .minimumScaleFactor(0.85)

                if let subtitle, subtitle.isEmpty == false {
                    DSText(subtitle)
                        .dsTextStyle(.caption1, .text(.caption1))
                        .lineLimit(1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer(minLength: 0)

            if let countText, countText.isEmpty == false {
                DSText(countText)
                    .dsTextStyle(.caption1, .text(.headline))
                    .dsPadding(.horizontal, DSEntityListRowLayout.pillHorizontalPadding)
                    .dsPadding(.vertical, DSEntityListRowLayout.pillVerticalPadding)
                    .background(Color.secondary.opacity(0.14))
                    .clipShape(Capsule())
                    .accessibilityLabel(countAccessibilityLabel ?? countText)
            }

            if let accessorySystemName {
                DSImageView(
                    systemName: accessorySystemName,
                    size: .font(.caption1),
                    tint: .text(.caption2)
                )
            }
        }
        .dsPadding(.horizontal, DSEntityListRowLayout.horizontalPadding)
        .dsPadding(.vertical, DSEntityListRowLayout.verticalPadding)
        .dsMinHeight(DSEntityListRowLayout.minHeight)
        .dsCardStyle(padding: .space0)
        .contentShape(Rectangle())
        .onTap {
            onTap?()
        }
    }
}

public struct DSEntityInitialsCircleView: View {
    private let title: String
    private let colorSeed: String?
    private let initialsMode: DSEntityInitialsMode

    public init(
        title: String,
        colorSeed: String? = nil,
        initialsMode: DSEntityInitialsMode = .oneOrTwo
    ) {
        self.title = title
        self.colorSeed = colorSeed
        self.initialsMode = initialsMode
    }

    public var body: some View {
        ZStack {
            Circle()
                .fill(DSLetterBadgeView.generatedColor(for: colorSeed ?? title))

            DSText(Self.initials(for: title, mode: initialsMode))
                .dsTextStyle(.label, .color(.white))
                .lineLimit(1)
                .minimumScaleFactor(0.65)
        }
    }

    public static func initials(for title: String, mode: DSEntityInitialsMode) -> String {
        let words = title
            .components(separatedBy: CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters))
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { $0.isEmpty == false }

        let rawInitials: String
        if words.count >= 2 {
            rawInitials = words.prefix(2)
                .compactMap { $0.first }
                .map(String.init)
                .joined()
        } else if let firstWord = words.first {
            let prefixCount = mode == .forceTwo ? 2 : min(2, firstWord.count)
            rawInitials = String(firstWord.prefix(prefixCount))
        } else {
            rawInitials = ""
        }

        if rawInitials.count == 1, mode == .forceTwo, let firstWord = words.first {
            return String(firstWord.prefix(2)).uppercased(with: Locale(identifier: "ro_MD"))
        }

        return rawInitials.uppercased(with: Locale(identifier: "ro_MD"))
    }
}

public struct DSEntityAvatarView: View {
    private let imageURL: URL?
    private let title: String
    private let colorSeed: String?
    private let initialsMode: DSEntityInitialsMode
    private let fallbackSystemName: String?
    private let size: DSSize
    private let shape: DSEntityAvatarShape

    public init(
        imageURL: URL?,
        title: String,
        colorSeed: String? = nil,
        initialsMode: DSEntityInitialsMode = .forceTwo,
        fallbackSystemName: String? = nil,
        size: DSSize,
        shape: DSEntityAvatarShape = .none
    ) {
        self.imageURL = imageURL
        self.title = title
        self.colorSeed = colorSeed
        self.initialsMode = initialsMode
        self.fallbackSystemName = fallbackSystemName
        self.size = size
        self.shape = shape
    }

    public var body: some View {
        content
            .dsSize(size)
            .entityAvatarClip(shape)
    }

    @ViewBuilder
    private var content: some View {
        if let imageURL {
            DSImageView(
                url: imageURL,
                style: .none,
                size: size
            )
        } else {
            ZStack {
                Color.secondary.opacity(0.14)

                if let fallbackSystemName {
                    DSImageView(
                        systemName: fallbackSystemName,
                        size: .font(.headline),
                        tint: .text(.headline)
                    )
                } else {
                    DSText(DSEntityInitialsCircleView.initials(for: title, mode: initialsMode))
                        .dsTextStyle(.label, .text(.headline))
                        .lineLimit(1)
                        .minimumScaleFactor(0.65)
                }
            }
        }
    }
}

public struct DSEntityCategoryIconView: View {
    private let systemName: String
    private let iconSize: DSSize
    private let foreground: DSColorToken
    private let backgroundOpacity: Double

    public init(
        systemName: String,
        iconSize: DSSize = .size(.custom(20)),
        foreground: DSColorToken = .text(.headline),
        backgroundOpacity: Double = 0.14
    ) {
        self.systemName = systemName
        self.iconSize = iconSize
        self.foreground = foreground
        self.backgroundOpacity = backgroundOpacity
    }

    public var body: some View {
        ZStack {
            Circle()
                .fill(Color.secondary.opacity(backgroundOpacity))

            DSImageView(
                systemName: systemName,
                size: iconSize,
                tint: foreground
            )
        }
    }
}

public struct DSEntityListRowsSection<Row: Identifiable, RowContent: View>: View {
    private let rows: [Row]
    private let rowContent: (Row) -> RowContent

    public init(
        rows: [Row],
        @ViewBuilder rowContent: @escaping (Row) -> RowContent
    ) {
        self.rows = rows
        self.rowContent = rowContent
    }

    public var body: some View {
        DSSection(
            data: rows,
            id: \.id,
            content: { row, _ in
                rowContent(row)
            }
        )
        .dsSpacing(.space2)
    }
}

private extension View {
    @ViewBuilder
    func entityAvatarClip(_ shape: DSEntityAvatarShape) -> some View {
        switch shape {
        case .none:
            self
        case .circle:
            clipShape(Circle())
        case let .roundedRectangle(cornerRadius):
            clipShape(.rect(cornerRadius: cornerRadius))
        }
    }
}

struct Testable_DSEntityListRow: View {
    var body: some View {
        DSVStack(spacing: .space8) {
            DSEntityListRow(
                title: "Maia Sandu",
                subtitle: "President",
                countText: "24",
                countAccessibilityLabel: "24 mentions",
                leadingSize: DSEntityListRowLayout.peopleAvatarSize,
                accessorySystemName: "chevron.right"
            ) {
                DSEntityAvatarView(
                    imageURL: nil,
                    title: "Maia Sandu",
                    colorSeed: "Maia Sandu",
                    initialsMode: .forceTwo,
                    size: DSEntityListRowLayout.peopleAvatarSize,
                    shape: .roundedRectangle(cornerRadius: 8)
                )
            }

            DSEntityListRow(
                title: "Politics",
                subtitle: "Current affairs",
                countText: "12",
                accessorySystemName: "chevron.right"
            ) {
                DSEntityCategoryIconView(systemName: "building.columns")
            }
        }
    }
}

struct DSEntityListRow_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSEntityListRow()
            }
        }
    }
}
