//
//  HomeScreen1.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct HomeScreen1: View {
    @StateObject var viewModel = HomeScreen1Model()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        DSList {
            DSSection {
                ProfileView(title: "Your Shop", subtitle: "The best experience", profileUrl: profile)
                DSCoverFlow(height: 220, data: viewModel.topProducts, id: \.self) { imageUrl in
                    DSImageView(url: imageUrl, style: .capsule).onTap { dismiss() }
                }
                DSVStack {
                    DSSectionHeaderView(title: "New arrivals", actionTitle: "View All", action: { dismiss() })
                    DSGrid(viewHeight: 180, data: viewModel.newArrivals, id: \.id) { arrival in
                        ProductView(product: arrival).onTap { dismiss() }
                    }
                }
            }
        }
    }
}

extension HomeScreen1 {
    // MARK: - Product View

    struct ProductView: View {
        let product: Product
        var body: some View {
            DSVStack {
                DSImageView(url: product.imageUrl, style: .capsule)
                DSVStack(spacing: .custom(0)) {
                    DSText(product.title).dsTextStyle(DSTypographyToken.label)
                    DSText(product.description).dsTextStyle(.caption1)
                }
            }.dsPadding(.bottom, .space8)
        }

        struct Product: Identifiable {
            let id = UUID()
            let title: String
            let description: String
            let imageUrl: URL?
        }
    }

    // MARK: - Profile View

    struct ProfileView: View {
        let title: String
        let subtitle: String
        let profileUrl: URL?
        var body: some View {
            DSHStack {
                DSVStack(spacing: .custom(0)) {
                    DSText(title).dsTextStyle(DSTypographyToken.custom(size: 30, weight: .semibold, relativeTo: .headline))
                    DSText(subtitle).dsTextStyle(.subheadline)
                }
                Spacer()
                DSImageView(url: profileUrl, style: .circle, size: .size(50))
            }
        }
    }
}

// MARK: - Model

final class HomeScreen1Model: ObservableObject {
    var topProducts: [URL?] = [
        sneakersWhiteOnYellowBg,
        sneakersBlackOnBlueBg,
        sneakersThreePairs
    ]

    var newArrivals: [HomeScreen1.ProductView.Product] = [
        .init(title: "New trend", description: "Colourful sneakers", imageUrl: sneakersThreePairs),
        .init(title: "Shirts", description: "Fresh prints of Bel-Air", imageUrl: shirtsThreePairs),
        .init(title: "Shoes", description: "Bring power to you", imageUrl: shoesThreePairs),
        .init(title: "Watches", description: "Time is what you make", imageUrl: watchesOnYellowBg),
        .init(title: "Jeans", description: "Quality newer goes down", imageUrl: jeansOnBlackBg),
        .init(title: "T-Shirts", description: "Blink if you want me", imageUrl: tShirtGirlOnYellowBg)
    ]
}

// MARK: - Testable

struct Testable_HomeScreen1: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        TabView {
            HomeScreen1()
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

struct HomeScreen1_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_HomeScreen1()
        }
    }
}

// MARK: - Image Links

private let profile = ExplorerImageAssets.url(named: "web_home_screen1_profile_5cfa55aca3")

private let sneakersThreePairs = ExplorerImageAssets.url(named: "web_cart_screen5_sneakers_three_pairs_32ce2597b8")
private let sneakersBlackOnBlueBg = ExplorerImageAssets.url(named: "web_home_screen1_sneakers_black_on_blue_bg_578f6ebc68")
private let sneakersWhiteOnYellowBg = ExplorerImageAssets.url(named: "web_cart_screen5_sneakers_white_on_yellow_bg_100c84f711")

private let shirtsThreePairs = ExplorerImageAssets.url(named: "web_categories2_shirts_three_pairs_81d5027b53")
private let shoesThreePairs = ExplorerImageAssets.url(named: "web_categories2_shoes_three_pairs_f3c4a5232b")
private let watchesOnYellowBg = ExplorerImageAssets.url(named: "web_categories1_watches_on_yellow_bg_9722965ee2")
private let jeansOnBlackBg = ExplorerImageAssets.url(named: "web_categories2_jeans_on_black_bg_4d0da7b9a3")
private let tShirtGirlOnYellowBg = ExplorerImageAssets.url(named: "web_home_screen1_t_shirt_girl_on_yellow_bg_543f1bf17b")
