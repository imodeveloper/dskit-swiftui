//
//  DSSection.swift
//  DSKit
//
//  Created by Ivan Borinschi on 02.01.2025.
//

import SwiftUI

public struct DSSectionSpacingKey: EnvironmentKey {
    public static let defaultValue: DSSpatialToken? = nil
}

public extension EnvironmentValues {
    var dsSectionSpacingKey: DSSpatialToken? {
        get { self[DSSectionSpacingKey.self] }
        set { self[DSSectionSpacingKey.self] = newValue }
    }
}

/*
## DSSection

`DSSection` wraps SwiftUI's `Section` and applies DSKit list styling, background, and content margins.

Use the plain initializer for arbitrary section content:
- `DSSection(content:)`
- Override row spacing for a subtree with `.dsSpacing(...)`

Use the data-driven initializers when the section renders repeated list rows and DSKit should own
row position and separator boilerplate:
- `DSSection(data:id:content:)`
- `DSSection(data:id:nativeSeparator:content:)`
- `DSSection(data:id:content:separator:)`

When section content contains many vertical rows, emit the `ForEach` rows directly instead of
wrapping the whole set in `VStack` or `LazyVStack`, or SwiftUI may collapse them into one large
list cell.
*/

public enum DSSectionRowPosition: Hashable, Sendable {
    case single
    case first
    case middle
    case last
}

public struct DSSectionNativeSeparator {
    public let visibility: Visibility
    public let edges: VerticalEdge.Set

    public init(
        _ visibility: Visibility = .visible,
        edges: VerticalEdge.Set = .bottom
    ) {
        self.visibility = visibility
        self.edges = edges
    }

    public static var visible: Self {
        Self(.visible, edges: .bottom)
    }

    public static var hidden: Self {
        Self(.hidden, edges: .bottom)
    }
}

public struct DSSectionSeparatorContext<Item> {
    public let item: Item
    public let index: Int
    public let count: Int
    public let position: DSSectionRowPosition

    public var isFirst: Bool {
        index == 0
    }

    public var isLast: Bool {
        index == count - 1
    }

    init(
        item: Item,
        index: Int,
        count: Int,
        position: DSSectionRowPosition
    ) {
        self.item = item
        self.index = index
        self.count = count
        self.position = position
    }
}

public enum DSSectionCustomSeparator<Top: View, Between: View, Bottom: View> {
    case none
    case top(Top)
    case between(Between)
    case bottom(Bottom)
    case topBetween(top: Top, between: Between)
    case topBottom(top: Top, bottom: Bottom)
    case betweenBottom(between: Between, bottom: Bottom)
    case topBetweenBottom(top: Top, between: Between, bottom: Bottom)
}

public extension DSSectionCustomSeparator {
    static func top<Separator: View>(
        @ViewBuilder _ top: () -> Separator
    ) -> DSSectionCustomSeparator<Separator, EmptyView, EmptyView> {
        .top(top())
    }

    static func between<Separator: View>(
        @ViewBuilder _ between: () -> Separator
    ) -> DSSectionCustomSeparator<EmptyView, Separator, EmptyView> {
        .between(between())
    }

    static func bottom<Separator: View>(
        @ViewBuilder _ bottom: () -> Separator
    ) -> DSSectionCustomSeparator<EmptyView, EmptyView, Separator> {
        .bottom(bottom())
    }

    static func top<TopSeparator: View, BetweenSeparator: View>(
        @ViewBuilder _ top: () -> TopSeparator,
        @ViewBuilder between: () -> BetweenSeparator
    ) -> DSSectionCustomSeparator<TopSeparator, BetweenSeparator, EmptyView> {
        .topBetween(top: top(), between: between())
    }

    static func top<TopSeparator: View, BottomSeparator: View>(
        @ViewBuilder _ top: () -> TopSeparator,
        @ViewBuilder bottom: () -> BottomSeparator
    ) -> DSSectionCustomSeparator<TopSeparator, EmptyView, BottomSeparator> {
        .topBottom(top: top(), bottom: bottom())
    }

    static func between<BetweenSeparator: View, BottomSeparator: View>(
        @ViewBuilder _ between: () -> BetweenSeparator,
        @ViewBuilder bottom: () -> BottomSeparator
    ) -> DSSectionCustomSeparator<EmptyView, BetweenSeparator, BottomSeparator> {
        .betweenBottom(between: between(), bottom: bottom())
    }

    static func top<TopSeparator: View, BetweenSeparator: View, BottomSeparator: View>(
        @ViewBuilder _ top: () -> TopSeparator,
        @ViewBuilder between: () -> BetweenSeparator,
        @ViewBuilder bottom: () -> BottomSeparator
    ) -> DSSectionCustomSeparator<TopSeparator, BetweenSeparator, BottomSeparator> {
        .topBetweenBottom(top: top(), between: between(), bottom: bottom())
    }
}

private enum DSSectionSeparatorMode<Data: RandomAccessCollection, TopSeparator: View, BetweenSeparator: View, BottomSeparator: View> {
    case hidden
    case native(DSSectionNativeSeparator)
    case custom((DSSectionSeparatorContext<Data.Element>) -> DSSectionCustomSeparator<TopSeparator, BetweenSeparator, BottomSeparator>)
}

public struct DSSectionRows<Data, ID, RowContent, TopSeparator, BetweenSeparator, BottomSeparator>: View
where Data: RandomAccessCollection, ID: Hashable, RowContent: View, TopSeparator: View, BetweenSeparator: View, BottomSeparator: View {
    fileprivate struct IndexedRow: Identifiable {
        let index: Int
        let element: Data.Element
        let rowID: ID

        var id: ID {
            rowID
        }
    }

    @Environment(\.appearance) private var appearance
    @Environment(\.surfaceStyle) private var viewStyle
    @Environment(\.dsContentMarginKey) private var contentMargin
    @Environment(\.dsSectionSpacingKey) private var inheritedSpacing

    fileprivate let data: Data
    fileprivate let id: KeyPath<Data.Element, ID>
    fileprivate let separatorMode: DSSectionSeparatorMode<Data, TopSeparator, BetweenSeparator, BottomSeparator>
    fileprivate let content: (Data.Element, DSSectionRowPosition) -> RowContent

    fileprivate init(
        data: Data,
        id: KeyPath<Data.Element, ID>,
        separatorMode: DSSectionSeparatorMode<Data, TopSeparator, BetweenSeparator, BottomSeparator>,
        content: @escaping (Data.Element, DSSectionRowPosition) -> RowContent
    ) {
        self.data = data
        self.id = id
        self.separatorMode = separatorMode
        self.content = content
    }

    public var body: some View {
        let items = Array(data)
        let indexedRows = items.enumerated().map { item in
            IndexedRow(
                index: item.offset,
                element: item.element,
                rowID: item.element[keyPath: id]
            )
        }

        ForEach(indexedRows) { item in
            let context = makeSeparatorContext(
                item: item.element,
                index: item.index,
                count: items.count
            )

            styledRow(
                applyingSeparator(
                    to: content(item.element, context.position),
                    with: context
                )
            )
        }
    }

    private var resolvedSpacing: DSSpatialToken {
        inheritedSpacing ?? .space8
    }

    private var allSeparatorEdges: VerticalEdge.Set {
        [.top, .bottom]
    }

    private func makeSeparatorContext(
        item: Data.Element,
        index: Int,
        count: Int
    ) -> DSSectionSeparatorContext<Data.Element> {
        DSSectionSeparatorContext(
            item: item,
            index: index,
            count: count,
            position: rowPosition(for: index, count: count)
        )
    }

    private func rowPosition(for index: Int, count: Int) -> DSSectionRowPosition {
        if count <= 1 {
            return .single
        }
        if index == 0 {
            return .first
        }
        if index == count - 1 {
            return .last
        }
        return .middle
    }

    @ViewBuilder
    private func applyingSeparator(
        to row: RowContent,
        with context: DSSectionSeparatorContext<Data.Element>
    ) -> some View {
        switch separatorMode {
        case .hidden:
            row
                .dsNativeListRowSeparator(.hidden, edges: allSeparatorEdges)
        case let .native(separator):
            applyNativeSeparator(
                separator,
                to: row,
                isLastRow: context.isLast
            )
        case let .custom(separatorBuilder):
            applyCustomSeparator(
                separatorBuilder(context),
                to: row,
                context: context
            )
        }
    }

    @ViewBuilder
    private func applyNativeSeparator<Content: View>(
        _ separator: DSSectionNativeSeparator,
        to row: Content,
        isLastRow: Bool
    ) -> some View {
        switch separator.visibility {
        case .hidden:
            row
                .dsNativeListRowSeparator(.hidden, edges: allSeparatorEdges)
        case .visible, .automatic:
            let edgesToShow = visibleEdges(
                from: separator.edges,
                isLastRow: isLastRow
            )

            applyDividerSeparators(
                to: row
                    .dsNativeListRowSeparator(.hidden, edges: allSeparatorEdges),
                edges: edgesToShow,
                spacing: resolvedSpacing
            )
        @unknown default:
            row
        }
    }

    private func visibleEdges(
        from edges: VerticalEdge.Set,
        isLastRow: Bool
    ) -> VerticalEdge.Set {
        var visibleEdges = edges

        if isLastRow {
            visibleEdges.remove(.bottom)
        }

        return visibleEdges
    }

    @ViewBuilder
    private func applyCustomSeparator<Content: View>(
        _ separator: DSSectionCustomSeparator<TopSeparator, BetweenSeparator, BottomSeparator>,
        to row: Content,
        context: DSSectionSeparatorContext<Data.Element>
    ) -> some View {
        let rowWithoutNativeSeparators = row
            .dsNativeListRowSeparator(.hidden, edges: allSeparatorEdges)

        switch separator {
        case .none:
            rowWithoutNativeSeparators
        case let .top(topContent):
            applyTopSeparator(
                topContent,
                to: rowWithoutNativeSeparators,
                context: context
            )
        case let .between(betweenContent):
            applyBetweenSeparator(
                betweenContent,
                to: rowWithoutNativeSeparators,
                context: context
            )
        case let .bottom(bottomContent):
            applyBottomSeparator(
                bottomContent,
                to: rowWithoutNativeSeparators,
                context: context
            )
        case let .topBetween(topContent, betweenContent):
            applyBetweenSeparator(
                betweenContent,
                to: applyTopSeparator(
                    topContent,
                    to: rowWithoutNativeSeparators,
                    context: context
                ),
                context: context
            )
        case let .topBottom(topContent, bottomContent):
            applyBottomSeparator(
                bottomContent,
                to: applyTopSeparator(
                    topContent,
                    to: rowWithoutNativeSeparators,
                    context: context
                ),
                context: context
            )
        case let .betweenBottom(betweenContent, bottomContent):
            applyBottomSeparator(
                bottomContent,
                to: applyBetweenSeparator(
                    betweenContent,
                    to: rowWithoutNativeSeparators,
                    context: context
                ),
                context: context
            )
        case let .topBetweenBottom(topContent, betweenContent, bottomContent):
            applyBottomSeparator(
                bottomContent,
                to: applyBetweenSeparator(
                    betweenContent,
                    to: applyTopSeparator(
                        topContent,
                        to: rowWithoutNativeSeparators,
                        context: context
                    ),
                    context: context
                ),
                context: context
            )
        }
    }

    @ViewBuilder
    private func applyTopSeparator<Content: View, Separator: View>(
        _ separator: Separator,
        to row: Content,
        context: DSSectionSeparatorContext<Data.Element>
    ) -> some View {
        if context.isFirst {
            row.dsListRowSeparator(.before, spacing: resolvedSpacing) {
                separator
            }
        } else {
            row
        }
    }

    @ViewBuilder
    private func applyBetweenSeparator<Content: View, Separator: View>(
        _ separator: Separator,
        to row: Content,
        context: DSSectionSeparatorContext<Data.Element>
    ) -> some View {
        if context.isLast == false {
            row.dsListRowSeparator(.after, spacing: resolvedSpacing) {
                separator
            }
        } else {
            row
        }
    }

    @ViewBuilder
    private func applyBottomSeparator<Content: View, Separator: View>(
        _ separator: Separator,
        to row: Content,
        context: DSSectionSeparatorContext<Data.Element>
    ) -> some View {
        if context.isLast {
            row.dsListRowSeparator(.after, spacing: resolvedSpacing) {
                separator
            }
        } else {
            row
        }
    }

    private func applyDividerSeparators<Content: View>(
        to row: Content,
        edges: VerticalEdge.Set,
        spacing: DSSpatialToken
    ) -> some View {
        applyDividerBottomIfNeeded(
            to: applyDividerTopIfNeeded(
                to: row,
                edges: edges,
                spacing: spacing
            ),
            edges: edges,
            spacing: spacing
        )
    }

    @ViewBuilder
    private func applyDividerTopIfNeeded<Content: View>(
        to row: Content,
        edges: VerticalEdge.Set,
        spacing: DSSpatialToken
    ) -> some View {
        if edges.contains(.top) {
            row.dsListRowSeparator(.before, spacing: spacing) {
                DSDivider()
            }
        } else {
            row
        }
    }

    @ViewBuilder
    private func applyDividerBottomIfNeeded<Content: View>(
        to row: Content,
        edges: VerticalEdge.Set,
        spacing: DSSpatialToken
    ) -> some View {
        if edges.contains(.bottom) {
            row.dsListRowSeparator(.after, spacing: spacing) {
                DSDivider()
            }
        } else {
            row
        }
    }

    private func styledRow<Content: View>(_ row: Content) -> some View {
        row
            .listRowInsets(
                EdgeInsets(
                    top: 0,
                    leading: contentMargin,
                    bottom: appearance.spacing.value(for: resolvedSpacing),
                    trailing: contentMargin
                )
            )
            .listRowBackground(appearance.color(for: .background(viewStyle.backgroundToken), surfaceStyle: viewStyle))
    }
}

public struct DSSection<Content: View>: View {
    @Environment(\.appearance) private var appearance: DSAppearance
    @Environment(\.surfaceStyle) private var viewStyle: DSSurfaceStyle
    @Environment(\.dsContentMarginKey) private var contentMargin: CGFloat
    @Environment(\.dsSectionSpacingKey) private var inheritedSpacing

    let plainRowSeparatorVisibility: Visibility?
    let contentOwnsRowStyle: Bool
    let content: () -> Content

    public init(
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(
            plainRowSeparatorVisibility: .hidden,
            contentOwnsRowStyle: false,
            content: content
        )
    }

    public init(
        hidesRowSeparators: Bool,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(
            plainRowSeparatorVisibility: hidesRowSeparators ? .hidden : nil,
            contentOwnsRowStyle: false,
            content: content
        )
    }

    init(
        plainRowSeparatorVisibility: Visibility?,
        contentOwnsRowStyle: Bool,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.plainRowSeparatorVisibility = plainRowSeparatorVisibility
        self.contentOwnsRowStyle = contentOwnsRowStyle
        self.content = content
    }

    public var body: some View {
        Section {
            if contentOwnsRowStyle {
                content()
            } else {
                styledPlainContent(content())
            }
        }
        .background(appearance.color(for: .background(viewStyle.backgroundToken), surfaceStyle: viewStyle))
        .listSectionSeparator(.hidden)
        .environment(\.dsScreenMarginsAlreadyApplied, true)
    }

    private var resolvedSpacing: DSSpatialToken {
        inheritedSpacing ?? .space8
    }

    private func styledPlainContent<SectionContent: View>(_ sectionContent: SectionContent) -> some View {
        sectionContent
            .modifier(DSSectionRowSeparatorVisibilityModifier(visibility: plainRowSeparatorVisibility))
            .listRowInsets(
                EdgeInsets(
                    top: 0,
                    leading: contentMargin,
                    bottom: appearance.spacing.value(for: resolvedSpacing),
                    trailing: contentMargin
                )
            )
            .listRowBackground(appearance.color(for: .background(viewStyle.backgroundToken), surfaceStyle: viewStyle))
    }
}

public extension DSSection {
    init<Data, ID, RowContent, SeparatorContent>(
        data: Data,
        id: KeyPath<Data.Element, ID>,
        @ViewBuilder content: @escaping (Data.Element, DSSectionRowPosition) -> RowContent,
        separator: @escaping (DSSectionSeparatorContext<Data.Element>) -> SeparatorContent
    ) where Content == DSSectionRows<Data, ID, RowContent, EmptyView, SeparatorContent, EmptyView>, Data: RandomAccessCollection, ID: Hashable, RowContent: View, SeparatorContent: View {
        self.init(
            plainRowSeparatorVisibility: nil,
            contentOwnsRowStyle: true
        ) {
            DSSectionRows(
                data: data,
                id: id,
                separatorMode: DSSectionSeparatorMode<Data, EmptyView, SeparatorContent, EmptyView>.custom { context in
                    DSSectionCustomSeparator<EmptyView, SeparatorContent, EmptyView>.between {
                        separator(context)
                    }
                },
                content: content
            )
        }
    }

    init<Data, ID, RowContent>(
        data: Data,
        id: KeyPath<Data.Element, ID>,
        @ViewBuilder content: @escaping (Data.Element, DSSectionRowPosition) -> RowContent
    ) where Content == DSSectionRows<Data, ID, RowContent, EmptyView, EmptyView, EmptyView>, Data: RandomAccessCollection, ID: Hashable, RowContent: View {
        self.init(
            plainRowSeparatorVisibility: nil,
            contentOwnsRowStyle: true
        ) {
            DSSectionRows(
                data: data,
                id: id,
                separatorMode: DSSectionSeparatorMode<Data, EmptyView, EmptyView, EmptyView>.hidden,
                content: content
            )
        }
    }

    init<Data, ID, RowContent>(
        data: Data,
        id: KeyPath<Data.Element, ID>,
        nativeSeparator: DSSectionNativeSeparator = .visible,
        @ViewBuilder content: @escaping (Data.Element, DSSectionRowPosition) -> RowContent
    ) where Content == DSSectionRows<Data, ID, RowContent, EmptyView, EmptyView, EmptyView>, Data: RandomAccessCollection, ID: Hashable, RowContent: View {
        self.init(
            plainRowSeparatorVisibility: nil,
            contentOwnsRowStyle: true
        ) {
            DSSectionRows(
                data: data,
                id: id,
                separatorMode: DSSectionSeparatorMode<Data, EmptyView, EmptyView, EmptyView>.native(nativeSeparator),
                content: content
            )
        }
    }

    init<Data, ID, RowContent, TopSeparator, BetweenSeparator, BottomSeparator>(
        data: Data,
        id: KeyPath<Data.Element, ID>,
        @ViewBuilder content: @escaping (Data.Element, DSSectionRowPosition) -> RowContent,
        separator: @escaping (DSSectionSeparatorContext<Data.Element>) -> DSSectionCustomSeparator<TopSeparator, BetweenSeparator, BottomSeparator>
    ) where Content == DSSectionRows<Data, ID, RowContent, TopSeparator, BetweenSeparator, BottomSeparator>, Data: RandomAccessCollection, ID: Hashable, RowContent: View, TopSeparator: View, BetweenSeparator: View, BottomSeparator: View {
        self.init(
            plainRowSeparatorVisibility: nil,
            contentOwnsRowStyle: true
        ) {
            DSSectionRows(
                data: data,
                id: id,
                separatorMode: .custom(separator),
                content: content
            )
        }
    }
}

public extension View {
    func dsSpacing(_ spacing: DSSpatialToken) -> some View {
        environment(\.dsSectionSpacingKey, spacing)
    }
}

private struct DSSectionRowSeparatorVisibilityModifier: ViewModifier {
    let visibility: Visibility?

    func body(content: Content) -> some View {
        if let visibility {
            content.listRowSeparator(visibility)
        } else {
            content
        }
    }
}

struct Testable_DSSection: View {
    private let colors: [DSSectionPreviewColor] = [
        DSSectionPreviewColor(title: "red", color: .red),
        DSSectionPreviewColor(title: "green", color: .green),
        DSSectionPreviewColor(title: "yellow", color: .yellow),
        DSSectionPreviewColor(title: "purple", color: .purple)
    ]

    var body: some View {
        DSList(spacing: .custom(12)) {
            DSSection {
                DSVStack(spacing: .space4) {
                    DSText("Section Title").dsTextStyle(.headline)
                    DSText("Section body text").dsTextStyle(.caption2)
                }
            }

            DSSection(
                data: colors,
                id: \.title,
                nativeSeparator: .visible
            ) { item, position in
                DSHStack {
                    Circle()
                        .fill(item.color)
                        .frame(width: 16, height: 16)

                    DSText("\(item.title) · \(String(describing: position))")
                        .dsTextStyle(.headline)
                }
            }

            DSSection(
                data: colors,
                id: \.title,
                content: { item, _ in
                    DSText(item.title)
                        .dsTextStyle(.headline)
                },
                separator: { _ in
                    DSDivider(style: .dots())
                }
            )
            .dsSpacing(.space4)
        }
    }
}

struct DSSectionPreviewColor: Hashable {
    let title: String
    let color: Color
}

struct DSSection_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSSection()
            }
        }
    }
}
