//
//  HomeScreen4.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct HomeScreen4: View {
    @StateObject private var viewModel = HomeScreen4Model()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        DSList {
            DSSection {
                ProfileView(
                    title: "Shoes Shop",
                    youHave: "You have",
                    numberOfItemsInCart: "4",
                    itemsInYourCart: "items in your cart",
                    profileImageUrl: profileOnYellowBg
                )

                DSCoverFlow(height: 220, data: viewModel.topProducts, id: \.imageUrl) { product in
                    TopProductView(product: product)
                        .onTap { dismiss() }
                }

                DSHScroll(data: viewModel.categories, id: \.id) { category in
                    CategoryView(category: category, isSelected: viewModel.selectedCategory == category.id)
                        .onTap { viewModel.selectedCategory = category.id }
                }.dsPadding(.top, .space4)

                DSGrid(viewHeight: 190, data: viewModel.products, id: \.id) { product in
                    ProductView(product: product).onTap { dismiss() }
                }

//                DSVStack {
//
//                }.dsPadding(.top, .space4)
            }
        }
    }
}

extension HomeScreen4 {
    // MARK: - Product View

    struct ProductView: View {
        let product: Product
        var body: some View {
            DSVStack(spacing: .custom(0)) {
                DSImageView(named: product.image)
                DSVStack(spacing: .custom(0)) {
                    DSText(product.title).dsTextStyle(DSTypographyToken.label)
                    DSText(product.description).dsTextStyle(.caption1)
                    DSPriceView(price: product.price, size: DSTypographyToken.label)
                        .dsPadding(.top, .space8)
                }.dsPadding()
            }
            .dsSecondaryBackground()
            .dsCornerRadius()
        }

        struct Product: Identifiable {
            let id = UUID()
            let title: String
            let description: String
            let image: String
            let price: DSPrice
        }
    }

    // MARK: - Top Product View

    struct TopProductView: View {
        let product: TopProduct
        var body: some View {
            Group {
                DSImageView(url: product.imageUrl)
                    .overlay(alignment: .bottomTrailing) {
                        DSVStack(alignment: .trailing, spacing: .custom(0)) {
                            DSText(product.title).dsTextStyle(DSTypographyToken.label)
                            DSText(product.subtitle).dsTextStyle(.caption1)
                        }
                        .dsPadding(.space8)
                        .dsBackground(.surface)
                        .dsCornerRadius()
                        .dsPadding(.space8)
                    }
            }.dsCornerRadius()
        }

        struct TopProduct: Identifiable, Equatable {
            let id = UUID()
            let title: String
            let subtitle: String
            let imageUrl: URL?
        }
    }

    // MARK: - Profile View

    struct ProfileView: View {
        let title: String
        let youHave: String
        let numberOfItemsInCart: String
        let itemsInYourCart: String
        let profileImageUrl: URL?
        var body: some View {
            DSHStack {
                DSVStack(spacing: .custom(0)) {
                    DSText(title)
                        .dsTextStyle(DSTypographyToken.custom(size: 28, weight: .semibold, relativeTo: .headline))
                    DSHStack(spacing: .space4) {
                        DSText(youHave).dsTextStyle(.subheadline)
                        DSText(numberOfItemsInCart)
                            .dsTextStyle(DSTypographyToken.custom(size: 12, weight: .semibold, relativeTo: .headline), .text(.brandOnBold))
                            .dsSize(20)
                            .dsBackground(.background(.brand))
                            .clipShape(Circle())
                        DSText(itemsInYourCart).dsTextStyle(.subheadline)
                    }
                }
                Spacer()

                DSImageView(
                    url: profileImageUrl,
                    style: .circle,
                    size: 50
                )
            }
        }
    }

    // MARK: - Category View

    struct CategoryView: View {
        let category: Category
        let isSelected: Bool
        var body: some View {
            DSHStack {
                if isSelected {
                    DSText(category.title)
                        .dsTextStyle(DSTypographyToken.label, .text(.brandOnBold))
                } else {
                    DSText(category.title)
                        .dsTextStyle(DSTypographyToken.label)
                }

                DSText(category.count)
                    .dsTextStyle(DSTypographyToken.custom(size: 10, weight: .semibold, relativeTo: .headline))
                    .dsSize(20)
                    .dsBackground(isSelected ? .background(.surface) : .background(.canvas))
                    .clipShape(Capsule())
            }
            .dsPadding(.horizontal)
            .dsHeight(35)
            .dsBackground(isSelected ? .background(.brand) : .background(.surface))
            .dsCornerRadius()
        }

        struct Category: Identifiable {
            let id = UUID()
            let title: String
            let count: String
        }
    }
}

// MARK: - Model

@MainActor
final class HomeScreen4Model: ObservableObject {
    init() {
        selectedCategory = categories.first!.id
    }

    @Published var selectedCategory: UUID

    let categories: [HomeScreen4.CategoryView.Category] = [
        .init(title: "Nike", count: "12"),
        .init(title: "Puma", count: "7"),
        .init(title: "Crocs", count: "56"),
        .init(title: "Vans", count: "23"),
        .init(title: "New Balance", count: "12")
    ]

    let topProducts: [HomeScreen4.TopProductView.TopProduct] = [
        .init(title: "Nike", subtitle: "Top quality", imageUrl: sneakersOnWhiteBg),
        .init(title: "Love", subtitle: "Bring the future to light", imageUrl: sneakersNeon),
        .init(title: "Converse", subtitle: "All the stars in the world", imageUrl: sneakersWhiteOnYellowBg)
    ]

    let products: [HomeScreen4.ProductView.Product] = [
        .init(
            title: "Total Orange",
            description: "Air Max 95 x Kim Jones",
            image: "nike_1",
            price: DSPrice(amount: "85", regularAmount: "120", currency: "$", discountBadge: "-29%")
        ),
        .init(
            title: "All-Star",
            description: "Kobe 6 Protro",
            image: "nike_2",
            price: DSPrice(amount: "90", regularAmount: "130", currency: "$", discountBadge: "-29%")
        ),
        .init(
            title: "Bacon",
            description: "Air Max 90",
            image: "nike_3",
            price: DSPrice(amount: "75", regularAmount: "110", currency: "$", discountBadge: "-29%")
        ),
        .init(
            title: "Midnight Navy",
            description: "Air Jordan 3",
            image: "nike_4",
            price: DSPrice(amount: "95", regularAmount: "140", currency: "$", discountBadge: "-29%")
        ),
        .init(
            title: "College Navy",
            description: "Women's Dunk Low",
            image: "nike_5",
            price: DSPrice(amount: "80", regularAmount: "115", currency: "$", discountBadge: "-29%")
        ),
        .init(
            title: "Black",
            description: "Dunk Low",
            image: "nike_6",
            price: DSPrice(amount: "100", regularAmount: "150", currency: "$", discountBadge: "-29%")
        )
    ]
}

// MARK: - Testable

struct Testable_HomeScreen4: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        TabView {
            HomeScreen4()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            Text("Shop")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Shop")
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

struct HomeScreen4_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_HomeScreen4()
        }
    }
}

// MARK: - Image Links

private let profileOnYellowBg = ExplorerImageAssets.url(named: "web_home_screen4_profile_on_yellow_bg_4eb46a6268")
private let sneakersOnWhiteBg = ExplorerImageAssets.url(named: "web_cart_screen5_sneakers_on_white_bg_02b087dd14")
private let sneakersNeon = ExplorerImageAssets.url(named: "web_home_screen4_sneakers_neon_bbaa5adb52")
private let sneakersWhiteOnYellowBg = ExplorerImageAssets.url(named: "web_cart_screen5_sneakers_white_on_yellow_bg_100c84f711")
