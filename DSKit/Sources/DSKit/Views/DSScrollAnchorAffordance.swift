//
//  DSScrollAnchorAffordance.swift
//  DSKit
//
//  Created by Ivan Borinschi on 09.06.2026.
//

import SwiftUI

public struct DSScrollAnchorVisibilityModifier: ViewModifier {
    private let onAppearAction: () -> Void
    private let onDisappearAction: () -> Void
    @State private var visibilityTask: Task<Void, Never>?

    public init(
        onAppear: @escaping () -> Void,
        onDisappear: @escaping () -> Void
    ) {
        self.onAppearAction = onAppear
        self.onDisappearAction = onDisappear
    }

    public func body(content: Content) -> some View {
        content
            .onAppear {
                scheduleVisibilityUpdate(onAppearAction)
            }
            .onDisappear {
                scheduleVisibilityUpdate(onDisappearAction)
            }
    }

    private func scheduleVisibilityUpdate(_ update: @escaping () -> Void) {
        visibilityTask?.cancel()
        visibilityTask = Task { @MainActor in
            await Task.yield()
            guard Task.isCancelled == false else { return }
            update()
        }
    }
}

public struct DSScrollAwayTrackingModifier: ViewModifier {
    private let minimumDistance: CGFloat
    private let onScrollAway: () -> Void

    public init(
        minimumDistance: CGFloat = 8,
        onScrollAway: @escaping () -> Void
    ) {
        self.minimumDistance = minimumDistance
        self.onScrollAway = onScrollAway
    }

    public func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: minimumDistance)
                    .onChanged { value in
                        guard value.translation.height < -minimumDistance else { return }
                        onScrollAway()
                    }
            )
    }
}

public extension View {
    func dsScrollAnchorVisibility(
        onAppear: @escaping () -> Void,
        onDisappear: @escaping () -> Void
    ) -> some View {
        modifier(
            DSScrollAnchorVisibilityModifier(
                onAppear: onAppear,
                onDisappear: onDisappear
            )
        )
    }

    func dsScrollAwayTracking(
        minimumDistance: CGFloat = 8,
        onScrollAway: @escaping () -> Void
    ) -> some View {
        modifier(
            DSScrollAwayTrackingModifier(
                minimumDistance: minimumDistance,
                onScrollAway: onScrollAway
            )
        )
    }
}

public extension ScrollViewProxy {
    func dsScrollToTopAnchor<ID: Hashable>(_ id: ID) {
        scrollTo(id, anchor: .top)
    }
}
