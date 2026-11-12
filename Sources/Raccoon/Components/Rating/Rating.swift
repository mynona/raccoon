import HTML
import SGML
import SVG
import WebBuilders

// No import needed for twRatingThumbsStyling; same module

public struct Rating: TemplateRepresentable {
    let data: RatingData
    let iconSize = 28
    let textAreaId: String

    typealias styles = RatingStyles

    private static let question = LocalizedText(
        "rating.question",
        "How do you like this article?"
    )
    private static let positiveFollowUp = LocalizedText(
        "rating.positiveFollowUp",
        "What do you like about it?"
    )
    private static let negativeFollowUp = LocalizedText(
        "rating.negativeFollowUp",
        "What shall be improved?"
    )
    private static let thumbsUp = LocalizedText(
        "rating.thumbsUp",
        "Thumbs up"
    )
    private static let thumbsDown = LocalizedText(
        "rating.thumbsDown",
        "Thumbs down"
    )
    private static let thumbsRating = LocalizedText(
        "rating.thumbsRating",
        "Thumbs rating"
    )
    private static let starRating = LocalizedText(
        "rating.starRating",
        "Star rating"
    )
    private static let clear = LocalizedText("rating.clear", "Clear")
    private static let clearSelection = LocalizedText(
        "rating.clearSelection",
        "Clear selection"
    )
    private static let placeholder = LocalizedText(
        "rating.placeholder",
        "Your feedback helps to improve this page"
    )
    private static let tooShort = LocalizedText(
        "rating.tooShort",
        "Feedback must be at least 5 characters long."
    )
    private static let submit = LocalizedText("rating.submit", "Submit")
    private static let wentWrong = LocalizedText(
        "rating.wentWrong",
        "Something went wrong"
    )
    private static let couldNotSubmit = LocalizedText(
        "rating.couldNotSubmit",
        "Your feedback could not be submitted. Please try again."
    )
    private static let thankYou = LocalizedText(
        "rating.thankYou",
        "Thank you for your feedback!"
    )
    private static let closeWidget = LocalizedText(
        "rating.closeWidget",
        "Close feedback widget"
    )
    typealias buttonStyles = ActionButtonStyles

    public init(
        _ data: RatingData
    ) {
        self.data = data
        self.textAreaId = "textarea-\(data.sanitizedId())"
    }

    private func xDataExpression() -> String {
        let uuid = data.sanitizedId()
        let scrollFlag = data.isShownOnScroll ? "true" : "false"
        let cookieNameLit = JavaScriptEscaper.alpineStringLiteral(
            data.cookieName
        )
        let floatingFlag = data.isFloating ? "true" : "false"
        return "ratingWidget('" + uuid + "', " + scrollFlag + ", "
            + cookieNameLit + ", " + floatingFlag + ")"
    }

    @Builder<Element>
    func heading() -> [Element] {
        let title = data.question ?? Self.question
        P(title.resolved)
            .localized(title)
            .class("text-center pt-1")
            .addClass(styles.question)
            .setAttribute(name: "x-show", value: "!showSuccess")
    }

    @Builder<Element>
    func ratingRow() -> [Element] {
        switch data.ratingType {
        case .thumbsUpDown:
            thumbsRow()
        case .fiveStars:
            starRow()
        }
    }

    @Builder<Element>
    func showButtonThumbsUp() -> [Element] {
        Div {
            Svg.icon(.hand_thumbs_up, width: iconSize, height: iconSize)
                .setAttribute(name: "x-show", value: "thumb !== 'up'")

            Svg.icon(.hand_thumbs_up_fill, width: iconSize, height: iconSize)
                .setAttribute(name: "x-show", value: "thumb === 'up'")
        }
        .class("flex-initial align-middle")
    }

    @Builder<Element>
    func showButtonThumbsDown() -> [Element] {
        Div {
            Svg.icon(.hand_thumbs_down_fill, width: iconSize, height: iconSize)
                .setAttribute(name: "x-show", value: "thumb === 'down'")

            Svg.icon(.hand_thumbs_down, width: iconSize, height: iconSize)
                .setAttribute(name: "x-show", value: "thumb !== 'down'")
        }
        .class("flex-initial align-middle")
    }

    @Builder<Element>
    func showButtonReset() -> [Element] {
        Div {
            Svg.icon(.x_lg, width: 16, height: 16)
        }
        .class("flex-initial align-middle")
    }

    @Builder<Element>
    func showButtonStar(_ counter: Int) -> [Element] {
        Div {
            Svg.icon(.star_fill, width: iconSize, height: iconSize)
                .setAttribute(name: "x-show", value: "rating >= \(counter)")

            Svg.icon(.star, width: iconSize, height: iconSize)
                .setAttribute(name: "x-show", value: "rating < \(counter)")
        }
        .class("flex-initial align-middle")
    }

    @Builder<Element>
    func thumbsRow() -> [Element] {
        Div {
            Button { showButtonThumbsUp() }
                .type(.button)
                .id("thumb-up")
                .role("radio")
                .setAttribute(name: ":aria-checked", value: "thumb === 'up'")
                .class(buttonStyles.iconButton)
                .localized(.ariaLabel, Self.thumbsUp)
                .setAttribute(name: "x-ref", value: "thumbUp")
                .setAttribute(name: "@click", value: "selectThumb('up')")
                .setAttribute(
                    name: "@keydown.right",
                    value: "$refs.thumbDown.focus()"
                )

            Button { showButtonThumbsDown() }
                .type(.button)
                .id("thumb-down")
                .role("radio")
                .setAttribute(name: ":aria-checked", value: "thumb === 'down'")
                .class(buttonStyles.iconButton)
                .localized(.ariaLabel, Self.thumbsDown)
                .setAttribute(name: "x-ref", value: "thumbDown")
                .setAttribute(name: "@click", value: "selectThumb('down')")
                .setAttribute(
                    name: "@keydown.left",
                    value: "$refs.thumbUp.focus()"
                )

            Span {
                ActionButton(
                    ActionButtonData(
                        id: "btn-reset-thumb",
                        clickAction: "resetThumb()",
                        label: Self.clear,
                        ariaLabel: Self.clearSelection,
                        htmlType: .button,
                        buttonType: .tertiary,
                        state: .enabled,
                        size: .base,
                        hasFullWidth: false,
                        contentTracker: MatomoContentTracker(
                            name: "feedback-widget",
                            piece: "btn_reset",
                            target: ""
                        )
                    )
                )
                .render()
            }
            .setAttribute(name: "x-show", value: "thumb !== null")

        }
        .role("radiogroup")
        .localized(.ariaLabel, Self.thumbsRating)
        .class("flex flex-wrap items-center justify-center gap-4 mb-8")
        .setAttribute(name: "x-show", value: "!showSuccess")
    }

    @Builder<Element>
    func starRow() -> [Element] {
        Div {
            for i in 1...5 {
                Button { showButtonStar(i) }
                    .type(.button)
                    .role("radio")
                    .setAttribute(
                        name: ":aria-checked",
                        value: "rating === \(i)"
                    )
                    .class(buttonStyles.iconButton)
                    .localized(
                        .ariaLabel,
                        LocalizedText(
                            "rating.rateStar",
                            "Rate {{number}} star",
                            variables: ["number": "\(i)"]
                        )
                    )
                    .setAttribute(name: "x-ref", value: "star\(i)")
                    .setAttribute(
                        name: "@keydown.left",
                        value: "focusStar(Math.max(1, \(i) - 1))"
                    )
                    .setAttribute(
                        name: "@keydown.right",
                        value: "focusStar(Math.min(5, \(i) + 1))"
                    )
                    .setAttribute(name: "@click", value: "selectStar(\(i))")
            }

            Span {
                ActionButton(
                    ActionButtonData(
                        id: "btn-reset-star",
                        clickAction: "resetStar()",
                        label: Self.clear,
                        ariaLabel: Self.clearSelection,
                        htmlType: .button,
                        buttonType: .tertiary,
                        state: .enabled,
                        size: .base,
                        hasFullWidth: false,
                        contentTracker: MatomoContentTracker(
                            name: "feedback-widget",
                            piece: "btn_reset",
                            target: ""
                        )
                    )
                )
                .render()
            }
            .setAttribute(name: "x-show", value: "rating !== 0")

        }
        .role("radiogroup")
        .localized(.ariaLabel, Self.starRating)
        .class("flex flex-wrap items-center justify-center gap-4 mb-8")
        .setAttribute(name: "x-show", value: "!showSuccess")
    }

    /// The two follow-up questions as inert templates. The label of the feedback field shows the one
    /// that matches the rating (`followUpLabel()` in `rating.js`), with its translation marker.
    @Builder<Element>
    func followUpTemplates() -> [Element] {
        let positive = data.positiveFollowUpQuestion ?? Self.positiveFollowUp
        let negative = data.negativeFollowUpQuestion ?? Self.negativeFollowUp

        Template { Span(positive.resolved).localized(positive) }
            .setAttribute(name: "data-follow-up", value: "positive")
        Template { Span(negative.resolved).localized(negative) }
            .setAttribute(name: "data-follow-up", value: "negative")
    }

    private var feedbackFields: [FormField] {
        [
            .hidden(HiddenFieldData(id: "id", value: data.id)),
            .custom(RatingHiddenInput()),
            .textArea(
                TextAreaFieldData(
                    id: textAreaId,
                    name: "feedback",
                    label: LabelData(
                        id: textAreaId,
                        title: Self.negativeFollowUp,
                        size: .sm,
                        isRequired: true,
                        xhtml: "followUpLabel()"
                    ),
                    placeholder: Self.placeholder,
                    rows: 1,
                    validation: .custom(
                        pattern: #"^[\s\S]{5,}$"#,
                        message: data.ErrorMessageInvalidFeedback
                            ?? Self.tooShort
                    )
                )
            ),
        ]
    }

    @Builder<Element>
    func feedbackForm() -> [Element] {

        // Show form only if a rating is selected (thumb or star)
        let showFormExpr: String = {
            switch data.ratingType {
            case .thumbsUpDown:
                return "thumb !== null && !showSuccess"
            case .fiveStars:
                return "rating !== 0 && !showSuccess"
            }
        }()

        Div {
            FormBuilder(
                FormBuilderData(
                    id: "feedback-form-\(data.sanitizedId())",
                    fields: feedbackFields,
                    actions: [
                        .button(
                            ActionButtonData(
                                id: "thumb-submit",
                                label: Self.submit,
                                htmlType: .submit,
                                buttonType: .primary,
                                size: .base,
                                hasFullWidth: true,
                                contentTracker: MatomoContentTracker(
                                    name: "feedback-widget",
                                    piece: "btn_submit",
                                    target: ""
                                )
                            )
                        )
                    ],
                    validationMethod: .submit,
                    layout: .widget,
                    isTracked: false
                )
            )
            .render()

            followUpTemplates()

            // Error notification for failed submission
            Div {
                Notification(
                    NotificationData(
                        title: Self.wentWrong,
                        text: Self.couldNotSubmit,
                        type: .error
                    )
                )
                .render()
            }
            .setAttribute(name: "x-show", value: "showError")
            .class("mt-8")
        }
        .class("w-full mt-6")
        .setAttribute(name: "x-show", value: showFormExpr)
        .setAttribute(
            name: "x-on:submit.prevent",
            value: "submitFeedback($event.target, '\(data.url)')"
        )
    }

    @Builder<Element>
    func thankYouMessage() -> [Element] {
        P(Self.thankYou.resolved)
            .localized(Self.thankYou)
            .setAttribute(name: "x-show", value: "showSuccess")
            .class(styles.thankYouMessage)
    }

    @Builder<Element>
    func showCloseButton() -> [Element] {
        if data.isFloating {
            Div {
                ActionButton(
                    ActionButtonData(
                        id: "btn-close",
                        clickAction: "close()",
                        label: nil,
                        ariaLabel: Self.closeWidget,
                        htmlType: .button,
                        buttonType: .icon,
                        state: .enabled,
                        size: .base,
                        hasFullWidth: false,
                        icon: .x_lg,
                        iconPosition: .left,
                        contentTracker: MatomoContentTracker(
                            name: "feedback-widget",
                            piece: "btn_close",
                            target: ""
                        )
                    )
                )
                .render()
            }
            .setAttribute(name: "x-show", value: "isFloating")
        }
    }

    @Builder<Element>
    public func render() -> [Element] {
        DebugComment("Feedback widget")

        Script()
            .src("/js/rating.js")
            .setAttribute(
                name: "type",
                value: "text/javascript"
            )

        Div {
            Div {

                Div {
                    heading()
                    showCloseButton()
                }
                .class("flex flex-wrap items-center justify-center gap-4")
                .if(data.ratingType == .thumbsUpDown) {
                    $0.addClass("mb-8")
                } else: {
                    $0.addClass("mb-4")
                }

                ratingRow()
                feedbackForm()
                thankYouMessage()
            }
            .class(styles.panelInner)
            .if(data.isFloating) {
                $0.id("rating-floating-panel-\(data.sanitizedId())")
            } else: {
                $0.id("rating-panel-\(data.sanitizedId())")
            }
            .class(DialogStyles.backgroundPadding)
        }
        .class(styles.panel)
        .if(data.isFloating) {
            $0.setAttribute(
                name: ":class",
                value:
                    "isFloating ? '\(styles.containerFloating)' : '\(styles.containerDefault)'"
            )
        } else: {
            $0.addClass(styles.containerDefault)
        }
        .setAttribute(name: "x-data", value: xDataExpression())
        .setAttribute(name: "x-show", value: "visible")
    }
}

/// The `rating` value the widget submits. It follows the selection, so it is bound in Alpine.
private struct RatingHiddenInput: TemplateRepresentable, Sendable {
    @Builder<Element>
    func render() -> [Element] {
        Input()
            .type(.hidden)
            .name("rating")
            .setAttribute(name: "x-bind:value", value: "rating")
    }
}
