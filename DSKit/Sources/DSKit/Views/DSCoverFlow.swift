//
//  DSCoverFlow.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import SwiftUI

/*
## DSCoverFlow

`DSCoverFlow` is a SwiftUI component that creates a customizable, paginated scroll view. It is designed to display a sequence of views, such as images or cards, in a horizontal scrollable layout. This component is useful for creating cover flow or carousel-like interfaces.

#### Properties:
- `height`: The height of the cover flow view.
- `spacing`: Spacing between each item in the scroll view.
- `showPaginationView`: A Boolean value that indicates whether pagination indicators should be shown.
- `data`: The collection of data that the cover flow will iterate over.
- `content`: A closure that takes a data element and returns a SwiftUI view.
- `id`: A key path to the unique identifier property of each data element.

#### Initialization:
Initializes `DSCoverFlow` with specific layout and behavioral settings.
- Parameters:
- `height`: `DSDimension` specifying the height of the cover flow.
- `spacing`: `DSSpace` specifying the spacing between items.
- `showPaginationView`: Boolean indicating whether to show pagination dots.
- `data`: The collection of data items to display.
- `id`: KeyPath to the unique identifier for each data item.
- `content`: Closure that returns a `Content` view for each data item.
*/


public struct DSCoverFlow<Data, ID, Content>: View where Data: RandomAccessCollection, ID: Hashable, Data.Element: Equatable, Content: View {
    
    @Environment(\.appearance) var appearance: DSAppearance
    let height: DSDimension
    let spacing: DSSpace
    let showPaginationView: Bool
    
    let data: Data
    let content: (Data.Element) -> Content
    let id: KeyPath<Data.Element, ID>
    
    @State private var currentElementID: Data.Element?
    
    public init(
        height: DSDimension,
        spacing: DSSpace = .regular,
        showPaginationView: Bool = true,
        data: Data,
        id: KeyPath<Data.Element, ID>,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.height = height
        self.spacing = spacing
        self.showPaginationView = showPaginationView
        self.data = data
        self.id = id
        self.content = content
        _currentElementID = State(initialValue: data.first)
    }
    
    public var body: some View {
        Group {
            if data.isEmpty {
                Color.clear
            } else {
                DSVStack(alignment: .center, spacing: .zero) {
                    GeometryReader { p in
                        let itemWidth = max(1, p.size.width)
                        DSPaginatedScrollView(
                            viewportWidth: p.size.width,
                            itemWidth: itemWidth,
                            interItemSpacing: appearance.spacing.value(for: spacing),
                            data: data,
                            id: id,
                            currentPage: $currentElementID
                        ) { element in
                            content(element)
                        }
                    }
                    if showPaginationView {
                        defaultPaginationIndicator()
                            .dsPadding(.top)
                    }
                }
            }
        }
        .dsHeight(height)
    }
    
    private func defaultPaginationIndicator() -> some View {
        DSHStack {
            ForEach(data, id: id) { element in
                Circle()
                    .fill(Color(appearance.primaryView.text.headline))
                    .dsSize(7)
                    .opacity(currentElementID == element ? 1 : 0.1)
            }
        }.dsHeight(7)
    }
}

struct DSPaginatedScrollView<Data, ID, Content>: DSViewRepresentable where Data: RandomAccessCollection, Data.Element: Equatable, ID: Hashable, Content: View {
    
    let data: Data
    let content: (Data.Element) -> Content
    let id: KeyPath<Data.Element, ID>
    @Binding var currentPage: Data.Element?
    let interItemSpacing: CGFloat
    let viewportWidth: CGFloat
    let itemWidth: CGFloat
    
    init(
        viewportWidth: CGFloat,
        itemWidth: CGFloat,
        interItemSpacing: CGFloat,
        data: Data,
        id: KeyPath<Data.Element, ID>,
        currentPage: Binding<Data.Element?>,
        @ViewBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.content = content
        self.id = id
        self.interItemSpacing = interItemSpacing
        self.viewportWidth = viewportWidth
        self.itemWidth = itemWidth
        self._currentPage = currentPage
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    // MARK: - Cross-Platform Implementations
    #if canImport(UIKit)
    func makeUIView(context: Context) -> DSUIScrollView {
        let scrollView = DSUIScrollView()
        setupScrollView(scrollView, context: context)
        addContentView(to: scrollView, context: context)
        applyCenteringInsets(to: scrollView)
        return scrollView
    }
    
    func updateUIView(_ uiView: DSUIScrollView, context: Context) {
        applyCenteringInsets(to: uiView)
    }
    #elseif canImport(AppKit)
    func makeNSView(context: Context) -> DSUIScrollView {
        let scrollView = DSUIScrollView()
        setupScrollView(scrollView, context: context)
        addContentView(to: scrollView, context: context)
        return scrollView
    }
    
    func updateNSView(_ nsView: DSUIScrollView, context: Context) {}
    #endif
    
    // MARK: - Setup Methods
    private func setupScrollView(_ scrollView: DSUIScrollView, context: Context) {
        #if canImport(UIKit)
        scrollView.isPagingEnabled = false
        scrollView.decelerationRate = .fast
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.delegate = context.coordinator
        scrollView.clipsToBounds = false
        #elseif canImport(AppKit)
        scrollView.hasHorizontalScroller = true
        scrollView.hasVerticalScroller = false
        scrollView.drawsBackground = false
        scrollView.backgroundColor = .clear
        #endif
    }

    private func applyCenteringInsets(to scrollView: DSUIScrollView) {
        #if canImport(UIKit)
        let horizontalInset = max((viewportWidth - itemWidth) / 2, 0)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
        #endif
    }
    
    private func addContentView(to scrollView: DSUIScrollView, context: Context) {
        let hostingController = DSHostingController(rootView: createContentView())
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        
        #if canImport(UIKit)
        scrollView.addSubview(hostingController.view)
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostingController.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        #elseif canImport(AppKit)
        scrollView.documentView = hostingController.view
        #endif
    }
    
    private func createContentView() -> some View {
        HStack(spacing: interItemSpacing) {
            ForEach(data, id: id) { element in
                content(element)
                    .frame(width: itemWidth)
            }
        }
    }
    
    // MARK: - Coordinator
    class Coordinator: NSObject, DSScrollViewDelegate {
        var parent: DSPaginatedScrollView
        private var dragStartOffsetX: CGFloat = .zero
        private var pendingTargetIndex: Int?
        
        init(parent: DSPaginatedScrollView) {
            self.parent = parent
        }
        
        #if canImport(UIKit)
        private var itemStride: CGFloat {
            parent.itemWidth + parent.interItemSpacing
        }

        private func clampedIndex(_ index: Int) -> Int {
            guard parent.data.isEmpty == false else { return 0 }
            return min(max(index, 0), parent.data.count - 1)
        }

        private func pageIndex(for offsetX: CGFloat, insetLeft: CGFloat) -> Int {
            guard itemStride > 0 else { return 0 }
            let rawIndex = (offsetX + insetLeft) / itemStride
            return clampedIndex(Int(round(rawIndex)))
        }

        private func targetOffset(for index: Int, insetLeft: CGFloat) -> CGFloat {
            CGFloat(index) * itemStride - insetLeft
        }

        private func syncCurrentPage(for scrollView: UIScrollView) {
            let index = pageIndex(for: scrollView.contentOffset.x, insetLeft: scrollView.contentInset.left)
            let dataIndex = parent.data.index(parent.data.startIndex, offsetBy: index)
            parent.currentPage = parent.data[dataIndex]
        }

        func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
            dragStartOffsetX = scrollView.contentOffset.x
        }

        func scrollViewWillEndDragging(
            _ scrollView: UIScrollView,
            withVelocity velocity: CGPoint,
            targetContentOffset: UnsafeMutablePointer<CGPoint>
        ) {
            let insetLeft = scrollView.contentInset.left
            let currentIndex = pageIndex(for: dragStartOffsetX, insetLeft: insetLeft)
            let releasedOffsetX = scrollView.contentOffset.x
            let dragDistance = releasedOffsetX - dragStartOffsetX
            let velocityThreshold: CGFloat = 0.22
            let dragThreshold = itemStride * 0.33

            let targetIndex: Int
            if abs(velocity.x) > velocityThreshold {
                targetIndex = clampedIndex(currentIndex + (velocity.x > 0 ? 1 : -1))
            } else if abs(dragDistance) > dragThreshold {
                targetIndex = clampedIndex(currentIndex + (dragDistance > 0 ? 1 : -1))
            } else {
                targetIndex = currentIndex
            }

            pendingTargetIndex = targetIndex
            targetContentOffset.pointee.x = targetOffset(for: targetIndex, insetLeft: insetLeft)
        }

        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if decelerate == false {
                let insetLeft = scrollView.contentInset.left
                let targetIndex = pendingTargetIndex ?? pageIndex(for: scrollView.contentOffset.x, insetLeft: insetLeft)
                scrollView.setContentOffset(
                    CGPoint(x: targetOffset(for: targetIndex, insetLeft: insetLeft), y: scrollView.contentOffset.y),
                    animated: true
                )
                pendingTargetIndex = nil
                syncCurrentPage(for: scrollView)
            }
        }

        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            pendingTargetIndex = nil
            syncCurrentPage(for: scrollView)
        }
        #endif
    }
}

struct Testable_DSCoverFlow: View {
    
    let colors = [
        DSUIColor(0x006A7A),
        DSUIColor(0x28527a),
        DSUIColor(0xfbeeac)
    ]
    
    var body: some View {
        DSCoverFlow(
            height: 200,
            data: colors,
            id: \.self,
            content: { uiColor in
            uiColor.color
        })
    }
}

struct DSCoverFlow_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_DSCoverFlow()
        }.dsScreen()
    }
}
