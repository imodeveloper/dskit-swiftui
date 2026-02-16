//
//  FoodRestaurantScreen1.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct FoodRestaurantScreen1: View {
    @StateObject var viewModel = FoodRestaurantScreen1Model()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        DSList {
            DSSection {
                BannerView()

                DSVStack(spacing: .regular) {
                    DSText("Popular Products")
                        .dsTextStyle(.headline)

                    DSGrid(
                        spacing: .regular,
                        data: viewModel.popularProducts,
                        id: \.id
                    ) { product in
                        PopularProductView(product: product)
                    }
                }

                .dsPadding(.bottom)
            }
        }
    }
}

extension FoodRestaurantScreen1 {
    // MARK: - CategoryView View

    struct PopularProductView: View {
        let product: Data

        var body: some View {
            DSVStack(spacing: .zero) {
                DSImageView(named: product.image)
                    .dsHeight(160)
                    .overlay(alignment: .topLeading) {
                        DSText(product.discount)
                            .dsTextStyle(.smallSubheadline, .color(.white))
                            .dsPadding(.small)
                            .dsBackground(.view(.button(.accentColor)))
                            .dsPadding(.top)
                    }

                DSVStack(spacing: .zero) {
                    DSText(product.title)
                        .dsTextStyle(.smallHeadline)
                        .dsPadding(.small)
                        .dsFullWidth()
                    Spacer()

                    DSHStack {
                        DSHStack(spacing: .zero) {
                            DSImageView(
                                systemName: "star.fill",
                                size: .font(.smallSubheadline),
                                tint: .color(.yellow)
                            )

                            DSText(product.rating)
                                .dsTextStyle(.smallSubheadline)
                                .dsPadding(.small)
                        }

                        DSHStack(spacing: .zero) {
                            DSImageView(
                                systemName: "clock.fill",
                                size: .font(.smallSubheadline),
                                tint: .text(.headline)
                            )

                            DSText(product.time)
                                .dsTextStyle(.smallSubheadline)
                                .dsPadding(.small)
                        }
                    }.dsPadding(.leading, 3)
                }
                .dsPadding(.regular)
            }
            .dsSecondaryBackground()
            .dsCornerRadius()
        }

        struct Data: Identifiable, Equatable {
            let id = UUID()
            let title: String
            let rating: String
            let time: String
            let discount: String
            let image: String
        }
    }

    // MARK: - Banner View

    struct BannerView: View {
        var body: some View {
            DSVStack {
                DSImageView(named: "Food_restaurant_1", displayShape: .capsule)
                    .dsHeight(200)
                    .dsCornerRadius()
                    .overlay(alignment: .bottomLeading) {
                        DSVStack(spacing: .small) {
                            DSText("Express Ramen Shop")
                                .dsTextStyle(.headline, 25, .color(.white))

                            DSHStack(spacing: .zero) {
                                DSImageView(
                                    systemName: "star.fill",
                                    size: .font(.smallSubheadline),
                                    tint: .color(.yellow)
                                )

                                DSText("4.5")
                                    .dsTextStyle(.smallHeadline, .color(.white))
                                    .dsPadding(.small)

                                DSText("(678)")
                                    .dsTextStyle(.smallSubheadline, .color(.white))
                                    .dsPadding(.small)

                                DSText("Bread, Cacke $$")
                                    .dsTextStyle(.smallHeadline, .color(.white))
                                    .dsPadding(.small)
                            }

                            DSHStack {
                                DSText("Pickup")
                                    .dsTextStyle(.smallHeadline)
                                    .dsPadding(.small)
                                    .dsSecondaryBackground()
                                    .dsCornerRadius()

                                DSText("Free Delivery")
                                    .dsTextStyle(.smallHeadline)
                                    .dsPadding(.small)
                                    .dsSecondaryBackground()
                                    .dsCornerRadius()
                            }
                        }
                        .dsPadding()
                        .dsCornerRadius()
                    }
            }
        }
    }
}

// MARK: - Model

final class FoodRestaurantScreen1Model: ObservableObject {
    var popularProducts: [FoodRestaurantScreen1.PopularProductView.Data] = [
        .init(
            title: "Authentic Japanese Ramen",
            rating: "4.5",
            time: "30 min",
            discount: "-15%",
            image: "Food_menu_1"
        ),
        .init(
            title: "Mushroom & Nori Noodle",
            rating: "4.5",
            time: "14 min",
            discount: "-35%",
            image: "Food_menu_2"
        ),
        .init(
            title: "Chicken Peanut Noodle",
            rating: "4.5",
            time: "30 min",
            discount: "-25%",
            image: "Food_menu_3"
        ),
        .init(
            title: "Spicy Chicken Noodle",
            rating: "4.5",
            time: "30 min",
            discount: "-25%",
            image: "Food_menu_4"
        ),
        .init(
            title: "Egs with Sea Food",
            rating: "4.5",
            time: "30 min",
            discount: "-25%",
            image: "Food_menu_5"
        ),
        .init(
            title: "Suuper Noodles",
            rating: "4.5",
            time: "30 min",
            discount: "-25%",
            image: "Food_menu_6"
        ),
        .init(
            title: "Spicy Chicken Noodle",
            rating: "4.5",
            time: "30 min",
            discount: "-25%",
            image: "Food_menu_7"
        )
    ]
}

// MARK: - Testable

struct Testable_FoodRestaurantScreen1: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            FoodRestaurantScreen1()
                .navigationTitle("Restaurant")
        }
    }
}

// MARK: - Preview

struct FoodRestaurantScreen1_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_FoodRestaurantScreen1()
        }
    }
}
