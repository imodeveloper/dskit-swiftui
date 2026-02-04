//
//  MNewsTests.swift
//  MNewsTests
//
//  Created by Ivan Borinschi on 20.01.2026.
//

import XCTest
@testable import DSKitExplorer

final class MNewsTests: XCTestCase {

    func testNewsScreen1ModelHasArticles() {
        let model = NewsScreen1Model()
        XCTAssertFalse(model.articles.isEmpty)
    }
}
