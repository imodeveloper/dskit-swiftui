//
//  Items6.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct Items6: View {
    @Environment(\.dismiss) var dismiss
    let viewModel = Items6Model()

    var body: some View {
        DSList {
            DSSection {
                DSGrid(data: viewModel.products, id: \.id) { product in
                    ProductView(product: product).onTap {}
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

extension Items6 {
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
                }.dsPadding(.space8)
            }.overlay(alignment: .topTrailing, content: {
                DSImageView(
                    systemName: "heart.fill",
                    size: .font(.subheadline),
                    tint: .color(product.favourite ? .red : .white)
                )
                .dsPadding(.space8)
                .dsBlurBackgroundLight()
                .dsCornerRadius()
                .dsPadding(.space8)
            })
            .dsSecondaryBackground()
            .dsCornerRadius()
            .dsHeight(300)
        }

        struct Data: Identifiable {
            var id = UUID()
            let title: String
            let description: String
            var tag: String?
            let price: DSPrice
            var favourite: Bool = false
            let image: URL?
        }
    }
}

// MARK: - View Model

final class Items6Model {
    let products: [Items6.ProductView.Data] = [
        .init(
            title: "The Iconic Mesh Polo Shirt - All Fits",
            description: "Polo Ralph Lauren",
            tag: "SALES",
            price: DSPrice(amount: "22", regularAmount: "89", currency: "$"),
            favourite: true,
            image: p1Image
        ),
        .init(
            title: "Big Pony Mesh Polo Shirt",
            description: "Stella McCarthney",
            price: DSPrice(amount: "92", currency: "$"),
            image: p2Image
        ),
        .init(
            title: "Soft Cotton Polo Shirt - All Fits",
            description: "Hermes",
            price: DSPrice(amount: "13", regularAmount: "82", currency: "$", discountBadge: "-69$"),
            favourite: true,
            image: p4Image
        ),
        .init(
            title: "Big Pony Mesh Polo Shirt",
            description: "Arrmani", tag: "50% OFF",
            price: DSPrice(amount: "57", regularAmount: "85", currency: "$"),
            image: p5Image
        ),
        .init(
            title: "Polo Team Mesh Polo Shirt",
            description: "House & Versace",
            price: DSPrice(amount: "84", regularAmount: "94", currency: "$"),
            favourite: true,
            image: p6Image
        ),
        .init(
            title: "Polo Team Mesh Polo Shirt",
            description: "House & Versace",
            price: DSPrice(amount: "84", regularAmount: "94", currency: "$"),
            favourite: true,
            image: p7Image
        ),
        .init(
            title: "Mesh Long-Sleeve Polo Shirt – All Fits",
            description: "Dolce & Gabbana",
            price: DSPrice(amount: "84", currency: "$"),
            favourite: false,
            image: p3Image
        )
    ]
}

// MARK: - Testable

struct Testable_Items6: View {
    var body: some View {
        NavigationView {
            Items6()
                .navigationTitle("Products")
                .platformBasedNavigationBarTitleDisplayModeInline()
        }
    }
}

// MARK: - Preview

struct Items6_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_Items6() }
    }
}

// MARK: - Image Links

private let p1Image = ExplorerImageAssets.url(named: "web_items6_p1_image_793c19e87d")
private let p2Image = ExplorerImageAssets.url(named: "web_items6_p2_image_6c50198658")
private let p3Image = ExplorerImageAssets.url(named: "web_items6_p3_image_c05472dbf9")
private let p4Image = ExplorerImageAssets.url(named: "web_items6_p4_image_21f5bb9e9f")
private let p5Image = ExplorerImageAssets.url(named: "web_items6_p5_image_4db245b354")
private let p6Image = ExplorerImageAssets.url(named: "web_items6_p6_image_09d404f0e9")
private let p7Image = ExplorerImageAssets.url(named: "web_items6_p7_image_d011b48d3d")
