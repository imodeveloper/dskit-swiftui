//
//  HomeScreen3.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct HomeScreen3: View {
    @StateObject var viewModel = HomeScreen3Model()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        DSList {
            DSSection {
                ProfileView(
                    title: "Jane Doe",
                    subtitle: "4 Items in cart",
                    profileImageUrl: profileOnRedBg
                )

                DSCoverFlow(height: 220, data: viewModel.topProducts, id: \.self) { imageUrl in
                    DSImageView(url: imageUrl, style: .capsule).onTap { dismiss() }
                }

                DSHScroll(data: viewModel.categories, id: \.self) { category in
                    CategoryView(title: category) { dismiss() }
                }.dsPadding(.top, .space4)

                DSVStack {
                    DSSectionHeaderView(title: "Discounts", actionTitle: "View all", action: { dismiss() })
                    DSGrid(viewHeight: 200, data: viewModel.products, id: \.id) { product in
                        ProductView(product: product).onTap { dismiss() }
                    }
                }
            }
        }
    }
}

extension HomeScreen3 {
    // MARK: - Product View

    struct ProductView: View {
        let product: Product
        var body: some View {
            DSVStack(spacing: .custom(0)) {
                DSImageView(url: product.imageUrl)
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
                DSImageView(url: profileImageUrl, style: .circle, size: 50)
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
                .dsHeight(35)
                .dsPadding(.horizontal, .space24)
                .dsSecondaryBackground()
                .dsCornerRadius()
                .onTap { action() }
        }
    }
}

// MARK: - Model

final class HomeScreen3Model: ObservableObject {
    var categories = ["Shoes", "Shirts", "Jeans", "Watches", "Accessories"]

    var topProducts: [URL?] = [
        personOnYellowBg,
        sneakersBlackOnBlueBg,
        sneakersThreePairs
    ]

    var products: [HomeScreen3.ProductView.Product] = [
        .init(
            title: "New trend",
            description: "Colourful sneakers",
            imageUrl: personOnPurpleBg2,
            price: DSPrice(amount: "100", regularAmount: "120", currency: "$", discountBadge: "20% Off")
        ),
        .init(
            title: "Shirts",
            description: "Fresh prints of Bel-Air",
            imageUrl: personOnPurpleBg,
            price: DSPrice(amount: "50", regularAmount: "60", currency: "$", discountBadge: "15% Off")
        ),
        .init(
            title: "Shoes",
            description: "Bring power to you",
            imageUrl: sneakersOnBlackBg,
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
            imageUrl: personOnBlueBg,
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

struct Testable_HomeScreen3: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        TabView {
            HomeScreen3()
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

struct HomeScreen3_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_HomeScreen3()
        }
    }
}

// MARK: - Image Links

private let profileOnRedBg = ExplorerImageAssets.url(named: "web_home_screen3_profile_on_red_bg_13d1bf2827")
private let personOnPurpleBg2 = ExplorerImageAssets.url(named: "web_home_screen3_person_on_purple_bg2_12eee5951d")
private let personOnPurpleBg = ExplorerImageAssets.url(named: "web_home_screen3_person_on_purple_bg_735bf05d78")
private let sneakersOnBlackBg = ExplorerImageAssets.url(named: "web_home_screen3_sneakers_on_black_bg_5b5d737e3d")
private let watchesOnYellowBg = ExplorerImageAssets.url(named: "web_categories1_watches_on_yellow_bg_9722965ee2")
private let personOnBlueBg = ExplorerImageAssets.url(named: "web_home_screen3_person_on_blue_bg_da16db7acc")
private let tShirtGirlOnYellowBg = ExplorerImageAssets.url(named: "web_home_screen1_t_shirt_girl_on_yellow_bg_543f1bf17b")
private let personOnYellowBg = ExplorerImageAssets.url(named: "web_home_screen3_person_on_yellow_bg_4e967f4f50")
private let sneakersBlackOnBlueBg = ExplorerImageAssets.url(named: "web_home_screen1_sneakers_black_on_blue_bg_578f6ebc68")
private let sneakersThreePairs = ExplorerImageAssets.url(named: "web_cart_screen5_sneakers_three_pairs_32ce2597b8")
