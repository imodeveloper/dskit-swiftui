//
//  DSSurfaceStyle.swift
//  DSKit
//
//  Created by Ivan Borinschi on 08.04.2026.
//

import SwiftUI

struct AppearanceSurfaceStyleEnvironment: EnvironmentKey {
    static let defaultValue: DSSurfaceStyle = .canvas
}

public extension EnvironmentValues {
    var surfaceStyle: DSSurfaceStyle {
        get { self[AppearanceSurfaceStyleEnvironment.self] }
        set { self[AppearanceSurfaceStyleEnvironment.self] = newValue }
    }
}

public enum DSSurfaceStyle: Equatable, Hashable, Sendable {
    case canvas
    case surface
    case surfaceRaised
    case surfaceSunken
    case inverse

    var backgroundToken: DSBackgroundColorToken {
        switch self {
        case .canvas:
            return .canvas
        case .surface:
            return .surface
        case .surfaceRaised:
            return .surfaceRaised
        case .surfaceSunken:
            return .surfaceSunken
        case .inverse:
            return .neutral
        }
    }

    var defaultBorderToken: DSBorderColorToken {
        switch self {
        case .inverse:
            return .inverse
        default:
            return .subtle
        }
    }
}

public extension DSSurfaceStyle {
    static let primary: DSSurfaceStyle = .canvas
    static let secondary: DSSurfaceStyle = .surface
}
