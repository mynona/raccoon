import HTML
import Raccoon
import SGML
import Testing

@testable import Raccoon

@Suite("CookieBanner")
struct CookieBannerTests {
    private func renderHTML(_ elements: [any SGML.Element]) -> String {
        elements.map { Document(root: $0).render(indent: 0) }.joined()
    }

    @Test("renders cookie banner")
    func testCookieBannerRenders() {
        let ctx = CookieBannerData(url: "/test-url", matomoStatus: .BANNER)
        let html = renderHTML(CookieBanner(ctx).render())
        #expect(html.contains("cookie"))
    }

    @Test("renders accept and decline buttons")
    func testButtonsRender() {
        let ctx = CookieBannerData(url: "/test-url", matomoStatus: .BANNER)
        let html = renderHTML(CookieBanner(ctx).render())
        #expect(html.contains("Accept all"))
        #expect(html.contains("Decline statistics"))
    }

    @Test("renders opt-in and opt-out target URLs with current page url")
    func testActionURLs() {
        let ctx = CookieBannerData(
            url: "/blog/post-1",
            matomoStatus: .BANNER
        )
        let html = renderHTML(CookieBanner(ctx).render())
        #expect(html.contains("formaction=\"/opt-in/blog/post-1\""))
        #expect(html.contains("formaction=\"/opt-out/blog/post-1\""))
    }

    @Test("renders dialog role and accessibility label")
    func testAccessibilityDialog() {
        let ctx = CookieBannerData(url: "/home", matomoStatus: .BANNER)
        let html = renderHTML(CookieBanner(ctx).render())
        #expect(html.contains("role=\"dialog\""))
        #expect(html.contains("aria-label=\"Cookie consent\""))
        #expect(html.contains("id=\"cookie-consent\""))
        #expect(html.contains("x-data=\"{ consent: true }\""))
    }

    @Test("renders edge cases")
    func testEdgeCases() {
        let ctx = CookieBannerData(url: "", matomoStatus: .BANNER)
        let html = renderHTML(CookieBanner(ctx).render())
        #expect(html.contains("formaction=\"/opt-in\""))
        #expect(html.contains("formaction=\"/opt-out\""))
    }

    @Test("validates form configuration and button action behavior")
    func testFormConfigurationAndActions() {
        let ctx = CookieBannerData(url: "/articles/test", matomoStatus: .BANNER)
        let html = renderHTML(CookieBanner(ctx).render())

        #expect(html.contains("<form"))
        #expect(html.contains("formaction=\"/opt-in/articles/test\""))
        #expect(html.contains("formaction=\"/opt-out/articles/test\""))
        #expect(html.contains("formmethod=\"get\""))
        #expect(html.contains("consent = false"))
        #expect(!html.contains("name=\"X-CSRF-Token\""))
    }

    // MARK: localization

    @Test(
        "all texts are built in and translated; the sentence around the link is split into three keys"
    )
    func localizedTexts() {
        let data = CookieBannerData(url: "/x", matomoStatus: .BANNER)
        let english = renderHTML(CookieBanner(data).render())
        for key in [
            "title", "statistics", "statisticsText", "necessary",
            "necessaryText", "privacyBefore", "privacyLink", "privacyAfter",
            "acceptAll", "decline", "consent",
        ] {
            #expect(english.contains("cookiebanner.\(key)"), "\(key)")
        }
        let german = I18n.render(language: "de") {
            renderHTML(CookieBanner(data).render())
        }
        #expect(german.contains(">Du entscheidest</p>"))
        #expect(
            german.contains(
                ">Du kannst deine Cookie-Einstellungen jederzeit in der </span>"
            )
        )
        #expect(german.contains(">Datenschutzerklärung</a>"))
        #expect(german.contains("> ändern.</span>"))
        #expect(german.contains("Alle akzeptieren"))
        #expect(german.contains("aria-label=\"Cookie-Einwilligung\""))
    }
}
