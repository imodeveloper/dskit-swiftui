//
//  DSCardAccessory.swift
//  DSKit
//
//  Created by Ivan Borinschi on 09.06.2026.
//

import SwiftUI

public enum DSCardAccessoryKind: Hashable, Sendable {
    case none
    case chevron
    case edit
    case info
    case remove
    case systemName(String)

    var systemName: String? {
        switch self {
        case .none:
            nil
        case .chevron:
            "chevron.right"
        case .edit:
            "pencil.circle.fill"
        case .info:
            "info.circle"
        case .remove:
            "minus.circle.fill"
        case .systemName(let name):
            name
        }
    }
}

public struct DSCardAccessory: View {
    private let kind: DSCardAccessoryKind
    private let size: DSSize
    private let tint: DSColorToken

    public init(
        _ kind: DSCardAccessoryKind,
        size: DSSize = .mediumIcon,
        tint: DSColorToken = .icon(.brand)
    ) {
        self.kind = kind
        self.size = size
        self.tint = tint
    }

    public var body: some View {
        if let systemName = kind.systemName {
            if kind == .chevron {
                DSChevronView()
            } else {
                DSImageView(systemName: systemName, size: size, tint: tint)
            }
        }
    }
}
