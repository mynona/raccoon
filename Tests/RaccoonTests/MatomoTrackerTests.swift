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
        userState: MatomoUserState? = nil,
        customDimensions: [Int: String] = [:],
        events: [MatomoEvent] = [],
        resetsUser: Bool = false,
        siteId: String = "1",
        trackerUrl: String = "https://statistics.raumnebenan.de/"
    ) -> MatomoTrackerData {
        MatomoTrackerData(
            siteId: siteId,
            trackerUrl: trackerUrl,
            status: status,
            pageType: pageType,
            userState: userState,
            customDimensions: customDimensions,
            events: events,
            resetsUser: resetsUser
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

        #expect(html.contains("src=\"/js/raccoon-matomo-tracker.js\""))
        #expect(html.contains("data-site-id=\"1\""))
        #expect(
            html.contains("data-tracker-url=\"https://statistics.raumnebenan.de/\"")
        )
        #expect(!html.contains("_paq"))
        // Every script has a src
        #expect(html.components(separatedBy: "<script").count - 1 == 1)
        #expect(html.components(separatedBy: "<script src=").count - 1 == 1)
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

    @Test("renders one script only, the tracker handles forms itself")
    func rendersTrackerScriptOnly() async throws {
        let html = try await render(
            makeData(status: .ACCEPTED, pageType: .trackPageView)
        )

        #expect(html.components(separatedBy: "<script").count == 2)
        #expect(!html.contains("raccoon-form-tracking.js"))
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

    @Test("renders no noscript pixel")
    func rendersNoNoscriptPixel() async throws {
        let html = try await render(makeData(status: .ACCEPTED))

        #expect(!html.contains("<noscript>"))
        #expect(!html.contains("dimension3=noscript"))
    }

    @Test("passes custom dimensions and events as JSON data attributes")
    func passesDimensionsAndEvents() async throws {
        let html = try await render(
            makeData(
                status: .ACCEPTED,
                customDimensions: [4: "google"],
                events: [
                    MatomoEvent(
                        category: "login",
                        action: "success",
                        name: "google"
                    ),
                    MatomoEvent(category: "registration", action: "success"),
                ]
            )
        )

        #expect(html.contains("data-dimensions=\"{&quot;4&quot;:&quot;google&quot;}\""))
        #expect(
            html.contains(
                "data-events=\"[[&quot;login&quot;,&quot;success&quot;,&quot;google&quot;],[&quot;registration&quot;,&quot;success&quot;]]\""
            )
        )
        #expect(!html.contains("data-reset-user"))
    }

    @Test("omits dimensions, events and reset flag by default")
    func omitsExtrasByDefault() async throws {
        let html = try await render(makeData(status: .ACCEPTED))

        #expect(!html.contains("data-dimensions"))
        #expect(!html.contains("data-events"))
        #expect(!html.contains("data-reset-user"))
    }

    @Test("flags the page shown after a sign out")
    func flagsSignOutPage() async throws {
        let html = try await render(
            makeData(status: .ACCEPTED, resetsUser: true)
        )

        #expect(html.contains("data-reset-user=\"true\""))
    }

    @Test("builds slugs and pieces as <type>.<item>")
    func buildsSlugsAndPieces() {
        #expect(MatomoContentTracker.slug("5. Your right to your data") == "5-your-right-to-your-data")
        #expect(MatomoContentTracker.slug("  Größe & Ärger!  ") == "grosse-arger")
        #expect(MatomoContentTracker.slug("---") == "")
        #expect(MatomoContentTracker.slug(String(repeating: "ab ", count: 40)).count <= 60)
        #expect(!MatomoContentTracker.slug(String(repeating: "ab ", count: 40)).hasSuffix("-"))

        #expect(MatomoContentTracker.piece("tab", "Foundation") == "tab.foundation")
        #expect(MatomoContentTracker.piece("button", "save.given-name") == "button.save.given-name")
        #expect(MatomoContentTracker.piece("toggle") == "toggle")
        #expect(MatomoContentTracker.piece("link", "!!!") == "link")
    }
}
