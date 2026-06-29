//
//  AboutUsScreen1.swift
//  DSKit
//
//  Created by Ivan Borinschi on 31.13.3033.
//

import DSKit
import SwiftUI

struct AboutUsScreen1: View {
    @State private var isSwitchOn = true
    @Environment(\.appearance) var appearance: DSAppearance

    let imageGallery = [p1Image, p2Image, p3Image]

    var body: some View {
        DSList {
            DSSection {
                DSText("Our Story")
                    .dsTextStyle(.title2)

                DSText("Here you will feel the attitude, here you will receive quality, here you will see the atmosphere of an authentic store")
                    .dsTextStyle(.body)

                DSCoverFlow(height: 250, data: imageGallery, id: \.self) { image in
                    DSImageView(url: image)
                        .dsCornerRadius()
                }

                DSVStack(alignment: .leading) {
                    DSHStack(spacing: .space16) {
                        DSImageView(
                            systemName: "message.fill",
                            size: .font(.headline),
                            tint: .text(.body)
                        )
                        DSText("Introducing Grocify, where convenience meets quality. Our goal: tailor solutions for modern grocery stores. With a focus on user-friendly technology, we empower stores of all sizes to thrive.")
                            .dsTextStyle(.caption1)
                            .dsFullWidth()
                    }

                    DSDivider()
                        .dsPadding(.leading, 30)

                    DSHStack(spacing: .space16) {
                        DSImageView(
                            systemName: "shippingbox.fill",
                            size: .font(.headline),
                            tint: .text(.body)
                        )
                        DSText("At Grocify, collaboration is key. Our team crafts cutting-edge tools for seamless operations, from inventory management to customer service. From local markets to supermarket chains, we're committed to elevating the grocery experience.")
                            .dsTextStyle(.subheadline)
                            .dsFullWidth()
                    }

                    DSDivider()
                        .dsPadding(.leading, 30)

                    DSHStack(spacing: .space16) {
                        DSImageView(
                            systemName: "leaf.arrow.triangle.circlepath",
                            size: .font(.headline),
                            tint: .text(.body)
                        )
                        DSText("Join us at Grocify, redefining the grocery industry. With intuitive solutions, we're shaping the future of shopping.")
                            .dsTextStyle(.footnote)
                            .dsFullWidth()
                    }

                }.dsCardStyle()
            }
            .dsSpacing(.space16)
        }
    }
}

// MARK: - Testable

struct Testable_AboutUsScreen1: View {
    @Environment(\.dismiss) var dismiss
    @State var selectedTab: Int = 2
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Shop")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }.tag(0)

            Text("Cart")
                .tabItem {
                    Image(systemName: "cart.fill")
                    Text("Cart")
                }.tag(1)

            AboutUsScreen1()
                .tabItem {
                    Image(systemName: "info.circle.fill")
                    Text("About")
                }.tag(2)

            DSVStack {
                DSButton(title: "Dismiss", style: .clear) {
                    dismiss()
                }
            }.tabItem {
                Image(systemName: "gearshape")
                Text("Settings")
            }.tag(3)
        }
    }
}

struct AboutUsScreen1_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance { Testable_AboutUsScreen1() }
    }
}

private let p1Image = ExplorerImageAssets.url(named: "web_about_us_screen1_p1_image_6daa0fbfca")
private let p2Image = ExplorerImageAssets.url(named: "web_about_us_screen1_p2_image_18fe4f1187")
private let p3Image = ExplorerImageAssets.url(named: "web_about_us_screen1_p3_image_19dbcf5192")
