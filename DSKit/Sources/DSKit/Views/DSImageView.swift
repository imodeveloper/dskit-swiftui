//
//  DSImage.swift
//  DSKit
//
//  Created by Ivan Borinschi on 15.12.2022.
//

import SwiftUI
import SDWebImageSwiftUI

/*
 ## DSImageView

 `DSImageView` is a versatile SwiftUI component within the DSKit framework designed to display images in various formats including system symbols, local images, and remote images. It supports extensive customization options to fit the design system's requirements.
 
 #### Initialization:
 The `DSImageView` can be initialized with various types of image sources:
 - System symbols with optional tinting.
 - Local UI images with optional display shapes and tinting.
 - Remote image URLs with automatic fetching and display.
 - Each initializer configures the view to handle specific image requirements such as scaling, aspect ratio, and shape.

 #### Usage:
 `DSImageView` is ideal for applications requiring diverse image representations, from icons in buttons to profile pictures, and gallery images. Its flexibility makes it suitable for almost any visual representation involving images in a SwiftUI application.
*/

public struct DSImageView: View {

    let unitTestMode = ProcessInfo.processInfo.arguments.contains("TESTMODE")

    @Environment(\.appearance) var appearance: DSAppearance
    @Environment(\.viewStyle) var viewStyle: DSViewStyle
    let image: DSImage

    public init(dsImage: DSImage) {
        self.image = dsImage
    }

    public init(
        systemName: String,
        size: DSSize,
        tint: DSColorKey? = nil
    ) {
        self.image = DSImage(
            systemName: systemName,
            displayShape: .none,
            size: size,
            tintColor: tint,
            contentMode: .scaleAspectFit
        )
    }

    public init(
        uiImage: DSUIImage?,
        displayShape: DSDisplayShape = .none,
        size: DSSize = .fillUpTheSpace,
        tintColor: DSColorKey? = nil,
        contentMode: DSContentMode = .scaleAspectFill
    ) {
        self.image = DSImage(
            uiImage: uiImage,
            displayShape: displayShape,
            size: size,
            tintColor: tintColor,
            contentMode: contentMode
        )
    }

    public init(
        named: String,
        displayShape: DSDisplayShape = .none,
        size: DSSize = .fillUpTheSpace,
        tintColor: DSColorKey? = nil,
        contentMode: DSContentMode = .scaleAspectFill
    ) {
        self.image = DSImage(
            named: named,
            displayShape: displayShape,
            size: size,
            tintColor: tintColor,
            contentMode: contentMode
        )
    }

    public init(
        url: URL?,
        style: DSDisplayShape = .none,
        size: DSSize = .fillUpTheSpace,
        tintColor: DSColorKey? = nil,
        contentMode: DSContentMode = .scaleAspectFill
    ) {
        self.image = .init(
            content: .imageURL(url: url),
            displayShape: style,
            size: size,
            tintColor: tintColor,
            contentMode: contentMode
        )
    }

    public var body: some View {
        switch image.content {
        case .system(name: let name):
            Image(systemName: name)
                .resizable()
                .setImageTint(tint: image.tintColor)
                .setContentMode(mode: image.contentMode)
                .dsSize(image.size)
        case .image(image: let uiImage):

            if let uiImage {
                Color.clear
                    .overlay(alignment: .center) {
                        Image(dsUIImage: uiImage)
                            .resizable()
                            .setImageTint(tint: image.tintColor)
                            .setContentMode(mode: image.contentMode)
                    }
                    .dsSize(image.size)
                    .setDisplayShape(shape: image.displayShape)
            } else {
                Color.gray.opacity(0.1)
                    .dsSize(image.size)
                    .setDisplayShape(shape: image.displayShape)
            }
        case .imageURL(url: let url):
            if unitTestMode {
                if let uiImage = fileImage(for: url) {
                    Color.gray.opacity(0.1)
                        .overlay(alignment: .center) {
                            Image(dsUIImage: uiImage)
                                .resizable()
                                .setContentMode(mode: image.contentMode)
                        }
                        .dsSize(image.size)
                        .setDisplayShape(shape: image.displayShape)
                } else {
                    Color.gray.opacity(0.1)
                        .dsSize(image.size)
                        .setDisplayShape(shape: image.displayShape)
                }
            } else {
                DSRemoteImageView(url: url, image: image)
                    .dsSize(image.size)
            }
        }
    }

    private func fileImage(for url: URL?) -> DSUIImage? {
        guard let url, url.isFileURL else {
            return nil
        }
        if let cached = DSImageViewFileCache.image(for: url) {
            return cached
        }

        guard let data = try? Data(contentsOf: url), let decoded = DSUIImage(data: data) else {
            return nil
        }

        DSImageViewFileCache.store(decoded, for: url)
        return decoded
    }
}

private struct DSRemoteImageView: View {

    @Environment(\.displayScale) private var displayScale
    @StateObject private var imageManager = ImageManager()
    @State private var imageLoaded = false
    @State private var lastLoadRequest: LoadRequest?

    let url: URL?
    let image: DSImage

    var body: some View {
        GeometryReader { geometry in
            Group {
                if imageManager.image != nil {
                    Color.gray.opacity(0.1)
                        .overlay(alignment: .center) {
                            if let uiImage = imageManager.image {
                                Image(dsUIImage: uiImage)
                                    .resizable()
                                    .setContentMode(mode: image.contentMode)
                                    .opacity(imageLoaded ? 1 : 0)
                                    .onAppear {
                                        if imageManager.cacheType == .none {
                                            withAnimation { imageLoaded = true }
                                        } else {
                                            imageLoaded = true
                                        }
                                    }
                            }
                        }
                        .setDisplayShape(shape: image.displayShape)
                } else {
                    Color.gray.opacity(0.1)
                        .setDisplayShape(shape: image.displayShape)
                }
            }
            .onAppear {
                loadImageIfNeeded(for: geometry.size)
            }
            .onChange(of: geometry.size) { newSize in
                loadImageIfNeeded(for: newSize)
            }
            .onChange(of: url) { _ in
                imageLoaded = false
                loadImageIfNeeded(for: geometry.size)
            }
            .onDisappear {
                imageManager.cancel()
            }
        }
    }

    private func loadImageIfNeeded(for size: CGSize) {
        guard size.width > 0, size.height > 0 else { return }

        let targetSize = CGSize(
            width: max(CGFloat(1), ceil(size.width * displayScale)),
            height: max(CGFloat(1), ceil(size.height * displayScale))
        )
        let request = LoadRequest(url: url, pixelSize: targetSize)

        guard request != lastLoadRequest else { return }
        lastLoadRequest = request

        // Use decoder thumbnail context instead of image transformer to avoid
        // transformed WebP disk re-encoding on iOS simulators without WebP writer support.
        let context: [SDWebImageContextOption: Any] = [
            .imageThumbnailPixelSize: targetSize,
            .imagePreserveAspectRatio: true,
            .imageScaleFactor: displayScale,
            // Keep the derived (thumbnail) variant in memory only to avoid
            // disk encode attempts for unsupported writer formats like WebP.
            .storeCacheType: SDImageCacheType.memory.rawValue,
            // Keep the original payload on disk so subsequent requests can
            // reuse source bytes without another network fetch.
            .originalStoreCacheType: SDImageCacheType.disk.rawValue
        ]

        imageManager.cancel()
        imageManager.load(url: url, context: context)
    }
}

private struct LoadRequest: Equatable {
    let url: URL?
    let pixelSize: CGSize
}

private enum DSImageViewFileCache {
    private static let cache = NSCache<NSURL, DSUIImage>()

    static func image(for url: URL) -> DSUIImage? {
        cache.object(forKey: url as NSURL)
    }

    static func store(_ image: DSUIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}

public enum DSImageContentType {
    case system(name: String)
    case image(image: DSUIImage?)
    case imageURL(url: URL?)
}

public struct DSImage {

    public var displayShape: DSDisplayShape
    public var content: DSImageContentType
    public var contentMode: DSContentMode
    public var size: DSSize
    public var tintColor: DSColorKey?

    public init(
        content: DSImageContentType,
        displayShape: DSDisplayShape = .none,
        size: DSSize,
        tintColor: DSColorKey? = nil,
        contentMode: DSContentMode = .scaleAspectFit
    ) {
        self.content = content
        self.displayShape = displayShape
        self.tintColor = tintColor
        self.size = size
        self.contentMode = contentMode
    }

    public init(
        systemName: String,
        displayShape: DSDisplayShape = .none,
        size: DSSize,
        tintColor: DSColorKey? = nil,
        contentMode: DSContentMode = .scaleAspectFit
    ) {
        self.init(
            content: .system(name: systemName),
            displayShape: displayShape,
            size: size,
            tintColor: tintColor,
            contentMode: contentMode
        )
    }

    public init(
        named: String,
        displayShape: DSDisplayShape = .none,
        size: DSSize,
        tintColor: DSColorKey? = nil,
        contentMode: DSContentMode = .scaleAspectFit
    ) {
        self.init(
            content: .image(image: DSUIImage(named: named)),
            displayShape: displayShape,
            size: size,
            tintColor: tintColor,
            contentMode: contentMode
        )
    }

    public init(
        uiImage: DSUIImage?,
        displayShape: DSDisplayShape = .none,
        size: DSSize = .fillUpTheSpace,
        tintColor: DSColorKey? = nil,
        contentMode: DSContentMode = .scaleAspectFit
    ) {
        self.init(
            content: .image(image: uiImage),
            displayShape: displayShape,
            size: size,
            tintColor: tintColor,
            contentMode: contentMode
        )
    }

    public init(
        imageURL: URL?,
        displayShape: DSDisplayShape = .none,
        size: DSSize = .fillUpTheSpace,
        tintColor: DSColorKey? = nil,
        contentMode: DSContentMode = .scaleAspectFit
    ) {
        self.init(
            content: .imageURL(url: imageURL),
            displayShape: displayShape,
            size: size,
            tintColor: tintColor,
            contentMode: contentMode
        )
    }
}

extension DSImage {
    func imageWith(tint tintColor: DSColorKey) -> DSImage {
        var image = self
        image.tintColor = tintColor
        return image
    }
}

struct Testable_DSImageView: View {
    private static let localDemoImageURL: URL? = {
        guard let image = DSUIImage(named: "demo", in: Bundle.main, with: nil),
              let data = image.jpegData(compressionQuality: 0.9) else {
            return nil
        }
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("dskit-demo.jpg")
        try? data.write(to: url, options: [.atomic])
        return url
    }()

    let imageUrl = Testable_DSImageView.localDemoImageURL

    let testImage = DSUIImage(named: "demo", in: Bundle.main, with: nil)

    var body: some View {
        DSVStack {
            DSHStack {
                DSImageView(
                    url: imageUrl,
                    style: .circle,
                    size: .size(50)
                )
                DSImageView(
                    url: imageUrl,
                    style: .capsule,
                    size: .size(width: 100, height: 50)
                )
                DSImageView(
                    url: imageUrl,
                    style: .none,
                    size: .size(50)
                )
            }

            DSHStack {
                DSImageView(
                    uiImage: testImage,
                    displayShape: .circle,
                    size: .size(50)
                )
                DSImageView(
                    uiImage: testImage,
                    displayShape: .capsule,
                    size: .size(50)
                )
                DSImageView(
                    uiImage: testImage,
                    displayShape: .none,
                    size: .size(width: 100, height: 50)
                )
            }

            DSHStack {
                DSImageView(
                    systemName: "sun.rain.fill",
                    size: .font(.title1),
                    tint: .color(.red)
                )
                DSImageView(
                    systemName: "sun.rain.fill",
                    size: .font(.body),
                    tint: .color(.green)
                )
                DSImageView(
                    systemName: "sun.rain.fill",
                    size: .font(.headline),
                    tint: .color(.blue)
                )
                DSImageView(
                    systemName: "sun.rain.fill",
                    size: .font(.subheadline),
                    tint: .color(.cyan)
                )
            }
        }
    }
}

struct DSImageView_Previews: PreviewProvider {
    static var previews: some View {
        DSPreview {
            DSImageViewInteractivePreview()
        }
        .previewDisplayName("DSImageView Interactive")
    }
}

private struct DSImageViewInteractivePreview: View {
    private static let localDemoImageURL: URL? = {
        guard let image = DSUIImage(named: "demo", in: Bundle.main, with: nil),
              let data = image.jpegData(compressionQuality: 0.9) else {
            return nil
        }
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("dskit-demo-preview.jpg")
        try? data.write(to: url, options: [.atomic])
        return url
    }()

    @State private var selectedIndex: Double = 3
    private let demoImage = DSUIImage(named: "demo", in: Bundle.main, with: nil)

    private var dynamicTypeSnapshots: [(String, ContentSizeCategory)] {
        [
            ("extraSmall", .extraSmall),
            ("small", .small),
            ("medium", .medium),
            ("large", .large),
            ("extraLarge", .extraLarge),
            ("extraExtraLarge", .extraExtraLarge),
            ("extraExtraExtraLarge", .extraExtraExtraLarge),
            ("accessibilityMedium", .accessibilityMedium),
            ("accessibilityLarge", .accessibilityLarge),
            ("accessibilityExtraLarge", .accessibilityExtraLarge),
            ("accessibilityExtraExtraLarge", .accessibilityExtraExtraLarge),
            ("accessibilityExtraExtraExtraLarge", .accessibilityExtraExtraExtraLarge)
        ]
    }

    private var clampedIndex: Int {
        min(max(Int(selectedIndex.rounded()), 0), dynamicTypeSnapshots.count - 1)
    }

    private var selectedCategory: ContentSizeCategory {
        dynamicTypeSnapshots[clampedIndex].1
    }

    private var selectedLabel: String {
        dynamicTypeSnapshots[clampedIndex].0
    }

    var body: some View {
        ZStack {
            DSVStack {
                DSText("Size Category: \(selectedLabel)").dsTextStyle(.subheadline)
                Slider(
                    value: $selectedIndex,
                    in: 0...Double(dynamicTypeSnapshots.count - 1),
                    step: 1
                )
            }.offset(y: -200)

            DSVStack {
                DSHStack {
                    DSImageView(
                        uiImage: demoImage,
                        displayShape: .circle,
                        size: .size(50)
                    )
                    DSImageView(
                        uiImage: demoImage,
                        displayShape: .capsule,
                        size: .size(
                            width: 100,
                            height: 50
                        )
                    )
                    DSImageView(
                        url: Self.localDemoImageURL,
                        style: .none,
                        size: .size(50)
                    )
                }

                DSHStack {
                    DSImageView(systemName: "sun.rain.fill", size: .font(.title1), tint: .color(.red))
                    DSImageView(systemName: "heart.fill", size: .font(.headline), tint: .color(.pink))
                    DSImageView(systemName: "bell.fill", size: .font(.subheadline), tint: .color(.blue))
                }
            }
            .environment(\.sizeCategory, selectedCategory)
            .id(selectedLabel)
        }
        .dsHeight(300)
    }
}
