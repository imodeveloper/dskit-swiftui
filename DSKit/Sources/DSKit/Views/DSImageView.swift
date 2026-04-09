//
//  DSImage.swift
//  DSKit
//
//  Created by Ivan Borinschi on 15.12.2022.
//

import SwiftUI
import SDWebImage
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
    @Environment(\.surfaceStyle) var viewStyle: DSSurfaceStyle
    let image: DSImage

    public init(dsImage: DSImage) {
        self.image = dsImage
    }

    public init(
        systemName: String,
        size: DSSize,
        tint: DSColorToken? = nil
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
        tintColor: DSColorToken? = nil,
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
        tintColor: DSColorToken? = nil,
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
        tintColor: DSColorToken? = nil,
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
    @State private var currentWidth: CGFloat = 0
    @State private var resolvedAspectRatio: CGFloat?

    let url: URL?
    let image: DSImage

    var body: some View {
        GeometryReader { geometry in
            let layoutSize = effectiveLayoutSize(from: geometry.size)
            let loadFailed = imageManager.image == nil && imageManager.error != nil

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
                                        registerMetadata(for: uiImage)
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
                    placeholderView(
                        for: layoutSize,
                        failed: loadFailed
                    )
                }
            }
            .onAppear {
                updateLayoutState(for: geometry.size)
                loadImageIfNeeded(for: layoutSize)
            }
            .onChange(of: geometry.size) { _, newSize in
                updateLayoutState(for: newSize)
                loadImageIfNeeded(for: effectiveLayoutSize(from: newSize))
            }
            .onChange(of: url) { _, _ in
                imageLoaded = false
                lastLoadRequest = nil
                currentWidth = 0
                resolvedAspectRatio = nil
                updateLayoutState(for: geometry.size)
                loadImageIfNeeded(for: effectiveLayoutSize(from: geometry.size))
            }
            .onDisappear {
                imageManager.cancel()
            }
        }
        .frame(height: adaptiveDisplayHeight)
    }

    @ViewBuilder
    private func placeholderView(for layoutSize: CGSize, failed: Bool) -> some View {
        let placeholderIconSize = adaptivePlaceholderIconSize(for: layoutSize)

        Color.gray.opacity(0.1)
            .overlay(alignment: .center) {
                Image(systemName: failed ? "photo.badge.exclamationmark" : "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.secondary.opacity(failed ? 0.95 : 0.75))
                    .frame(width: placeholderIconSize, height: placeholderIconSize)
            }
            .setDisplayShape(shape: image.displayShape)
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
            // Reuse source bytes when possible and avoid encoding opaque images
            // with an alpha channel when SDWebImage has to write disk data.
            .cacheSerializer: DSOpaqueAwareCacheSerializer.instance,
            // Keep the original payload on disk so subsequent requests can
            // reuse source bytes without another network fetch.
            .originalStoreCacheType: SDImageCacheType.disk.rawValue
        ]

        imageManager.cancel()
        imageManager.load(url: url, context: context)
    }

    private func updateLayoutState(for size: CGSize) {
        guard size.width > 0 else {
            if resolvedAspectRatio == nil,
               let cachedAspectRatio = DSImageAspectRatioCache.shared.aspectRatio(for: url) {
                resolvedAspectRatio = cachedAspectRatio
            }
            return
        }

        let width = size.width
        if abs(currentWidth - width) > 0.5 {
            currentWidth = width
        }

        if resolvedAspectRatio == nil,
           let cachedAspectRatio = DSImageAspectRatioCache.shared.aspectRatio(for: url) {
            resolvedAspectRatio = cachedAspectRatio
        }
    }

    private func effectiveLayoutSize(from size: CGSize) -> CGSize {
        let width = max(CGFloat(1), size.width)
        let height = max(CGFloat(1), adaptiveDisplayHeight ?? size.height)
        return CGSize(width: width, height: height)
    }

    private func adaptivePlaceholderIconSize(for size: CGSize) -> CGFloat {
        let minSide = max(CGFloat(1), min(size.width, size.height))
        return min(max(14, minSide * 0.24), 22)
    }

    private var adaptiveDisplayHeight: CGFloat? {
        guard let defaultHeight = image.size.height.adaptiveHeightDefault else {
            return nil
        }

        guard currentWidth > 0 else {
            return defaultHeight
        }

        guard let aspectRatio = effectiveAspectRatio, aspectRatio > 0 else {
            return defaultHeight
        }

        return max(CGFloat(1), currentWidth / aspectRatio)
    }

    private var effectiveAspectRatio: CGFloat? {
        if let resolvedAspectRatio, resolvedAspectRatio > 0 {
            return resolvedAspectRatio
        }

        guard let cachedAspectRatio = DSImageAspectRatioCache.shared.aspectRatio(for: url),
              cachedAspectRatio > 0
        else {
            return nil
        }

        return cachedAspectRatio
    }

    private func registerMetadata(for uiImage: DSUIImage) {
        guard let aspectRatio = uiImage.dsAspectRatio, aspectRatio > 0 else {
            return
        }

        DSImageAspectRatioCache.shared.store(aspectRatio: aspectRatio, for: url)

        if resolvedAspectRatio == nil || abs((resolvedAspectRatio ?? 0) - aspectRatio) > 0.001 {
            resolvedAspectRatio = aspectRatio
        }
    }
}

private struct LoadRequest: Equatable {
    let url: URL?
    let pixelSize: CGSize
}

private enum DSOpaqueAwareCacheSerializer {
    static let instance = SDWebImageCacheSerializer(block: { image, originalData, _ in
        if let originalData, !originalData.isEmpty {
            return originalData
        }

        // SDWebImage sometimes needs to re-encode cache payloads (for example
        // transformed thumbnails). Prefer JPEG for opaque images to avoid alpha
        // storage warnings and reduce decode memory pressure.
        if image.dsHasAlphaChannel {
            return image.sd_imageData(as: .PNG)
        } else {
            return image.sd_imageData(as: .JPEG, compressionQuality: 0.9)
        }
    })
}

private extension DSUIImage {
    var dsAspectRatio: CGFloat? {
        let pixelSize = dsPixelSize
        guard pixelSize.width > 0, pixelSize.height > 0 else {
            return nil
        }

        return pixelSize.width / pixelSize.height
    }

    var dsPixelSize: CGSize {
        #if canImport(UIKit)
            if let cgImage {
                return CGSize(width: cgImage.width, height: cgImage.height)
            }
            return CGSize(width: size.width * scale, height: size.height * scale)
        #elseif canImport(AppKit)
            if let cgImage = cgImage(forProposedRect: nil, context: nil, hints: nil) {
                return CGSize(width: cgImage.width, height: cgImage.height)
            }
            return CGSize(width: size.width, height: size.height)
        #endif
    }

    var dsHasAlphaChannel: Bool {
        guard let cgImage else { return true }

        switch cgImage.alphaInfo {
        case .none, .noneSkipFirst, .noneSkipLast:
            return false
        default:
            return true
        }
    }
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

private final class DSImageAspectRatioCache: @unchecked Sendable {
    static let shared = DSImageAspectRatioCache()

    private struct Aggregate {
        var total: CGFloat
        var count: Int

        mutating func add(_ value: CGFloat) {
            total += value
            count += 1
        }

        var average: CGFloat? {
            guard count > 0 else { return nil }
            return total / CGFloat(count)
        }
    }

    private let lock = NSLock()
    private var exactRatios: [String: CGFloat] = [:]
    private var directoryRatios: [String: Aggregate] = [:]
    private var hostRatios: [String: Aggregate] = [:]

    func aspectRatio(for url: URL?) -> CGFloat? {
        guard let url else { return nil }

        lock.lock()
        defer { lock.unlock() }

        if let exactKey = exactKey(for: url), let ratio = exactRatios[exactKey] {
            return ratio
        }

        if let directoryKey = directoryKey(for: url),
           let ratio = directoryRatios[directoryKey]?.average {
            return ratio
        }

        if let hostKey = hostKey(for: url),
           let ratio = hostRatios[hostKey]?.average {
            return ratio
        }

        return nil
    }

    func store(aspectRatio: CGFloat, for url: URL?) {
        guard aspectRatio > 0, let url else { return }

        lock.lock()
        defer { lock.unlock() }

        if let exactKey = exactKey(for: url) {
            exactRatios[exactKey] = aspectRatio
        }

        if let directoryKey = directoryKey(for: url) {
            var aggregate = directoryRatios[directoryKey] ?? Aggregate(total: 0, count: 0)
            aggregate.add(aspectRatio)
            directoryRatios[directoryKey] = aggregate
        }

        if let hostKey = hostKey(for: url) {
            var aggregate = hostRatios[hostKey] ?? Aggregate(total: 0, count: 0)
            aggregate.add(aspectRatio)
            hostRatios[hostKey] = aggregate
        }
    }

    private func exactKey(for url: URL) -> String? {
        guard let host = hostKey(for: url) else { return nil }
        let path = url.path.isEmpty ? "/" : url.path
        return "\(host)|\(path)"
    }

    private func directoryKey(for url: URL) -> String? {
        guard let host = hostKey(for: url) else { return nil }
        let directoryPath = url.deletingLastPathComponent().path
        guard directoryPath.isEmpty == false else { return host }
        return "\(host)|\(directoryPath)"
    }

    private func hostKey(for url: URL) -> String? {
        url.host?.lowercased()
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
    public var tintColor: DSColorToken?

    public init(
        content: DSImageContentType,
        displayShape: DSDisplayShape = .none,
        size: DSSize,
        tintColor: DSColorToken? = nil,
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
        tintColor: DSColorToken? = nil,
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
        tintColor: DSColorToken? = nil,
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
        tintColor: DSColorToken? = nil,
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
        tintColor: DSColorToken? = nil,
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
    func imageWith(tint tintColor: DSColorToken) -> DSImage {
        var image = self
        image.tintColor = tintColor
        return image
    }
}

private extension DSDimension {
    var adaptiveHeightDefault: CGFloat? {
        if case .adaptiveHeight(let defaultHeight) = self {
            return defaultHeight
        }
        return nil
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
