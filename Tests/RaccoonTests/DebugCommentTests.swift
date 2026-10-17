import HTML
import Raccoon
import SGML
import Testing
import WebBuilders

@testable import Raccoon

@Suite("DebugComment")
struct DebugCommentTests {

    private func renderHTML(_ elements: [any SGML.Element]) -> String {
        elements.map { Document(root: $0).render(indent: 0) }.joined()
    }

    @Test("DebugComment emits HTML comment in debug mode")
    func testDebugCommentEmitsCommentInDebug() {
        let elements = DebugComment("Test Landmark")
        #if DEBUG
        #expect(elements.count == 1)
        let html = renderHTML(elements)
        #expect(html == "<!-- Test Landmark -->")
        #else
        #expect(elements.isEmpty)
        #endif
    }

    @Test("DebugComment works inside a Builder closure")
    func testDebugCommentInsideBuilder() {
        @Builder<Element>
        func buildSample() -> [Element] {
            DebugComment("Sample Component")
            Div {
                Span("Hello")
            }
        }

        let elements = buildSample()
        let html = renderHTML(elements)
        #if DEBUG
        #expect(html.contains("<!-- Sample Component -->"))
        #expect(html.contains("<div><span>Hello</span></div>"))
        #else
        #expect(!html.contains("<!-- Sample Component -->"))
        #expect(html == "<div><span>Hello</span></div>")
        #endif
    }

    @Test("DebugComment with empty text")
    func testDebugCommentEmptyText() {
        let elements = DebugComment("")
        #if DEBUG
        let html = renderHTML(elements)
        #expect(html == "<!--  -->")
        #else
        #expect(elements.isEmpty)
        #endif
    }
}
