//
//  DSPreviewForEachAppearance.swift
//  DSKit
//
//  Created by Ivan Borinschi on 20.02.2023.
//

import SwiftUI

// A generic structure that provides a way to
// preview content for different languages and brands.
public struct DSPreviewForEachAppearance<Content: View>: View {
    
    var content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some View {
        ForEach(resolvedAppearances, id: \.self.title) { configuration in
            self.content()
                .onAppear { configuration.appearance.overrideTheSystemAppearance() }
                .environment(\.appearance, configuration.appearance)
                .environment(\.viewStyle, .primary)
                .previewDisplayName(configuration.title)
        }
    }

    private var resolvedAppearances: [(title: String, appearance: DSAppearance)] {
        let env = ProcessInfo.processInfo.environment
        guard env["DSKIT_PREVIEW_SINGLE_APPEARANCE"] == "1" else {
            return appearances
        }

        if let requestedTitle = env["DSKIT_PREVIEW_APPEARANCE_TITLE"]?.trimmingCharacters(in: .whitespacesAndNewlines),
           !requestedTitle.isEmpty,
           let match = appearances.first(where: { $0.title.caseInsensitiveCompare(requestedTitle) == .orderedSame }) {
            return [match]
        }

        if let rawIndex = env["DSKIT_PREVIEW_APPEARANCE_INDEX"],
           let index = Int(rawIndex),
           appearances.indices.contains(index) {
            return [appearances[index]]
        }

        return [appearances[0]]
    }
}

fileprivate let appearances: [(title: String, appearance: DSAppearance)] = [
    ("Light Blue", LightBlueAppearance()),
    ("Dark", DarkAppearance()),
    ("Blue", BlueAppearance()),
    ("Retro", RetroAppearance()),
    ("Peach", PeachAppearance())
]
