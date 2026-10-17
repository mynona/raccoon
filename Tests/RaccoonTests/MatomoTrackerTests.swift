import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("MatomoTracker")
struct MatomoTrackerTests {

    private func render(_ data: MatomoTrackerData) async throws -> String {
        var html = ""
        html = renderHTML(MatomoTracker(data).render())
        return html
    }

    @Test("renders nothing when tracking is declined")
    func rendersNothingWhenDeclined() async throws {
        let html = try await render(
            MatomoTrackerData(status: .DECLINED, pageType: .trackPageView)
        )

        #expect(html.isEmpty)
    }

    @Test("renders the tracking script when accepted")
    func rendersTrackingScriptWhenAccepted() async throws {
        let html = try await render(
            MatomoTrackerData(status: .ACCEPTED, pageType: .trackPageView)
        )

        #expect(html.contains("var _paq = window._paq"))
        #expect(html.contains("_paq.push(['setSiteId', '1']);"))
        #expect(html.contains("u=\"https://statistics.raumnebenan.de/\""))
    }

    @Test("loads the form tracking script deferred")
    func loadsFormTrackingDeferred() async throws {
        let html = try await render(
            MatomoTrackerData(status: .ACCEPTED, pageType: .trackPageView)
        )

        #expect(html.contains("src=\"/js/formtracking.js\""))
        #expect(html.contains("defer"))
    }

    @Test("disables cookies while the banner is still showing")
    func disablesCookiesWhileBannerShows() async throws {
        let html = try await render(
            MatomoTrackerData(status: .BANNER, pageType: .trackPageView)
        )

        #expect(html.contains("_paq.push(['disableCookies']);"))
        #expect(html.contains("_paq.push(['enableHeartBeatTimer', 15, 30]);"))
    }

    @Test("keeps cookies once tracking is accepted")
    func keepsCookiesOnceAccepted() async throws {
        let html = try await render(
            MatomoTrackerData(status: .ACCEPTED, pageType: .trackPageView)
        )

        #expect(!html.contains("disableCookies"))
        #expect(html.contains("_paq.push(['enableHeartBeatTimer', 5, 10]);"))
    }

    @Test("sends the user id for a signed in visitor")
    func sendsUserIdForSignedInVisitor() async throws {
        let html = try await render(
            MatomoTrackerData(
                status: .ACCEPTED,
                pageType: .trackPageView,
                userState: .signedIn(userID: "user-42")
            )
        )

        #expect(html.contains("_paq.push(['setUserId', 'user-42']);"))
        #expect(
            html.contains("_paq.push(['setCustomDimension', 1, 'signed-in']);")
        )
    }

    @Test("marks a visitor without a session as not signed in")
    func marksVisitorWithoutSessionAsNotSignedIn() async throws {
        let html = try await render(
            MatomoTrackerData(
                status: .ACCEPTED,
                pageType: .trackPageView,
                userState: .signedOut
            )
        )

        #expect(!html.contains("setUserId"))
        #expect(
            html.contains(
                "_paq.push(['setCustomDimension', 1, 'not-signed-in']);"
            )
        )
    }

    @Test("omits the user dimension when no user state is given")
    func omitsUserDimensionWithoutUserState() async throws {
        let html = try await render(
            MatomoTrackerData(status: .ACCEPTED, pageType: .trackPageView)
        )

        #expect(!html.contains("setUserId"))
        #expect(!html.contains("setCustomDimension', 1"))
    }

    @Test("tracks a site search instead of a page view")
    func tracksSiteSearch() async throws {
        let html = try await render(
            MatomoTrackerData(status: .ACCEPTED, pageType: .trackSiteSearch)
        )

        #expect(html.contains("_paq.push(['trackSiteSearch','',false,false]);"))
        #expect(!html.contains("trackPageView"))
    }

    @Test("points the fallback pixel at the canonical path")
    func fallbackPixelUsesCanonicalPath() async throws {
        let html = try await render(
            MatomoTrackerData(
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
            MatomoTrackerData(status: .ACCEPTED, pageType: .trackPageView)
        )

        #expect(html.contains("url=https://www.raumnebenan.de\""))
    }
}
