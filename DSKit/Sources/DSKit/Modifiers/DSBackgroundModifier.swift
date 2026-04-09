//
//  DSBackgroundModifier.swift
//  DSKit
//
//  Created by Borinschi Ivan on 21.01.2021.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
//

import SwiftUI

public struct DSBackgroundModifier: ViewModifier {

    @Environment(\.appearance) var appearance: DSAppearance
    @Environment(\.surfaceStyle) var surfaceStyle: DSSurfaceStyle

    let group: DSSurfaceStyle

    public init(group: DSSurfaceStyle) {
        self.group = group
    }

    public func body(content: Content) -> some View {
        content
            .background(appearance.color(for: .background(group.backgroundToken), surfaceStyle: surfaceStyle))
            .environment(\.surfaceStyle, group)
    }
}

public extension View {
    func dsBackground(_ group: DSSurfaceStyle) -> some View {
        let modifier = DSBackgroundModifier(group: group)
        return self.modifier(modifier)
    }
}

struct Testable_DSBackgroundModifier: View {
    var body: some View {
        DSVStack {
            DSText("Primary Background")
            DSVStack {
                DSText("Secondary Background")
                DSVStack {
                    DSText("Primary Background")
                    DSVStack {
                        DSText("Decondary Background")
                    }
                    .dsPadding()
                    .dsBackground(.surface)
                }
                .dsPadding()
                .dsBackground(.canvas)
            }
            .dsPadding()
            .dsBackground(.surface)
        }
        .dsPadding()
        .dsBackground(.canvas)
    }
}

#Preview {
    Testable_DSBackgroundModifier()
}
