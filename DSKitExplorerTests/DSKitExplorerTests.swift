//
//  DSKitExplorerTests.swift
//  DSKitExplorerTests
//
//  Created by Ivan Borinschi on 29.03.2024.
//

//import SwiftUI
//import XCTest
//import SnapshotTesting
//@testable import DSKitExplorer
//
//final class DSKitExplorerTests: SnapshotTestCase {
//    override func setUpWithError() throws {
//        try super.setUpWithError()
//        recordAll = false
//    }
//    
//    func testHomeScreen1() throws {
//        assertSnapshot(for: Testable_HomeScreen1(), named: "HomeScreen1", layout: .screen())
//    }
//    
//    func testHomeScreen2() throws {
//        assertSnapshot(for: Testable_HomeScreen2(), named: "HomeScreen2", layout: .screen())
//    }
//    
//    func testHomeScreen3() throws {
//        assertSnapshot(for: Testable_HomeScreen3(), named: "HomeScreen3", layout: .screen())
//    }
//    
//    func testHomeScreen4() throws {
//        assertSnapshot(for: Testable_HomeScreen4(), named: "HomeScreen4", layout: .screen())
//    }
//    
//    func testLogInScreen1() throws {
//        assertSnapshot(for: Testable_LogInScreen1(), named: "LogInScreen1", layout: .screen())
//    }
//    
//    func testLogInScreen2() throws {
//        assertSnapshot(for: Testable_LogInScreen2(), named: "LogInScreen2", layout: .screen())
//    }
//    
//    func testLogInScreen3() throws {
//        assertSnapshot(for: Testable_LogInScreen3(), named: "LogInScreen3", layout: .screen())
//    }
//    
//    func testLogInScreen4() throws {
//        assertSnapshot(for: Testable_LogInScreen4(), named: "LogInScreen4", layout: .screen())
//    }
//    
//    func testProfileScreen1() throws {
//        assertSnapshot(for: Testable_ProfileScreen1(), named: "ProfileScreen1", layout: .screen())
//    }
//    
//    func testProfileScreen2() throws {
//        assertSnapshot(for: Testable_ProfileScreen2(), named: "ProfileScreen2", layout: .screen())
//    }
//    
//    func testProfileScreen3() throws {
//        assertSnapshot(for: Testable_ProfileScreen3(), named: "ProfileScreen3", layout: .screen())
//    }
//    
//    func testSignUpScreen1() throws {
//        assertSnapshot(for: Testable_SignUpScreen1(), named: "SignUpScreen1", layout: .screen())
//    }
//    
//    func testSignUpScreen2() throws {
//        assertSnapshot(for: Testable_SignUpScreen2(), named: "SignUpScreen2", layout: .screen())
//    }
//    
//    func testSignUpScreen3() throws {
//        assertSnapshot(for: Testable_SignUpScreen3(), named: "SignUpScreen3", layout: .screen())
//    }
//    
//    func testSignUpScreen4() throws {
//        assertSnapshot(for: Testable_SignUpScreen4(), named: "SignUpScreen4", layout: .screen())
//    }
//   
//    func testCartScreen1() throws {
//        assertSnapshot(for: Testable_CartScreen1(), named: "CartScreen1", layout: .screen())
//    }
//    
//    func testCartScreen2() throws {
//        assertSnapshot(for: Testable_CartScreen2(), named: "CartScreen2", layout: .screen())
//    }
//    
//    func testCartScreen3() throws {
//        assertSnapshot(for: Testable_CartScreen3(), named: "CartScreen3", layout: .screen())
//    }
//    
//    func testCartScreen4() throws {
//        assertSnapshot(for: Testable_CartScreen4(), named: "CartScreen4", layout: .screen())
//    }
//    
//    func testCartScreen5() throws {
//        assertSnapshot(for: Testable_CartScreen5(), named: "CartScreen5", layout: .screen())
//    }
//    
//    func testItemDetails1() throws {
//        assertSnapshot(for: Testable_ItemDetails1(), named: "ItemDetails1", layout: .screen())
//    }
//    
//    func testItemDetails2() throws {
//        assertSnapshot(for: Testable_ItemDetails2(), named: "ItemDetails2", layout: .screen())
//    }
//    
//    func testItemDetails3() throws {
//        assertSnapshot(for: Testable_ItemDetails3(), named: "ItemDetails3", layout: .screen())
//    }
//    
//    func testItemDetails4() throws {
//        assertSnapshot(for: Testable_ItemDetails4(), named: "ItemDetails4", layout: .screen())
//    }
//    
//    func testItemDetails5() throws {
//        assertSnapshot(for: Testable_ItemDetails5(), named: "ItemDetails5", layout: .screen())
//    }
//    
//    func testOrder1() throws {
//        assertSnapshot(for: Testable_Order1(), named: "Order1", layout: .screen())
//    }
//    
//    func testOrder2() throws {
//        assertSnapshot(for: Testable_Order2(), named: "Order2", layout: .screen())
//    }
//    
//    func testOrder3() throws {
//        assertSnapshot(for: Testable_Order3(), named: "Order3", layout: .screen())
//    }
//    
//    func testOrder4() throws {
//        assertSnapshot(for: Testable_Order4(), named: "Order4", layout: .screen())
//    }
//    
//    func testShipping1() throws {
//        assertSnapshot(for: Testable_Shipping1(), named: "Shipping1", layout: .screen())
//    }
//    
//    func testShipping2() throws {
//        assertSnapshot(for: Testable_Shipping2(), named: "Shipping2", layout: .screen())
//    }
//    
//    func testPayment1() throws {
//        assertSnapshot(for: Testable_Payment1(), named: "Payment1", layout: .screen())
//    }
//    
//    func testFilters1() throws {
//        assertSnapshot(for: Testable_Filters1(), named: "Filters1", layout: .screen())
//    }
//    
//    func testFilters2() throws {
//        assertSnapshot(for: Testable_Filters1(), named: "Filters2", layout: .screen())
//    }
//    
//    func testFilters3() throws {
//        assertSnapshot(for: Testable_Filters3(), named: "Filters3", layout: .screen())
//    }
//    
//    func testItems1() throws {
//        assertSnapshot(for: Testable_Items1(), named: "Items1", layout: .screen())
//    }
//    
//    func testItems2() throws {
//        assertSnapshot(for: Testable_Items2(), named: "Items2", layout: .screen())
//    }
//    
//    func testItems3() throws {
//        assertSnapshot(for: Testable_Items3(), named: "Items3", layout: .screen())
//    }
//    
//    func testItems4() throws {
//        assertSnapshot(for: Testable_Items4(), named: "Items4", layout: .screen())
//    }
//    
//    func testItems5() throws {
//        assertSnapshot(for: Testable_Items5(), named: "Items5", layout: .screen())
//    }
//    
//    func testItems6() throws {
//        assertSnapshot(for: Testable_Items6(), named: "Items6", layout: .screen())
//    }
//    
//    func testItems7() throws {
//        assertSnapshot(for: Testable_Items7(), named: "Items7", layout: .screen())
//    }
//    
//    func testItems8() throws {
//        assertSnapshot(for: Testable_Items8(), named: "Items8", layout: .screen())
//    }
//    
//    func testCategories1() throws {
//        assertSnapshot(for: Testable_Categories1(), named: "Categories1", layout: .screen())
//    }
//    
//    func testCategories2() throws {
//        assertSnapshot(for: Testable_Categories2(), named: "Categories2", layout: .screen())
//    }
//    
//    func testCategories3() throws {
//        assertSnapshot(for: Testable_Categories3(), named: "Categories3", layout: .screen())
//    }
//    
//    func testCategories4() throws {
//        assertSnapshot(for: Testable_Categories4(), named: "Categories4", layout: .screen())
//    }
//    
//    func testCategories5() throws {
//        assertSnapshot(for: Testable_Categories5(), named: "Categories5", layout: .screen())
//    }
//    
//    func testNotificationsScreen1() throws {
//        assertSnapshot(for: Testable_NotificationsScreen1(), named: "NotificationsScreen1", layout: .screen())
//    }
//    
//    func testNewsScreen1() throws {
//        assertSnapshot(for: Testable_NewsScreen1(), named: "NewsScreen1", layout: .screen())
//    }
//    
//    func testNewsScreen2() throws {
//        assertSnapshot(for: Testable_NewsScreen2(), named: "NewsScreen2", layout: .screen())
//    }
//    
//    func testAboutUsScreen1() throws {
//        assertSnapshot(for: Testable_AboutUsScreen1(), named: "AboutUsScreen1", layout: .screen())
//    }
//    
//    func testAboutUsScreen2() throws {
//        assertSnapshot(for: Testable_AboutUsScreen2(selectedTab: 0), named: "AboutUsScreen2_0", layout: .screen())
//        assertSnapshot(for: Testable_AboutUsScreen2(selectedTab: 1), named: "AboutUsScreen2_1", layout: .screen())
//    }
//    
//}
