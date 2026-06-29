//
//  Categories5.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct Categories5: View {
    @Environment(\.dismiss) var dismiss
    let viewModel = Categories5Model()

    var body: some View {
        DSList {
            DSSection {
                DSGrid(data: viewModel.categories, id: \.id) { category in
                    CategoryView(category: category).onTap { dismiss() }
                }
            }
        }
    }
}

extension Categories5 {
    // MARK: - Categories View

    struct CategoryView: View {
        let category: Data
        var body: some View {
            Group {
                DSVStack(alignment: .center, spacing: .custom(0)) {
                    DSImageView(url: category.image)
                    DSVStack(alignment: .center, spacing: .custom(0)) {
                        DSText(category.title).dsTextStyle(DSTypographyToken.label)
                        DSText(category.description).dsTextStyle(.subheadline)
                    }.dsPadding(.space8)
                }
                .dsSecondaryBackground()
                .dsHeight(220)
                .overlay(alignment: .topTrailing) {
                    DSImageView(
                        systemName: "heart.fill",
                        size: .font(.subheadline),
                        tint: .color(category.favourite ? .red : .white)
                    )
                    .dsPadding(.space8)
                    .dsBlurBackgroundLight()
                    .dsCornerRadius()
                    .dsPadding(.space8)
                }
                .overlay(alignment: .topLeading) {
                    if let tag = category.tag {
                        DSText(tag)
                            .dsTextStyle(DSTypographyToken.custom(size: 10, weight: .semibold, relativeTo: .headline), Color.white)
                            .dsPadding(.space8)
                            .dsBlurBackgroundLight()
                            .dsCornerRadius()
                            .dsPadding(.space8)
                    }
                }
            }
            .dsCornerRadius()
        }

        struct Data: Identifiable {
            var id = UUID()
            let title: String
            let description: String
            let image: URL?
            var tag: String?
            var favourite: Bool = false
        }
    }
}

// MARK: - View Model

final class Categories5Model {
    let categories: [Categories5.CategoryView.Data] = [
        .init(title: "Shoes", description: "812 items", image: sneakersNeon, tag: "Sales"),
        .init(title: "Shirts", description: "1.4K items", image: personOnNeonRegBg),
        .init(title: "Watches", description: "20K items", image: watchesOnYellowBg, favourite: true),
        .init(title: "Shorts", description: "2.5k items", image: personInWhite),
        .init(title: "Jackets", description: "20K items", image: personOnOrangeBg),
        .init(title: "Blazers", description: "915 items", image: personOnPurpleNeonBg, favourite: true),
        .init(title: "Track Pants", description: "600 items", image: pantsTrack),
        .init(title: "Jeans", description: "345 items", image: personOnMarineBg)
    ]
}

// MARK: - Testable

struct Testable_Categories5: View {
    var body: some View {
        NavigationView {
            Categories5()
                .navigationTitle("Categories")
        }
    }
}

// MARK: - Preview

struct Categories5_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_Categories5() }
    }
}

// MARK: - Image Links

private let sneakersNeon = ExplorerImageAssets.url(named: "web_categories5_sneakers_neon_4607fa9bcb")
private let personOnNeonRegBg = ExplorerImageAssets.url(named: "web_categories5_person_on_neon_reg_bg_1418eb0d05")
private let watchesOnYellowBg = ExplorerImageAssets.url(named: "web_categories1_watches_on_yellow_bg_9722965ee2")
private let personInWhite = ExplorerImageAssets.url(named: "web_categories2_person_in_white_214a08c3b5")
private let personOnOrangeBg = ExplorerImageAssets.url(named: "web_categories2_person_on_orange_bg_97e98d1709")
private let personOnPurpleNeonBg = ExplorerImageAssets.url(named: "web_categories5_person_on_purple_neon_bg_71ae84ffcd")
private let pantsTrack = ExplorerImageAssets.url(named: "web_categories1_pants_track_de1d332995")
private let personOnMarineBg = ExplorerImageAssets.url(named: "web_categories5_person_on_marine_bg_acd650b8c6")
