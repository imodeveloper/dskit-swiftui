//
//  FoodHomeScreen1.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import SwiftUI
import DSKit

struct FoodHomeScreen1: View {
    
    let viewModel = FoodHomeScreen1Model()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        DSList {
            DSSection(spacing: .regular) {
                LocationView(title: "2464 Royal Ln. Mesa")
                SearchView()
                DSCoverFlow(height: 150, data: viewModel.banners, id: \.self.id) { banner in
                    BannerView(banner: banner)
                }
            }
            DSSection(spacing: .regular) {
                DSVStack(spacing: .regular) {
                    DSSectionHeaderView(
                        title: "Popular Products",
                        actionTitle: "View all",
                        action: { self.dismiss() }
                    )
                    DSHScroll(
                        spacing: .regular,
                        data: viewModel.popularProducts,
                        id: \.self.id
                    ) { product in
                        PopularProductView(product: product)
                    }
                }
            }
            DSSection(spacing: .custom(15)) {
                DSVStack(spacing: .regular) {
                    DSSectionHeaderView(
                        title: "All Categories",
                        actionTitle: "View all",
                        action: { self.dismiss() }
                    )
                    DSHScroll(
                        spacing: .regular,
                        data: viewModel.categories,
                        id: \.self.id
                    ) { category in
                        CategoryView(category: category)
                    }
                }
                .dsPadding(.bottom)
            }
        }
    }
}

extension FoodHomeScreen1 {
    
    // MARK: - Profile View
    struct LocationView: View {
        let title: String
        var body: some View {
            DSHStack {
                DSVStack(spacing: .zero) {
                    DSText("Your Location")
                        .dsTextStyle(.smallSubheadline)
                    DSText(title)
                        .dsTextStyle(.headline)
                }
                
                Spacer()
                
                DSButton(
                    title: "Change",
                    rightSystemName: "location.circle.fill",
                    style: .clear,
                    maxWidth: false
                ) { }
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
                    DSVStack(spacing: .zero) {
                        DSText(category.title)
                            .dsTextStyle(.smallHeadline)
                        DSText(category.subtitle)
                            .dsTextStyle(.smallSubheadline)
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
            DSVStack(spacing: .zero) {
                DSImageView(named: product.image)
                    .dsSize(dimension: 160)
                    .overlay(alignment: .bottomLeading) {
                        DSText(product.discount)
                            .dsTextStyle(.smallSubheadline, .color(.white))
                            .dsPadding(.small)
                            .dsBackground(.view(.button(.accentColor)))
                            .dsPadding(.bottom)
                    }
                
                DSVStack(spacing: .zero) {
                    
                    DSText(product.title)
                        .dsTextStyle(.smallHeadline)
                        .dsPadding(.small)
                        .dsFullWidth()
                    
                    DSHStack {
                        DSHStack(spacing: .zero) {
                            DSImageView(
                                systemName: "star",
                                size: .font(.smallSubheadline),
                                tint: .text(.smallSubheadline)
                            )
                            
                            DSText(product.rating)
                                .dsTextStyle(.smallSubheadline)
                                .dsPadding(.small)
                        }
                        
                        DSHStack(spacing: .zero) {
                            DSImageView(
                                systemName: "clock",
                                size: .font(.smallSubheadline),
                                tint: .text(.smallSubheadline)
                            )
                            
                            DSText(product.time)
                                .dsTextStyle(.smallSubheadline)
                                .dsPadding(.small)
                        }
                    }.dsPadding(.leading, 3)
                        
                }.dsPadding(.regular)
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
                        DSVStack(spacing: .zero) {
                            DSText(banner.title)
                                .dsTextStyle(.headline, 25, .view(.button(.accentColor)))
                            DSText(banner.subtitle)
                                .dsTextStyle(.body, 15)
                        }
                        .dsPadding()
                        .dsPadding(.bottom)
                    }
                    .overlay(alignment: .bottomLeading) {
                        DSVStack(spacing: .zero) {
                            DSText(banner.discount)
                                .dsTextStyle(.smallSubheadline)
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
