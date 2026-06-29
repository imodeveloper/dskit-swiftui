//
//  HomeScreen2.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct HomeScreen2: View {
    @StateObject var viewModel = HomeScreen2Model()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        DSList {
            DSSection {
                ProfileView(
                    title: "Shop",
                    subtitle: "Over 45k items available for you",
                    profileImageUrl: profileImageUrl
                )

                DSCoverFlow(height: 220, data: viewModel.topProducts, id: \.self) { imageUrl in
                    DSImageView(url: imageUrl, style: .capsule).onTap { dismiss() }
                }

                DSVStack {
                    DSSectionHeaderView(title: "Categories", actionTitle: "View all", action: { dismiss() })
                    DSGrid(data: viewModel.categories, id: \.id) { category in
                        CategoryView(title: category.title, action: { dismiss() })
                    }
                }

                DSVStack {
                    DSSectionHeaderView(title: "Discounts", actionTitle: "View all", action: { dismiss() })
                    DSGrid(viewHeight: 180, data: viewModel.products, id: \.id) { arrival in
                        ProductView(product: arrival)
                            .onTap { dismiss() }
                    }
                }
            }
        }
    }
}

extension HomeScreen2 {
    // MARK: - Product View

    struct ProductView: View {
        let product: Product
        var body: some View {
            DSVStack {
                DSImageView(
                    url: product.imageUrl,
                    style: .capsule
                )
                DSVStack(spacing: .custom(0)) {
                    DSText(product.title).dsTextStyle(DSTypographyToken.label)
                    DSText(product.description).dsTextStyle(.caption1)
                    DSPriceView(price: product.price, size: DSTypographyToken.label)
                        .dsPadding(.top, .space8)
                }
            }.dsPadding(.bottom)
        }

        struct Product: Identifiable {
            let id = UUID()
            let title: String
            let description: String
            let imageUrl: URL?
            let price: DSPrice
        }
    }

    // MARK: - Profile View

    struct ProfileView: View {
        let title: String
        let subtitle: String
        let profileImageUrl: URL?
        var body: some View {
            DSHStack {
                DSVStack(spacing: .custom(0)) {
                    DSText(title).dsTextStyle(DSTypographyToken.custom(size: 30, weight: .semibold, relativeTo: .headline))
                    DSText(subtitle).dsTextStyle(.subheadline)
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
        let title: String
        let action: () -> Void
        var body: some View {
            DSText(title).dsTextStyle(DSTypographyToken.label)
                .frame(maxWidth: .infinity, alignment: .center)
                .dsCardStyle()
                .onTap { action() }
        }

        struct Category: Identifiable {
            let id = UUID()
            let title: String
        }
    }
}

// MARK: - Model

final class HomeScreen2Model: ObservableObject {
    var categories: [HomeScreen2.CategoryView.Category] = [
        .init(title: "Shoes"),
        .init(title: "Shirts"),
        .init(title: "Jeans"),
        .init(title: "Watches")
    ]

    var topProducts: [URL?] = [
        sneakersBlackOnBlueBg,
        sneakersWhiteOnYellowBg,
        sneakersThreePairs
    ]

    var products: [HomeScreen2.ProductView.Product] = [
        .init(
            title: "New trend",
            description: "Colourful sneakers",
            imageUrl: sneakersThreePairs,
            price: DSPrice(amount: "100", regularAmount: "120", currency: "$", discountBadge: "20% Off")
        ),
        .init(
            title: "Shirts",
            description: "Fresh prints of Bel-Air",
            imageUrl: shirtsThreePairs,
            price: DSPrice(amount: "50", regularAmount: "60", currency: "$", discountBadge: "15% Off")
        ),
        .init(
            title: "Shoes",
            description: "Bring power to you",
            imageUrl: shoesThreePairs,
            price: DSPrice(amount: "200", regularAmount: "250", currency: "$", discountBadge: "20% Off")
        ),
        .init(
            title: "Watches",
            description: "Time is what you make",
            imageUrl: watchesOnYellowBg,
            price: DSPrice(amount: "300", regularAmount: "350", currency: "$", discountBadge: "10% Off")
        ),
        .init(
            title: "Jeans",
            description: "Quality newer goes down",
            imageUrl: jeansOnBlackBg,
            price: DSPrice(amount: "80", regularAmount: "90", currency: "$", discountBadge: "10% Off")
        ),
        .init(
            title: "T-Shirts",
            description: "Blink if you want me",
            imageUrl: tShirtGirlOnYellowBg,
            price: DSPrice(amount: "40", regularAmount: "45", currency: "$", discountBadge: "10% Off")
        )
    ]
}

// MARK: - Testable

struct Testable_HomeScreen2: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        TabView {
            HomeScreen2()
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

struct HomeScreen2_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_HomeScreen2()
        }
    }
}

// MARK: - Image Links

private let profileImageUrl = ExplorerImageAssets.url(named: "web_home_screen2_profile_image_url_be9c908d69")
private let sneakersBlackOnBlueBg = ExplorerImageAssets.url(named: "web_home_screen1_sneakers_black_on_blue_bg_578f6ebc68")
private let sneakersWhiteOnYellowBg = ExplorerImageAssets.url(named: "web_cart_screen5_sneakers_white_on_yellow_bg_100c84f711")
private let sneakersThreePairs = ExplorerImageAssets.url(named: "web_cart_screen5_sneakers_three_pairs_32ce2597b8")
private let shirtsThreePairs = ExplorerImageAssets.url(named: "web_categories2_shirts_three_pairs_81d5027b53")
private let shoesThreePairs = ExplorerImageAssets.url(named: "web_categories2_shoes_three_pairs_f3c4a5232b")
private let watchesOnYellowBg = ExplorerImageAssets.url(named: "web_categories1_watches_on_yellow_bg_9722965ee2")
private let jeansOnBlackBg = ExplorerImageAssets.url(named: "web_categories2_jeans_on_black_bg_4d0da7b9a3")
private let tShirtGirlOnYellowBg = ExplorerImageAssets.url(named: "web_home_screen1_t_shirt_girl_on_yellow_bg_543f1bf17b")
