import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("Quote")
struct QuoteTests {

    @Test("renders quote text")
    func rendersQuoteText() async throws {

        let html = renderHTML(
            Quote(QuoteData(quote: "Ship early, ship often.", citation: nil))
                .render()
        )
        #expect(html.contains("Ship early, ship often."))
    }

    @Test("renders figure element")
    func rendersFigureElement() async throws {

        let html = renderHTML(
            Quote(QuoteData(quote: "Some insight.", citation: nil))
                .render()
        )
        #expect(html.contains("<figure"))
    }

    @Test("renders citation when provided")
    func rendersCitation() async throws {

        let html = renderHTML(
            Quote(
                QuoteData(
                    quote: "Design is how it works.",
                    citation: "Steve Jobs"
                )
            )
            .render()
        )
        #expect(html.contains("Steve Jobs"))
        #expect(html.contains("<figcaption"))
    }

    @Test("omits figcaption when citation is nil")
    func omitsFigcaptionWhenNoCitation() async throws {

        let html = renderHTML(
            Quote(QuoteData(quote: "Quote text.", citation: nil))
                .render()
        )
        #expect(!html.contains("<figcaption"))
    }

    @Test("wraps quote in quotation marks when hasQuotationMarks is true")
    func wrapsQuotationMarks() async throws {

        let htmlWith = renderHTML(
            Quote(
                QuoteData(
                    quote: "Hello world",
                    citation: nil,
                    hasQuotationMarks: true
                )
            )
            .render()
        )
        #expect(htmlWith.contains("“Hello world”"))

        let htmlWithout = renderHTML(
            Quote(
                QuoteData(
                    quote: "Hello world",
                    citation: nil,
                    hasQuotationMarks: false
                )
            )
            .render()
        )
        #expect(htmlWithout.contains("Hello world"))
        #expect(!htmlWithout.contains("“"))
    }

    @Test("renders markdown inside quote")
    func rendersMarkdownInsideQuote() async throws {

        let html = renderHTML(
            Quote(
                QuoteData(
                    quote: "This is *italic* and **bold**",
                    citation: "Author",
                    hasQuotationMarks: false
                )
            )
            .render()
        )
        #expect(html.contains("<em>italic</em>"))
        #expect(html.contains("<strong>bold</strong>"))
    }
}
