import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("Tooltip")
struct TooltipTests {

    @Test("renders tooltip text")
    func rendersTooltipText() async throws {

        let html = renderHTML(
            Tooltip(
                TooltipData(id: "tip-1", text: "Helpful information")
            )
            .render()
        )
        #expect(html.contains("Helpful information"))
    }

    @Test("renders tooltip id")
    func rendersTooltipId() async throws {

        let html = renderHTML(
            Tooltip(TooltipData(id: "my-tooltip", text: "Tip"))
                .render()
        )
        #expect(html.contains("my-tooltip"))
    }

    @Test("renders top position variant")
    func rendersTopPosition() async throws {

        let html = renderHTML(
            Tooltip(
                TooltipData(id: "tip-top", text: "Top tip", position: .top)
            )
            .render()
        )
        #expect(!html.isEmpty)
    }

    @Test("renders bottom position variant")
    func rendersBottomPosition() async throws {

        let html = renderHTML(
            Tooltip(
                TooltipData(
                    id: "tip-bot",
                    text: "Bottom tip",
                    position: .bottom
                )
            )
            .render()
        )
        #expect(!html.isEmpty)
    }

    @Test("renders left and right position variants and arrow toggle")
    func rendersLeftRightAndArrow() async throws {

        let htmlLeft = renderHTML(
            Tooltip(
                TooltipData(
                    id: "tip-left",
                    text: "Left tip",
                    position: .left,
                    hasArrow: false
                )
            )
            .render()
        )
        #expect(htmlLeft.contains("tooltipPosition: 'left'"))
        #expect(htmlLeft.contains("tooltipArrow: false"))

        let htmlRight = renderHTML(
            Tooltip(
                TooltipData(
                    id: "tip-right",
                    text: "Right tip",
                    position: .right,
                    hasArrow: true
                )
            )
            .render()
        )
        #expect(htmlRight.contains("tooltipPosition: 'right'"))
        #expect(htmlRight.contains("tooltipArrow: true"))
    }

    @Test("a literal text is a plain string in the getter")
    func literalTextIsPlain() {
        let html = I18n.render(language: "de") {
            renderHTML(
                Tooltip(TooltipData(id: "t", text: "Tip")).render()
            )
        }
        #expect(html.contains("get tooltipText() { return 'Tip'; }"))
        #expect(!html.contains("RaccoonI18n"))
    }

    @Test("a consumer text follows the language switch through the getter")
    func consumerTextIsLocalized() {
        let text = LocalizedText(en: "Save", translations: ["de": "Speichern"])
        let html = I18n.render(language: "de") {
            renderHTML(Tooltip(TooltipData(id: "t", text: text)).render())
        }
        #expect(
            html.contains(
                "get tooltipText() { return (window.RaccoonI18n?RaccoonI18n.pick("
            )
        )
        #expect(html.contains("'de':'Speichern'"))
        #expect(html.contains("'Speichern'):'Speichern')"))
    }

    @Test("a quote in the text cannot break the x-data attribute")
    func quoteIsEscaped() {
        let html = renderHTML(
            Tooltip(TooltipData(id: "t", text: "Say \"hi\"")).render()
        )
        #expect(html.contains("&quot;hi&quot;"))
    }
}
