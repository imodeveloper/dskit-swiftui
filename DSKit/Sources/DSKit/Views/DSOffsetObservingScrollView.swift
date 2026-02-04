//
//  ScrollViewContentFrameReader.swift
//  DSKitExplorer
//
//  Created by Ivan Borinschi on 11.04.2025.
//

import SwiftUI
import Foundation

public struct DSScrollViewContentFrameReader<Content: View>: View {
    
    var axes: Axis.Set = [.vertical]
    var showsIndicators = true
    @Binding var contentFrame: CGRect
    @Binding var page: Int
    @ViewBuilder var content: () -> Content
    
    public init(axes: Axis.Set, showsIndicators: Bool = true, contentFrame: Binding<CGRect>, page: Binding<Int>, content: @escaping () -> Content) {
        self.axes = axes
        self.showsIndicators = showsIndicators
        self._contentFrame = contentFrame
        self._page = page
        self.content = content
    }
    
    private let coordinateSpaceName = UUID()
    
    public var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView(axes, showsIndicators: showsIndicators) {
                DSGeometryTrackingView(
                    coordinateSpace: .named(coordinateSpaceName),
                    trackedFrame: $contentFrame,
                    content: content
                )
            }.coordinateSpace(name: coordinateSpaceName)
                .onChange(of: page) { newValue in
                    withAnimation {
                        scrollViewProxy.scrollTo(page, anchor: .center)
                    }

            }
        }
    }
}

public struct DSGeometryTrackingView<Content: View>: View {
    
    var coordinateSpace: CoordinateSpace
    @Binding var trackedFrame: CGRect
    @ViewBuilder var content: () -> Content
    
    public init(coordinateSpace: CoordinateSpace, trackedFrame: Binding<CGRect>, content: @escaping () -> Content) {
        self.coordinateSpace = coordinateSpace
        self._trackedFrame = trackedFrame
        self.content = content
    }
    
    public var body: some View {
        content()
            .background(
                GeometryReader { geometry in
                    Color.clear.preference(
                        key: ScrollFramePreferenceKey.self,
                        value: geometry.frame(in: coordinateSpace)
                    )
                }
            )
            .onPreferenceChange(ScrollFramePreferenceKey.self) { newValue in
                trackedFrame = newValue
            }
    }
}

public struct ScrollFramePreferenceKey: PreferenceKey {
    public static var defaultValue: CGRect { .zero }
    public static func reduce(value: inout CGRect, nextValue: () -> CGRect) {}
}

struct Testable_ScrollViewContentFrameReader: View {
    
    @State private var scrollContentFrame: CGRect = .zero
    @State var page: Int = 0
    
    var body: some View {
        DSVStack {
            
            DSText("\(scrollContentFrame)")
                .padding()
            
            DSScrollViewContentFrameReader(
                axes: .horizontal,
                showsIndicators: false,
                contentFrame: $scrollContentFrame,
                page: $page
            ) {
                DSHStack {
                    Group {
                        Color.red
                        Color.blue
                        Color.green
                        Color.yellow
                        Color.purple
                    }.frame(width: 100, height: 50)
                }
            }
        }
    }
}

struct DSScrollViewContentFrameReader_Previews: PreviewProvider {
    static var previews: some View {
        Testable_ScrollViewContentFrameReader()
    }
}
