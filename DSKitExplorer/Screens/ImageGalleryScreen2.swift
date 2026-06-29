//
//  ImageGalleryScreen2.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct ImageGalleryScreen2: View {
    @StateObject var viewModel = ImageGalleryScreen2Model()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        DSVStack {
            DSText("Gallery")
                .dsPadding()
                .dsMaxWidthCentered()
                .overlay(alignment: .trailing) {
                    DSImageView(
                        systemName: "xmark.circle",
                        size: .mediumIcon
                    ).onTap { dismiss() }
                }

            DSCoverFlow(
                height: .fillUpTheSpace,
                data: viewModel.topProducts,
                id: \.self
            ) { imageUrl in
                DSImageView(url: imageUrl, style: .capsule)
            }
        }
        .clipped()
        .dsScreen()
    }
}

// MARK: - Model

final class ImageGalleryScreen2Model: ObservableObject {
    var topProducts: [URL?] = [
        image1,
        image2,
        image3
    ]
}

// MARK: - Testable

struct Testable_ImageGalleryScreen2: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ImageGalleryScreen2()
    }
}

// MARK: - Preview

struct ImageGalleryScreen2_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_ImageGalleryScreen2()
        }
    }
}

// MARK: - Image Links

private let image1 = ExplorerImageAssets.url(named: "web_image_gallery_screen1_image1_9ec1edc1c4")

private let image2 = ExplorerImageAssets.url(named: "web_image_gallery_screen1_image2_0aaf8381a4")

private let image3 = ExplorerImageAssets.url(named: "web_image_gallery_screen1_image3_575b2f51e4")
