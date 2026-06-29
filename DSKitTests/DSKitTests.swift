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
import Foundation
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

    private var imageRenderingOptions: SnapshotAssertionOptions {
        SnapshotAssertionOptions(
            recordDelay: 0.5,
            retries: 20,
            retryDelay: 0.01,
            precision: 0.95,
            perceptualPrecision: 1.0,
            minimumPrecision: 0.95,
            minimumPerceptualPrecision: 1.0,
            precisionStep: 0,
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

    func testDSContentCardComponents() throws {
        assertSnapshot(
            for: Testable_DSContentCardComponents(),
            named: "DSContentCardComponents",
            options: crossSimulatorOptions
        )
    }

    func testDSArticleThreadComponents() throws {
        assertSnapshot(
            for: Testable_DSArticleThreadComponents(),
            named: "DSArticleThreadComponents",
            options: crossSimulatorOptions
        )
    }

    func testDSThreadSection() throws {
        assertSnapshot(
            for: Testable_DSThreadSection(),
            named: "DSThreadSection",
            options: crossSimulatorOptions
        )
    }

    func testDSChipsView() throws {
        assertSnapshot(for: Testable_DSChipsView(), named: "DSChipsView", options: crossSimulatorOptions)
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
        assertSnapshot(for: Testable_DSImageView(), named: "DSImageView", options: imageRenderingOptions)
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

    func testGeneratedComponentPreviewSnapshots() throws {
        assertSnapshot(for: ComponentPreview_DSArticleRows(), named: "DSArticleRows", options: crossSimulatorOptions)
        assertSnapshot(for: ComponentPreview_DSAuthorView(), named: "DSAuthorView", options: crossSimulatorOptions)
        assertSnapshot(for: ComponentPreview_DSCardAccessory(), named: "DSCardAccessory", options: crossSimulatorOptions)
        assertSnapshot(for: ComponentPreview_DSCardSurface(), named: "DSCardSurface", options: crossSimulatorOptions)
        assertSnapshot(for: ComponentPreview_DSContentCard(), named: "DSContentCard", options: crossSimulatorOptions)
        assertSnapshot(for: ComponentPreview_DSEntityCardRow(), named: "DSEntityCardRow", options: crossSimulatorOptions)
        assertSnapshot(for: ComponentPreview_DSEntityRow(), named: "DSEntityRow", options: crossSimulatorOptions)
        assertSnapshot(for: ComponentPreview_DSFloatingBannerView(), named: "DSFloatingBannerView", options: crossSimulatorOptions)
        assertSnapshot(for: ComponentPreview_DSIconBadgeView(), named: "DSIconBadgeView", options: crossSimulatorOptions)
        assertSnapshot(for: ComponentPreview_DSInfoCallout(), named: "DSInfoCallout", options: crossSimulatorOptions)
        assertSnapshot(for: ComponentPreview_DSInlineTagView(), named: "DSInlineTagView", options: crossSimulatorOptions)
        assertSnapshot(for: ComponentPreview_DSLazyVStack(), named: "DSLazyVStack", options: crossSimulatorOptions)
        assertSnapshot(for: ComponentPreview_DSLetterBadgeView(), named: "DSLetterBadgeView", options: crossSimulatorOptions)
        assertSnapshot(for: ComponentPreview_DSList(), named: "DSList", options: crossSimulatorOptions)
        assertSnapshot(for: ComponentPreview_DSListSeparatorView(), named: "DSListSeparatorView", options: crossSimulatorOptions)
        assertSnapshot(for: ComponentPreview_DSMetadataRow(), named: "DSMetadataRow", options: crossSimulatorOptions)
        assertSnapshot(
            for: ComponentPreview_DSOffsetObservingScrollView(),
            named: "DSOffsetObservingScrollView",
            options: crossSimulatorOptions
        )
        assertSnapshot(for: ComponentPreview_DSRelativeTimeTag(), named: "DSRelativeTimeTag", options: crossSimulatorOptions)
        assertSnapshot(
            for: ComponentPreview_DSScrollAnchorAffordance(),
            named: "DSScrollAnchorAffordance",
            options: crossSimulatorOptions
        )
        assertSnapshot(for: ComponentPreview_DSSection(), named: "DSSection", options: crossSimulatorOptions)
        assertSnapshot(for: ComponentPreview_DSThread(), named: "DSThread", options: crossSimulatorOptions)

        if #available(iOS 17, *) {
            assertSnapshot(for: ComponentPreview_DSTabPagingView(), named: "DSTabPagingView", options: crossSimulatorOptions)
        }
    }

    func testEveryDSKitViewHasSnapshotCoverageAndDocumentationPreview() throws {
        let root = repositoryRoot
        let components = try componentNames(in: root)
        let testSource = try String(contentsOf: URL(fileURLWithPath: #filePath), encoding: .utf8)
        let viewIndex = try String(
            contentsOf: root.appendingPathComponent("Content/Views.md"),
            encoding: .utf8
        )

        var missingAssertions: [String] = []
        var missingSnapshots: [String] = []
        var missingPages: [String] = []
        var missingPagePreviews: [String] = []
        var missingIndexPreviews: [String] = []

        for component in components {
            let snapshotName = "\(component).snapshot.png"
            if !testSource.contains("named: \"\(component)\"") {
                missingAssertions.append(component)
            }
            if !root.appendingPathComponent("DSKitTests/__Snapshots__/DSKitTests/\(snapshotName)").fileExists {
                missingSnapshots.append(component)
            }

            let pageURL = root.appendingPathComponent("Content/Views/\(component).md")
            guard pageURL.fileExists else {
                missingPages.append(component)
                continue
            }

            let page = try String(contentsOf: pageURL, encoding: .utf8)
            if !page.contains("<img src=") || !page.contains(snapshotName) {
                missingPagePreviews.append(component)
            }
            if !viewIndex.contains(snapshotName) {
                missingIndexPreviews.append(component)
            }
        }

        assertNoMissing(missingAssertions, "Missing exact DSKit component snapshot assertions")
        assertNoMissing(missingSnapshots, "Missing DSKit component snapshot PNG files")
        assertNoMissing(missingPages, "Missing generated DSKit component documentation pages")
        assertNoMissing(missingPagePreviews, "Missing snapshot preview images in component pages")
        assertNoMissing(missingIndexPreviews, "Missing snapshot preview images in Content/Views.md")
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

    func testDSTypographyTokenSizing() {
        let appearance = LightBlueAppearance()

        XCTAssertEqual(DSTypographyToken.label.pointSize(for: appearance), 14, accuracy: 0.5)
        XCTAssertEqual(DSTypographyToken.bodySmall.pointSize(for: appearance), 14, accuracy: 0.5)
        XCTAssertEqual(DSTypographyToken.bodyLarge.pointSize(for: appearance), 18, accuracy: 0.5)
        XCTAssertEqual(
            DSTypographyToken.custom(size: 19, weight: .bold, relativeTo: .headline).pointSize(for: appearance),
            19,
            accuracy: 0.5
        )
    }

    func testDSTypographyTokenColorRoles() {
        XCTAssertEqual(DSTypographyToken.label.baseColorRoleToken, .headline)
        XCTAssertEqual(DSTypographyToken.bodySmall.baseColorRoleToken, .body)
        XCTAssertEqual(DSTypographyToken.bodyLarge.baseColorRoleToken, .body)
        XCTAssertEqual(
            DSTypographyToken.custom(size: 12, weight: .regular, relativeTo: .subheadline).baseColorRoleToken,
            .subheadline
        )
    }

    func testDSSectionHeaderRoleBottomInsetIgnoresSectionSpacing() {
        let appearance = LightBlueAppearance()

        XCTAssertEqual(
            sectionBottomInset(for: .header, spacing: .space32, appearance: appearance),
            0,
            accuracy: 0.5
        )
        XCTAssertEqual(
            sectionBottomInset(for: .standard, spacing: .space32, appearance: appearance),
            appearance.spacing.value(for: .space32),
            accuracy: 0.5
        )
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

    private var repositoryRoot: URL {
        URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .deletingLastPathComponent()
    }

    private func componentNames(in root: URL) throws -> [String] {
        try FileManager.default
            .contentsOfDirectory(
                at: root.appendingPathComponent("DSKit/Sources/DSKit/Views"),
                includingPropertiesForKeys: nil
            )
            .filter { $0.pathExtension == "swift" }
            .map { $0.deletingPathExtension().lastPathComponent }
            .sorted()
    }

    private func assertNoMissing(
        _ missing: [String],
        _ message: String,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        if !missing.isEmpty {
            XCTFail("\(message):\n- \(missing.joined(separator: "\n- "))", file: file, line: line)
        }
    }
}

private extension URL {
    var fileExists: Bool {
        FileManager.default.fileExists(atPath: path)
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

private struct ComponentPreview_DSArticleRows: View {
    private let fixedDate = Date(timeIntervalSince1970: 1_780_000_000)

    var body: some View {
        DSVStack(alignment: .leading, spacing: .space16) {
            DSArticleSummaryRow(
                authorName: "Moldova 1",
                title: "Parliament approves the updated infrastructure calendar",
                titleTextStyle: .bodyLarge
            ) {
                metadataRow
            }

            DSArticleThreadRow(
                title: "Three agencies published matching procurement updates this morning.",
                titleTextStyle: .bodySmall
            ) {
                DSCardAccessory(.chevron)
            }

            DSArticleMetadataFooter {
                metadataRow
            }
        }
    }

    private var metadataRow: some View {
        DSMetadataRow(spacing: .space16) {
            DSRelativeTimeTag(
                date: fixedDate.addingTimeInterval(-3_600),
                locale: Locale(identifier: "en_US"),
                referenceDate: fixedDate
            )
            DSMetadataTag("Politics", systemName: "building.columns")
            DSMetadataTag("3 sources", systemName: "square.stack.3d.down.forward")
        }
    }
}

private struct ComponentPreview_DSAuthorView: View {
    var body: some View {
        DSVStack(alignment: .leading, spacing: .space12) {
            DSAuthorView(name: "Moldova 1", badgeColor: .blue, textStyle: .label)
            DSAuthorView(name: "NewsMaker", badgeColor: .purple, textStyle: .subheadline)
            DSAuthorView(name: "Europa Libera", badgeColor: .orange, textStyle: .caption1)
        }
    }
}

private struct ComponentPreview_DSCardAccessory: View {
    var body: some View {
        DSHStack(spacing: .space16) {
            DSCardAccessory(.chevron)
            DSCardAccessory(.edit)
            DSCardAccessory(.info)
            DSCardAccessory(.remove)
            DSCardAccessory(.systemName("sparkles"))
        }
        .dsCardStyle()
    }
}

private struct ComponentPreview_DSCardSurface: View {
    var body: some View {
        DSCardSurface {
            DSHStack(spacing: .space12) {
                DSIconBadgeView(systemName: "calendar")
                DSVStack(spacing: .space4) {
                    DSText("Card surface").dsTextStyle(.headline)
                    DSText("Consistent padding, radius, and background.").dsTextStyle(.caption1)
                }
                .dsFullWidth()
            }
        }
    }
}

private struct ComponentPreview_DSContentCard: View {
    var body: some View {
        DSContentCard(spacing: .space12, mediaPlacement: .top) {
            DSVStack(spacing: .space4) {
                DSText("Barbershop Broadway").dsTextStyle(.headline)
                DSMetadataRow {
                    DSMetadataTag("325 Broadway", systemName: "house")
                    DSMetadataTag("Open", systemName: "checkmark.circle")
                }
            }
            .dsPadding()
        } media: {
            Rectangle()
                .fill(Color.blue.opacity(0.22))
                .overlay {
                    DSImageView(systemName: "scissors", size: .font(.title1), tint: .color(.blue))
                }
                .dsHeight(96)
        }
    }
}

private struct ComponentPreview_DSEntityCardRow: View {
    var body: some View {
        DSVStack(spacing: .space8) {
            DSEntityCardRow(
                title: "Maia Sandu",
                subtitle: "President",
                placeholderSystemName: "person.crop.circle",
                badgeText: "2",
                accessorySystemName: "chevron.right"
            )
            DSEntityCardRow(
                title: "Infrastructure Desk",
                subtitle: "Government updates",
                placeholderSystemName: "newspaper",
                accessorySystemName: "info.circle"
            )
        }
    }
}

private struct ComponentPreview_DSEntityRow: View {
    var body: some View {
        DSVStack(spacing: .space12) {
            DSEntityRow(title: "Service", subtitle: "Select service", accessory: .chevron) {
                DSIconBadgeView(systemName: "scissors")
            }
            DSEntityRow(title: "Location", subtitle: "325 Broadway", accessory: .info) {
                DSIconBadgeView(systemName: "mappin.and.ellipse", foreground: .color(.orange))
            }
        }
        .dsCardStyle()
    }
}

private struct ComponentPreview_DSFloatingBannerView: View {
    var body: some View {
        ZStack(alignment: .top) {
            LinearGradient(
                colors: [Color(.systemBackground), Color(.secondarySystemBackground)],
                startPoint: .top,
                endPoint: .bottom
            )

            DSFloatingBannerView(
                isPresented: true,
                content: DSFloatingBannerContent(
                    title: "12 new articles",
                    style: .label(systemImage: "arrow.trianglehead.2.clockwise.rotate.90", placement: .trailing),
                    titleUsesMonospacedDigits: true
                ),
                topInset: 18,
                horizontalPadding: 20
            )
        }
        .frame(height: 140)
        .clipShape(.rect(cornerRadius: 18))
    }
}

private struct ComponentPreview_DSIconBadgeView: View {
    var body: some View {
        DSHStack(spacing: .space12) {
            DSIconBadgeView(systemName: "newspaper")
            DSIconBadgeView(systemName: "calendar", foreground: .color(.orange))
            DSIconBadgeView(systemName: "sparkles", size: 34, foreground: .color(.purple))
            DSBadgeText("Live")
            DSSymbolIconView(systemName: "bookmark.fill", textStyle: .headline)
        }
    }
}

private struct ComponentPreview_DSInfoCallout: View {
    var body: some View {
        DSVStack(spacing: .space12) {
            DSInfoCallout(
                lines: [
                    "Use one card for one topic.",
                    "Keep actions clear and predictable."
                ],
                systemName: "sparkles"
            )
            DSInfoCallout(
                lines: [DSInfoCalloutLine(prefix: "Sync status: ", emphasizedSuffix: "updated")],
                systemName: "checkmark.circle.fill",
                usesIconBadge: true
            )
        }
    }
}

private struct ComponentPreview_DSInlineTagView: View {
    var body: some View {
        DSVStack(alignment: .leading, spacing: .space8) {
            DSInlineTagView(systemName: "clock", text: "1h ago", color: .text(.caption1))
            DSInlineTagView(systemName: "building.columns", text: "Politics", color: .text(.caption1))
            DSInlineTagView(systemName: "square.stack.3d.down.forward", text: "10 sources", color: .text(.caption1))
            DSInlineTagView(spacing: .space4) {
                Circle().fill(Color.orange).frame(width: 8, height: 8)
            } content: {
                DSText("Live").dsTextStyle(.caption1)
            }
        }
    }
}

private struct ComponentPreview_DSLazyVStack: View {
    var body: some View {
        ScrollView {
            DSLazyVStack(spacing: .space8) {
                Color.yellow.dsHeight(48)
                Color.green.dsHeight(48)
                Color.blue.dsHeight(48)
            }
        }
        .frame(height: 180)
        .dsCardStyle()
    }
}

private struct ComponentPreview_DSLetterBadgeView: View {
    var body: some View {
        DSVStack(alignment: .leading, spacing: .space12) {
            DSHStack(spacing: .space8) {
                DSLetterBadgeView(text: "M", backgroundColor: .blue, textStyle: .caption1)
                DSLetterBadgeView(text: "N", backgroundColor: .green, textStyle: .label)
                DSLetterBadgeView(text: "EU", backgroundColor: .orange, textStyle: .label)
            }
            DSHStack(spacing: .space8) {
                DSLetterBadgeView(text: "Flux", backgroundColor: .purple, textStyle: .footnote)
                DSLetterBadgeView(text: "Vector", backgroundColor: .red, textStyle: .title2)
            }
        }
    }
}

private struct ComponentPreview_DSList: View {
    private let rows = ["Overview", "Details", "History"]

    var body: some View {
        DSList(sectionSpacing: .space12, sectionHeaderSpacing: .space8) {
            DSSection {
                DSVStack(spacing: .space4) {
                    DSText("Account").dsTextStyle(.headline)
                    DSText("Compact list with DSKit spacing.").dsTextStyle(.caption1)
                }
            }

            DSSection(data: rows, id: \.self) { row, _ in
                DSEntityRow(title: row, subtitle: "List row", accessory: .chevron) {
                    DSIconBadgeView(systemName: "doc.text")
                }
            }
        }
        .frame(height: 320)
    }
}

private struct ComponentPreview_DSListSeparatorView: View {
    var body: some View {
        DSVStack(spacing: .space12) {
            DSText("Section break").dsTextStyle(.headline)
            DSListSeparatorView()
            DSListSeparatorView(title: "Today")
            DSListSeparatorView(title: "Custom", height: 44, horizontalBleed: 16, backgroundStyle: .canvas)
        }
    }
}

private struct ComponentPreview_DSMetadataRow: View {
    private let fixedDate = Date(timeIntervalSince1970: 1_780_000_000)

    var body: some View {
        DSMetadataRow(spacing: .space16) {
            DSRelativeTimeTag(
                date: fixedDate.addingTimeInterval(-7_200),
                locale: Locale(identifier: "en_US"),
                referenceDate: fixedDate
            )
            DSMetadataTag("Politics", systemName: "building.columns")
            DSMetadataTag("3 sources", systemName: "square.stack.3d.down.forward")
        }
        .dsCardStyle()
    }
}

private struct ComponentPreview_DSOffsetObservingScrollView: View {
    @State private var contentFrame: CGRect = .zero
    @State private var page = 0

    var body: some View {
        DSVStack(spacing: .space12) {
            DSText("Offset observing scroll view").dsTextStyle(.headline)
            DSScrollViewContentFrameReader(
                axes: .horizontal,
                showsIndicators: false,
                contentFrame: $contentFrame,
                page: $page
            ) {
                DSHStack {
                    Color.red.frame(width: 96, height: 56)
                    Color.blue.frame(width: 96, height: 56)
                    Color.green.frame(width: 96, height: 56)
                }
            }
            .frame(height: 64)
        }
        .dsCardStyle()
    }
}

private struct ComponentPreview_DSRelativeTimeTag: View {
    private let fixedDate = Date(timeIntervalSince1970: 1_780_000_000)

    var body: some View {
        DSVStack(alignment: .leading, spacing: .space8) {
            DSRelativeTimeTag(
                date: fixedDate.addingTimeInterval(-3_600),
                locale: Locale(identifier: "en_US"),
                referenceDate: fixedDate
            )
            DSRelativeTimeTag(
                date: fixedDate.addingTimeInterval(-86_400),
                iconStyle: .badge,
                iconSize: .badge(diameter: 22, iconFont: .caption2),
                locale: Locale(identifier: "en_US"),
                referenceDate: fixedDate
            )
        }
    }
}

private struct ComponentPreview_DSScrollAnchorAffordance: View {
    @State private var isVisible = true

    var body: some View {
        DSHStack(spacing: .space12) {
            DSIconBadgeView(systemName: "arrow.up")
            DSVStack(spacing: .space4) {
                DSText(isVisible ? "Anchor visible" : "Anchor hidden").dsTextStyle(.headline)
                DSText("Visibility and scroll-away modifiers attached.").dsTextStyle(.caption1)
            }
            .dsFullWidth()
        }
        .dsCardStyle()
        .dsScrollAnchorVisibility(
            onAppear: { isVisible = true },
            onDisappear: { isVisible = false }
        )
        .dsScrollAwayTracking {}
    }
}

private struct ComponentPreview_DSSection: View {
    private let colors = [
        DSSectionPreviewColor(title: "red", color: .red),
        DSSectionPreviewColor(title: "green", color: .green),
        DSSectionPreviewColor(title: "blue", color: .blue)
    ]

    var body: some View {
        DSList(spacing: .space12) {
            DSSection {
                DSText("Section Title").dsTextStyle(.headline)
                DSText("Section body text").dsTextStyle(.caption1)
            }

            DSSection(data: colors, id: \.title, nativeSeparator: .visible) { item, position in
                DSHStack {
                    Circle().fill(item.color).frame(width: 16, height: 16)
                    DSText("\(item.title) · \(String(describing: position))").dsTextStyle(.label)
                }
            }
        }
        .frame(height: 280)
    }
}

@available(iOS 17, *)
private struct ComponentPreview_DSTabPagingView: View {
    var body: some View {
        DSTabPagingView {
            DSTabPage {
                Color.red.opacity(0.25)
                    .overlay { DSText("First page").dsTextStyle(.headline) }
            }
            .tabItem { isCurrent in
                DSText("First").dsTextStyle(.headline, isCurrent ? .text(.headline) : .text(.caption1))
            }

            DSTabPage {
                Color.blue.opacity(0.25)
                    .overlay { DSText("Second page").dsTextStyle(.headline) }
            }
            .tabItem { isCurrent in
                DSText("Second").dsTextStyle(.headline, isCurrent ? .text(.headline) : .text(.caption1))
            }
        }
        .frame(height: 240)
    }
}

private struct ComponentPreview_DSThread: View {
    var body: some View {
        DSThread(
            data: DSPreviewThreadItem.samples,
            id: \.id
        ) { item, _ in
            DSLetterBadgeView(text: item.initial, backgroundColor: item.color, textStyle: .caption1)
        } content: { item, _ in
            DSVStack(spacing: .space4) {
                DSText(item.title).dsTextStyle(.label)
                DSText(item.subtitle).dsTextStyle(.caption1)
            }
            .dsPadding(.bottom, .space8)
        } footer: {
            DSButton(title: "View thread", maxWidth: false, action: {})
        }
    }
}

private struct DSPreviewThreadItem: Identifiable {
    let id: Int
    let initial: String
    let title: String
    let subtitle: String
    let color: Color

    static let samples = [
        DSPreviewThreadItem(id: 1, initial: "M", title: "Moldova 1", subtitle: "Published first update", color: .blue),
        DSPreviewThreadItem(id: 2, initial: "N", title: "NewsMaker", subtitle: "Added context", color: .purple),
        DSPreviewThreadItem(id: 3, initial: "E", title: "Europa Libera", subtitle: "Confirmed timeline", color: .orange)
    ]
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
