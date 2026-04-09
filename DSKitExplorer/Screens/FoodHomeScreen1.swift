//
//  FoodHomeScreen1.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct FoodHomeScreen1: View {
    let viewModel = FoodHomeScreen1Model()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        DSList {
            DSSection {
                LocationView(title: "2464 Royal Ln. Mesa")
                SearchView()
                DSCoverFlow(height: 150, data: viewModel.banners, id: \.id) { banner in
                    BannerView(banner: banner)
                }
            }
            .dsSpacing(.space8)
            DSSection {
                DSVStack(spacing: .space8) {
                    DSSectionHeaderView(
                        title: "Popular Products",
                        actionTitle: "View all",
                        action: { dismiss() }
                    )
                    DSHScroll(
                        spacing: .space8,
                        data: viewModel.popularProducts,
                        id: \.id
                    ) { product in
                        PopularProductView(product: product)
                    }
                }
            }
            .dsSpacing(.space8)
            DSSection {
                DSVStack(spacing: .space8) {
                    DSSectionHeaderView(
                        title: "All Categories",
                        actionTitle: "View all",
                        action: { dismiss() }
                    )
                    DSHScroll(
                        spacing: .space8,
                        data: viewModel.categories,
                        id: \.id
                    ) { category in
                        CategoryView(category: category)
                    }
                }
                .dsPadding(.bottom)
            }
            .dsSpacing(.custom(15))
        }
    }
}

extension FoodHomeScreen1 {
    // MARK: - Profile View

    struct LocationView: View {
        let title: String
        var body: some View {
            DSHStack {
                DSVStack(spacing: .custom(0)) {
                    DSText("Your Location")
                        .dsTextStyle(.caption1)
                    DSText(title)
                        .dsTextStyle(.headline)
                }

                Spacer()

                DSButton(
                    title: "Change",
                    rightSystemName: "location.circle.fill",
                    style: .clear,
                    maxWidth: false
                ) {}
                    .dsHeight(17)

            }.dsCardStyle()
        }
    }

    // MARK: - Search View

    struct SearchView: View {
        let value = DSTextFieldValue()
        var body: some View {
            DSTextField.search(value: value, placeholder: "What do you want to eat?")
        }
    }

    // MARK: - CategoryView View

    struct CategoryView: View {
        let category: Data

        var body: some View {
            DSVStack {
                DSImageView(named: category.image)
                DSHStack {
                    DSVStack(spacing: .custom(0)) {
                        DSText(category.title)
                            .dsTextStyle(DSTypographyToken.label)
                        DSText(category.subtitle)
                            .dsTextStyle(.caption1)
                    }
                    Spacer()
                    DSSFSymbolButton(name: "chevron.right.square.fill", size: .mediumIcon)
                }
            }
            .dsCardStyle()
            .dsSize(.size(width: 160, height: 200))
        }

        struct Data: Identifiable, Equatable {
            let id = UUID()
            let title: String
            let subtitle: String
            let image: String
        }
    }

    // MARK: - CategoryView View

    struct PopularProductView: View {
        let product: Data

        var body: some View {
            DSVStack(spacing: .custom(0)) {
                DSImageView(named: product.image)
                    .dsSize(dimension: 160)
                    .overlay(alignment: .bottomLeading) {
                        DSText(product.discount)
                            .dsTextStyle(.caption1, .color(.white))
                            .dsPadding(.space4)
                            .dsBackground(.background(.brand))
                            .dsPadding(.bottom)
                    }

                DSVStack(spacing: .custom(0)) {
                    DSText(product.title)
                        .dsTextStyle(DSTypographyToken.label)
                        .dsPadding(.space4)
                        .dsFullWidth()

                    DSHStack {
                        DSHStack(spacing: .custom(0)) {
                            DSImageView(
                                systemName: "star",
                                size: .font(.caption1),
                                tint: .text(.caption1)
                            )

                            DSText(product.rating)
                                .dsTextStyle(.caption1)
                                .dsPadding(.space4)
                        }

                        DSHStack(spacing: .custom(0)) {
                            DSImageView(
                                systemName: "clock",
                                size: .font(.caption1),
                                tint: .text(.caption1)
                            )

                            DSText(product.time)
                                .dsTextStyle(.caption1)
                                .dsPadding(.space4)
                        }
                    }.dsPadding(.leading, 3)

                }.dsPadding(.space8)
            }
            .dsSecondaryBackground()
            .dsWidth(160)
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
        let banner: Data
        var body: some View {
            DSVStack {
                DSImageView(named: banner.image, displayShape: .capsule)
                    .dsSecondaryBackground()
                    .dsCornerRadius()
                    .overlay(alignment: .leading) {
                        DSVStack(spacing: .custom(0)) {
                            DSText(banner.title)
                                .dsTextStyle(DSTypographyToken.custom(size: 25, weight: .semibold, relativeTo: .headline), .text(.brand))
                            DSText(banner.subtitle)
                                .dsTextStyle(DSTypographyToken.custom(size: 15, weight: .regular, relativeTo: .body))
                        }
                        .dsPadding()
                        .dsPadding(.bottom)
                    }
                    .overlay(alignment: .bottomLeading) {
                        DSVStack(spacing: .custom(0)) {
                            DSText(banner.discount)
                                .dsTextStyle(.caption1)
                        }.dsPadding()
                    }
            }
        }

        struct Data: Identifiable, Equatable {
            let id = UUID()
            let title: String
            let subtitle: String
            let discount: String
            let image: String
        }
    }
}

// MARK: - Model

final class FoodHomeScreen1Model: ObservableObject {
    var banners: [FoodHomeScreen1.BannerView.Data] = [
        .init(
            title: "PASTA",
            subtitle: "DAY FESTIVAL",
            discount: "Get 25% off every pasta purchase",
            image: "Food_banner_pasta"
        ),
        .init(
            title: "SUSHI",
            subtitle: "DAY FESTIVAL",
            discount: "Get 35% off",
            image: "Food_banner_sushi"
        ),
        .init(
            title: "ORANGES",
            subtitle: "DAY FESTIVAL",
            discount: "Get 50% off",
            image: "Food_banner_oranges"
        )
    ]

    var categories: [FoodHomeScreen1.CategoryView.Data] = [
        .init(
            title: "Breakfast",
            subtitle: "30+ menu",
            image: "Food_category_1"
        ),
        .init(
            title: "Salad Veggie",
            subtitle: "13+ menu",
            image: "Food_category_2"
        ),
        .init(
            title: "Noodles",
            subtitle: "10+ menu",
            image: "Food_category_3"
        )
    ]

    var popularProducts: [FoodHomeScreen1.PopularProductView.Data] = [
        .init(
            title: "Marinated Grilled Salmon",
            rating: "4.5",
            time: "30 min",
            discount: "-15%",
            image: "Food_popular_product_3"
        ),
        .init(
            title: "The Best Beef Sandwich",
            rating: "4.5",
            time: "14 min",
            discount: "-35%",
            image: "Food_popular_product_2"
        ),
        .init(
            title: "Coco Strawberry Pancake",
            rating: "4.5",
            time: "30 min",
            discount: "-25%",
            image: "Food_popular_product_1"
        )
    ]
}

// MARK: - Testable

struct Testable_FoodHomeScreen1: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        TabView {
            FoodHomeScreen1()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            Text("Menu")
                .tabItem {
                    Image(systemName: "menucard.fill")
                    Text("Menu")
                }
            Text("Cart")
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Cart")
                }
            DSVStack {
                DSButton(title: "Dismiss", style: .clear) {
                    dismiss()
                }
            }.tabItem {
                Image(systemName: "gearshape")
                Text("Settings")
            }
        }
    }
}

// MARK: - Preview

struct FoodHomeScreen1_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_FoodHomeScreen1()
        }
    }
}
