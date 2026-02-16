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

private let image1 = URL(string: "https://images.unsplash.com/photo-1522512115668-c09775d6f424?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")

private let image2 = URL(string: "https://images.unsplash.com/photo-1516313570236-85371711ee13?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")

private let image3 = URL(string: "https://images.unsplash.com/photo-1495298599282-d8920eb5009b?q=80&w=3087&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
