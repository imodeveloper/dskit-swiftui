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

                DSVStack(spacing: .space8) {
                    DSText("Popular Products")
                        .dsTextStyle(.headline)

                    DSGrid(
                        spacing: .space8,
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
            DSVStack(spacing: .custom(0)) {
                DSImageView(named: product.image)
                    .dsHeight(160)
                    .overlay(alignment: .topLeading) {
                        DSText(product.discount)
                            .dsTextStyle(.caption1, .color(.white))
                            .dsPadding(.space4)
                            .dsBackground(.background(.brand))
                            .dsPadding(.top)
                    }

                DSVStack(spacing: .custom(0)) {
                    DSText(product.title)
                        .dsTextStyle(DSTypographyToken.label)
                        .dsPadding(.space4)
                        .dsFullWidth()
                    Spacer()

                    DSHStack {
                        DSHStack(spacing: .custom(0)) {
                            DSImageView(
                                systemName: "star.fill",
                                size: .font(.caption1),
                                tint: .color(.yellow)
                            )

                            DSText(product.rating)
                                .dsTextStyle(.caption1)
                                .dsPadding(.space4)
                        }

                        DSHStack(spacing: .custom(0)) {
                            DSImageView(
                                systemName: "clock.fill",
                                size: .font(.caption1),
                                tint: .text(.headline)
                            )

                            DSText(product.time)
                                .dsTextStyle(.caption1)
                                .dsPadding(.space4)
                        }
                    }.dsPadding(.leading, 3)
                }
                .dsPadding(.space8)
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
                        DSVStack(spacing: .space4) {
                            DSText("Express Ramen Shop")
                                .dsTextStyle(DSTypographyToken.custom(size: 25, weight: .semibold, relativeTo: .headline), .color(.white))

                            DSHStack(spacing: .custom(0)) {
                                DSImageView(
                                    systemName: "star.fill",
                                    size: .font(.caption1),
                                    tint: .color(.yellow)
                                )

                                DSText("4.5")
                                    .dsTextStyle(DSTypographyToken.label, .color(.white))
                                    .dsPadding(.space4)

                                DSText("(678)")
                                    .dsTextStyle(.caption1, .color(.white))
                                    .dsPadding(.space4)

                                DSText("Bread, Cacke $$")
                                    .dsTextStyle(DSTypographyToken.label, .color(.white))
                                    .dsPadding(.space4)
                            }

                            DSHStack {
                                DSText("Pickup")
                                    .dsTextStyle(DSTypographyToken.label)
                                    .dsPadding(.space4)
                                    .dsSecondaryBackground()
                                    .dsCornerRadius()

                                DSText("Free Delivery")
                                    .dsTextStyle(DSTypographyToken.label)
                                    .dsPadding(.space4)
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
