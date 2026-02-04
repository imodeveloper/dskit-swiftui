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
}

enum SnapshotLayout {
    case component(
        width: CGFloat = 400,
        padding: CGFloat = 12,
        background: DSViewStyle = .primary,
        traits: UITraitCollection = .init()
    )
    case screen(
        config: ViewImageConfig = .iPhone15Pro(.portrait),
        traits: UITraitCollection = .iPhone(.portrait),
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

        let snapshotting = Snapshotting<UIImage, UIImage>.image(
            precision: options.precision,
            perceptualPrecision: options.perceptualPrecision,
            scale: prepared.traits.displayScale
        )
        .pullback { view in
            renderSnapshot(view: view, traits: prepared.traits)
        }

        var failure: String?
        for attempt in 0...max(options.retries, 0) {
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
    return renderer.image { context in
        if !view.drawHierarchy(in: bounds, afterScreenUpdates: true) {
            view.layer.render(in: context.cgContext)
        }
    }
}

final class SnapshotImagePreparer {

    typealias Cleanup = () -> Void

    struct PreparedView {
        let cleanup: Cleanup
        let size: CGSize
        let traits: UITraitCollection
    }

    func prepareView(
        config: ViewImageConfig,
        traits: UITraitCollection,
        view: UIView,
        viewController: UIViewController
    ) -> PreparedView {
        let resolvedSize = resolvedSize(for: config, viewController: viewController, view: view)
        configureView(view, inside: viewController, size: resolvedSize)

        let mergedTraits = UITraitCollection(traitsFrom: [config.traits, traits])
        let window = makeWindow(config: config, viewController: viewController, size: resolvedSize)
        let dispose = attach(
            viewController: viewController,
            to: window,
            applying: mergedTraits,
            safeArea: config.safeArea
        )

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
        size: CGSize
    ) -> UIWindow {
        let window = UIWindow(frame: .init(origin: .zero, size: size))
        window.isHidden = false
        return window
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
