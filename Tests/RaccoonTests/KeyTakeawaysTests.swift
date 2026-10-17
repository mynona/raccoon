import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("KeyTakeaways")
struct KeyTakeawaysTests {

    @Test("renders title")
    func rendersTitle() async throws {

        let html = renderHTML(
            KeyTakeaways(
                KeyTakeawaysData(
                    title: "Key Learnings",
                    contentAsMarkdown: "- Point one"
                )
            )
            .render()
        )
        #expect(html.contains("Key Learnings"))
        #expect(html.contains("<h3"))
    }

    @Test("wraps block-level markdown in a div, never a span")
    func wrapsMarkdownInDiv() async throws {

        let html = renderHTML(
            KeyTakeaways(
                KeyTakeawaysData(
                    title: "Tips",
                    contentAsMarkdown: "- one\n- two"
                )
            )
            .render()
        )
        #expect(
            html.contains(
                "<div class=\"mt-8 \(KeyTakeawaysStyles.prose)\"><ul>"
            )
        )
        #expect(!html.contains("<span><ul>"))
    }

    @Test("typealias KeyTakeaway works interchangeably")
    func typealiasWorks() async throws {

        let html = renderHTML(
            KeyTakeaways(
                KeyTakeawaysData(
                    title: "Singular",
                    contentAsMarkdown: "Takeaway text"
                )
            )
            .render()
        )
        #expect(html.contains("Singular"))
        #expect(html.contains("Takeaway text"))
    }

    @Test("renders markdown content")
    func rendersMarkdownContent() async throws {

        let html = renderHTML(
            KeyTakeaways(
                KeyTakeawaysData(
                    title: "Tips",
                    contentAsMarkdown: "- Always test your code."
                )
            )
            .render()
        )
        #expect(html.contains("Always test your code."))
    }

    @Test("renders with empty title and markdown")
    func rendersWithEmptyTitleAndMarkdown() async throws {
        let html = renderHTML(
            KeyTakeaways(KeyTakeawaysData(title: "", contentAsMarkdown: ""))
                .render()
        )
        #expect(html.contains("<section"))
    }

    @Test("renders with long markdown text")
    func rendersWithLongMarkdown() async throws {
        let longText = String(repeating: "- Point\n", count: 256)
        let html = renderHTML(
            KeyTakeaways(
                KeyTakeawaysData(title: "Long", contentAsMarkdown: longText)
            )
            .render()
        )
        #expect(html.contains("Long"))
        #expect(html.contains("Point"))
    }

    @Test("renders multiple instances")
    func rendersMultipleInstances() async throws {
        let elements =
            KeyTakeaways(KeyTakeawaysData(title: "A", contentAsMarkdown: "- 1"))
            .render()
            + KeyTakeaways(
                KeyTakeawaysData(title: "B", contentAsMarkdown: "- 2")
            )
            .render()
        let html = renderHTML(elements)
        #expect(html.contains("A"))
        #expect(html.contains("B"))
    }

}
