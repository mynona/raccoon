import HTML
import SGML
import SVG
import WebBuilders

public struct Rating: TemplateRepresentable {
    let data: RatingData
    let iconSize = 28
    let textAreaId: String

    typealias styles = RatingStyles
    typealias buttonStyles = ActionButtonStyles

    private static let question = LocalizedText(
        "rating.question",
        "How do you like this application?"
    )
    private static let suggestImprovement = LocalizedText(
        "rating.suggestImprovement",
        "Suggest an improvement"
    )
    private static let shareImprovement = LocalizedText(
        "rating.shareImprovement",
        "Share an improvement?"
    )
    private static let positiveFollowUp = LocalizedText(
        "rating.positiveFollowUp",
        "What do you like about it?"
    )
    private static let negativeFollowUp = LocalizedText(
        "rating.negativeFollowUp",
        "What shall be improved?"
    )
    private static let feedback = LocalizedText(
        "rating.feedback",
        "Your feedback improves this service"
    )
    private static let categoryLabel = LocalizedText(
        "rating.category",
        "Category"
    )
    private static let selectCategory = LocalizedText(
        "rating.selectCategory",
        "Select category"
    )
    private static let categoryRequired = LocalizedText(
        "rating.categoryRequired",
        "Please select a category."
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
    private static let toastErrorTitle = LocalizedText(
        "rating.toastErrorTitle",
        "Server error"
    )
    private static let toastErrorText = LocalizedText(
        "rating.toastErrorText",
        "Rating has not been submitted."
    )
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
    private static let close = LocalizedText(
        "rating.close",
        "Close"
    )

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
    func headerRow() -> [Element] {
        let title = data.question ?? (data.hasLikertRating ? Self.question : Self.suggestImprovement)
        Div {
            P(title.resolved)
                .localized(title)
                .setAttribute(name: ":id", value: "$id('rating-modal-title')")
                .class(styles.question)

            ActionButton(
                ActionButtonData(
                    id: "btn-close",
                    clickAction: "closeModal()",
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
        .class(styles.headerRow)
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

    private var hasCustomFollowUp: Bool {
        data.positiveFollowUpQuestion != nil || data.negativeFollowUpQuestion != nil
    }

    private var feedbackFields: [FormField] {
        var fields: [FormField] = []

        if data.hasCategory && !data.categoryOptions.isEmpty {
            fields.append(
                .dropdown(
                    DropdownData(
                        id: "category-\(data.sanitizedId())",
                        name: "category",
                        label: nil,
                        placeholder: Self.selectCategory,
                        placeholderText: Self.selectCategory,
                        options: data.categoryOptions,
                        errorMessages: ErrorMessageData(
                            id: "category-error-\(data.sanitizedId())",
                            errorMessages: [Self.categoryRequired]
                        )
                    )
                )
            )
        }

        let labelTitle = hasCustomFollowUp ? Self.negativeFollowUp : Self.feedback
        let labelXhtml = hasCustomFollowUp ? "followUpLabel()" : nil

        fields.append(
            .textArea(
                TextAreaFieldData(
                    id: textAreaId,
                    name: "feedback",
                    label: LabelData(
                        id: textAreaId,
                        title: labelTitle,
                        size: .sm,
                        isRequired: true,
                        xhtml: labelXhtml
                    ),
                    placeholder: nil,
                    rows: 3,
                    validation: .custom(
                        pattern: #"^[\s\S]{5,}$"#,
                        message: data.ErrorMessageInvalidFeedback
                            ?? Self.tooShort
                    )
                )
            )
        )

        fields.append(.hidden(HiddenFieldData(id: "id", value: data.id)))
        fields.append(.custom(RatingHiddenInput()))
        return fields
    }

    @Builder<Element>
    func feedbackForm() -> [Element] {

        // Show form only if a rating is selected (thumb or star), or immediately if no Likert rating
        let showFormExpr: String = {
            if !data.hasLikertRating {
                return "!showSuccess"
            }
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

            if hasCustomFollowUp {
                followUpTemplates()
            }
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
        Div {
            P(Self.thankYou.resolved)
                .localized(Self.thankYou)
                .class(styles.thankYouMessage)

            ActionButton(
                ActionButtonData(
                    id: "btn-thank-you-close",
                    clickAction: "closeModal()",
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
                        piece: "btn_thank_you_close",
                        target: ""
                    )
                )
            )
            .render()
        }
        .class(styles.thankYouContainer)
        .setAttribute(name: "x-show", value: "showSuccess")
    }

    @Builder<Element>
    func floatingTriggerButton() -> [Element] {
        let labelText = data.tooltip ?? Self.shareImprovement

        Div {
            Button {
                Div {
                    Svg.icon(.lightbulb, width: 16, height: 16)
                        .setAttribute(name: "aria-hidden", value: "true")
                        .class("shrink-0")

                    Span(labelText.resolved)
                        .localized(labelText)
                        .class(styles.triggerText)
                }
                .class("flex items-center")
            }
            .type(.button)
            .id("rating-trigger-\(data.sanitizedId())")
            .localized(.ariaLabel, labelText)
            .setAttribute(name: "x-ref", value: "triggerButton")
            .setAttribute(name: "@click", value: "openModal()")
            .setAttribute(name: "aria-haspopup", value: "dialog")
            .setAttribute(name: ":aria-expanded", value: "open")
            .setAttribute(
                name: ":aria-controls",
                value: "'rating-modal-\(data.sanitizedId())'"
            )
            .class(styles.triggerButton)
        }
        .class(styles.floatingContainer)
        .setAttribute(name: "x-show", value: "visible && !open")
    }

    @Builder<Element>
    func modalDialog() -> [Element] {
        Div {
            // Backdrop
            Div {}
                .setAttribute(name: "x-show", value: "open")
                .flagAttribute("x-transition.opacity")
                .class(styles.backdrop)

            // Dialog container
            Div {
                Div {
                    headerRow()

                    if data.hasLikertRating {
                        ratingRow()
                    }
                    feedbackForm()
                    thankYouMessage()
                }
                .flagAttribute("x-on:click.stop")
                .setAttribute(name: "x-trap.noscroll.inert", value: "open")
                .class(styles.panelInner)
                .id("rating-floating-panel-\(data.sanitizedId())")
            }
            .setAttribute(name: "x-show", value: "open")
            .flagAttribute("x-transition")
            .setAttribute(name: "x-on:click", value: "closeModal()")
            .class(styles.modalWrapper)
        }
        .setAttribute(name: "x-show", value: "open")
        .setAttribute(
            name: "x-on:keydown.escape.prevent.stop",
            value: "closeModal()"
        )
        .setAttribute(name: "role", value: "dialog")
        .setAttribute(name: "aria-modal", value: "true")
        .setAttribute(name: "x-id", value: "['rating-modal-title']")
        .setAttribute(
            name: ":aria-labelledby",
            value: "$id('rating-modal-title')"
        )
        .id("rating-modal-\(data.sanitizedId())")
        .flagAttribute("x-cloak")
        .class("fixed inset-0 z-50 overflow-y-auto")
    }

    @Builder<Element>
    public func render() -> [Element] {
        DebugComment("Feedback widget")

        let errorTitle = data.toastErrorTitle ?? Self.toastErrorTitle
        let errorText = data.toastErrorText ?? Self.toastErrorText

        Script()
            .src("/js/rating.js")
            .setAttribute(
                name: "type",
                value: "text/javascript"
            )

        Div {
            floatingTriggerButton()
            modalDialog()
        }
        .setAttribute(name: "x-data", value: xDataExpression())
        .setAttribute(
            name: "data-toast-error-title",
            value: errorTitle.resolved
        )
        .setAttribute(
            name: "data-toast-error-text",
            value: errorText.resolved
        )
        .setAttribute(
            name: "data-i18n-toast-error-title",
            value: "rating.toastErrorTitle"
        )
        .setAttribute(
            name: "data-i18n-toast-error-text",
            value: "rating.toastErrorText"
        )
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
