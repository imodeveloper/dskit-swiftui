//
//  Categories2.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct Categories2: View {
    @Environment(\.dismiss) var dismiss
    let viewModel = Categories2Model()

    var body: some View {
        DSList {
            DSSection {
                DSGrid(data: viewModel.categories, id: \.id) { category in
                    CategoryView(category: category)
                }
            }
        }
    }
}

extension Categories2 {
    // MARK: - Category View

    struct CategoryView: View {
        let category: Data
        var body: some View {
            ZStack(alignment: .bottom) {
                ZStack {
                    DSImageView(url: category.image)
                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.2), Color.black.opacity(1)]),
                                   startPoint: .top,
                                   endPoint: .bottom)
                }
                DSVStack(alignment: .center, spacing: .custom(0)) {
                    DSText(category.title).dsTextStyle(.headline, Color.white)
                    DSText(category.description).dsTextStyle(.caption1, Color.white.opacity(0.8))
                }
                .dsPadding(.bottom)
            }
            .dsSecondaryBackground()
            .dsCornerRadius()
            .dsHeight(250)
            .onTap {}
        }

        struct Data: Identifiable {
            var id = UUID()
            let title: String
            let description: String
            let image: URL?
        }
    }
}

// MARK: - View Model

final class Categories2Model {
    let categories: [Categories2.CategoryView.Data] = [
        .init(title: "Shorts", description: "2.5k items", image: personInWhite),
        .init(title: "Jackets", description: "20K items", image: personOnOrangeBg),
        .init(title: "Blazers", description: "915 items", image: blazers),
        .init(title: "Track Pants", description: "600 items", image: pantsTrack),
        .init(title: "Shirts", description: "1.4K items", image: shirtsThreePairs),
        .init(title: "Jeans", description: "345 items", image: jeansOnBlackBg),
        .init(title: "Shoes", description: "812 items", image: shoesThreePairs),
        .init(title: "Watches", description: "20K items", image: watchesOnYellowBg)
    ]
}

// MARK: - Testable

struct Testable_Categories2: View {
    var body: some View {
        NavigationView {
            Categories2()
                .navigationTitle("Categories")
        }
    }
}

// MARK: - Preview

struct Categories2_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_Categories2() }
    }
}

// MARK: - Image Links

private let personInWhite = ExplorerImageAssets.url(named: "web_categories2_person_in_white_214a08c3b5")

private let personOnOrangeBg = ExplorerImageAssets.url(named: "web_categories2_person_on_orange_bg_97e98d1709")

private let blazers = ExplorerImageAssets.url(named: "web_categories1_blazers_3329d3b07e")

private let pantsTrack = ExplorerImageAssets.url(named: "web_categories1_pants_track_de1d332995")

private let shirtsThreePairs = ExplorerImageAssets.url(named: "web_categories2_shirts_three_pairs_81d5027b53")

private let jeansOnBlackBg = ExplorerImageAssets.url(named: "web_categories2_jeans_on_black_bg_4d0da7b9a3")

private let shoesThreePairs = ExplorerImageAssets.url(named: "web_categories2_shoes_three_pairs_f3c4a5232b")

private let watchesOnYellowBg = ExplorerImageAssets.url(named: "web_categories1_watches_on_yellow_bg_9722965ee2")
