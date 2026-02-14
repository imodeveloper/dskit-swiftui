//
//  AssertSnapshot.swift
//  SharedTests
//
//  Created by Ivan Borinschi on 29.03.2024.
//

import SwiftUI
import XCTest
import SnapshotTesting
import UIKit
import DSKit

open class SnapshotTestCase: XCTestCase {
    public var recordAll = false

    override open func setUpWithError() throws {
        try super.setUpWithError()
        UIView.setAnimationsEnabled(false)
    }
}

struct SnapshotAssertionOptions {
    var recordDelay: TimeInterval = 0.5
    var retries: Int = 2
    var retryDelay: TimeInterval = 0.2
    var precision: Float = 0.96
    var perceptualPrecision: Float = 0.96
    var minimumPrecision: Float = 0.96
    var minimumPerceptualPrecision: Float = 0.96
    var precisionStep: Float = 0
    var perceptualPrecisionStep: Float = 0
}

enum SnapshotLayout {
    static let deterministicScreenTraits: UITraitCollection = .init(
        traitsFrom: [
            .iPhone(.portrait),
            .init(displayScale: 3)
        ]
    )
    
    static let deterministicComponentTraits: UITraitCollection = .init(
        traitsFrom: [
            .iPhone(.portrait, userInterfaceStyle: .dark),
            .init(displayScale: 3)
        ]
    )

    case component(
        width: CGFloat = 400,
        padding: CGFloat = 12,
        background: DSViewStyle = .primary,
        traits: UITraitCollection = SnapshotLayout.deterministicComponentTraits
    )
    case screen(
        config: ViewImageConfig = .iPhone15Pro(.portrait),
        traits: UITraitCollection = SnapshotLayout.deterministicScreenTraits,
        appearance: DSAppearance = LightBlueAppearance()
    )
}

extension XCTestCase {
    func assertSnapshot(
        for testView: some View,
        named: String,
        layout: SnapshotLayout = .component(),
        options: SnapshotAssertionOptions = SnapshotAssertionOptions(),
        record: Bool? = nil,
        timeout: TimeInterval = 5,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        SnapshotTesting.diffTool = "open"
        let recordAll = (self as? SnapshotTestCase)?.recordAll ?? false
        let shouldRecord = record ?? (ProcessInfo.processInfo.environment["SNAPSHOT_RECORD"] == "1") || recordAll
        isRecording = shouldRecord

        let (rootView, config, overrideTraits) = makeSnapshotInputs(
            view: testView,
            layout: layout
        )

        let hostingController = UIHostingController(rootView: rootView)
        hostingController.view.backgroundColor = .clear

        let snapshotHelper = SnapshotImagePreparer()
        let prepared = snapshotHelper.prepareView(
            config: config,
            traits: overrideTraits,
            view: hostingController.view,
            viewController: hostingController
        )
        defer { prepared.cleanup() }

        if options.recordDelay > 0 {
            RunLoop.main.run(until: Date().addingTimeInterval(options.recordDelay))
        }
        hostingController.view.setNeedsLayout()
        hostingController.view.layoutIfNeeded()

        var failure: String?
        for attempt in 0...max(options.retries, 0) {
            let attemptPrecision = max(
                options.precision - (Float(attempt) * options.precisionStep),
                options.minimumPrecision
            )
            let attemptPerceptualPrecision = max(
                options.perceptualPrecision - (Float(attempt) * options.perceptualPrecisionStep),
                options.minimumPerceptualPrecision
            )

            let snapshotting = Snapshotting<UIImage, UIImage>.image(
                precision: attemptPrecision,
                perceptualPrecision: attemptPerceptualPrecision,
                scale: prepared.traits.displayScale
            )
            .pullback { view in
                renderSnapshot(view: view, traits: prepared.traits)
            }

            failure = verifySnapshot(
                matching: hostingController.view,
                as: snapshotting,
                named: "snapshot",
                record: shouldRecord,
                snapshotDirectory: nil,
                timeout: timeout,
                file: file,
                testName: named,
                line: line
            )

            if failure == nil {
                if attempt > 0 {
                    let warning = "Snapshot matched with reduced precision \(attemptPrecision)/\(attemptPerceptualPrecision) on attempt \(attempt + 1)"
                    XCTContext.runActivity(named: warning) { _ in }
                }
                break
            }

            if attempt < options.retries {
                RunLoop.main.run(until: Date().addingTimeInterval(options.retryDelay))
            }
        }

        if let failure {
            XCTFail(failure, file: file, line: line)
        }
    }
}

private func makeSnapshotInputs(
    view: some View,
    layout: SnapshotLayout
) -> (AnyView, ViewImageConfig, UITraitCollection) {
    switch layout {
    case let .component(width, padding, background, traits):
        let preparedView = view
            .frame(width: width)
            .padding(padding)
            .dsBackground(background)
            .fixedSize(horizontal: true, vertical: true)
        let config = ViewImageConfig(
            safeArea: .zero,
            size: nil,
            traits: traits
        )
        return (AnyView(preparedView), config, traits)
    case let .screen(config, traits, appearance):
        let preparedView = view.dsAppearance(appearance)
        return (AnyView(preparedView), config, traits)
    }
}

private func renderSnapshot(view: UIView, traits: UITraitCollection) -> UIImage {
    view.setNeedsLayout()
    view.layoutIfNeeded()
    let bounds = view.bounds
    let renderer: UIGraphicsImageRenderer
    if #available(iOS 11.0, *) {
        renderer = UIGraphicsImageRenderer(bounds: bounds, format: .init(for: traits))
    } else {
        renderer = UIGraphicsImageRenderer(bounds: bounds)
    }
    let image = renderer.image { context in
        if !view.drawHierarchy(in: bounds, afterScreenUpdates: true) {
            view.layer.render(in: context.cgContext)
        }
    }
    return normalizeTo8Bit(image)
}

private func normalizeTo8Bit(_ image: UIImage) -> UIImage {
    guard let cgImage = image.cgImage else { return image }
    let width = cgImage.width
    let height = cgImage.height
    let colorSpace = CGColorSpace(name: CGColorSpace.sRGB) ?? CGColorSpaceCreateDeviceRGB()
    let alphaInfo = CGImageAlphaInfo.premultipliedLast.rawValue
    let bitmapInfo = CGBitmapInfo(rawValue: alphaInfo)

    guard let context = CGContext(
        data: nil,
        width: width,
        height: height,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: colorSpace,
        bitmapInfo: bitmapInfo.rawValue
    ) else {
        return image
    }

    context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
    guard let normalized = context.makeImage() else { return image }
    return UIImage(cgImage: normalized, scale: image.scale, orientation: .up)
}

final class SnapshotImagePreparer {

    typealias Cleanup = () -> Void

    struct PreparedView {
        let cleanup: Cleanup
        let size: CGSize
        let traits: UITraitCollection
    }
    
    private let offscreen: CGFloat = 10_000

    func prepareView(
        config: ViewImageConfig,
        traits: UITraitCollection,
        view: UIView,
        viewController: UIViewController
    ) -> PreparedView {
        let resolvedSize = resolvedSize(for: config, viewController: viewController, view: view)
        configureView(view, inside: viewController, size: resolvedSize)

        let mergedTraits = UITraitCollection(traitsFrom: [config.traits, traits])
        let window = makeWindow(config: config, viewController: viewController, size: resolvedSize, traits: mergedTraits)
        let dispose = attach(
            viewController: viewController,
            to: window,
            applying: mergedTraits,
            safeArea: config.safeArea
        )
        
        if config.safeArea == .zero {
            view.frame.origin = .init(x: offscreen, y: offscreen)
        }

        return PreparedView(cleanup: dispose, size: resolvedSize, traits: mergedTraits)
    }
}

// MARK: - Private: High-level assembly

private extension SnapshotImagePreparer {

    func resolvedSize(
        for config: ViewImageConfig,
        viewController: UIViewController,
        view: UIView
    ) -> CGSize {
        if let size = config.size {
            return size
        }

        let intrinsic = view.intrinsicContentSize
        if intrinsic.width > 0 && intrinsic.height > 0 {
            return intrinsic
        }

        let controllerSize = viewController.view.frame.size
        if controllerSize.width > 0 && controllerSize.height > 0 {
            return controllerSize
        }

        return CGSize(width: 1, height: 1)
    }

    func configureView(_ view: UIView, inside viewController: UIViewController, size: CGSize) {
        view.frame = CGRect(origin: .zero, size: size)
        guard view !== viewController.view else { return }

        viewController.view.bounds = view.bounds
        viewController.view.addSubview(view)
    }

    func makeWindow(
        config: ViewImageConfig,
        viewController: UIViewController,
        size: CGSize,
        traits: UITraitCollection
    ) -> UIWindow {
        SnapshotWindow(
            config: .init(safeArea: config.safeArea, size: config.size ?? size, traits: traits),
            viewController: viewController
        )
    }

    func attach(
        viewController: UIViewController,
        to window: UIWindow,
        applying traits: UITraitCollection,
        safeArea: UIEdgeInsets
    ) -> Cleanup {
        let root = buildRootContainerIfNeeded(for: viewController, in: window)

        applyTraitCollection(traits, to: viewController, in: root)
        finalizeEmbedding(root: root, child: viewController, in: window)
        driveInitialLayout(root: root, child: viewController)

        return cleanupClosure(root: root, child: viewController, window: window)
    }
}

private final class SnapshotWindow: UIWindow {
    private var config: ViewImageConfig
    
    init(config: ViewImageConfig, viewController: UIViewController) {
        let size = config.size ?? viewController.view.bounds.size
        self.config = config
        super.init(frame: .init(origin: .zero, size: size))
        
        // Match SnapshotTesting behavior to keep UINavigationController and UITabBarController snapshots stable.
        if viewController is UINavigationController {
            self.frame.size.height -= self.config.safeArea.top
            self.config.safeArea.top = 0
        } else if let tabBarController = viewController as? UITabBarController {
            self.frame.size.height -= self.config.safeArea.bottom
            self.config.safeArea.bottom = 0
            
            if tabBarController.selectedViewController is UINavigationController {
                self.frame.size.height -= self.config.safeArea.top
                self.config.safeArea.top = 0
            }
        }
        
        self.isHidden = false
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @available(iOS 11.0, *)
    override var safeAreaInsets: UIEdgeInsets {
        let removeTopInset =
            self.config.safeArea == .init(top: 20, left: 0, bottom: 0, right: 0)
            && (self.rootViewController?.prefersStatusBarHidden ?? false)
        if removeTopInset {
            return .zero
        }
        
        return self.config.safeArea
    }
}

// MARK: - Private: Embedding helpers

private extension SnapshotImagePreparer {

    func buildRootContainerIfNeeded(
        for viewController: UIViewController,
        in window: UIWindow
    ) -> UIViewController {
        if viewController == window.rootViewController {
            return viewController
        }

        let root = UIViewController()
        root.view.backgroundColor = .clear
        root.view.frame = window.frame
        root.view.translatesAutoresizingMaskIntoConstraints = viewController.view.translatesAutoresizingMaskIntoConstraints
        root.preferredContentSize = root.view.frame.size

        viewController.view.frame = root.view.frame
        root.view.addSubview(viewController.view)

        if viewController.view.translatesAutoresizingMaskIntoConstraints {
            viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        } else {
            NSLayoutConstraint.activate([
                viewController.view.topAnchor.constraint(equalTo: root.view.topAnchor),
                viewController.view.bottomAnchor.constraint(equalTo: root.view.bottomAnchor),
                viewController.view.leadingAnchor.constraint(equalTo: root.view.leadingAnchor),
                viewController.view.trailingAnchor.constraint(equalTo: root.view.trailingAnchor)
            ])
        }

        root.addChild(viewController)
        return root
    }

    func applyTraitCollection(
        _ traits: UITraitCollection,
        to child: UIViewController,
        in parent: UIViewController
    ) {
        parent.setOverrideTraitCollection(traits, forChild: child)
        child.didMove(toParent: parent)
    }

    func finalizeEmbedding(root: UIViewController, child: UIViewController, in window: UIWindow) {
        window.rootViewController = root
        root.beginAppearanceTransition(true, animated: false)
        root.endAppearanceTransition()
    }

    func driveInitialLayout(root: UIViewController, child: UIViewController) {
        root.view.setNeedsLayout()
        root.view.layoutIfNeeded()
        child.view.setNeedsLayout()
        child.view.layoutIfNeeded()
    }

    func cleanupClosure(
        root: UIViewController,
        child: UIViewController,
        window: UIWindow
    ) -> Cleanup {
        return {
            root.beginAppearanceTransition(false, animated: false)
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
            child.didMove(toParent: nil)
            root.endAppearanceTransition()
            window.rootViewController = nil
        }
    }
}

extension ViewImageConfig {
    public static func iPhone15Pro(_ orientation: Orientation) -> ViewImageConfig {
        let safeArea: UIEdgeInsets
        let size: CGSize
        switch orientation {
        case .landscape:
            safeArea = .init(top: 0, left: 47, bottom: 21, right: 47)
            size = .init(width: 852, height: 393)
        case .portrait:
            safeArea = .init(top: 47, left: 0, bottom: 34, right: 0)
            size = .init(width: 393, height: 852)
        }
        return .init(safeArea: safeArea, size: size, traits: .iPhone(orientation))
    }
}

extension UITraitCollection {
    public static func iPhone(
        _ orientation: ViewImageConfig.Orientation,
        userInterfaceStyle: UIUserInterfaceStyle = .light
    ) -> UITraitCollection {
        let base: [UITraitCollection] = [
            .init(forceTouchCapability: .unavailable),
            .init(layoutDirection: .leftToRight),
            .init(preferredContentSizeCategory: .medium),
            .init(userInterfaceIdiom: .phone),
            .init(userInterfaceStyle: userInterfaceStyle)
        ]
        switch orientation {
        case .landscape:
            return .init(
                traitsFrom: base + [
                    .init(horizontalSizeClass: .regular),
                    .init(verticalSizeClass: .compact)
                ]
            )
        case .portrait:
            return .init(
                traitsFrom: base + [
                    .init(horizontalSizeClass: .compact),
                    .init(verticalSizeClass: .regular)
                ]
            )
        }
    }
}
