//
//  DSNavigationBarAppearance.swift
//  DSKit
//
//  Created by Borinschi Ivan on 01.12.2020.
//

import SwiftUI

public protocol DSNavigationBarAppearanceProtocol {
    var translucent: Bool { get set }
}

public struct DSNavigationBarAppearance: DSNavigationBarAppearanceProtocol {
    public init(translucent: Bool = false) {
        self.translucent = translucent
    }

    public var translucent: Bool
}
