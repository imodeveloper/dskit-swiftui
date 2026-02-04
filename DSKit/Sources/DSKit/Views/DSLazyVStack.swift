//
//  DSLazyVStack.swift
//  DSKit
//
//  Created by Ivan Borinschi on 02.01.2025.
//

import SwiftUI

/*
## DSLazyVStack

`DSLazyVStack` is a SwiftUI component within the DSKit framework that provides a lazily loaded vertical stack with DSKit spacing and content margins.

#### Initialization:
Initializes a `DSLazyVStack` with alignment, spacing, and dynamic content.
- Parameters:
- `alignment`: The horizontal alignment of content within the stack. Defaults to `.leading`.
- `spacing`: Specifies the space between each item within the stack. Defaults to `.regular`.
- `content`: A `@ViewBuilder` closure that generates the content of the stack.

#### Usage:
`DSLazyVStack` is useful for vertically stacked content inside scroll views, especially when the content is large and should be loaded lazily.
*/

public struct DSLazyVStack<Content: View>: View {

    @Environment(\.appearance) var appearance: DSAppearance

    let spacing: DSSpace
    let alignment: HorizontalAlignment
    let content: () -> Content

    public init(
        alignment: HorizontalAlignment = .leading,
        spacing: DSSpace = .regular,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.content = content
        self.spacing = spacing
        self.alignment = alignment
    }

    public var body: some View {
        LazyVStack(alignment: alignment, spacing: appearance.spacing.value(for: spacing)) {
            content()
                .dsDebuggable(debugColor: Color.mint)
                .dsResetContentMargins()
        }
        .dsContentMargins()
    }
}

struct Testable_DSLazyVStack: View {
    var body: some View {
        ScrollView {
            DSLazyVStack(spacing: .small) {
                Color.yellow.dsHeight(60)
                Color.green.dsHeight(60)
                Color.blue.dsHeight(60)
            }
        }
        .dsHeight(240)
    }
}

struct DSLazyVStack_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSLazyVStack()
            }
        }
    }
}
