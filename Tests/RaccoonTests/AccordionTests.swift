import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("Accordion")
struct AccordionTests {

    @Test("renders label in summary")
    func rendersLabel() async throws {

        let html = renderHTML(
            Accordion(
                AccordionData(
                    label: "What is Vapor?",
                    content: .html("A Swift web framework.")
                )
            )
            .render()
        )
        #expect(html.contains("What is Vapor?"))
    }

    @Test("renders markdown content")
    func rendersMarkdown() async throws {

        let html = renderHTML(
            Accordion(
                AccordionData(
                    label: "Q",
                    content: .markdown("**Bold answer** and _italic_")
                )
            )
            .render()
        )
        #expect(
            html.contains("<strong>Bold answer</strong>")
                || html.contains("<b>Bold answer</b>")
                || html.contains("Bold answer")
        )
    }

    @Test("wraps block-level markdown and html content in a div, never a span")
    func wrapsBlockContentInDiv() async throws {

        let markdown = renderHTML(
            Accordion(
                AccordionData(
                    label: "Q",
                    content: .markdown("- one\n- two")
                )
            )
            .render()
        )
        #expect(markdown.contains("<div><ul>"))
        #expect(!markdown.contains("<span><ul>"))

        let rawHTML = renderHTML(
            Accordion(
                AccordionData(
                    label: "Q",
                    content: .html("<p>Paragraph</p>"),
                    isContentSansSerif: true
                )
            )
            .render()
        )
        #expect(
            rawHTML.contains(
                "<div class=\"\(AccordionStyles.fontSans)\"><p>Paragraph</p></div>"
            )
        )
        #expect(
            !rawHTML.contains("<span\"")
                && !rawHTML.contains(
                    "<span class=\"\(AccordionStyles.fontSans)\">"
                )
        )
    }

    @Test("renders icon and keyboard key when provided")
    func rendersIconAndKeyboardKey() async throws {

        let html = renderHTML(
            Accordion(
                AccordionData(
                    label: "Help shortcut",
                    content: .html("Help text"),
                    icon: .question_circle,
                    keyboardKey: "k"
                )
            )
            .render()
        )
        #expect(html.contains("<svg"))
        #expect(html.contains("K"))
    }

    @Test("renders font variations for label and content")
    func rendersFontVariations() async throws {

        let monoLabelSansContent = renderHTML(
            Accordion(
                AccordionData(
                    label: "Code query",
                    content: .html("Sans content"),
                    isLabelMonospaced: true,
                    isContentSansSerif: true
                )
            )
            .render()
        )
        #expect(monoLabelSansContent.contains("font-mono"))
        #expect(monoLabelSansContent.contains("font-sans"))
    }

    @Test("renders matomo tracking attributes when enabled")
    func rendersMatomoAttributes() async throws {

        let tracked = renderHTML(
            Accordion(
                AccordionData(
                    label: "Tracked item",
                    content: .html("Tracked content"),
                    matomoStatus: .ACCEPTED
                )
            )
            .render()
        )
        #expect(tracked.contains("data-track-content"))
        #expect(tracked.contains("data-content-name=\"accordion\""))
        #expect(tracked.contains("data-content-target=\"Tracked item\""))
    }

    @Test("renders border class when showBorder is true")
    func rendersBorderWhenEnabled() async throws {

        let withBorder = renderHTML(
            Accordion(
                AccordionData(
                    label: "Q",
                    content: .html("A"),
                    hasBorder: true
                )
            )
            .render()
        )
        let withoutBorder = renderHTML(
            Accordion(
                AccordionData(
                    label: "Q",
                    content: .html("A"),
                    hasBorder: false
                )
            )
            .render()
        )
        #expect(
            withBorder.contains(AccordionStyles.summaryLabelBorder)
        )
        #expect(
            !withoutBorder.contains(
                AccordionStyles.summaryLabelBorder
            )
        )
    }

    @Test("renders details and summary elements")
    func rendersDetailsElement() async throws {

        let html = renderHTML(
            Accordion(
                AccordionData(
                    label: "Title",
                    content: .html("Content")
                )
            )
            .render()
        )
        #expect(html.contains("<details"))
        #expect(html.contains("<summary"))
    }

    @Test(
        "wires content accessibility attributes without redundant aria on native disclosure elements"
    )
    func wiresAccessibilityAttributes() async throws {

        let html = renderHTML(
            Accordion(
                AccordionData(
                    label: "Title",
                    content: .html("Content")
                )
            )
            .render()
        )

        // Native <details>/<summary> already convey the toggle relationship, so aria-controls is omitted.
        #expect(!html.contains("aria-controls="))
        #expect(html.contains("aria-labelledby=\"accordion-"))
        #expect(html.contains("id=\"accordion-"))
    }

    @Test("renders inline HTML content")
    func rendersInlineHTMLContent() async throws {

        let html = renderHTML(
            Accordion(
                AccordionData(
                    label: "Q",
                    content: .html("Answer with <em>emphasis</em>.")
                )
            )
            .render()
        )

        #expect(html.contains("<em>emphasis</em>"))
    }

    @Test("renders element content")
    func rendersElementContent() async throws {

        let html = renderHTML(
            Accordion(
                AccordionData(
                    label: "Q",
                    content: .element {
                        H1("Header").class("test")
                        P("Paragraph")
                    }
                )
            )
            .render()
        )

        #expect(html.contains("Header"))
        #expect(html.contains("Paragraph"))
        #expect(html.contains("class=\"test\""))
    }

    @Test("uses explicit id instead of label hash when provided")
    func usesExplicitId() async throws {

        let html = renderHTML(
            Accordion(
                AccordionData(
                    id: "custom-id",
                    label: "Q",
                    content: .html("A")
                )
            )
            .render()
        )

        #expect(html.contains("id=\"accordion-custom-id-heading\""))
        #expect(html.contains("id=\"accordion-custom-id-content\""))
    }
}
