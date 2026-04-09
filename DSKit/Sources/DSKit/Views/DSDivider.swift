//
//  DSDivider.swift
//  DSKitExplorer
//
//  Created by Ivan Borinschi on 04.03.2023.
//

import SwiftUI

/*
## DSDivider

 `DSDivider` is a simple, design-aware component within the DSKit framework that renders a visual separation line between UI elements. It conforms to the design system's aesthetics, adapting its appearance based on environmental settings.

#### Initialization:
The `DSDivider` is initialized without parameters, defaulting to predefined styling that respects the current theme and spacing conventions.

#### Usage:
 `DSDivider` is used to visually separate content within a view, often between list items, sections in a form, or alongside layout changes.
*/

public enum DSDividerAlignment: Sendable {
    case leading
    case center
    case trailing
}

public enum DSDividerStyle: Sendable {
    case line
    case dots(
        number: Int = 3,
        size: CGFloat = 4,
        spacing: CGFloat = 4,
        alignment: DSDividerAlignment = .center
    )
}

public struct DSDivider: View, DSDesignable {
    public let style: DSDividerStyle

    public init(style: DSDividerStyle = .line) {
        self.style = style
    }

    @Environment(\.appearance) public var appearance: DSAppearance
    @Environment(\.surfaceStyle) public var surfaceStyle: DSSurfaceStyle

    public var body: some View {
        switch style {
        case .line:
            Divider()
                .background(color(for: .border(.subtle)))
                .frame(minWidth: 1, minHeight: 1)
        case let .dots(number, size, spacing, alignment):
            dotsDivider(
                number: max(1, number),
                size: max(1, size),
                spacing: max(0, spacing),
                alignment: alignment
            )
        }
    }

    @ViewBuilder
    private func dotsDivider(
        number: Int,
        size: CGFloat,
        spacing: CGFloat,
        alignment: DSDividerAlignment
    ) -> some View {
        let dots = HStack(spacing: spacing) {
            ForEach(0 ..< number, id: \.self) { _ in
                Circle()
                    .fill(color(for: .border(.subtle)))
                    .frame(width: size, height: size)
            }
        }

        HStack(spacing: 0) {
            switch alignment {
            case .leading:
                dots
                Spacer(minLength: 0)
            case .center:
                Spacer(minLength: 0)
                dots
                Spacer(minLength: 0)
            case .trailing:
                Spacer(minLength: 0)
                dots
            }
        }
        .frame(maxWidth: .infinity, minHeight: size)
    }
}

struct Testable_DSDivider: View {
    var body: some View {
        DSVStack(spacing: .space16) {
            DSDivider()
            DSDivider(style: .dots())
        }
    }
}

struct DSDivider_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            DSPreview {
                Testable_DSDivider()
            }
        }
    }
}
