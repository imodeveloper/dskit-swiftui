//
//  Items7.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct Items7: View {
    @Environment(\.dismiss) var dismiss
    let viewModel = Items7Model()

    var body: some View {
        DSList {
            DSSection {
                ForEach(viewModel.products) { product in
                    ProductView(product: product)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .platformBasedTrailing) {
                DSToolbarSFSymbolButton(name: "arrow.up.arrow.down.circle.fill")
                    .onTap { dismiss() }
            }
            ToolbarItem(placement: .platformBasedTrailing) {
                DSToolbarSFSymbolButton(name: "line.horizontal.3.decrease.circle.fill")
                    .onTap { dismiss() }
            }
        }
    }
}

extension Items7 {
    // MARK: - Product View

    struct ProductView: View {
        let product: Data
        var body: some View {
            DSVStack(spacing: .custom(0)) {
                DSImageView(url: product.image)
                    .dsSecondaryBackground()

                DSVStack {
                    DSVStack(spacing: .custom(0)) {
                        DSText(product.title).dsTextStyle(DSTypographyToken.label)
                        DSText(product.description).dsTextStyle(.caption1)
                    }

                    DSHStack {
                        DSRatingView(rating: 4.5, size: 12)
                        DSText("2.4k Reviews").dsTextStyle(.caption2)
                    }

                    DSPriceView(price: product.price, size: DSTypographyToken.label)
                }
                .dsFullWidth()
                .dsPadding(.space8)
                .overlay(alignment: .trailing) {
                    DSChevronView()
                        .dsPadding(.trailing, .space16)
                }

            }.overlay(alignment: .topTrailing, content: {
                DSImageView(
                    systemName: "heart.fill",
                    size: .font(.subheadline),
                    tint: .color(product.favorite ? .red : .white)
                )
                .dsPadding(.space8)
                .dsBlurBackgroundLight()
                .dsCornerRadius()
                .dsPadding(.space8)
            })
            .dsSecondaryBackground()
            .dsCornerRadius()
            .dsHeight(300)
            .onTap {}
        }

        struct Data: Identifiable {
            let id = UUID()
            let title: String
            let description: String
            var tag: String?
            let price: DSPrice
            let favorite: Bool
            let image: URL?
        }
    }
}

// MARK: - View Model

final class Items7Model {
    let products: [Items7.ProductView.Data] = [
        .init(
            title: "The Iconic Mesh Polo Shirt - All Fits",
            description: "Polo Ralph Lauren",
            tag: "SALES",
            price: DSPrice(amount: "22", regularAmount: "89", currency: "$"),
            favorite: true,
            image: p1Image
        ),
        .init(
            title: "Big Pony Mesh Polo Shirt",
            description: "Stella McCarthney",
            price: DSPrice(amount: "92", currency: "$"),
            favorite: false,
            image: p2Image
        ),
        .init(
            title: "Soft Cotton Polo Shirt - All Fits",
            description: "Hermes",
            price: DSPrice(amount: "13", regularAmount: "82", currency: "$", discountBadge: "-69$"),
            favorite: true,
            image: p4Image
        ),
        .init(
            title: "Big Pony Mesh Polo Shirt",
            description: "Arrmani",
            tag: "50% OFF",
            price: DSPrice(amount: "57", regularAmount: "85", currency: "$"),
            favorite: false,
            image: p5Image
        ),
        .init(
            title: "Polo Team Mesh Polo Shirt",
            description: "House & Versace",
            price: DSPrice(amount: "84", regularAmount: "94", currency: "$"),
            favorite: true,
            image: p6Image
        ),
        .init(
            title: "Polo Team Mesh Polo Shirt",
            description: "House & Versace",
            price: DSPrice(amount: "84", regularAmount: "94", currency: "$"),
            favorite: true,
            image: p7Image
        ),
        .init(
            title: "Mesh Long-Sleeve Polo Shirt – All Fits",
            description: "Dolce & Gabbana",
            price: DSPrice(amount: "84", currency: "$"),
            favorite: false,
            image: p3Image
        )
    ]
}

// MARK: - Testable

struct Testable_Items7: View {
    var body: some View {
        NavigationView {
            Items7()
                .navigationTitle("Products")
        }
    }
}

// MARK: - Preview

struct Items7_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_Items7() }
    }
}

// MARK: - Image Links

private let p1Image = ExplorerImageAssets.url(named: "web_items7_p1_image_97f191d816")

private let p2Image = ExplorerImageAssets.url(named: "web_items7_p2_image_f9e9da1854")

private let p3Image = ExplorerImageAssets.url(named: "web_items7_p3_image_8c90865e6e")
private let p4Image = ExplorerImageAssets.url(named: "web_items7_p4_image_995c34b339")

private let p5Image = ExplorerImageAssets.url(named: "web_items7_p5_image_a5cc41e158")

private let p6Image = ExplorerImageAssets.url(named: "web_items7_p6_image_461c3f91cf")

private let p7Image = ExplorerImageAssets.url(named: "web_items7_p7_image_09351ad7f7")
