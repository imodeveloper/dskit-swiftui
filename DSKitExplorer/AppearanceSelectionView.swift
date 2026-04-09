//
//  AppearanceSelectionView.swift
//  DSKitExplorer
//
//  Created by Ivan Borinschi on 28.02.2023.
//

import SwiftUI
import DSKit

struct AppearanceSelectionView: View {

    @Environment(\.colorScheme) var colorScheme
    @State private var useDarkMode: Bool = false
    @Environment(\.appearance) var appearance: DSAppearance
    @State private var selectedAppearance: IdentifiableDesignable?

    var body: some View {
        DSVStack {
            DSVStack {
                DSVStack(spacing: .custom(0)) {
                    DSHStack(spacing: .space4) {
                        DSText("Welcome to").dsTextStyle(DSTypographyToken.custom(size: 30, weight: .semibold, relativeTo: .headline))
                        DSText("DSKit").dsTextStyle(DSTypographyToken.custom(size: 30, weight: .semibold, relativeTo: .headline), .text(.brand))
                    }
                    DSText("Please select an appearance to continue").dsTextStyle(.subheadline)
                }
                .dsPadding(.top)

                DSGrid(columns: 2, data: appearances, id: \.title) { appearance in
                    AppearanceView(appearance: appearance).onTap {
                        self.selectedAppearance = IdentifiableDesignable(appearance: appearance)
                    }
                }

                Spacer()
            }
            #if os(iOS)
            .fullScreenCover(item: $selectedAppearance) { identifiableDesignable in
                ScreensView(appearance: identifiableDesignable.appearance)
            }
            #elseif os(macOS)
            .sheet(item: $selectedAppearance) { identifiableDesignable in
                ScreensView(appearance: identifiableDesignable.appearance)
                    .frame(minWidth: 800, minHeight: 600)
            }
            #endif
            PoweredByDSKitView()
        }.dsScreen()
    }
}

fileprivate struct AppearanceView: View {
    let appearance: DSAppearance

    private let swatches: [(DSColorToken, DSSurfaceStyle)] = [
        (.text(.primary), .canvas),
        (.text(.secondary), .canvas),
        (.background(.brand), .canvas),
        (.background(.canvas), .canvas),
        (.text(.primary), .surface),
        (.text(.secondary), .surface),
        (.background(.surface), .surface),
        (.border(.brand), .surface)
    ]

    var body: some View {
        DSVStack {
            DSText(appearance.title).dsTextStyle(.headline)
            DSHStack(spacing: .custom(0)) {
                ForEach(Array(swatches.enumerated()), id: \.offset) { _, swatch in
                    Rectangle()
                        .fill(swatch.0.color(for: appearance, in: swatch.1))
                }
            }
            .dsHeight(40)
            .dsCornerRadius()
        }
        .dsPadding()
        .dsSecondaryBackground()
        .dsCornerRadius()

    }
}

struct IdentifiableDesignable: Identifiable {
    let id: UUID
    let appearance: DSAppearance
    init(appearance: DSAppearance) {
        self.id = UUID()
        self.appearance = appearance
    }
}

fileprivate let appearances: [DSAppearance] = [
    LightBlueAppearance(),
    DarkAppearance(),
    BlueAppearance(),
    RetroAppearance(),
    PeachAppearance()
]

#Preview {
    AppearanceSelectionView()
}
