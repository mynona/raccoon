import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("YesNoRating")
struct YesNoRatingTests {

    @Test("renders uuid and submit url in x-data attribute")
    func rendersUuidAndUrl() async throws {
        let html = renderHTML(
            YesNoRating(
                YesNoRatingData(id: "article-uuid-42", url: "/api/feedback")
            )
            .render()
        )
        #expect(
            html.contains(
                "yesNoRatingWidget('article-uuid-42', '/api/feedback')"
            )
        )
        #expect(html.contains("id=\"yesno-panel-article-uuid-42\""))
        #expect(html.contains("src=\"/js/yes-no-rating.js\""))
    }

    @Test("renders yes and no buttons with initial state and filled icons")
    func rendersYesNoButtons() async throws {
        let html = renderHTML(
            YesNoRating(
                YesNoRatingData(id: "uuid-1", url: "/api/feedback")
            )
            .render()
        )
        #expect(html.contains("id=\"yesno-btn-yes-uuid-1\""))
        #expect(html.contains("id=\"yesno-btn-no-uuid-1\""))
        #expect(html.contains("@click=\"selectChoice('yes')\""))
        #expect(html.contains("@click=\"selectChoice('no')\""))
        #expect(html.contains(":aria-pressed=\"choice === 'yes'\""))
        #expect(html.contains(":aria-pressed=\"choice === 'no'\""))
        #expect(html.contains("x-show=\"choice === 'yes'\""))
        #expect(html.contains("x-show=\"choice !== 'yes'\""))
        #expect(html.contains("x-show=\"choice === 'no'\""))
        #expect(html.contains("x-show=\"choice !== 'no'\""))
        #expect(html.contains(">Yes</span>"))
        #expect(html.contains(">No</span>"))
    }

    @Test("renders default positive options")
    func rendersDefaultPositiveOptions() async throws {
        let html = renderHTML(
            YesNoRating(
                YesNoRatingData(id: "uuid-2", url: "/api/feedback")
            )
            .render()
        )
        #expect(html.contains("Great! What worked best for you?"))
        #expect(!html.contains("This article worked as expected"))
        #expect(html.contains("It was easy to find the information I needed"))
        #expect(html.contains("It was easy to understand the information"))
        #expect(html.contains("Something else"))
    }

    @Test("renders default negative options")
    func rendersDefaultNegativeOptions() async throws {
        let html = renderHTML(
            YesNoRating(
                YesNoRatingData(id: "uuid-3", url: "/api/feedback")
            )
            .render()
        )
        #expect(html.contains("How can we improve this article?"))
        #expect(html.contains("I missed relevant information"))
        #expect(html.contains("The information was not understandable"))
        #expect(html.contains("Something else"))
    }

    @Test("renders textarea and action buttons with submit guard")
    func rendersTextareaAndActions() async throws {
        let html = renderHTML(
            YesNoRating(
                YesNoRatingData(id: "uuid-4", url: "/api/feedback")
            )
            .render()
        )
        #expect(html.contains("id=\"textarea-uuid-4\""))
        #expect(
            html.contains(
                "(Optional) Could you share more about your experience?"
            )
        )
        #expect(html.contains("id=\"yesno-btn-cancel-uuid-4\""))
        #expect(html.contains("id=\"yesno-btn-submit-uuid-4\""))
        #expect(html.contains(":disabled=\"!selectedOption || submitting\""))
        #expect(html.contains("@click=\"resetChoice()\""))
    }

    @Test("renders custom questions and options when provided")
    func rendersCustomQuestionsAndOptions() async throws {
        let html = renderHTML(
            YesNoRating(
                YesNoRatingData(
                    id: "uuid-5",
                    url: "/api/feedback",
                    question: LocalizedText(en: "Helpful?", translations: [:]),
                    yesLabel: LocalizedText(en: "Thumbs Up", translations: [:]),
                    noLabel: LocalizedText(
                        en: "Thumbs Down",
                        translations: [:]
                    ),
                    positiveFollowUpQuestion: LocalizedText(
                        en: "Why great?",
                        translations: [:]
                    ),
                    negativeFollowUpQuestion: LocalizedText(
                        en: "Why not?",
                        translations: [:]
                    ),
                    positiveOptions: [
                        LocalizedText(en: "Fast and clear", translations: [:])
                    ],
                    negativeOptions: [
                        LocalizedText(en: "Too complex", translations: [:])
                    ],
                    textareaLabel: LocalizedText(
                        en: "More info:",
                        translations: [:]
                    ),
                    cancelLabel: LocalizedText(en: "Back", translations: [:]),
                    submitLabel: LocalizedText(
                        en: "Send Now",
                        translations: [:]
                    )
                )
            )
            .render()
        )
        #expect(html.contains(">Helpful?</p>"))
        #expect(html.contains(">Thumbs Up</span>"))
        #expect(html.contains(">Thumbs Down</span>"))
        #expect(html.contains("Why great?"))
        #expect(html.contains("Why not?"))
        #expect(html.contains("Fast and clear"))
        #expect(html.contains("Too complex"))
        #expect(html.contains("More info:"))
        #expect(html.contains(">Back</span>"))
        #expect(html.contains(">Send Now</span>"))
    }

    // MARK: - Toast Configuration

    @Test("renders toast configuration attributes")
    func rendersToastConfiguration() async throws {
        let html = renderHTML(
            YesNoRating(
                YesNoRatingData(id: "uuid-toast", url: "/api/feedback")
            )
            .render()
        )
        #expect(html.contains("data-toast-success-title=\"Rating\""))
        #expect(
            html.contains(
                "data-toast-success-text=\"Rating successfully submitted\""
            )
        )
        #expect(html.contains("data-toast-error-title=\"Server error\""))
        #expect(
            html.contains(
                "data-toast-error-text=\"Rating has not been submitted.\""
            )
        )
        #expect(
            html.contains(
                "data-i18n-toast-success-title=\"yesnorating.toastSuccessTitle\""
            )
        )
        #expect(
            html.contains(
                "data-i18n-toast-success-text=\"yesnorating.toastSuccessText\""
            )
        )
        #expect(
            html.contains(
                "data-i18n-toast-error-title=\"yesnorating.toastErrorTitle\""
            )
        )
        #expect(
            html.contains(
                "data-i18n-toast-error-text=\"yesnorating.toastErrorText\""
            )
        )
    }

    // MARK: - Localization

    @Test("built-in texts translate to German correctly")
    func localizedTextsGerman() {
        let data = YesNoRatingData(id: "uuid-de", url: "/api/feedback")
        let german = I18n.render(language: "de") {
            renderHTML(YesNoRating(data).render())
        }
        #expect(german.contains(">War dieser Artikel hilfreich?</p>"))
        #expect(german.contains(">Ja</span>"))
        #expect(german.contains(">Nein</span>"))
        #expect(german.contains("Klasse! Was hat dir am besten geholfen?"))
        #expect(german.contains("Wie können wir diesen Artikel verbessern?"))
        #expect(german.contains("Mir haben wichtige Informationen gefehlt"))
        #expect(german.contains("Etwas anderes"))
        #expect(german.contains(">Abbrechen</span>"))
        #expect(german.contains(">Feedback absenden</span>"))
        #expect(german.contains("Danke für dein Feedback!"))
        #expect(german.contains("data-toast-success-title=\"Bewertung\""))
        #expect(
            german.contains(
                "data-toast-success-text=\"Bewertung erfolgreich gesendet\""
            )
        )
        #expect(german.contains("data-toast-error-title=\"Serverfehler\""))
        #expect(
            german.contains(
                "data-toast-error-text=\"Bewertung wurde nicht gesendet.\""
            )
        )
    }

    @Test("renders question and buttons in a single header row with full width")
    func rendersHeaderRowFullWidth() async throws {
        let html = renderHTML(
            YesNoRating(
                YesNoRatingData(id: "uuid-full", url: "/api/feedback")
            )
            .render()
        )
        #expect(html.contains(YesNoRatingStyles.panel))
        #expect(html.contains(YesNoRatingStyles.headerRow))
        #expect(html.contains(YesNoRatingStyles.yesNoButtonsGroup))
        #expect(!html.contains("max-w-md"))
        #expect(!html.contains("max-w-lg"))
    }
}
