//
//  DSTabbarAppearance.swift
//  DSKit
//
//  Created by Borinschi Ivan on 01.12.2020.
//

import SwiftUI

public protocol DSTabBarAppearanceProtocol {
    var translucent: Bool { get set }
}

public struct DSTabBarAppearance: DSTabBarAppearanceProtocol {
    public init(translucent: Bool = false) {
        self.translucent = translucent
    }

    public var translucent: Bool
}
