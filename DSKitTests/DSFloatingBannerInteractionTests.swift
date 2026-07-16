//
//  DSFloatingBannerInteractionTests.swift
//  DSKitTests
//
//  Created by Ivan Borinschi on 16.07.2026.
//

@testable import DSKit
import Testing

struct DSFloatingBannerInteractionTests {
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
