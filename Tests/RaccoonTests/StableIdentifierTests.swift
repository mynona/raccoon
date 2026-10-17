import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

private func generatedIds(in html: String, prefix: String) -> [String] {
    html.components(separatedBy: "id=\"")
        .dropFirst()
        .compactMap { part in
            guard let end = part.firstIndex(of: "\"") else { return nil }
            let id = String(part[part.startIndex..<end])
            return id.hasPrefix(prefix) ? id : nil
        }
}

private let tracker = MatomoContentTracker(
    name: "test",
    piece: "identifier",
    target: "#"
)

@Suite("Generated identifiers")
struct StableIdentifierTests {

    @Test("hash stays deterministic for the same seed")
    func hashIsDeterministic() {
        #expect(
            StableIdentifier.hash("Label") == StableIdentifier.hash("Label")
        )
        #expect(
            StableIdentifier.hash("Label") != StableIdentifier.hash("Other")
        )
    }

    @Test("unique keeps the readable hash prefix but never repeats")
    func uniqueIsCollisionFree() {
        let prefix = String(StableIdentifier.hash("Label"))
        // 200 identical components on one page is well beyond any realistic layout
        let ids = (0..<200).map { _ in StableIdentifier.unique("Label") }

        #expect(ids.allSatisfy { $0.hasPrefix("\(prefix)-") })
        #expect(Set(ids).count == ids.count)
    }

    @Test("two identically-labelled accordions render different ids")
    func accordionsWithSameLabelDoNotCollide() async throws {

        let data = AccordionData(
            label: "Same label",
            content: .markdown("Body")
        )
        let html =
            renderHTML(Accordion(data).render())
            + renderHTML(Accordion(data).render())

        let headings = generatedIds(in: html, prefix: "accordion-")
        #expect(headings.count == 4)  // heading + content per instance
        #expect(Set(headings).count == 4)
    }

    @Test("an explicit accordion id is used verbatim")
    func explicitIdWins() async throws {

        let html = renderHTML(
            Accordion(
                AccordionData(
                    id: "custom-id",
                    label: "L",
                    content: .markdown("B")
                )
            )
            .render()
        )

        #expect(html.contains("id=\"accordion-custom-id-heading\""))
        #expect(html.contains("id=\"accordion-custom-id-content\""))
    }

    @Test("identically-configured action buttons get their own tooltip id")
    func actionButtonTooltipsDoNotCollide() async throws {

        let data = ActionButtonData(
            id: "btn",
            label: "Label",
            tooltip: "Tooltip",
            contentTracker: tracker
        )
        let html =
            renderHTML(ActionButton(data).render())
            + renderHTML(ActionButton(data).render())

        let tooltipIds = generatedIds(in: html, prefix: "tooltip-")
        #expect(tooltipIds.count == 2)
        #expect(Set(tooltipIds).count == 2)
    }

    @Test(
        "action buttons without any explicit id still get their own tooltip id"
    )
    func actionButtonTooltipsWithoutExplicitIdDoNotCollide() async throws {

        let data = ActionButtonData(
            label: "Label",
            tooltip: "Tooltip",
            contentTracker: tracker
        )
        let html = (0..<3)
            .map { _ in renderHTML(ActionButton(data).render()) }.joined()

        let tooltipIds = generatedIds(in: html, prefix: "tooltip-")
        #expect(tooltipIds.count == 3)
        #expect(Set(tooltipIds).count == 3)
    }

    @Test("identically-configured hyperlinks get their own tooltip id")
    func hyperLinkTooltipsDoNotCollide() async throws {

        let data = HyperLinkData(
            label: "Label",
            href: "/x",
            tooltip: "Tooltip",
            isFocusable: true,
            isUnderlined: true,
            contentTracker: tracker
        )
        let html =
            renderHTML(HyperLink(data).render())
            + renderHTML(HyperLink(data).render())

        let tooltipIds = generatedIds(in: html, prefix: "content")
        #expect(tooltipIds.count == 2)
        #expect(Set(tooltipIds).count == 2)
    }

}
