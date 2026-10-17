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
        #expect(html.contains("hreflang=\"\(AppValues.lang)\""))
        #expect(html.contains("skip-link"))
    }

    @Test("renders custom text and target")
    func rendersCustomTextAndTarget() async throws {

        let data = SkipLinkData(
            text: "Skip to content",
            targetId: "content-area",
            hreflang: "de-DE"
        )
        let html = renderHTML(SkipLink(data).render())
        #expect(html.contains("href=\"#content-area\""))
        #expect(html.contains("Skip to content"))
        #expect(html.contains("hreflang=\"de-DE\""))
    }

    @Test("normalizes targetId starting with hash")
    func normalizesTargetIdWithHash() async throws {

        let data = SkipLinkData(
            targetId: "#main-content"
        )
        let html = renderHTML(SkipLink(data).render())
        #expect(html.contains("href=\"#main-content\""))
    }

    @Test("omits hreflang when nil")
    func omitsHreflangWhenNil() async throws {

        let data = SkipLinkData(
            hreflang: nil
        )
        let html = renderHTML(SkipLink(data).render())
        #expect(!html.contains("hreflang"))
    }
}
