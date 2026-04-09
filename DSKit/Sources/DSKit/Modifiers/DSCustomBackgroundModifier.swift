//
//  DSBackgroundModifier.swift
//  DSKit
//
//  Created by Borinschi Ivan on 21.01.2021.
//  Copyright © 2021 Borinschi Ivan. All rights reserved.
//

import SwiftUI

public struct DSCustomBackgroundModifier: ViewModifier {

    @Environment(\.appearance) var appearance: DSAppearance
    @Environment(\.surfaceStyle) var surfaceStyle: DSSurfaceStyle

    let dsColor: DSColorToken

    public init(dsColor: DSColorToken) {
        self.dsColor = dsColor
    }

    public func body(content: Content) -> some View {
        content.background(dsColor.color(for: appearance, in: surfaceStyle))
    }
}

public extension View {
    func dsBackground(_ dsColor: DSColorToken) -> some View {
        let modifier = DSCustomBackgroundModifier(dsColor: dsColor)
        return self.modifier(modifier)
    }
}

struct Testable_DSCustomBackgroundModifier: View {
    var body: some View {
        DSPreview {
            DSVStack {
                DSText("Secondary background")
                DSVStack {
                    DSText("Primary Background")
                    DSVStack {
                        DSText("Secondary Background")
                        DSVStack {
                            DSText("Primary Background")
                        }
                        .dsPadding()
                        dsBackground(.background(.canvas))
                    }
                    .dsPadding()
                    .dsBackground(.background(.surface))
                }
                .dsPadding()
                .dsBackground(.background(.canvas))
            }
            .dsPadding()
            .dsBackground(.background(.surface))
        }.dsScreen()
    }
}

#Preview {
    Testable_DSCustomBackgroundModifier()
}
