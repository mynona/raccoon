import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("Rating")
struct RatingTests {

    @Test("renders uuid in x-data attribute")
    func rendersUuid() async throws {

        let html = renderHTML(
            Rating(
                RatingData(id: "article-uuid-42", url: "/api/rating")
            )
            .render()
        )
        #expect(html.contains("article-uuid-42"))
    }

    @Test("renders rating API URL")
    func rendersUrl() async throws {

        let html = renderHTML(
            Rating(RatingData(id: "uuid-1", url: "/api/v1/rating"))
                .render()
        )
        #expect(html.contains("/api/v1/rating"))
    }

    @Test("renders rating buttons")
    func rendersButtons() async throws {

        let html = renderHTML(
            Rating(RatingData(id: "uuid-2", url: "/api/rating"))
                .render()
        )
        #expect(html.contains("<button"))
    }

    @Test("renders thumbs up down controls by default")
    func rendersThumbControlsByDefault() async throws {

        let html = renderHTML(
            Rating(RatingData(id: "uuid-3", url: "/api/rating"))
                .render()
        )

        #expect(html.contains("Thumbs up"))
        #expect(html.contains("Thumbs down"))
        #expect(html.contains("Clear"))
    }

    @Test("renders five star controls when configured")
    func rendersFiveStarControls() async throws {

        let html = renderHTML(
            Rating(
                RatingData(
                    id: "uuid-4",
                    url: "/api/rating",
                    ratingType: .fiveStars
                )
            )
            .render()
        )

        #expect(html.contains("Rate 1 star"))
        #expect(html.contains("Rate 5 star"))
        #expect(html.contains("selectStar(5)"))
    }

    @Test("renders floating rating action button with hide guard")
    func rendersFloatingRatingActionButtonWithHideGuard() async throws {

        let html = renderHTML(
            Rating(
                RatingData(
                    id: "uuid-floating",
                    url: "/api/rating",
                    ratingType: .fiveStars,
                    isFloating: true
                )
            )
            .render()
        )

        #expect(html.contains(RatingStyles.containerFloating))
        #expect(html.contains("id=\"rating-floating-panel-uuid-floating\""))
        #expect(html.contains("aria-label=\"Close feedback widget\""))
        #expect(html.contains("x-show=\"isFloating\""))
        #expect(html.contains(":class=\"isFloating ?"))
    }

    @Test("renders floating rating only after scrolling 80% of the page")
    func rendersFloatingRatingOnlyAfterScrollThreshold() async throws {

        let html = renderHTML(
            Rating(
                RatingData(
                    id: "uuid-floating-scroll",
                    url: "/api/rating",
                    ratingType: .fiveStars,
                    isFloating: true,
                    isShownOnScroll: true
                )
            )
            .render()
        )

        #expect(html.contains("x-show=\"visible\""))
        #expect(
            html.contains(
                "x-data=\"ratingWidget('uuid-floating-scroll', true, 'raumnebenan-matomo', true)\""
            )
        )
    }

    @Test("renders inline rating with floating flag false in x-data")
    func rendersInlineRatingWithFloatingFlagFalse() async throws {

        let html = renderHTML(
            Rating(
                RatingData(
                    id: "uuid-inline",
                    url: "/api/rating"
                )
            )
            .render()
        )

        #expect(
            html.contains(
                "x-data=\"ratingWidget('uuid-inline', false, 'raumnebenan-matomo', false)\""
            )
        )
        #expect(!html.contains("aria-label=\"Close feedback widget\""))
        #expect(!html.contains(":class=\"isFloating ?"))
    }

    @Test(
        "renders dynamic docking container and close button visibility guard when floating"
    )
    func rendersDynamicDockingContainerWhenFloating() async throws {

        let html = renderHTML(
            Rating(
                RatingData(
                    id: "uuid-docking",
                    url: "/api/rating",
                    isFloating: true,
                    isShownOnScroll: true
                )
            )
            .render()
        )

        #expect(
            html.contains(
                ":class=\"isFloating ? '\(RatingStyles.containerFloating)' : '\(RatingStyles.containerDefault)'\""
            )
        )
        #expect(html.contains("x-show=\"isFloating\""))
    }

    @Test("renders configurable cookie name")
    func rendersConfigurableCookieName() async throws {

        let html = renderHTML(
            Rating(
                RatingData(
                    id: "custom-cookie-test",
                    url: "/api/rating",
                    cookieName: "custom-cookie"
                )
            )
            .render()
        )

        #expect(html.contains("'custom-cookie'"))
    }

    @Test("renders deterministic textarea id from uuid")
    func rendersDeterministicTextareaId() async throws {

        let html = renderHTML(
            Rating(
                RatingData(
                    id: "article-uuid-42",
                    url: "/api/rating",
                    ratingType: .fiveStars
                )
            )
            .render()
        )

        #expect(html.contains("id=\"textarea-article-uuid-42\""))
    }

    @Test("renders star keyboard navigation attributes")
    func rendersStarKeyboardNavigationAttributes() async throws {

        let html = renderHTML(
            Rating(
                RatingData(
                    id: "uuid-10",
                    url: "/api/rating",
                    ratingType: .fiveStars
                )
            )
            .render()
        )

        #expect(html.contains("x-ref=\"star1\""))
        #expect(
            html.contains("@keydown.left=\"focusStar(Math.max(1, 1 - 1))\"")
        )
        #expect(
            html.contains("@keydown.right=\"focusStar(Math.min(5, 1 + 1))\"")
        )
    }

    @Test("renders feedback form fields and submit guard")
    func rendersFeedbackFormFieldsAndSubmitGuard() async throws {

        let html = renderHTML(
            Rating(RatingData(id: "uuid-5", url: "/api/rating"))
                .render()
        )

        #expect(html.contains("name=\"id\""))
        #expect(html.contains("name=\"rating\""))
        #expect(html.contains("name=\"feedback\""))
        #expect(html.contains("data-validation=\"submit\""))
        #expect(html.contains("id=\"thumb-submit\""))
        #expect(html.contains("submitFeedback($event.target"))
    }

    @Test("the feedback field needs at least 5 characters, with the given message")
    func feedbackFieldMinimumLength() async throws {

        let html = renderHTML(
            Rating(
                RatingData(
                    id: "uuid-7",
                    url: "/api/rating",
                    ErrorMessageInvalidFeedback: "Too short, please write more."
                )
            )
            .render()
        )

        #expect(html.contains("{5,}"))
        #expect(html.contains("Too short, please write more."))
        #expect(html.contains("x-html=\"followUpLabel()\""))
        #expect(html.contains("data-follow-up=\"positive\""))
        #expect(html.contains("data-follow-up=\"negative\""))
    }

    @Test("renders custom follow up questions")
    func rendersCustomFollowUpQuestions() async throws {

        let html = renderHTML(
            Rating(
                RatingData(
                    id: "uuid-6",
                    url: "/api/rating",
                    positiveFollowUpQuestion: "What worked well?",
                    negativeFollowUpQuestion: "What should change?"
                )
            )
            .render()
        )

        #expect(html.contains("What worked well?"))
        #expect(html.contains("What should change?"))
    }

    // MARK: localization

    @Test("all texts are built in and translated, for thumbs and for stars")
    func localizedTexts() {
        for type in [RatingData.RatingType.thumbsUpDown, .fiveStars] {
            let data = RatingData(
                id: "r",
                url: "/r",
                ratingType: type,
                isFloating: true
            )
            let english = renderHTML(Rating(data).render())
            for key in [
                "question", "positiveFollowUp", "negativeFollowUp", "clear",
                "clearSelection", "placeholder", "submit", "thankYou",
                "closeWidget",
            ] {
                #expect(english.contains("rating.\(key)"), "\(type) \(key)")
            }
            let german = I18n.render(language: "de") {
                renderHTML(Rating(data).render())
            }
            #expect(german.contains(">Wie gefällt dir dieser Artikel?</p>"))
            #expect(german.contains(">Absenden</span>"))
            #expect(german.contains("Danke für dein Feedback!"))
            #expect(
                german.contains("aria-label=\"Feedback-Fenster schließen\"")
            )
            #expect(
                german.contains("Dein Feedback konnte nicht gesendet werden.")
            )
        }
    }

    @Test("a consumer question replaces the default and is translated")
    func consumerQuestion() {
        let data = RatingData(
            id: "r",
            url: "/r",
            question: LocalizedText(
                en: "Helpful?",
                translations: ["de": "Hilfreich?"]
            )
        )
        let html = I18n.render(language: "de") {
            renderHTML(Rating(data).render())
        }
        #expect(html.contains(">Hilfreich?</p>"))
    }
}
