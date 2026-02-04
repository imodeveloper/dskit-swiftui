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
                        DSPaginatedScrollView(
                            pageWidth: p.size.width,
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
    let pageWidth: CGFloat
    
    init(
        pageWidth: CGFloat,
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
        self.pageWidth = pageWidth
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
        return scrollView
    }
    
    func updateUIView(_ uiView: DSUIScrollView, context: Context) {}
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
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.delegate = context.coordinator
        #elseif canImport(AppKit)
        scrollView.hasHorizontalScroller = true
        scrollView.hasVerticalScroller = false
        scrollView.drawsBackground = false
        scrollView.backgroundColor = .clear
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
                    .frame(width: pageWidth)
            }
        }
    }
    
    // MARK: - Coordinator
    class Coordinator: NSObject, DSScrollViewDelegate {
        var parent: DSPaginatedScrollView
        
        init(parent: DSPaginatedScrollView) {
            self.parent = parent
        }
        
        #if canImport(UIKit)
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let pageIndex = Int(round(scrollView.contentOffset.x / parent.pageWidth))
            if pageIndex >= 0 && pageIndex < parent.data.count {
                let index = parent.data.index(parent.data.startIndex, offsetBy: pageIndex)
                parent.currentPage = parent.data[index]
            }
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
