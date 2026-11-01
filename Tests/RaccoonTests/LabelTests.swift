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
            Label(LabelData(id: "l", title: LocalizedText(verbatim: longTitle)))
                .render()
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

    // MARK: localization

    @Test(
        "renders the required marker and the English text with the key marker"
    )
    func requiredMarkerEnglish() {
        let html = renderHTML(
            Label(LabelData(id: "a", title: "A", isRequired: true)).render()
        )
        #expect(
            html.contains(
                "<span class=\"sr-only\" data-i18n=\"label.required\">(required)</span>"
            )
        )
    }

    @Test("renders the required marker in the page language")
    func requiredMarkerGerman() {
        let html = I18n.render(language: "de") {
            renderHTML(
                Label(LabelData(id: "a", title: "A", isRequired: true)).render()
            )
        }
        #expect(
            html.contains("data-i18n=\"label.required\">(erforderlich)</span>")
        )
        #expect(!html.contains("(required)"))
    }

    @Test("an unsupported page language falls back to English")
    func requiredMarkerFallback() {
        let html = I18n.render(language: "ja") {
            renderHTML(
                Label(LabelData(id: "a", title: "A", isRequired: true)).render()
            )
        }
        #expect(html.contains(">(required)</span>"))
    }

    @Test("a literal title is a plain text without marker")
    func literalTitleHasNoMarker() {
        let html = I18n.render(language: "de") {
            renderHTML(
                Label(LabelData(id: "a", title: "Name", isRequired: false))
                    .render()
            )
        }
        #expect(html.contains(">Name</span>"))
        #expect(!html.contains("data-i18n"))
    }

    @Test("a consumer title is translated and carries its values")
    func consumerTitle() {
        let title = LocalizedText(en: "Save", translations: ["de": "Speichern"])
        let html = I18n.render(language: "de") {
            renderHTML(
                Label(LabelData(id: "a", title: title, isRequired: false))
                    .render()
            )
        }
        #expect(html.contains("data-i18n-values="))
        #expect(html.contains(">Speichern</span>"))
    }

    @Test("an x-html title gets no translation marker")
    func xhtmlTitleHasNoMarker() {
        let title = LocalizedText(en: "Save", translations: ["de": "Speichern"])
        let html = renderHTML(
            Label(
                LabelData(
                    id: "a",
                    title: title,
                    isRequired: false,
                    xhtml: "newText"
                )
            )
            .render()
        )
        #expect(html.contains("x-html=\"newText\""))
        #expect(!html.contains("data-i18n-values"))
    }

    @Test("the fallback title from the id is a plain text")
    func idFallbackTitle() {
        let html = I18n.render(language: "de") {
            renderHTML(
                Label(LabelData(id: "email", isRequired: false)).render()
            )
        }
        #expect(html.contains(">Email</span>"))
        #expect(!html.contains("data-i18n"))
    }

    @Test("the used required key is collected once")
    func requiredKeyCollected() {
        let keys = I18n.render(language: "de", collectsUsedKeys: true) {
            _ = renderHTML(Label(LabelData(id: "a", title: "A")).render())
            _ = renderHTML(Label(LabelData(id: "b", title: "B")).render())
            return I18n.context.usedKeys
        }
        #expect(keys == ["label.required"])
    }

}
