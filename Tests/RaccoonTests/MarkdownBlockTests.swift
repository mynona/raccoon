import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("MarkdownBlock")
struct MarkdownBlockTests {

    @Test("renders empty markdown string")
    func rendersEmptyMarkdown() async throws {
        let html = renderHTML(
            MarkdownBlock(MarkdownBlockData(markdown: "", isProse: false))
                .render()
        )
        #expect(html.contains("<section"))
    }

    @Test("renders HTML escaping in markdown")
    func rendersHtmlEscaping() async throws {
        let html = renderHTML(
            MarkdownBlock(
                MarkdownBlockData(markdown: "<b>bold</b>", isProse: true)
            )
            .render()
        )
        #expect(
            html.contains("&lt;b&gt;bold&lt;/b&gt;")
                || html.contains("<b>bold</b>")
        )
    }

    @Test("renders all markdown features (browser parity)")
    func rendersAllMarkdownFeaturesBrowserParity() async throws {
        let md = """
            # Heading 1
            ## Heading 2
            ### Heading 3
            #### Heading 4
            ---
            **Unordered List with asterix:**
            * Item one
            * Item two
            * Item three
            **Unordered List with hyphen:**
            - Item one
            - Item two
            - Item three
            **Ordered List:**
            1. First item
            2. Second item
            3. Third item
            **Bold**
            *Italic*
            `Inline code`
            ```
            Multiline code block 
            Another line of code
            ```
            [Link](https://link)
            > Blockquote
            | Name | Age |
            |------|-----|
            | Max  | 32  |
            | Eva  | 29  |
            ![Alt text](/images/bmc-yellow.png)
            Term
            : Definition text
            - [x] Done
            - [ ] Not done
            - [x] Done
            - [ ] Not done
            ~~This is crossed out~~
            """
        let html = renderHTML(
            MarkdownBlock(MarkdownBlockData(markdown: md, isProse: true))
                .render()
        )
        #expect(html.contains("Heading 1"))
        #expect(html.contains("Heading 2"))
        #expect(html.contains("Heading 3"))
        #expect(html.contains("Heading 4"))
        #expect(html.contains("Unordered List with asterix"))
        #expect(html.contains("Item one"))
        #expect(html.contains("Ordered List"))
        #expect(html.contains("First item"))
        #expect(html.contains("Bold"))
        #expect(html.contains("Italic"))
        #expect(html.contains("Inline code"))
        #expect(html.contains("Multiline code block"))
        #expect(html.contains("Another line of code"))
        #expect(html.contains("Link"))
        #expect(html.contains("Blockquote"))
        #expect(html.contains("Name"))
        #expect(html.contains("Age"))
        #expect(html.contains("Max"))
        #expect(html.contains("32"))
        #expect(html.contains("Eva"))
        #expect(html.contains("29"))
        #expect(html.contains("Term"))
        #expect(html.contains("Definition text"))
        #expect(html.contains("Done"))
        #expect(html.contains("Not done"))
        #expect(html.contains("crossed out"))
    }

    @Test("renders raw HTML in markdown (no sanitization)")
    func rendersRawHtmlNoSanitization() async throws {
        let html = renderHTML(
            MarkdownBlock(
                MarkdownBlockData(
                    markdown: "<script>alert('x')</script>",
                    isProse: false
                )
            )
            .render()
        )
        #expect(html.contains("<script>"))
    }

    @Test("renders unicode and special characters")
    func rendersUnicodeAndSpecialChars() async throws {
        let html = renderHTML(
            MarkdownBlock(
                MarkdownBlockData(
                    markdown: "Emoji 🚀 and ümläuts äöü",
                    isProse: true
                )
            )
            .render()
        )
        #expect(html.contains("🚀"))
        #expect(html.contains("äöü"))
    }

    @Test("renders very long markdown (performance)")
    func rendersVeryLongMarkdown() async throws {
        let longText = String(repeating: "LongText ", count: 5000)
        let html = renderHTML(
            MarkdownBlock(MarkdownBlockData(markdown: longText, isProse: false))
                .render()
        )
        #expect(html.contains("LongText"))
    }

    @Test("renders markdown content")
    func rendersMarkdownContent() async throws {

        let html = renderHTML(
            MarkdownBlock(
                MarkdownBlockData(markdown: "Hello **world**", isProse: true)
            )
            .render()
        )
        #expect(html.contains("Hello"))
    }

    @Test("renders section element")
    func rendersSectionElement() async throws {

        let html = renderHTML(
            MarkdownBlock(
                MarkdownBlockData(markdown: "Content", isProse: false)
            )
            .render()
        )
        #expect(html.contains("<section"))
    }

    @Test("applies prose class when hasProse is true")
    func appliesProseClass() async throws {

        let withProse = renderHTML(
            MarkdownBlock(MarkdownBlockData(markdown: "Text", isProse: true))
                .render()
        )
        let withoutProse = renderHTML(
            MarkdownBlock(MarkdownBlockData(markdown: "Text", isProse: false))
                .render()
        )
        #expect(withProse.contains("prose"))
        #expect(!withoutProse.contains("prose"))
    }
}
