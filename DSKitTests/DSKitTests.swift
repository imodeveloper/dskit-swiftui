//
//  DSKitTests.swift
//  DSKitTests
//
//  Created by Ivan Borinschi on 29.03.2024.
//

import SwiftUI
import XCTest
import SnapshotTesting
import UIKit
@testable import DSKit

final class DSKitTests: SnapshotTestCase {
    override func setUpWithError() throws {
        try super.setUpWithError()
        recordAll = false
    }

    private var crossSimulatorOptions: SnapshotAssertionOptions {
        SnapshotAssertionOptions(
            recordDelay: 0.5,
            retries: 20,
            retryDelay: 0.01,
            precision: 1.0,
            perceptualPrecision: 1.0,
            minimumPrecision: 0.98,
            minimumPerceptualPrecision: 1.0,
            precisionStep: 0.001,
            perceptualPrecisionStep: 0
        )
    }

    func testDSCustomBackgroundModifier() throws {
        assertSnapshot(for: Testable_DSBackgroundModifier(), named: "DSBackgroundModifier", options: crossSimulatorOptions)
    }
    
    func testDSCornerRadiusModifier() throws {
        assertSnapshot(for: Testable_DSCornerRadiusModifier(), named: "DSCornerRadiusModifier", options: crossSimulatorOptions)
    }
    
    func testDSPriceView() throws {
        assertSnapshot(for: Testable_DSPriceView(), named: "DSPriceView", options: crossSimulatorOptions)
    }
    
    func testDSBottomContainer() throws {
        assertSnapshot(for: Testable_DSBottomContainer(), named: "DSBottomContainer", options: crossSimulatorOptions)
    }
    
    func testDSButton() throws {
        assertSnapshot(for: Testable_DSButton(), named: "DSButton", options: crossSimulatorOptions)
    }

    func testDSButton_DynamicType() throws {
        for (categoryName, category) in dynamicTypeSnapshots {
            assertSnapshot(
                for: Testable_DSButton()
                    .environment(\.sizeCategory, category),
                named: "DSButton_DynamicType_\(categoryName)",
                options: crossSimulatorOptions
            )
        }
    }
    
    func testDSButton_Symbols_DynamicType() throws {
        for (categoryName, category) in dynamicTypeSnapshots {
            assertSnapshot(
                for: Testable_DSButtonSymbols()
                    .environment(\.sizeCategory, category),
                named: "DSButtonSymbols_DynamicType_\(categoryName)",
                options: crossSimulatorOptions
            )
        }
    }
    
    func testDSChevronView() throws {
        assertSnapshot(for: Testable_DSChevronView(), named: "DSChevronView", options: crossSimulatorOptions)
    }
    
    func testDSCoverFlow() throws {
        assertSnapshot(for: Testable_DSCoverFlow(), named: "DSCoverFlow", options: crossSimulatorOptions)
    }
    
    func testDSDivider() throws {
        assertSnapshot(for: Testable_DSDivider(), named: "DSDivider", options: crossSimulatorOptions)
    }
    
    func testDSGrid() throws {
        assertSnapshot(for: Testable_DSGrid(), named: "DSGrid", options: crossSimulatorOptions)
    }
    
    func testDSGroupedList() throws {
        assertSnapshot(for: Testable_DSGroupedList(), named: "DSGroupedList", options: crossSimulatorOptions)
    }
    
    func testDSHScroll() throws {
        assertSnapshot(for: Testable_DSHScroll(), named: "DSHScroll", options: crossSimulatorOptions)
    }
    
    func testDSRatingView() throws {
        assertSnapshot(for: Testable_DSRatingView(), named: "DSRatingView", options: crossSimulatorOptions)
    }
    
    func testDSSectionHeaderView() throws {
        assertSnapshot(for: Testable_DSSectionHeaderView(), named: "DSSectionHeaderView", options: crossSimulatorOptions)
    }
    
    func testDSSFSymbolButton() throws {
        assertSnapshot(for: Testable_DSSFSymbolButton(), named: "DSSFSymbolButton", options: crossSimulatorOptions)
    }
    
    func testDSTermsAndConditions() throws {
        assertSnapshot(for: Testable_DSTermsAndConditions(), named: "DSTermsAndConditions", options: crossSimulatorOptions)
    }
    
    func testDSTextField() throws {
        assertSnapshot(for: Testable_DSTextField(), named: "DSTextField", options: crossSimulatorOptions)
    }

    func testDSTextField_DynamicType() throws {
        for (categoryName, category) in dynamicTypeSnapshots {
            assertSnapshot(
                for: Testable_DSTextField()
                    .environment(\.sizeCategory, category),
                named: "DSTextField_DynamicType_\(categoryName)",
                options: crossSimulatorOptions
            )
        }
    }
    
    func testDSToolbarSFSymbolButton() throws {
        assertSnapshot(for: Testable_DSToolbarSFSymbolButton(), named: "DSToolbarSFSymbolButton", options: crossSimulatorOptions)
    }
    
    func testDSImageView() throws {
        assertSnapshot(for: Testable_DSImageView(), named: "DSImageView", options: crossSimulatorOptions)
    }
    
    func testDSText() throws {
        assertSnapshot(for: Testable_DSText(), named: "DSText", options: crossSimulatorOptions)
    }

    func testDSText_DynamicType() throws {
        for (categoryName, category) in dynamicTypeSnapshots {
            assertSnapshot(
                for: Testable_DSText()
                    .environment(\.sizeCategory, category),
                named: "DSText_DynamicType_\(categoryName)",
                options: crossSimulatorOptions
            )
        }
    }
    
    func testDSVStack() throws {
        assertSnapshot(for: Testable_DSVStack(), named: "DSVStack", options: crossSimulatorOptions)
    }
    
    func testDSHStack() throws {
        assertSnapshot(for: Testable_DSHStack(), named: "DSHStack", options: crossSimulatorOptions)
    }
    
    func testDSPickerView() throws {
        assertSnapshot(for: Testable_DSPickerView(), named: "DSPickerView", options: crossSimulatorOptions)
    }
    
    func testDSQuantityPicker() throws {
        assertSnapshot(for: Testable_DSQuantityPicker(), named: "DSQuantityPicker", options: crossSimulatorOptions)
    }
    
    func testDSRadioPickerView() throws {
        assertSnapshot(for: Testable_DSRadioPickerView(), named: "DSRadioPickerView", options: crossSimulatorOptions)
    }

    func testDSSizeModifierFillWidthFixedHeight() throws {
        let targetSize = CGSize(width: 200, height: 100)
        let measuredSize = measureSize(
            targetSize: targetSize,
            content: Text("Fill width / fixed height")
                .dsSize(.size(width: .fillUpTheSpace, height: 60))
        )
        XCTAssertEqual(measuredSize.width, targetSize.width, accuracy: 0.5)
        XCTAssertEqual(measuredSize.height, 60, accuracy: 0.5)
    }

    func testDSSizeModifierFixedWidthFillHeight() throws {
        let targetSize = CGSize(width: 200, height: 100)
        let measuredSize = measureSize(
            targetSize: targetSize,
            content: Text("Fixed width / fill height")
                .dsSize(.size(width: 120, height: .fillUpTheSpace))
        )
        XCTAssertEqual(measuredSize.width, 120, accuracy: 0.5)
        XCTAssertEqual(measuredSize.height, targetSize.height, accuracy: 0.5)
    }

    private func measureSize(
        targetSize: CGSize,
        content: some View,
        timeout: TimeInterval = 1.0
    ) -> CGSize {
        let probe = SizeProbe()
        let expectation = expectation(description: "Measured size")
        let view = SizeReportingView(targetSize: targetSize, content: content) { size in
            guard size != .zero, !probe.didFulfill else { return }
            probe.didFulfill = true
            probe.measuredSize = size
            expectation.fulfill()
        }

        let hosting = UIHostingController(rootView: view)
        let window = UIWindow(frame: CGRect(origin: .zero, size: targetSize))
        window.rootViewController = hosting
        window.makeKeyAndVisible()

        RunLoop.main.run(until: Date().addingTimeInterval(0.05))
        wait(for: [expectation], timeout: timeout)
        return probe.measuredSize
    }
}

private let dynamicTypeSnapshots: [(String, ContentSizeCategory)] = [
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

private struct Testable_DSButtonSymbols: View {
    var body: some View {
        DSVStack {
            DSButton.sfSymbol(name: "star.fill", action: {})
            DSButton(
                title: "Message",
                leftSystemName: "message.fill",
                action: {}
            )
            DSButton(
                title: "Dual",
                leftSystemName: "message.fill",
                rightSystemName: "heart.fill",
                action: {}
            )
        }
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

private struct SizeReportingView<Content: View>: View {
    let targetSize: CGSize
    let content: Content
    let onSizeChange: (CGSize) -> Void

    var body: some View {
        ZStack(alignment: .topLeading) {
            content
                .background(
                    GeometryReader { proxy in
                        Color.clear.preference(key: SizePreferenceKey.self, value: proxy.size)
                    }
                )
        }
        .frame(width: targetSize.width, height: targetSize.height, alignment: .topLeading)
        .onPreferenceChange(SizePreferenceKey.self, perform: onSizeChange)
    }
}

private final class SizeProbe {
    var didFulfill = false
    var measuredSize: CGSize = .zero
}
