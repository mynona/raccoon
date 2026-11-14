import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("MatomoTracker")
struct MatomoTrackerTests {

    private func makeData(
        status: MatomoStatus = .BANNER,
        pageType: MatomoPageType = .trackPageView,
        canonicalPath: String? = nil,
        userState: MatomoUserState? = nil,
        siteId: String = "1",
        trackerUrl: String = "https://statistics.raumnebenan.de/",
        siteBaseUrl: String = "https://www.raumnebenan.de"
    ) -> MatomoTrackerData {
        MatomoTrackerData(
            siteId: siteId,
            trackerUrl: trackerUrl,
            siteBaseUrl: siteBaseUrl,
            status: status,
            pageType: pageType,
            canonicalPath: canonicalPath,
            userState: userState
        )
    }

    private func render(_ data: MatomoTrackerData) async throws -> String {
        var html = ""
        html = renderHTML(MatomoTracker(data).render())
        return html
    }

    @Test("renders nothing when tracking is declined")
    func rendersNothingWhenDeclined() async throws {
        let html = try await render(
            makeData(status: .DECLINED, pageType: .trackPageView)
        )

        #expect(html.isEmpty)
    }

    @Test("renders the tracker as an external script, never as an inline script")
    func rendersExternalTrackerScript() async throws {
        let html = try await render(
            makeData(status: .ACCEPTED, pageType: .trackPageView)
        )

        #expect(html.contains("src=\"/js/matomo-tracker.js\""))
        #expect(html.contains("data-site-id=\"1\""))
        #expect(
            html.contains("data-tracker-url=\"https://statistics.raumnebenan.de/\"")
        )
        #expect(!html.contains("_paq"))
        // Every script has a src
        #expect(html.components(separatedBy: "<script").count - 1 == 2)
        #expect(html.components(separatedBy: "<script src=").count - 1 == 2)
    }

    @Test("escapes configured values in the data attributes")
    func escapesAttributeValues() async throws {
        let html = try await render(
            makeData(
                status: .ACCEPTED,
                pageType: .trackPageView,
                userState: .signedIn(userID: "a\"><script>x</script>")
            )
        )

        #expect(!html.contains("<script>x</script>"))
        #expect(html.contains("data-user-id=\"a&quot;&gt;&lt;script&gt;x"))
    }

    @Test("loads the form tracking script deferred")
    func loadsFormTrackingDeferred() async throws {
        let html = try await render(
            makeData(status: .ACCEPTED, pageType: .trackPageView)
        )

        #expect(html.contains("src=\"/js/formtracking.js\""))
        #expect(html.contains("defer"))
    }

    @Test("disables cookies while the banner is still showing")
    func disablesCookiesWhileBannerShows() async throws {
        let html = try await render(
            makeData(status: .BANNER, pageType: .trackPageView)
        )

        #expect(html.contains("data-consent=\"banner\""))
    }

    @Test("keeps cookies once tracking is accepted")
    func keepsCookiesOnceAccepted() async throws {
        let html = try await render(
            makeData(status: .ACCEPTED, pageType: .trackPageView)
        )

        #expect(html.contains("data-consent=\"accepted\""))
    }

    @Test("sends the user id for a signed in visitor")
    func sendsUserIdForSignedInVisitor() async throws {
        let html = try await render(
            makeData(
                status: .ACCEPTED,
                pageType: .trackPageView,
                userState: .signedIn(userID: "user-42")
            )
        )

        #expect(html.contains("data-user-state=\"signed-in\""))
        #expect(html.contains("data-user-id=\"user-42\""))
    }

    @Test("marks a visitor without a session as not signed in")
    func marksVisitorWithoutSessionAsNotSignedIn() async throws {
        let html = try await render(
            makeData(
                status: .ACCEPTED,
                pageType: .trackPageView,
                userState: .signedOut
            )
        )

        #expect(!html.contains("data-user-id"))
        #expect(html.contains("data-user-state=\"signed-out\""))
    }

    @Test("omits the user dimension when no user state is given")
    func omitsUserDimensionWithoutUserState() async throws {
        let html = try await render(
            makeData(status: .ACCEPTED, pageType: .trackPageView)
        )

        #expect(!html.contains("data-user-id"))
        #expect(!html.contains("data-user-state"))
    }

    @Test("tracks a site search instead of a page view")
    func tracksSiteSearch() async throws {
        let html = try await render(
            makeData(status: .ACCEPTED, pageType: .trackSiteSearch)
        )

        #expect(html.contains("data-page-type=\"site-search\""))
    }

    @Test("points the fallback pixel at the canonical path")
    func fallbackPixelUsesCanonicalPath() async throws {
        let html = try await render(
            makeData(
                status: .ACCEPTED,
                pageType: .trackPageView,
                canonicalPath: "/artikel/test"
            )
        )

        #expect(html.contains("<noscript>"))
        #expect(
            html.contains(
                "url=https://www.raumnebenan.de/artikel/test"
            )
        )
        #expect(html.contains("dimension3=noscript"))
    }

    @Test("falls back to the site root without a canonical path")
    func fallbackPixelUsesSiteRoot() async throws {
        let html = try await render(
            makeData(status: .ACCEPTED, pageType: .trackPageView)
        )

        #expect(html.contains("url=https://www.raumnebenan.de\""))
    }
}
