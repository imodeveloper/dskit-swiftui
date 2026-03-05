//
//  DSThread.swift
//  DSKitExplorer
//
//  Created by Ivan Borinschi on 18.03.2025.
//

import SwiftUI

public enum DSThreadPosition {
    case top
    case bottom
    case middle
}

extension EnvironmentValues {
    var showFooterThreadLine: Bool {
        get { self[ShowDSThreadFooterThreadLine.self] }
        set { self[ShowDSThreadFooterThreadLine.self] = newValue }
    }
}

private struct ShowDSThreadFooterThreadLine: EnvironmentKey {
    static let defaultValue: Bool = true
}

public struct DSThread<Data, ID, Content, Header, Footer>: View where Data: RandomAccessCollection, ID: Hashable, Content: View, Header: View, Footer: View {

    @Environment(\.appearance) var appearance: DSAppearance
    @Environment(\.viewStyle) var viewStyle: DSViewStyle
    @Environment(\.showFooterThreadLine) var showFooterThreadLine

    let headerSpacing: DSSpace
    let threadContentSpacing: CGFloat
    let threadLeftPadding: CGFloat
    let data: Data
    let content: (Data.Element, DSThreadPosition) -> Content
    let header: (Data.Element, DSThreadPosition) -> Header
    let footer: () -> Footer
    let id: KeyPath<Data.Element, ID>

    public init(
        headerSpacing: DSSpace = .regular,
        threadContentSpacing: CGFloat = 10,
        threadLeftPadding: CGFloat = 10,
        showThreadToFooter: Bool = false,
        data: Data,
        id: KeyPath<Data.Element, ID>,
        @ViewBuilder header: @escaping (Data.Element, DSThreadPosition) -> Header,
        @ViewBuilder content: @escaping (Data.Element, DSThreadPosition) -> Content,
        @ViewBuilder footer: @escaping () -> Footer
    ) {
        self.data = data
        self.headerSpacing = headerSpacing
        self.threadContentSpacing = threadContentSpacing
        self.threadLeftPadding = threadLeftPadding
        self.id = id
        self.content = content
        self.header = header
        self.footer = footer
    }

    public var body: some View {
        threadView.dsDebuggable(debugColor: Color.yellow)
    }

    private func positionFor(
        elementID: ID,
        firstID: ID?,
        lastID: ID?
    ) -> DSThreadPosition {
        if elementID == firstID {
            return .top
        } else if elementID == lastID {
            return .bottom
        }
        return .middle
    }

    var threadView: some View {
        let firstID = data.first.map { $0[keyPath: id] }
        let lastID = data.last.map { $0[keyPath: id] }
        let headerVerticalPadding = appearance.spacing.value(for: headerSpacing)

        return DSVStack(spacing: .zero) {

            ForEach(data, id: id) { element in
                let elementID = element[keyPath: id]
                let position = positionFor(
                    elementID: elementID,
                    firstID: firstID,
                    lastID: lastID
                )
                let showsThreadLineToFooter = showFooterThreadLine || elementID != lastID

                DSVStack(spacing: .zero) {

                    self.header(element, position)
                        .dsPadding(.vertical, .custom(headerVerticalPadding))
                        .zIndex(1)

                    self.content(element, position)
                        .padding(.leading, threadLeftPadding + threadContentSpacing)
                        .overlay(alignment: .leading) {
                            appearance.color(for: .text(.headline), viewStyle: viewStyle)
                                .frame(width: 2)
                                .frame(maxHeight: .infinity)
                                .padding(.vertical, -headerVerticalPadding)
                                .zIndex(0)
                                .opacity(showsThreadLineToFooter ? 0.1 : 0)
                                .padding(.leading, threadLeftPadding)
                        }
                }
            }

            footer()

        }
    }
}

struct ThreadItem<T: Hashable>: Hashable {
    let item: T
}

struct SomeColor: Hashable {
    let title: String
    let color: Color
}

struct Testable_DSThread: View {

    let colors: [ThreadItem] = [
        ThreadItem(item: SomeColor(title: "red", color: Color.red)),
        ThreadItem(item: SomeColor(title: "green", color: Color.green)),
        ThreadItem(item: SomeColor(title: "yellow", color: Color.yellow)),
        ThreadItem(item: SomeColor(title: "purple", color: Color.purple))
    ]

    var body: some View {
        ScrollView {
            DSThread(
                data: colors,
                id: \.self,
                header: { threadItem, _ in
                    DSHStack {
                        Circle()
                            .fill(threadItem.item.color)
                            .frame(width: 24, height: 24)

                        Text(threadItem.item.title)
                    }
                }, content: { threadItem, _ in
                    threadItem.item.color
                        .frame(height: 100)
                }, footer: {
                    Color.red.frame(height: 100)
                }
            ).environment(\.showFooterThreadLine, true)
        }
    }
}

struct DSThread_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSThread()
            }
        }
    }
}
