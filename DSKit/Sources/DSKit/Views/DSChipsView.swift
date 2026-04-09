//
//  DSChipsView.swift
//  DSKit
//
//  Created by Ivan Borinschi on 22.03.2026.
//

import SwiftUI

/*
## DSChipsView

`DSChipsView` is a reusable DSKit layout container for chip and tag collections. It lays out child views horizontally and wraps items onto the next line based on each item's intrinsic width.

#### Initialization:
Initializes `DSChipsView` with data, identity, spacing, and a content builder.
- Parameters:
- `data`: The collection of items to render.
- `id`: A key path to a stable identifier for each element.
- `horizontalSpacing`: Horizontal spacing between chips.
- `verticalSpacing`: Vertical spacing between wrapped rows.
- `content`: A closure that returns the chip content for each element.

#### Usage:
`DSChipsView` is intentionally layout-only. It does not impose visual styling, selection behavior, or tap handling, so callers can render chips, filters, or tags with the appearance they need while reusing a single wrapping layout.
*/

public struct DSChipsView<Data, ID, Content>: View where Data: RandomAccessCollection, ID: Hashable, Content: View {

    @Environment(\.appearance) private var appearance: DSAppearance

    private let data: Data
    private let id: KeyPath<Data.Element, ID>
    private let horizontalSpacing: DSSpatialToken
    private let verticalSpacing: DSSpatialToken
    private let content: (Data.Element) -> Content

    public init(
        data: Data,
        id: KeyPath<Data.Element, ID>,
        horizontalSpacing: DSSpatialToken = .space8,
        verticalSpacing: DSSpatialToken = .space8,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.id = id
        self.horizontalSpacing = horizontalSpacing
        self.verticalSpacing = verticalSpacing
        self.content = content
    }

    public var body: some View {
        _DSChipsFlowLayout(
            horizontalSpacing: appearance.spacing.value(for: horizontalSpacing),
            verticalSpacing: appearance.spacing.value(for: verticalSpacing)
        ) {
            ForEach(data, id: id) { item in
                content(item)
            }
        }
    }
}

private struct _DSChipsFlowLayout: Layout {
    let horizontalSpacing: CGFloat
    let verticalSpacing: CGFloat

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache _: inout ()) -> CGSize {
        layoutFrames(in: proposal.width ?? .infinity, subviews: subviews).size
    }

    func placeSubviews(in bounds: CGRect, proposal _: ProposedViewSize, subviews: Subviews, cache _: inout ()) {
        let layout = layoutFrames(in: bounds.width, subviews: subviews)
        for (index, frame) in layout.frames.enumerated() {
            subviews[index].place(
                at: CGPoint(x: bounds.minX + frame.minX, y: bounds.minY + frame.minY),
                proposal: ProposedViewSize(width: frame.width, height: frame.height)
            )
        }
    }

    private func layoutFrames(in maxWidth: CGFloat, subviews: Subviews) -> (frames: [CGRect], size: CGSize) {
        var frames: [CGRect] = []
        frames.reserveCapacity(subviews.count)

        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        var contentWidth: CGFloat = 0
        let availableWidth = maxWidth.isFinite ? maxWidth : .greatestFiniteMagnitude

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x > 0, x + size.width > availableWidth {
                contentWidth = max(contentWidth, x - horizontalSpacing)
                x = 0
                y += rowHeight + verticalSpacing
                rowHeight = 0
            }

            let frame = CGRect(origin: CGPoint(x: x, y: y), size: size)
            frames.append(frame)
            x += size.width + horizontalSpacing
            rowHeight = max(rowHeight, size.height)
        }

        contentWidth = max(contentWidth, max(0, x - horizontalSpacing))
        let contentHeight = subviews.isEmpty ? 0 : y + rowHeight
        return (frames, CGSize(width: contentWidth, height: contentHeight))
    }
}

struct Testable_DSChipsView: View {
    let values: [DSChipsPreviewChip] = [
        .init(id: "swift", title: "Swift", style: .secondary),
        .init(id: "design-system", title: "Design System", style: .primary),
        .init(id: "swiftui", title: "SwiftUI", style: .secondary),
        .init(id: "ios", title: "iOS", style: .secondary),
        .init(id: "monitor", title: "Monitor", style: .primary),
        .init(id: "dskit", title: "DSKit", style: .secondary),
        .init(id: "components", title: "Components", style: .primary),
        .init(id: "layout", title: "Layout Only", style: .secondary)
    ]

    var body: some View {
        DSVStack {
            DSChipsView(data: values, id: \.id) { item in
                DSChipsPreviewTag(title: item.title, style: item.style)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .dsPadding()
    }
}

struct DSChipsPreviewChip: Identifiable {
    let id: String
    let title: String
    let style: DSSurfaceStyle
}

private struct DSChipsPreviewTag: View {
    let title: String
    let style: DSSurfaceStyle

    var body: some View {
        DSText(title)
            .dsCardStyle(padding: .space8)
    }
}

struct DSChipsView_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSChipsView()
            }
        }
    }
}
