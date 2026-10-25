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
    typealias buttonStyles = ActionButtonStyles
    typealias inputFieldStyles = InputFieldStyles

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
        let title = data.question ?? "How do you like this article?"
        P(title)
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
                .setAttribute(name: "aria-label", value: "Thumbs up")
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
                .setAttribute(name: "aria-label", value: "Thumbs down")
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
                        label: "Clear",
                        ariaLabel: "Clear selection",
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
        .setAttribute(name: "aria-label", value: "Thumbs rating")
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
                    .setAttribute(name: "aria-label", value: "Rate \(i) star")
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
                        label: "Clear",
                        ariaLabel: "Clear selection",
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
        .setAttribute(name: "aria-label", value: "Star rating")
        .class("flex flex-wrap items-center justify-center gap-4 mb-8")
        .setAttribute(name: "x-show", value: "!showSuccess")
    }

    @Builder<Element>
    func showLabel(title: String) -> [Element] {
        // Rendered inside mutually exclusive Alpine <template x-if> blocks: that content is inert,
        // so the repeated id must not be reported as a duplicate.

        Label(
            LabelData(
                id: textAreaId,
                title: title,
                size: .sm,
                isRequired: true
            )
        )
        .render()
    }

    @Builder<Element>
    func showError() -> [Element] {
        Div {
            ErrorMessage(
                ErrorMessageData(
                    id: "error-\(textAreaId)",
                    errorMessages: [
                        "Feedback must be at least 5 characters long."
                    ],
                    hasIcon: false
                )
            )
            .render()
        }
        .setAttribute(
            name: "x-show",
            value: "textarea.length < 5"
        )
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

        Form {
            Input()
                .type(.hidden)
                .name("id")
                .value(data.id)

            Input()
                .type(.hidden)
                .name("rating")
                .setAttribute(name: "x-bind:value", value: "rating")

            // Dynamic label based on rating type and value
            let positiveFollowUpQuestion =
                data.positiveFollowUpQuestion ?? "What do you like about it?"
            let negativeFollowUpQuestion =
                data.negativeFollowUpQuestion ?? "What shall be improved?"

            Div {

                switch data.ratingType {
                case .thumbsUpDown:
                    Template {
                        Span {
                            showLabel(title: positiveFollowUpQuestion)
                        }
                    }
                    .setAttribute(
                        name: "x-if",
                        value: "thumb === 'up'"
                    )

                    Template {
                        Span {
                            showLabel(title: negativeFollowUpQuestion)
                        }
                    }
                    .setAttribute(
                        name: "x-if",
                        value: "thumb === 'down'"
                    )
                case .fiveStars:
                    Template {
                        Span {
                            showLabel(title: negativeFollowUpQuestion)
                        }
                    }
                    .setAttribute(
                        name: "x-if",
                        value: "rating <= 4"
                    )

                    Template {
                        Span {
                            showLabel(title: positiveFollowUpQuestion)
                        }
                    }
                    .setAttribute(
                        name: "x-if",
                        value: "rating >= 5"
                    )

                }

                // Textarea with auto-grow
                Textarea("")
                    .id(textAreaId)
                    .name("feedback")
                    .ariaLabel("Your feedback")
                    .rows(1)
                    .setAttribute(name: "x-model", value: "textarea")
                    .setAttribute(
                        name: "placeholder",
                        value:
                            "Your feedback helps to improve this page"
                    )
                    .setAttribute(name: "x-ref", value: "textarea")
                    .setAttribute(name: "@input", value: "autoResize($el)")
                    .class(
                        "block w-full resize-none min-h-0 overflow-y-auto pt-1 pl-0"
                    )
                    .addClass(styles.textareaTextSize)
                    .addClass(inputFieldStyles.textColorInput)
                    .addClass(inputFieldStyles.inputReset)
                    //.addClass(inputFieldStyles.textColorInput)
                    .addClass(inputFieldStyles.textColorPlaceholder)

                // Error icon (dash_circle)
                Div {
                    Svg.icon(.dash_circle)
                }
                .class(
                    "pointer-events-none absolute inset-y-0 right-0 flex items-center pr-4"
                )
                .addClass(inputFieldStyles.textColorError)
                .setAttribute(
                    name: "x-show",
                    value: "textarea.length > 0 && textarea.length < 5"
                )
                .setAttribute(name: "x-transition", value: "")

                // Success icon (check_circle)
                Div {
                    Svg.icon(.check_circle)
                }
                .class(
                    "pointer-events-none absolute inset-y-0 right-0 flex items-center pr-4"
                )
                .addClass(inputFieldStyles.textColorSuccess)
                .setAttribute(name: "x-show", value: "textarea.length >= 5")
            }
            .class("relative rounded-md px-3 pb-1.5 pt-2.5 mt-6")
            .addClass(inputFieldStyles.inputBorder)
            .addClass(inputFieldStyles.inputContainerHover)
            .addClass(inputFieldStyles.inputContainerFocus)
            .setAttribute(
                name: ":class",
                value:
                    "{ '\(inputFieldStyles.borderColorError)': textarea.length < 5, '\(inputFieldStyles.borderColorSuccess)': textarea.length >= 5 }"
            )

            showError()

            Button("Submit")
                .type(.submit)
                .id("thumb-submit")
                .setAttribute(
                    name: ":disabled",
                    value: "submitting || !textarea || textarea.length < 5"
                )
                .class("w-full px-4 py-1.5 mt-8")
                .addClass(buttonStyles.primaryButton)
                .setAttribute(
                    name: ":class",
                    value:
                        "{ '\(buttonStyles.focusDefault) \(buttonStyles.hoverDefault)': textarea.length >= 5 }"
                )
                .setAttribute(
                    name: ":class",
                    value:
                        "{ '\(buttonStyles.disabledButton)': !textarea || textarea.length < 5 }"
                )

            // Error notification for failed submission
            Div {
                Notification(
                    NotificationData(
                        title: "Something went wrong",
                        text:
                            "Your feedback could not be submitted. \nPlease try again.",
                        type: .error
                    )
                )
                .render()
            }
            .setAttribute(name: "x-show", value: "showError")
            .class("mt-8")
        }
        .class("w-full")
        .setAttribute(name: "x-show", value: showFormExpr)
        .setAttribute(
            name: "x-on:submit.prevent",
            value: "submitFeedback($el, '\(data.url)')"
        )
    }

    @Builder<Element>
    func thankYouMessage() -> [Element] {
        P("Thank you for your feedback!")
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
                        ariaLabel: "Close feedback widget",
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
            $0.addClass(styles.containerFloating)
                .setAttribute(
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
