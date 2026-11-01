import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("LocalizedText")
struct LocalizedTextTests {

    private let builtIn = LocalizedText("label.required", "(required)")
    private let consumer = LocalizedText(
        en: "Save",
        translations: ["de": "Speichern", "fr": "Enregistrer"]
    )

    // MARK: kinds

    @Test("a string literal is a plain text: as given, no marker")
    func literalIsPlain() {
        let text: LocalizedText = "Mein Fortschritt"
        #expect(!text.isTranslatable)
        let html = I18n.render(language: "fr") {
            renderHTML([
                Div {}.localized(.ariaLabel, text),
                Span(text.resolved).localized(text),
            ])
        }
        #expect(html.contains("aria-label=\"Mein Fortschritt\""))
        #expect(html.contains(">Mein Fortschritt</span>"))
        #expect(!html.contains("data-i18n"))
        #expect(text.alpineExpression == "'Mein Fortschritt'")
    }

    @Test("verbatim is a plain text and keeps its value")
    func verbatimIsPlain() {
        let text = LocalizedText(verbatim: "Page \(3)")
        #expect(!text.isTranslatable)
        #expect(text.resolved == "Page 3")
        #expect(text == LocalizedText("", "Page 3"))
    }

    @Test(
        "a built-in text resolves per page language and falls back to English"
    )
    func builtInResolves() {
        #expect(builtIn.resolved == "(required)")
        #expect(
            I18n.render(language: "de") { builtIn.resolved } == "(erforderlich)"
        )
        #expect(
            I18n.render(language: "de-AT") { builtIn.resolved }
                == "(erforderlich)"
        )
        #expect(
            I18n.render(language: "ja") { builtIn.resolved } == "(required)"
        )
    }

    @Test(
        "a consumer text resolves per page language and falls back to English"
    )
    func consumerResolves() {
        #expect(consumer.resolved == "Save")
        #expect(
            I18n.render(language: "de") { consumer.resolved } == "Speichern"
        )
        #expect(
            I18n.render(language: "fr") { consumer.resolved } == "Enregistrer"
        )
        #expect(I18n.render(language: "it") { consumer.resolved } == "Save")
    }

    @Test("variables are substituted in every language")
    func variables() {
        let text = LocalizedText(
            en: "Page {{number}}",
            translations: ["de": "Seite {{number}}"],
            variables: ["number": "3"]
        )
        #expect(text.english == "Page 3")
        #expect(I18n.render(language: "de") { text.resolved } == "Seite 3")
        let builtIn = LocalizedText(
            "pagination.page",
            "Page {{number}}",
            variables: ["number": "7"]
        )
        #expect(builtIn.english == "Page 7")
        #expect(builtIn.template == "Page {{number}}")
    }

    @Test("interpolating a text yields the English text")
    func interpolationYieldsEnglish() {
        let text = LocalizedText("a.b", "Page {{n}}", variables: ["n": "3"])
        #expect("\(text)" == "Page 3")
        let optional: LocalizedText? = "Name"
        #expect("\(optional ?? "input")" == "Name")
    }

    // MARK: markers

    @Test("a built-in text renders the key marker and the resolved text")
    func builtInMarkers() {
        let html = I18n.render(language: "de") {
            renderHTML([
                Span(builtIn.resolved).localized(builtIn),
                Div {}.localized(.ariaLabel, builtIn),
            ])
        }
        #expect(
            html.contains("data-i18n=\"label.required\">(erforderlich)</span>")
        )
        #expect(html.contains("aria-label=\"(erforderlich)\""))
        #expect(html.contains("data-i18n-aria-label=\"label.required\""))
    }

    @Test("a consumer text renders the values marker with sorted languages")
    func consumerMarkers() {
        let html = I18n.render(language: "de") {
            renderHTML([
                Span(consumer.resolved).localized(consumer),
                Div {}.localized(.placeholder, consumer),
            ])
        }
        let values =
            "{&quot;de&quot;:&quot;Speichern&quot;,&quot;en&quot;:&quot;Save&quot;,&quot;fr&quot;:&quot;Enregistrer&quot;}"
        #expect(
            html.contains("data-i18n-values=\"\(values)\">Speichern</span>")
        )
        #expect(html.contains("placeholder=\"Speichern\""))
        #expect(html.contains("data-i18n-placeholder-values=\"\(values)\""))
    }

    @Test("variables are rendered as sorted JSON")
    func variableMarker() {
        let text = LocalizedText(
            "a.b",
            "{{x}} {{y}}",
            variables: ["y": "2", "x": "1"]
        )
        let html = renderHTML([Span(text.english).localized(text)])
        #expect(
            html.contains(
                "data-i18n-vars=\"{&quot;x&quot;:&quot;1&quot;,&quot;y&quot;:&quot;2&quot;}\""
            )
        )
    }

    @Test("attribute values are escaped")
    func attributeEscaping() {
        let html = renderHTML([
            Button { Span("x") }
                .localized(
                    .ariaLabel,
                    LocalizedText("a.b", "Say \"hi\" & 'bye'")
                )
        ])
        #expect(
            html.contains(
                "aria-label=\"Say &quot;hi&quot; &amp; &#39;bye&#39;\""
            )
        )
    }

    // MARK: Alpine

    @Test("builds a safe Alpine expression with a fallback for built-in texts")
    func alpineBuiltIn() {
        let plain = LocalizedText("audioplayer.pause", "Pause")
        #expect(
            plain.alpineExpression
                == "(window.RaccoonI18n?RaccoonI18n.t('audioplayer.pause',null,'Pause'):'Pause')"
        )
        let quoted = LocalizedText("a.c", "Say \"hi\"")
        #expect(!quoted.alpineExpression.contains("\""))
    }

    @Test("builds an Alpine expression that picks a consumer text")
    func alpineConsumer() {
        #expect(
            consumer.alpineExpression
                == "(window.RaccoonI18n?RaccoonI18n.pick({'de':'Speichern','en':'Save','fr':'Enregistrer'},null,'Save'):'Save')"
        )
        let german = I18n.render(language: "de") { consumer.alpineExpression }
        #expect(german.hasSuffix(",'Speichern'):'Speichern')"))
    }

    // MARK: page scripts

    @Test("the engine tag is the store only")
    func engine() {
        let html = renderHTML([I18n.engine()])
        #expect(html.contains("src=\"/js/i18n.js\""))
        #expect(!html.contains("/js/i18n/"))
    }

    @Test(
        "the page dictionary has exactly the built-in keys that were rendered"
    )
    func pageDictionary() {
        let html = I18n.render(language: "de", collectsUsedKeys: true) {
            _ = builtIn.resolved
            _ = builtIn.resolved
            _ = consumer.resolved
            return renderHTML(I18n.scripts())
        }
        #expect(html.contains("src=\"/js/i18n.js\""))
        #expect(
            html.contains(
                "\"label\":{\"de\":{\"required\":\"(erforderlich)\"},\"en\":{\"required\":\"(required)\"}"
            )
        )
        #expect(!html.contains("Speichern"))
        let usedKeys = I18n.render(language: "de", collectsUsedKeys: true) {
            _ = builtIn.resolved
            _ = builtIn.resolved
            return I18n.context.usedKeys
        }
        #expect(usedKeys == ["label.required"])
    }

    @Test("without collecting nothing is recorded")
    func noCollectingByDefault() {
        _ = builtIn.resolved
        #expect(I18n.context.usedKeys.isEmpty)
    }

    @Test("the page dictionary cannot break out of the script tag")
    func dictionaryIsSafe() {
        let html = renderHTML([I18n.pageDictionary()])
        #expect(!html.contains("</script><"))
    }

    @Test(
        "with(variables:) fills the placeholders of a built-in or consumer text"
    )
    func withVariables() {
        let builtIn = LocalizedText("pagination.page", "Page {{number}}")
            .with(variables: ["number": "4"])
        #expect(builtIn.english == "Page 4")
        #expect(I18n.render(language: "de") { builtIn.resolved } == "Seite 4")

        let consumer = LocalizedText(
            en: "Hello {{name}}",
            translations: ["de": "Hallo {{name}}"]
        )
        .with(variables: ["name": "Ann"])
        #expect(
            I18n.render(language: "de") { consumer.resolved } == "Hallo Ann"
        )
    }
}
