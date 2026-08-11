//
//  DSRemoteImageRequestTests.swift
//  DSKitTests
//
//  Created by Ivan Borinschi on 11.08.2026.
//

import CoreGraphics
@testable import DSKit
import Foundation
import Nuke
import Testing

struct DSRemoteImageRequestTests {
    @Test(
        "Remote images decode and cache a thumbnail matching their rendered pixel size",
        arguments: [
            (DSContentMode.scaleAspectFill, ImageProcessingOptions.ContentMode.aspectFill),
            (DSContentMode.scaleAspectFit, ImageProcessingOptions.ContentMode.aspectFit)
        ]
    )
    func requestUsesRenderedPixelSize(
        contentMode: DSContentMode,
        expectedContentMode: ImageProcessingOptions.ContentMode
    ) throws {
        let url = try #require(URL(string: "https://images.unsplash.com/photo-large"))

        let request = try #require(
            DSRemoteImageRequest.make(
                url: url,
                layoutSize: CGSize(width: 48, height: 64),
                displayScale: 3,
                contentMode: contentMode
            )
        )

        let thumbnail = try #require(
            request.userInfo[.thumbnailKey] as? ImageRequest.ThumbnailOptions
        )
        let expectedThumbnail = ImageRequest.ThumbnailOptions(
            size: CGSize(width: 144, height: 192),
            unit: .pixels,
            contentMode: expectedContentMode
        )

        #expect(request.url == url)
        #expect(thumbnail == expectedThumbnail)
    }

    @Test("A missing remote URL does not create an image request")
    func missingURLDoesNotCreateRequest() {
        let request = DSRemoteImageRequest.make(
            url: nil,
            layoutSize: CGSize(width: 48, height: 48),
            displayScale: 3,
            contentMode: .scaleAspectFill
        )

        #expect(request == nil)
    }
}
