//
//  DSDefaultSpacing.swift
//  DSKit
//
//  Created by Ivan Borinschi on 26.02.2023.
//

import Foundation

public protocol DSSpacingProtocol {
    func value(for: DSSpatialToken) -> CGFloat
}

public struct DSSpacingSystem: DSSpacingProtocol {
    public init() {
    }

    public func value(for token: DSSpatialToken) -> CGFloat {
        token.value
    }
}
