//
//  DSFloatingBannerInteractionTests.swift
//  DSKitTests
//
//  Created by Ivan Borinschi on 16.07.2026.
//

@testable import DSKit
import Testing

struct DSFloatingBannerInteractionTests {
    @Test("Compact loading uses tighter capsule padding without resizing other banners")
    func compactLoadingUsesTighterCapsulePadding() {
        let compactLoading = DSFloatingBannerContent(
            title: "Loading",
            style: .loading(tint: .orange),
            size: .compact
        )
        let compactLabel = DSFloatingBannerContent(
            title: "Mergi sus",
            style: .label(systemImage: "arrow.up"),
            size: .compact
        )
        let compactProgress = DSFloatingBannerContent(
            title: "Loading",
            style: .progress,
            size: .compact
        )
        let regularLoading = DSFloatingBannerContent(
            title: "Loading",
            style: .loading(tint: .orange)
        )

        #expect(compactLoading.surfaceMetrics == DSFloatingBannerSurfaceMetrics(
            horizontalPadding: 8,
            verticalPadding: 4,
            minimumHeight: 32
        ))
        #expect(compactLabel.surfaceMetrics == DSFloatingBannerSurfaceMetrics(
            horizontalPadding: 10,
            verticalPadding: 7,
            minimumHeight: 32
        ))
        #expect(compactProgress.surfaceMetrics == compactLabel.surfaceMetrics)
        #expect(regularLoading.surfaceMetrics == DSFloatingBannerSurfaceMetrics(
            horizontalPadding: 14,
            verticalPadding: 10,
            minimumHeight: 40
        ))
    }

    @Test("Loading phase changes keep one banner animation identity")
    func loadingPhaseChangesKeepOneBannerAnimationIdentity() {
        let orange = DSFloatingBannerView(
            isPresented: true,
            content: DSFloatingBannerContent(
                title: "Citim sursele RSS",
                style: .loading(tint: .orange),
                transitionID: "Monitor.FloatingBanner.SyncProgress",
                isInteractive: false
            )
        )
        let yellow = DSFloatingBannerView(
            isPresented: true,
            content: DSFloatingBannerContent(
                title: "Analizăm articolele",
                style: .loading(tint: .yellow),
                transitionID: "Monitor.FloatingBanner.SyncProgress",
                isInteractive: false
            )
        )
        let brand = DSFloatingBannerView(
            isPresented: true,
            content: DSFloatingBannerContent(
                title: "Publicăm articolele",
                style: .loading(tint: .brand),
                transitionID: "Monitor.FloatingBanner.SyncProgress",
                isInteractive: false
            )
        )

        #expect(orange.content != yellow.content)
        #expect(yellow.content != brand.content)
        #expect(orange.contentAnimationIdentity == yellow.contentAnimationIdentity)
        #expect(yellow.contentAnimationIdentity == brand.contentAnimationIdentity)
    }

    @Test("A genuine banner presentation change gets a new animation identity")
    func presentationChangeGetsNewAnimationIdentity() {
        let loading = DSFloatingBannerView(
            isPresented: true,
            content: DSFloatingBannerContent(
                title: "Analizăm articolele",
                style: .loading(tint: .yellow),
                transitionID: "Monitor.FloatingBanner.SyncProgress",
                isInteractive: false
            )
        )
        let failed = DSFloatingBannerView(
            isPresented: true,
            content: DSFloatingBannerContent(
                title: "Nu s-a actualizat",
                style: .status(systemImage: "exclamationmark.triangle.fill"),
                transitionID: "Monitor.FloatingBanner.SyncFailed",
                isInteractive: false
            )
        )

        #expect(loading.contentAnimationIdentity != failed.contentAnimationIdentity)
    }

    @Test("Presented noninteractive loading banners pass gestures through to content")
    func noninteractiveLoadingBannerPassesGesturesThrough() {
        let banner = DSFloatingBannerView(
            isPresented: true,
            content: DSFloatingBannerContent(
                title: "Loading",
                style: .loading(tint: .yellow),
                isInteractive: false
            )
        )

        #expect(banner.shouldAllowHitTesting == false)
    }

    @Test("Presented interactive action banners remain tappable")
    func interactiveActionBannerRemainsTappable() {
        let banner = DSFloatingBannerView(
            isPresented: true,
            content: DSFloatingBannerContent(
                title: "Mergi sus",
                style: .label(systemImage: "arrow.up")
            )
        )

        #expect(banner.shouldAllowHitTesting)
    }

    @Test("Hidden banners never participate in hit testing")
    func hiddenBannerDoesNotHitTest() {
        let banner = DSFloatingBannerView(
            isPresented: false,
            content: DSFloatingBannerContent(
                title: "Mergi sus",
                style: .label(systemImage: "arrow.up")
            )
        )

        #expect(banner.shouldAllowHitTesting == false)
    }
}
