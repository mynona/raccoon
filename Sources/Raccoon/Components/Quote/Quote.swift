import HTML
import SGML
import SVG
import WebBuilders

public struct Quote: TemplateRepresentable {
    let data: QuoteData
    typealias styles = QuoteStyles

    public init(
        _ data: QuoteData
    ) {
        self.data = data
    }

    func quoteAsMarkdown() -> String {
        let html = renderMarkdownAsHTML(data.quote)

        // Destructive <p> and </p> stripping done intentionally: quotes must never include paragraphs
        let result =
            html
            .replacingOccurrences(
                of: #"<pre\b[^>]*>"#,
                with: "",
                options: .regularExpression
            )
            .replacingOccurrences(of: "</pre>", with: "")
            .replacingOccurrences(of: "<p>", with: "")
            .replacingOccurrences(of: "</p>", with: "")
            .replacingOccurrences(
                of: #"<code\b[^>]*>"#,
                with: "",
                options: .regularExpression
            )
            .replacingOccurrences(of: "</code>", with: "")
            .replacingOccurrences(
                of: #"\s+"#,
                with: " ",
                options: .regularExpression
            )
            .trimmingCharacters(in: .whitespacesAndNewlines)

        // Deliberate choice to use English typographical quotes for all languages
        guard data.hasQuotationMarks else {
            return result
        }
        return "“\(result)”"
    }

    @Builder<Element>
    func showCitation() -> [Element] {
        if let citation = data.citation {
            Figcaption(citation)
                .class("m-0 pt-2 !mt-0")
                .addClass(styles.citation)
        }
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Quote")
        Div {
            Figure {
                Blockquote(quoteAsMarkdown())
                showCitation()
            }
            .class("border-0 p-0 pl-4 md:pl-8 m-0 !mb-0")
            .addClass(styles.quote)
        }
        .class("space-y-0 my-14")
        .addClass(styles.container)

    }
}
