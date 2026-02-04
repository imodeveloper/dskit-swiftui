//
//  DSTabPagingView.swift
//  DSKit
//
//  Created by Ivan Borinschi on 11.04.2025.
//

import SwiftUI

/// A single page in our tab paging view.
public struct DSTabPage<Content: View> {

    let content: Content
    
    /// The view shown in the indicator at the top (e.g. `DSText("Popular")`).
    var activeItem: AnyView? = nil
    var defaultItem: AnyView? = nil
    
    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    public func tabItem<Item: View>(@ViewBuilder content: (Bool) -> Item) -> Self {
        var copy = self
        copy.activeItem = AnyView(content(true))
        copy.defaultItem = AnyView(content(false))
        return copy
    }
}

/// Type‐erased version of a `DSTabPage` (so we can store them in arrays easily).
public struct AnyDSTabPage: Identifiable {
    public let id = UUID()
    public let content: AnyView
    public let activeItem: AnyView?
    public let defaultItem: AnyView?
}

/// Helper for erasing a `DSTabPage<Content>` to an `AnyDSTabPage`.
public extension DSTabPage {
    func eraseToAnyDSTabPage() -> AnyDSTabPage {
        .init(content: AnyView(content), activeItem: activeItem, defaultItem: defaultItem)
    }
}

public protocol DSTabPageConvertible {
    func asDSTabPages() -> [AnyDSTabPage]
}

extension AnyDSTabPage: DSTabPageConvertible {
    public func asDSTabPages() -> [AnyDSTabPage] { [self] }
}

public func makeDSTabPages(@DSTabPagingViewBuilder _ content: () -> [AnyDSTabPage]) -> [AnyDSTabPage] {
    content()
}


@resultBuilder
public struct DSTabPagingViewBuilder {
    
    public static func buildExpression<Content: View>(_ expression: DSTabPage<Content>) -> AnyDSTabPage {
        expression.eraseToAnyDSTabPage()
    }
    
    public static func buildBlock(_ values: DSTabPageConvertible...) -> [AnyDSTabPage] {
        values.flatMap { $0.asDSTabPages() }
    }
}

extension Array: DSTabPageConvertible where Element == AnyDSTabPage {
    public func asDSTabPages() -> [AnyDSTabPage] { self }
}

public extension DSTabPagingViewBuilder {
    static func buildIf(_ value: DSTabPageConvertible?) -> DSTabPageConvertible {
        value ?? []
    }
}

@available(iOS 17, *)
public struct DSTabPagingView: View {
    @Environment(\.appearance) private var appearance: DSAppearance
    
    private let pages: [AnyDSTabPage]
    
    @State private var offset: CGRect = .zero
    @State private var page: Int = 0
    
    public init(@DSTabPagingViewBuilder _ content: () -> [AnyDSTabPage]) {
        self.pages = content()
    }
    
    public var body: some View {
        GeometryReader { proxy in
            VStack(spacing: 0) {

                DSTabPagingIndicatorView(
                    offset: $offset,
                    page: $page,
                    pageItems: pages.compactMap { (active: $0.activeItem, default: $0.defaultItem) as? (active: AnyView, default: AnyView) },
                    screenWidth: proxy.size.width
                )
                
                DSScrollViewContentFrameReader(
                    axes: .horizontal,
                    showsIndicators: false,
                    contentFrame: $offset,
                    page: $page
                ) {
                    LazyHStack(spacing: 0) {
                        ForEach(0..<pages.count, id: \.self) { i in
                            let page = pages[i]
                            page.content
                                .frame(width: proxy.size.width)
                                .id(i)
                        }
                    }.scrollTargetLayout()
                    
                }.scrollTargetBehavior(.viewAligned)
                
            }.background(appearance.navigationBar.bar.color)
        }
    }
}

struct DSTabPagingIndicatorView: View {
    
    @Binding var offset: CGRect
    @Binding var page: Int
    
    let pageItems: [(active: AnyView, default: AnyView)]  // e.g. [DSText("Top"), DSText("Popular"), ...]
    let screenWidth: CGFloat
    
    @Environment(\.appearance) private var appearance: DSAppearance
    
    // Stores the measured frames of each item (index → CGRect).
    @State private var frames: [Int: CGRect] = [:]
    @State private var debounceWorkItem: DispatchWorkItem?
    
    var body: some View {
        let totalPages = pageItems.count
        
        let pageFraction = offset.origin.x > 0 ? 0 : -offset.origin.x / screenWidth
        let currentIndex = min(max(Int(floor(pageFraction)), 0), totalPages - 1)
        let fraction = pageFraction - floor(pageFraction)
        let nextIndex = min(currentIndex + 1, totalPages - 1)
        
        let (indicatorX, indicatorWidth) = indicatorGeometry(
            currentIndex: currentIndex,
            nextIndex: nextIndex,
            fraction: fraction
        )
        
        return VStack(spacing: 8) {

            HStack(spacing: 0) {
                Spacer()
                ForEach(0..<totalPages, id: \.self) { idx in
                    let activeItemView = pageItems[idx].active
                    let defaultItemView = pageItems[idx].default
                    defaultItemView
                        .opacity(
                            dsDefaultOpacityForIndex(
                                idx,
                                currentIndex: currentIndex,
                                fraction: fraction,
                                nextIndex: nextIndex
                            )
                        )
                        .overlay {
                            activeItemView
                                .dsAssignFrame(index: idx)
                                .opacity(
                                    dsActiveOpacityForIndex(
                                        idx,
                                        currentIndex: currentIndex,
                                        fraction: fraction,
                                        nextIndex: nextIndex
                                    )
                                )
                        }
                        .onTapGesture {
                            page = idx
                            print("tap")
                        }
                    
                    if idx < totalPages - 1 {
                        Spacer(minLength: 0)
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .coordinateSpace(name: "DSTabIndicatorSpace")
            .onPreferenceChange(DSFramePreferenceKey.self) { newValue in
                frames = newValue
            }.onChange(of: offset) { newValue in
                
                debounceWorkItem?.cancel()
                debounceWorkItem = DispatchWorkItem {
                    let currentPage = Int(round(abs(newValue.origin.x) / screenWidth))
                    if page != currentPage {
                        page = currentPage
                    }
                }
                
                if let workItem = debounceWorkItem {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: workItem)
                }
            }
            
            VStack(spacing: 0) {
                HStack {
                    Capsule()
                        .fill(appearance.primaryView.button.accentColor.color)
                        .frame(width: indicatorWidth, height: 4)
                        .offset(x: indicatorX)
                        .animation(.bouncy, value: frames.values.map { $0.width }.reduce(0, +) + CGFloat(frames.count))
                    Spacer(minLength: 0)
                }
                DSDivider()
            }
        }
    }
    
    /// Interpolates the x/width of the highlight between the “current” and “next” item frames.
    private func indicatorGeometry(
        currentIndex: Int,
        nextIndex: Int,
        fraction: CGFloat
    ) -> (CGFloat, CGFloat) {
        guard let currentFrame = frames[currentIndex],
              let nextFrame    = frames[nextIndex] else {
            // If frames not measured yet, fallback:
            let defaultWidth = screenWidth / CGFloat(pageItems.count)
            let x = CGFloat(currentIndex) * defaultWidth
            return (x, defaultWidth)
        }
        
        // Interpolate X:
        let xDiff = nextFrame.minX - currentFrame.minX
        let x = currentFrame.minX + xDiff * fraction
        // Interpolate width:
        let wDiff = nextFrame.width - currentFrame.width
        let w = currentFrame.width + wDiff * fraction
        return (x, w)
    }
    
    private func dsActiveOpacityForIndex(
        _ index: Int,
        currentIndex: Int,
        fraction: CGFloat,
        nextIndex: Int
    ) -> Double {
        if index == currentIndex {
            return Double(1.0 - fraction)
        } else if index == nextIndex {
            return Double(fraction)
        } else {
            return 0.0
        }
    }
    
    private func dsDefaultOpacityForIndex(
        _ index: Int,
        currentIndex: Int,
        fraction: CGFloat,
        nextIndex: Int
    ) -> Double {
        if index == currentIndex {
            return Double(fraction)
        } else if index == nextIndex {
            return Double(1.0 - fraction)
        } else {
            return 1.0
        }
    }
}

fileprivate struct DSFramePreferenceKey: PreferenceKey {
    static let defaultValue: [Int: CGRect] = [:]
    static func reduce(value: inout [Int: CGRect], nextValue: () -> [Int: CGRect]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

extension View {
    func dsAssignFrame(index: Int) -> some View {
        background(
            GeometryReader { proxy in
                Color.clear.preference(
                    key: DSFramePreferenceKey.self,
                    value: [index: proxy.frame(in: .named("DSTabIndicatorSpace"))]
                )
            }
        )
    }
}


@available(iOS 17, *)
struct Testable_DSTabPagingView: View {
    
    @State private var scrollContentFrame: CGRect = .zero
    
    @State var firstLastPage: Bool = true
    @State var showSecondPage: Bool = true
    @State var showLastPage: Bool = true
    
    @State var showIndicator: Bool = true
    
    var body: some View {
        
        DSVStack {
            DSTabPagingView {
                
                if firstLastPage {
                    DSTabPage {
                        Color.red
                    }.tabItem { isCurrent in
                        DSHStack {
                            DSText("First")
                                .dsTextStyle(.headline, isCurrent ? .text(.headline) : .text(.callout))
                            if showIndicator {
                                Color.red
                                    .frame(width: 10, height: 10)
                            }
                        }
                    }
                }
                
                if showSecondPage {
                    DSTabPage {
                        Color.green
                    }.tabItem { isCurrent in
                        DSText("Second")
                            .dsTextStyle(.headline, isCurrent ? .text(.headline) : .text(.callout))
                    }
                }
                
                if showLastPage {
                    DSTabPage {
                        Color.blue
                    }.tabItem { isCurrent in
                        DSText("Third")
                            .dsTextStyle(.headline, isCurrent ? .text(.headline) : .text(.callout))
                    }
                }
            }
            
            DSHStack {
                
                DSButton(title: "Toggle first") {
                    withAnimation {
                        firstLastPage.toggle()
                    }
                }
                
                DSButton(title: "Toggle second") {
                    withAnimation {
                        showSecondPage.toggle()
                    }
                }
                
                DSButton(title: "Toggle third") {
                    withAnimation {
                        showLastPage.toggle()
                    }
                }
                
            }.dsPadding(.horizontal)
            
            DSHStack {
                
                DSButton(title: "Toggle show indicator") {
                    withAnimation {
                        showIndicator.toggle()
                    }
                }
                
            }.dsPadding(.horizontal)
            
        }.dsPadding(.vertical)
    }
}

@available(iOS 17, *)
struct DSTabPagingView_Previews: PreviewProvider {
    static var previews: some View {
        Testable_DSTabPagingView()
    }
}
