//
//  DSRemoteImageRequest.swift
//  DSKit
//
//  Created by Ivan Borinschi on 11.08.2026.
//

import CoreGraphics
import Foundation
import Nuke

enum DSRemoteImageRequest {
    static func make(
        url: URL?,
        layoutSize: CGSize,
        displayScale: CGFloat,
        contentMode: DSContentMode
    ) -> ImageRequest? {
        guard let url else { return nil }

        let pixelSize = CGSize(
            width: max(1, ceil(layoutSize.width * displayScale)),
            height: max(1, ceil(layoutSize.height * displayScale))
        )
        let thumbnail = ImageRequest.ThumbnailOptions(
            size: pixelSize,
            unit: .pixels,
            contentMode: contentMode.nukeContentMode
        )

        // Nuke includes thumbnail options in its image-cache key, so repeated
        // list rows reuse the bounded decoded image instead of the full source.
        return ImageRequest(
            url: url,
            userInfo: [.thumbnailKey: thumbnail]
        )
    }
}

private extension DSContentMode {
    var nukeContentMode: ImageProcessingOptions.ContentMode {
        switch self {
        case .scaleAspectFit:
            return .aspectFit
        case .scaleAspectFill:
            return .aspectFill
        }
    }
}
