//
//  DSListSeparatorView.swift
//  DSKit
//
//  Created by Ivan Borinschi on 07.04.2026.
//

import SwiftUI

/*
## DSListSeparatorView

`DSListSeparatorView` is a reusable DSKit list separator that supports both compact bar separators and titled section-break separators.

#### Initialization:
Use the default initializer for the common cases:
- `DSListSeparatorView()` renders a compact bar separator.
- `DSListSeparatorView(title: "Today")` renders a titled separator.

For more control you can customize:
- `style`: `.bar` or `.title`
- `height`
- `horizontalBleed` (defaults to the current DSKit content margin)
- `backgroundStyle`
- `textStyle`
- `textColor`

#### Usage:
`DSListSeparatorView` is intended for custom list separators inserted through `DSSection(data:id:content:separator:)` or `dsListRowSeparator(...)` when the default line divider is not enough.
*/

public struct DSListSeparatorView: View, DSDesignable {
    public enum Style: Equatable, Sendable {
        case bar
        case title
    }

    public let title: String?
    public let style: Style
    public let height: CGFloat
    public let horizontalBleed: CGFloat?
    public let backgroundStyle: DSSurfaceStyle
    public let textStyle: DSTypographyToken
    public let textColor: DSColorToken

    @Environment(\.appearance) public var appearance: DSAppearance
    @Environment(\.surfaceStyle) public var surfaceStyle: DSSurfaceStyle
    @Environment(\.dsContentMarginKey) private var contentMargin: CGFloat

    public init(
        title: String? = nil,
        style: Style? = nil,
        height: CGFloat? = nil,
        horizontalBleed: CGFloat? = nil,
        backgroundStyle: DSSurfaceStyle = .surface,
        textStyle: DSTypographyToken = .label,
        textColor: DSColorToken = .text(.secondary)
    ) {
        let resolvedStyle = style ?? (title == nil ? .bar : .title)

        self.title = title
        self.style = resolvedStyle
        self.height = height ?? Self.defaultHeight(for: resolvedStyle)
        self.horizontalBleed = horizontalBleed
        self.backgroundStyle = backgroundStyle
        self.textStyle = textStyle
        self.textColor = textColor
    }

    public var body: some View {
        switch style {
        case .bar:
            appearance.color(for: .background(backgroundStyle.backgroundToken), surfaceStyle: surfaceStyle)
                .frame(height: height)
                .padding(.horizontal, -resolvedHorizontalBleed)
        case .title:
            DSVStack {
                if let title, title.isEmpty == false {
                    DSText(title)
                        .dsTextStyle(textStyle, textColor)
                        .dsMaxWidthCentered()
                }
            }
            .frame(height: height)
            .dsBackground(backgroundStyle)
            .padding(.horizontal, -resolvedHorizontalBleed)
        }
    }

    private var resolvedHorizontalBleed: CGFloat {
        horizontalBleed ?? (contentMargin == .zero ? appearance.screenMargins : contentMargin)
    }

    private static func defaultHeight(for style: Style) -> CGFloat {
        switch style {
        case .bar:
            return 5
        case .title:
            return 40
        }
    }
}

struct Testable_DSListSeparatorView: View {
    var body: some View {
        DSList {
            DSSection {
                DSText("Top item")
                    .dsTextStyle(.headline)
            }

            DSSection {
                DSListSeparatorView()
                DSListSeparatorView(title: "Today")
                DSListSeparatorView(
                    title: "Custom",
                    height: 48,
                    horizontalBleed: 24,
                    backgroundStyle: .canvas,
                    textStyle: .headline,
                    textColor: .text(.primary)
                )
            }
        }
    }
}

struct DSListSeparatorView_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSListSeparatorView()
            }
        }
    }
}
