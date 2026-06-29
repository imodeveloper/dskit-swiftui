//
//  Items2.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct Items2: View {
    @Environment(\.dismiss) var dismiss
    let viewModel = Items2Model()

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

extension Items2 {
    // MARK: - Product View

    struct ProductView: View {
        let product: Data
        var body: some View {
            ZStack(alignment: .bottom) {
                ZStack {
                    DSImageView(url: product.image)
                    LinearGradient(
                        gradient:
                        Gradient(
                            colors: [
                                Color.black.opacity(0.0),
                                Color.black.opacity(0.2),
                                Color.black.opacity(1)
                            ]
                        ),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }.overlay(alignment: .topLeading) {
                    if let tag = product.tag {
                        DSText(tag)
                            .dsTextStyle(DSTypographyToken.custom(size: 9, weight: .semibold, relativeTo: .headline))
                            .dsPadding(.space4)
                            .dsBackground(.primary)
                            .dsCornerRadius()
                            .dsPadding(.space8)
                    }
                }.overlay(alignment: .topTrailing) {
                    DSImageView(
                        systemName: "heart.fill",
                        size: .font(.subheadline),
                        tint: .color(product.favorite ? .red : .white)
                    )
                    .dsPadding(.space8)
                    .dsBlurBackgroundLight()
                    .dsCornerRadius()
                    .dsPadding(.space8)
                }

                DSVStack(alignment: .center, spacing: .custom(0)) {
                    DSText(product.title)
                        .dsTextStyle(DSTypographyToken.label, .white)
                    DSText(product.description)
                        .dsTextStyle(.caption1, .white.opacity(0.8))
                    DSPriceView(price: product.price, size: DSTypographyToken.label, color: .white)
                }
                .dsPadding(.bottom)
            }
            .dsSecondaryBackground()
            .dsCornerRadius()
            .dsHeight(280)
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

// MARK: - Model

final class Items2Model {
    let products: [Items2.ProductView.Data] = [
        .init(
            title: "Jodhpur Boots",
            description: "House & Versace",
            price: DSPrice(amount: "84", regularAmount: "94", currency: "$"),
            favorite: true,
            image: jodhpurBootsImage
        ),
        .init(
            title: "Platform derby shoes",
            description: "Stella McCarthney",
            price: DSPrice(amount: "92", currency: "$"),
            favorite: false,
            image: shoesImage
        ),
        .init(
            title: "Motocross Boots",
            description: "Hermes",
            price: DSPrice(amount: "13", regularAmount: "82", currency: "$", discountBadge: "-69$"),
            favorite: true,
            image: motocrossBootsImage
        ),
        .init(
            title: "Hiking Boots",
            description: "Dolce & Gabbana",
            price: DSPrice(amount: "84", currency: "$"),
            favorite: false,
            image: hikingBootsImage
        ),
        .init(
            title: "Suede Chuck-a Boots",
            description: "River Island",
            tag: "SALES",
            price: DSPrice(amount: "22", regularAmount: "89", currency: "$"),
            favorite: true,
            image: bootsImage
        ),
        .init(
            title: "Riding Boots",
            description: "Arrmani",
            tag: "50% OFF",
            price: DSPrice(amount: "57", regularAmount: "85", currency: "$"),
            favorite: false,
            image: ridingBootsImage
        )
    ]
}

// MARK: - Testable

struct Testable_Items2: View {
    var body: some View {
        NavigationView {
            Items2()
                .navigationTitle("Products")
        }
    }
}

// MARK: - Preview

struct Items2_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_Items2() }
    }
}

// MARK: - Image Links

private let bootsImage = ExplorerImageAssets.url(named: "web_items1_boots_image_550b9775d4")
private let shoesImage = ExplorerImageAssets.url(named: "web_items1_shoes_image_2b8485d1d3")
private let hikingBootsImage = ExplorerImageAssets.url(named: "web_items1_hiking_boots_image_49c47002b6")
private let motocrossBootsImage = ExplorerImageAssets.url(named: "web_items1_motocross_boots_image_f9750b3f91")
private let ridingBootsImage = ExplorerImageAssets.url(named: "web_items1_riding_boots_image_a3fb43ead6")
private let jodhpurBootsImage = ExplorerImageAssets.url(named: "web_items1_jodhpur_boots_image_e176d168d9")
