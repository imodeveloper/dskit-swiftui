//
//  DSSpatialToken.swift
//  DSKit
//
//  Created by Ivan Borinschi on 26.02.2023.
//

import Foundation

public protocol DPaddingsProtocol {
    func value(for: DSSpatialToken) -> CGFloat
}

public struct DSPaddingSystem: DPaddingsProtocol {
    public init() {
    }

    public func value(for token: DSSpatialToken) -> CGFloat {
        token.value
    }
}
