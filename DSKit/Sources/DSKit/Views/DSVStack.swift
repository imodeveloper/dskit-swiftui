//
//  DSStackView.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import SwiftUI

/*
## DSVStack

`DSVStack` is a SwiftUI component within the DSKit framework designed to layout child views vertically with customizable spacing and alignment. It enhances the standard `VStack` by integrating design system themes and spacing guidelines.

#### Initialization:
Initializes a `DSVStack` with alignment, spacing, and dynamic content.
- Parameters:
- `alignment`: The horizontal alignment of content within the stack. Defaults to `.leading`.
- `spacing`: Specifies the space between each item within the stack. Defaults to `.space8`.
- `content`: A `@ViewBuilder` closure that generates the content of the stack.

#### Usage:
`DSVStack` is particularly useful for creating layouts where vertical arrangement of components is required, maintaining consistency with the design system’s spacing and alignment guidelines.
*/

public struct DSVStack<Content: View>: View {

    @Environment(\.appearance) var appearance: DSAppearance

    let spacing: DSSpatialToken
    let alignment: HorizontalAlignment
    let content: () -> Content

    public init(
        alignment: HorizontalAlignment = .leading,
        spacing: DSSpatialToken = .space8,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
        self.spacing = spacing
        self.alignment = alignment
    }

    public var body: some View {
        VStack(alignment: alignment, spacing: appearance.spacing.value(for: spacing)) {
            content()
                .dsDebuggable(debugColor: Color.mint)
                .dsResetContentMargins()
        }.dsContentMargins()
    }
}

struct Testable_DSVStack: View {
    var body: some View {
        DSHStack {
            DSVStack(spacing: .space4) {
                Color.yellow
                Color.green
                Color.blue
            }.overlay(alignment: .center, content: { Text("1") })
            DSVStack(spacing: .space8) {
                Color.yellow
                Color.green
                Color.blue
            }.overlay(alignment: .center, content: { Text("2") })
            DSVStack(spacing: .space16) {
                Color.yellow
                Color.green
                Color.blue
            }.overlay(alignment: .center, content: { Text("3") })
        }.dsHeight(300)
    }
}

struct DSVStack_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSVStack()
            }
        }
    }
}
