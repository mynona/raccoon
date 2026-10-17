import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("Label")
struct LabelTests {

    @Test("renders label title")
    func rendersTitle() async throws {

        let html = renderHTML(
            Label(LabelData(id: "email", title: "Email address"))
                .render()
        )
        #expect(html.contains("Email address"))
    }

    @Test("renders label element with for attribute")
    func rendersForAttribute() async throws {

        let html = renderHTML(
            Label(LabelData(id: "username", title: "Username"))
                .render()
        )
        #expect(html.contains("<label"))
        #expect(html.contains("username"))
    }

    @Test("renders required indicator when required")
    func rendersRequiredIndicator() async throws {

        let required = renderHTML(
            Label(LabelData(id: "f", title: "Field", isRequired: true))
                .render()
        )
        let optional = renderHTML(
            Label(LabelData(id: "f", title: "Field", isRequired: false))
                .render()
        )
        #expect(required.contains("(required)"))
        #expect(required.contains("sr-only"))
        #expect(!optional.contains("(required)"))
    }

    @Test("renders all size and position variants")
    func rendersAllSizeAndPositionVariants() async throws {
        for size in [ComponentSize.sm, .base, .xl] {
            for pos in [LabelData.Position.left, .right] {
                let html = renderHTML(
                    Label(
                        LabelData(
                            id: "s",
                            title: "S",
                            position: pos,
                            size: size
                        )
                    )
                    .render()
                )
                #expect(html.contains("<label"))
            }
        }
    }

    @Test("renders with empty, long, and special title")
    func rendersEmptyLongSpecialTitle() async throws {
        let longTitle = String(repeating: "T", count: 512)
        let htmlEmpty = renderHTML(
            Label(LabelData(id: "e", title: "")).render()
        )
        let htmlLong = renderHTML(
            Label(LabelData(id: "l", title: longTitle)).render()
        )
        #expect(htmlEmpty.contains("<label"))
        #expect(htmlLong.contains(longTitle))
    }

    @Test("renders XHTML compatible label")
    func rendersXHTMLCompatibleLabel() async throws {
        let html = renderHTML(
            Label(
                LabelData(id: "x", title: "XHTML", xhtml: "'xhtml-test'")
            )
            .render()
        )
        #expect(html.contains("<label"))
        #expect(html.contains("x-html=\"'xhtml-test'\""))
    }

    @Test("renders disabled label styling")
    func rendersDisabledLabelStyling() async throws {

        let html = renderHTML(
            Label(
                LabelData(id: "disabled", title: "Disabled", isDisabled: true)
            )
            .render()
        )
        #expect(html.contains("cursor-not-allowed"))
        #expect(html.contains("Disabled"))
    }

    @Test("falls back to capitalized id when title is missing")
    func fallsBackToCapitalizedIdWhenTitleMissing() async throws {

        let html = renderHTML(
            Label(LabelData(id: "apiToken", title: nil)).render()
        )
        #expect(html.contains("Apitoken"))
    }

}
