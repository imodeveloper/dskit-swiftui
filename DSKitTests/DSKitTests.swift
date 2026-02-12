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

    func testDSCustomBackgroundModifier() throws {
        assertSnapshot(for: Testable_DSBackgroundModifier(), named: "DSBackgroundModifier")
    }
    
    func testDSCornerRadiusModifier() throws {
        assertSnapshot(for: Testable_DSCornerRadiusModifier(), named: "DSCornerRadiusModifier")
    }
    
    func testDSPriceView() throws {
        assertSnapshot(for: Testable_DSPriceView(), named: "DSPriceView")
    }
    
    func testDSBottomContainer() throws {
        assertSnapshot(for: Testable_DSBottomContainer(), named: "DSBottomContainer")
    }
    
    func testDSButton() throws {
        assertSnapshot(for: Testable_DSButton(), named: "DSButton")
    }

    func testDSButton_DynamicType() throws {
        assertSnapshot(
            for: Testable_DSButton()
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge),
            named: "DSButton_DynamicType"
        )
    }
    
    func testDSChevronView() throws {
        assertSnapshot(for: Testable_DSChevronView(), named: "DSChevronView")
    }
    
    func testDSCoverFlow() throws {
        assertSnapshot(for: Testable_DSCoverFlow(), named: "DSCoverFlow")
    }
    
    func testDSDivider() throws {
        assertSnapshot(for: Testable_DSDivider(), named: "DSDivider")
    }
    
    func testDSGrid() throws {
        assertSnapshot(for: Testable_DSGrid(), named: "DSGrid")
    }
    
    func testDSGroupedList() throws {
        assertSnapshot(for: Testable_DSGroupedList(), named: "DSGroupedList")
    }
    
    func testDSHScroll() throws {
        assertSnapshot(for: Testable_DSHScroll(), named: "DSHScroll")
    }
    
    func testDSRatingView() throws {
        assertSnapshot(for: Testable_DSRatingView(), named: "DSRatingView")
    }
    
    func testDSSectionHeaderView() throws {
        assertSnapshot(for: Testable_DSSectionHeaderView(), named: "DSSectionHeaderView")
    }
    
    func testDSSFSymbolButton() throws {
        assertSnapshot(for: Testable_DSSFSymbolButton(), named: "DSSFSymbolButton")
    }
    
    func testDSTermsAndConditions() throws {
        assertSnapshot(for: Testable_DSTermsAndConditions(), named: "DSTermsAndConditions")
    }
    
    func testDSTextField() throws {
        assertSnapshot(for: Testable_DSTextField(), named: "DSTextField")
    }

    func testDSTextField_DynamicType() throws {
        assertSnapshot(
            for: Testable_DSTextField()
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge),
            named: "DSTextField_DynamicType"
        )
    }
    
    func testDSToolbarSFSymbolButton() throws {
        assertSnapshot(for: Testable_DSToolbarSFSymbolButton(), named: "DSToolbarSFSymbolButton")
    }
    
    func testDSImageView() throws {
        assertSnapshot(for: Testable_DSImageView(), named: "DSImageView")
    }
    
    func testDSText() throws {
        assertSnapshot(for: Testable_DSText(), named: "DSText")
    }

    func testDSText_DynamicType() throws {
        assertSnapshot(
            for: Testable_DSText()
                .environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge),
            named: "DSText_DynamicType"
        )
    }
    
    func testDSVStack() throws {
        assertSnapshot(for: Testable_DSVStack(), named: "DSVStack")
    }
    
    func testDSHStack() throws {
        assertSnapshot(for: Testable_DSHStack(), named: "DSHStack")
    }
    
    func testDSPickerView() throws {
        assertSnapshot(for: Testable_DSPickerView(), named: "DSPickerView")
    }
    
    func testDSQuantityPicker() throws {
        assertSnapshot(for: Testable_DSQuantityPicker(), named: "DSQuantityPicker")
    }
    
    func testDSRadioPickerView() throws {
        assertSnapshot(for: Testable_DSRadioPickerView(), named: "DSRadioPickerView")
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
