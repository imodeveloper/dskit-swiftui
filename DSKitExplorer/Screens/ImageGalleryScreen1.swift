//
//  ImageGalleryScreen1.swift
//  DSKit
//
//  Created by Ivan Borinschi on 21.12.2022.
//

import DSKit
import SwiftUI

struct ImageGalleryScreen1: View {
    @StateObject var viewModel = ImageGalleryScreen1Model()
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
                    )
                    .dsPadding()
                    .onTap {
                        dismiss()
                    }
                }
            DSCoverFlow(
                height: .fillUpTheSpace,
                data: viewModel.topProducts,
                id: \.self
            ) { imageUrl in
                DSImageView(url: imageUrl, style: .none)
            }
        }
        .clipped()
        .dsBackground(.primary)
    }
}

// MARK: - Model

final class ImageGalleryScreen1Model: ObservableObject {
    var topProducts: [URL?] = [
        image3,
        image2,
        image1
    ]
}

// MARK: - Testable

struct Testable_ImageGalleryScreen1: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ImageGalleryScreen1()
    }
}

// MARK: - Preview

struct ImageGalleryScreen1_Previews: PreviewProvider {
    static var previews: some View {
        DSPreviewForEachAppearance {
            Testable_ImageGalleryScreen1()
        }
    }
}

// MARK: - Image Links

private let image1 = ExplorerImageAssets.url(named: "web_image_gallery_screen1_image1_9ec1edc1c4")

private let image2 = ExplorerImageAssets.url(named: "web_image_gallery_screen1_image2_0aaf8381a4")

private let image3 = ExplorerImageAssets.url(named: "web_image_gallery_screen1_image3_575b2f51e4")
