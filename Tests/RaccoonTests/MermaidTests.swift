import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("Mermaid")
struct MermaidTests {

    @Test("renders script tags and mermaid container")
    func rendersScriptsAndContainers() async throws {

        let data = MermaidData(diagram: "graph TD; A-->B;")
        let html = renderHTML(Mermaid(data).render())

        #expect(html.contains("/js/agentic-mermaid-component-lazy.js"))
        #expect(html.contains("x-data=\"beautifulMermaidComponent($el)\""))
        #expect(html.contains("class=\"mermaid-source hidden\""))
        #expect(html.contains("graph TD; A-->B;"))
        #expect(html.contains("class=\"mermaid-target\""))
        #expect(html.contains("style=\"width: 100%;\""))
    }

    @Test("clamps width at 100 percent")
    func clampsWidthAt100() async throws {

        let dataOver100 = MermaidData(
            diagram: "graph TD; A-->B;",
            widthInPercent: 150
        )
        let htmlOver100 = renderHTML(Mermaid(dataOver100).render())
        #expect(htmlOver100.contains("style=\"width: 100%;\""))

        let data50 = MermaidData(
            diagram: "graph TD; A-->B;",
            widthInPercent: 50
        )
        let html50 = renderHTML(Mermaid(data50).render())
        #expect(html50.contains("style=\"width: 50%;\""))
    }

    @Test("applies centering classes when isCentered is true")
    func appliesCentering() async throws {

        let centered = MermaidData(
            diagram: "graph TD; A-->B;",
            isCentered: true
        )
        let htmlCentered = renderHTML(Mermaid(centered).render())
        #expect(htmlCentered.contains("w-full flex justify-center mx-auto"))

        let uncentered = MermaidData(
            diagram: "graph TD; A-->B;",
            isCentered: false
        )
        let htmlUncentered = renderHTML(Mermaid(uncentered).render())
        #expect(!htmlUncentered.contains("w-full flex justify-center mx-auto"))
    }
}
