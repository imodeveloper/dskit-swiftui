//
//  DSSpatialToken.swift
//  DSKit
//
//  Created by Ivan Borinschi on 08.04.2026.
//

import Foundation

public enum DSSpatialToken: Equatable, ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
    case space0
    case space1
    case space2
    case space4
    case space8
    case space12
    case space16
    case space24
    case space32
    case space40
    case space48
    case space64
    case custom(CGFloat)

    public init(floatLiteral value: FloatLiteralType) {
        self = .custom(CGFloat(value))
    }

    public init(integerLiteral value: IntegerLiteralType) {
        self = .custom(CGFloat(value))
    }

    public var value: CGFloat {
        switch self {
        case .space0:
            0
        case .space1:
            1
        case .space2:
            2
        case .space4:
            4
        case .space8:
            8
        case .space12:
            12
        case .space16:
            16
        case .space24:
            24
        case .space32:
            32
        case .space40:
            40
        case .space48:
            48
        case .space64:
            64
        case .custom(let value):
            value
        }
    }
}
