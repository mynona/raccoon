import HTML
import Raccoon
import SGML
import Testing

@testable import Raccoon

@Suite("HelperText")
struct HelperTextTests {
    private func renderHTML(_ elements: [any SGML.Element]) -> String {
        elements.map { Document(root: $0).render(indent: 0) }.joined()
    }

    @Test("renders helper text")
    func testHelperTextRenders() {
        let ctx = HelperTextData(
            id: "help",
            text: "This is help"
        )
        let html = renderHTML(HelperText(ctx).render())
        #expect(html.contains("This is help"))
    }

    @Test("renders with empty text")
    func testEmptyText() {
        let ctx = HelperTextData(id: "empty", text: nil)
        let html = renderHTML(HelperText(ctx).render())
        #expect(html.isEmpty || html.contains("<p") == false)
    }

    @Test("wraps block-level markdown in the helper div, never a span")
    func wrapsMarkdownInDiv() {
        let ctx = HelperTextData(
            id: "help",
            text: "- one\n- two",
            isMarkdown: true
        )
        let html = renderHTML(HelperText(ctx).render())
        #expect(html.contains("id=\"help-helper\""))
        #expect(html.contains("<ul>"))
        #expect(!html.contains("<span"))
    }

    @Test("renders with long text")
    func testLongText() {
        let longText = String(repeating: "H", count: 256)
        let ctx = HelperTextData(id: "long", text: longText)
        let html = renderHTML(HelperText(ctx).render())
        #expect(html.contains(longText))
    }

    @Test("renders helper id and text classes")
    func testHelperIdAndClasses() {
        let ctx = HelperTextData(
            id: "helper",
            text: "This is a helper text."
        )
        let html = renderHTML(HelperText(ctx).render())
        #expect(html.contains("id=\"helper-helper\""))
        #expect(html.contains("class=\"mt-2"))
        #expect(html.contains("This is a helper text."))
    }

    @Test("omits element when title is empty string")
    func testEmptyStringTitle() {
        let ctx = HelperTextData(id: "blank", text: "")
        let html = renderHTML(HelperText(ctx).render())
        #expect(!html.contains("id=\"blank-helper\""))
    }

    @Test("renders markdown helper text and comment")
    func testMarkdownHelperText() {
        let ctx = HelperTextData(
            id: "md-help",
            text: "Read [docs](https://example.com) here",
            isMarkdown: true
        )
        let html = renderHTML(HelperText(ctx).render())
        #expect(html.contains("<!-- Helper text -->"))
        #expect(html.contains("id=\"md-help-helper\""))
        #expect(html.contains("href=\"https://example.com\""))
        #expect(html.contains(">docs</a>"))
    }
}
