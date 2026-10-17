import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("CodeBlock")
struct CodeBlockTests {

    @Test("renders code content")
    func rendersCodeContent() async throws {

        let html = renderHTML(
            CodeBlock(CodeBlockData(code: "let x = 42"))
                .render()
        )
        #expect(html.contains("let x = 42"))
    }

    @Test("renders relative-positioned container")
    func rendersRelativeContainer() async throws {

        let html = renderHTML(
            CodeBlock(CodeBlockData(code: "print(\"hello\")"))
                .render()
        )
        #expect(html.contains("relative"))
    }

    @Test("renders copy button")
    func rendersCopyButton() async throws {

        let html = renderHTML(
            CodeBlock(CodeBlockData(code: "func hello() {}"))
                .render()
        )
        #expect(html.contains("<button"))
    }

    @Test("wraps non-empty lines in spans")
    func wrapsNonEmptyLinesInSpans() async throws {

        let code = "line1\nline2"
        let html = renderHTML(
            CodeBlock(CodeBlockData(code: code)).render()
        )
        #expect(html.contains("<span>line1</span>"))
        #expect(html.contains("<span>line2</span>"))
    }

    @Test("handles multiline code with blank lines")
    func handlesMultilineWithBlankLines() async throws {

        let code = "line1\n\nline3"
        let html = renderHTML(
            CodeBlock(CodeBlockData(code: code)).render()
        )
        #expect(html.contains("<span>line1</span>"))
        #expect(html.contains("<span>line3</span>"))
    }

    @Test("renders pre and code elements with text lang attribute")
    func rendersPreAndCodeElements() async throws {

        let html = renderHTML(
            CodeBlock(CodeBlockData(code: "echo 'hi'")).render()
        )
        #expect(html.contains("<pre"))
        #expect(html.contains("<code"))
        #expect(html.contains("data-lang=\"text\""))
    }
}
