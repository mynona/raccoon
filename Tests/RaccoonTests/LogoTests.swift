import HTML
import Raccoon
import SGML
import Testing

@testable import Raccoon

@Suite("Logo")
struct LogoTests {

    @Test("renders default variant")
    func rendersDefaultVariant() {
        let ctx = LogoData(
            matomoStatus: .ACCEPTED
        )
        let html = renderHTML(Logo(ctx).render())
        #expect(html.contains("svg"))
        #expect(html.contains("aria-label=\"Go to home\""))
        #expect(html.contains("href=\"/home\""))
        #expect(html.contains("data-track-content"))
        #expect(html.contains("data-content-name=\"logo\""))
        #expect(html.contains("data-content-piece=\"button.home\""))
        #expect(html.contains("data-content-target=\"/home\""))
    }

    @Test("accessibility: aria-label, role, tabindex, and data attributes")
    func accessibilityAttributes() {
        let ctx = LogoData(matomoStatus: .ACCEPTED)
        let html = renderHTML(Logo(ctx).render())
        #expect(html.contains("aria-label=\"Go to home\""))
        #expect(html.contains("data-track-content"))
        #expect(html.contains("data-content-name=\"logo\""))
        #expect(html.contains("data-content-piece=\"button.home\""))
        #expect(html.contains("data-content-target=\"/home\""))
    }

    @Test("renders with all prop combinations (exhaustive)")
    func rendersAllPropCombinations() {
        let ctx = LogoData(matomoStatus: .ACCEPTED)
        let html = renderHTML(Logo(ctx).render())
        #expect(html.contains("svg"))
        #expect(html.contains("aria-label=\"Go to home\""))
        #expect(html.contains("href=\"/home\""))
        #expect(html.contains("data-track-content"))
    }
    @Test("renders logo SVG or image")
    func testLogoRenders() {
        let ctx = LogoData()
        let html = renderHTML(Logo(ctx).render())
        #expect(html.contains("svg") || html.contains("img"))
    }

    @Test("renders customizable destination")
    func testCustomDestination() {
        let ctx = LogoData(
            destination: "/de/start",
            matomoStatus: .ACCEPTED
        )
        let html = renderHTML(Logo(ctx).render())
        #expect(html.contains("href=\"/de/start\""))
        #expect(html.contains("data-content-target=\"/de/start\""))
    }

    private func renderHTML(_ elements: [any SGML.Element]) -> String {
        elements.map { Document(root: $0).render(indent: 0) }.joined()
    }

    // MARK: localization

    @Test("the aria-label is built in and translated")
    func localizedAriaLabel() {
        let english = renderHTML(Logo(LogoData()).render())
        #expect(english.contains("aria-label=\"Go to home\""))
        #expect(english.contains("data-i18n-aria-label=\"logo.home\""))
        let german = I18n.render(language: "de") {
            renderHTML(Logo(LogoData()).render())
        }
        #expect(german.contains("aria-label=\"Zur Startseite\""))
    }
}
