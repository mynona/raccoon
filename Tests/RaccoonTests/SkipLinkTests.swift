import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("SkipLink")
struct SkipLinkTests {

    @Test("renders default skip link element")
    func rendersDefaultSkipLink() async throws {

        let html = renderHTML(SkipLink().render())
        #expect(html.contains("<a"))
        #expect(html.contains("href=\"#main\""))
        #expect(html.contains("Jump directly to the main content"))
        #expect(!html.contains("hreflang"))
        #expect(html.contains("skip-link"))
    }

    @Test("renders custom text and target")
    func rendersCustomTextAndTarget() async throws {

        let data = SkipLinkData(
            text: "Skip to content",
            targetId: "content-area"
        )
        let html = renderHTML(SkipLink(data).render())
        #expect(html.contains("href=\"#content-area\""))
        #expect(html.contains("Skip to content"))
    }

    @Test("normalizes targetId starting with hash")
    func normalizesTargetIdWithHash() async throws {

        let data = SkipLinkData(
            targetId: "#main-content"
        )
        let html = renderHTML(SkipLink(data).render())
        #expect(html.contains("href=\"#main-content\""))
    }

    @Test("the default text is built in and translated; a literal stays plain")
    func localizedText() {
        let english = renderHTML(SkipLink().render())
        #expect(english.contains("data-i18n=\"skiplink.jump\""))
        let german = I18n.render(language: "de") {
            renderHTML(SkipLink().render())
        }
        #expect(german.contains(">Direkt zum Hauptinhalt springen</a>"))

        let own = I18n.render(language: "de") {
            renderHTML(SkipLink(SkipLinkData(text: "Zum Inhalt")).render())
        }
        #expect(own.contains(">Zum Inhalt</a>"))
        #expect(!own.contains("data-i18n"))
    }
}
