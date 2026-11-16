import HTML
import SGML
import SVG
import WebBuilders

/// A Yes/No rating component that presents an initial binary question, followed by
/// tailored feedback options and an optional comment textarea upon selection.
public struct YesNoRating: TemplateRepresentable {
    let data: YesNoRatingData

    typealias styles = YesNoRatingStyles
    typealias buttonStyles = ActionButtonStyles

    private static let question = LocalizedText(
        "yesnorating.question",
        "Was this article helpful?"
    )
    private static let yes = LocalizedText(
        "yesnorating.yes",
        "Yes"
    )
    private static let no = LocalizedText(
        "yesnorating.no",
        "No"
    )
    private static let positiveFollowUp = LocalizedText(
        "yesnorating.positiveFollowUp",
        "Great! What worked best for you?"
    )
    private static let positiveOptionEasyToFind = LocalizedText(
        "yesnorating.positiveOptionEasyToFind",
        "It was easy to find the information I needed"
    )
    private static let positiveOptionEasyToUnderstand = LocalizedText(
        "yesnorating.positiveOptionEasyToUnderstand",
        "It was easy to understand the information"
    )
    private static let negativeFollowUp = LocalizedText(
        "yesnorating.negativeFollowUp",
        "How can we improve this article?"
    )
    private static let negativeOptionMissedInfo = LocalizedText(
        "yesnorating.negativeOptionMissedInfo",
        "I missed relevant information"
    )
    private static let negativeOptionNotUnderstandable = LocalizedText(
        "yesnorating.negativeOptionNotUnderstandable",
        "The information was not understandable"
    )
    private static let somethingElse = LocalizedText(
        "yesnorating.somethingElse",
        "Something else"
    )
    private static let textareaLabel = LocalizedText(
        "yesnorating.textareaLabel",
        "(Optional) Could you share more about your experience?"
    )
    private static let cancel = LocalizedText(
        "yesnorating.cancel",
        "Cancel"
    )
    private static let submit = LocalizedText(
        "yesnorating.submit",
        "Submit feedback"
    )
    private static let thankYou = LocalizedText(
        "yesnorating.thankYou",
        "Thank you for your feedback!"
    )
    private static let toastSuccessTitle = LocalizedText(
        "yesnorating.toastSuccessTitle",
        "Rating"
    )
    private static let toastSuccessText = LocalizedText(
        "yesnorating.toastSuccessText",
        "Rating successfully submitted"
    )
    private static let toastErrorTitle = LocalizedText(
        "yesnorating.toastErrorTitle",
        "Server error"
    )
    private static let toastErrorText = LocalizedText(
        "yesnorating.toastErrorText",
        "Rating has not been submitted."
    )

    public init(_ data: YesNoRatingData) {
        self.data = data
    }

    private var positiveOptions: [LocalizedText] {
        data.positiveOptions ?? [
            Self.positiveOptionEasyToFind,
            Self.positiveOptionEasyToUnderstand,
            Self.somethingElse,
        ]
    }

    private var negativeOptions: [LocalizedText] {
        data.negativeOptions ?? [
            Self.negativeOptionMissedInfo,
            Self.negativeOptionNotUnderstandable,
            Self.somethingElse,
        ]
    }

    private func xDataExpression() -> String {
        let uuid = data.sanitizedId()
        let urlLit = JavaScriptEscaper.alpineStringLiteral(data.url)
        return "yesNoRatingWidget('" + uuid + "', " + urlLit + ")"
    }

    @Builder<Element>
    func headerRow() -> [Element] {
        let title = data.question ?? Self.question
        let yesText = data.yesLabel ?? Self.yes
        let noText = data.noLabel ?? Self.no

        Div {
            P(title.resolved)
                .localized(title)
                .class(styles.question)

            Div {
                Button {
                    Div {
                        Div {
                            Svg.icon(.hand_thumbs_up, width: 18, height: 18)
                                .setAttribute(
                                    name: "x-show",
                                    value: "choice !== 'yes'"
                                )
                            Svg.icon(
                                .hand_thumbs_up_fill,
                                width: 18,
                                height: 18
                            )
                            .setAttribute(
                                name: "x-show",
                                value: "choice === 'yes'"
                            )
                        }
                        .setAttribute(name: "aria-hidden", value: "true")
                        .class("flex items-center")

                        Span(yesText.resolved)
                            .localized(yesText)
                    }
                    .class(styles.yesNoButtonContent)
                }
                .type(.button)
                .id("yesno-btn-yes-\(data.sanitizedId())")
                .setAttribute(name: "x-ref", value: "yesBtn")
                .setAttribute(name: "@click", value: "selectChoice('yes')")
                .setAttribute(name: ":aria-pressed", value: "choice === 'yes'")
                .setAttribute(
                    name: ":class",
                    value:
                        "choice === 'yes' ? '\(styles.yesNoButtonActive)' : '\(styles.yesNoButton)'"
                )
                .class(styles.yesNoButton)

                Button {
                    Div {
                        Div {
                            Svg.icon(.hand_thumbs_down, width: 18, height: 18)
                                .setAttribute(
                                    name: "x-show",
                                    value: "choice !== 'no'"
                                )
                            Svg.icon(
                                .hand_thumbs_down_fill,
                                width: 18,
                                height: 18
                            )
                            .setAttribute(
                                name: "x-show",
                                value: "choice === 'no'"
                            )
                        }
                        .setAttribute(name: "aria-hidden", value: "true")
                        .class("flex items-center")

                        Span(noText.resolved)
                            .localized(noText)
                    }
                    .class(styles.yesNoButtonContent)
                }
                .type(.button)
                .id("yesno-btn-no-\(data.sanitizedId())")
                .setAttribute(name: "x-ref", value: "noBtn")
                .setAttribute(name: "@click", value: "selectChoice('no')")
                .setAttribute(name: ":aria-pressed", value: "choice === 'no'")
                .setAttribute(
                    name: ":class",
                    value:
                        "choice === 'no' ? '\(styles.yesNoButtonActive)' : '\(styles.yesNoButton)'"
                )
                .class(styles.yesNoButton)
            }
            .class(styles.yesNoButtonsGroup)
        }
        .class(styles.headerRow)
        .setAttribute(name: "x-show", value: "!showSuccess")
    }

    @Builder<Element>
    func positiveOptionsSection() -> [Element] {
        let followUp = data.positiveFollowUpQuestion ?? Self.positiveFollowUp
        Div {
            RadioGroup(
                RadioGroupData(
                    id: "yesno-radios-pos-\(data.sanitizedId())",
                    name: "yesno-option-pos-\(data.sanitizedId())",
                    label: LabelData(
                        id: "yesno-legend-pos-\(data.sanitizedId())",
                        title: followUp,
                        size: .base
                    ),
                    options: positiveOptions.enumerated()
                        .map { index, opt in
                            RadioData(
                                id:
                                    "yesno-opt-pos-\(data.sanitizedId())-\(index)",
                                label: opt,
                                value: opt.english
                            )
                        }
                )
            )
            .render()
        }
        .class(styles.optionsList)
        .setAttribute(name: "x-show", value: "choice === 'yes'")
    }

    @Builder<Element>
    func negativeOptionsSection() -> [Element] {
        let followUp = data.negativeFollowUpQuestion ?? Self.negativeFollowUp
        Div {
            RadioGroup(
                RadioGroupData(
                    id: "yesno-radios-neg-\(data.sanitizedId())",
                    name: "yesno-option-neg-\(data.sanitizedId())",
                    label: LabelData(
                        id: "yesno-legend-neg-\(data.sanitizedId())",
                        title: followUp,
                        size: .base
                    ),
                    options: negativeOptions.enumerated()
                        .map { index, opt in
                            RadioData(
                                id:
                                    "yesno-opt-neg-\(data.sanitizedId())-\(index)",
                                label: opt,
                                value: opt.english
                            )
                        }
                )
            )
            .render()
        }
        .class(styles.optionsList)
        .setAttribute(name: "x-show", value: "choice === 'no'")
    }

    @Builder<Element>
    func textareaSection() -> [Element] {
        let label = data.textareaLabel ?? Self.textareaLabel
        let textareaId = "textarea-\(data.sanitizedId())"
        Div {
            TextAreaField(
                TextAreaFieldData(
                    id: textareaId,
                    name: "comment",
                    label: LabelData(
                        id: textareaId,
                        title: label,
                        size: .sm,
                        isRequired: false
                    ),
                    rows: 3
                )
            )
            .render()
        }
        .class(styles.textareaContainer)
        .setAttribute(name: "x-show", value: "selectedOption !== null")
    }

    @Builder<Element>
    func actionsRow() -> [Element] {
        let cancelText = data.cancelLabel ?? Self.cancel
        let submitText = data.submitLabel ?? Self.submit
        Div {
            Button {
                Span(cancelText.resolved)
                    .localized(cancelText)
            }
            .type(.button)
            .id("yesno-btn-cancel-\(data.sanitizedId())")
            .class(styles.cancelButton)
            .setAttribute(name: "@click", value: "resetChoice()")

            Button {
                Span(submitText.resolved)
                    .localized(submitText)
            }
            .type(.submit)
            .id("yesno-btn-submit-\(data.sanitizedId())")
            .setAttribute(
                name: ":disabled",
                value: "!selectedOption || submitting"
            )
            .setAttribute(
                name: ":class",
                value:
                    "!selectedOption || submitting ? '\(styles.submitButtonDisabled)' : '\(styles.submitButton)'"
            )
        }
        .class(styles.actionRow)
    }

    @Builder<Element>
    func feedbackForm() -> [Element] {
        Form {
            positiveOptionsSection()
            negativeOptionsSection()
            textareaSection()
            actionsRow()
        }
        .class(styles.followUpContainer)
        .setAttribute(name: "x-show", value: "choice !== null && !showSuccess")
        .setAttribute(
            name: "@change",
            value:
                "$event.target.type === 'radio' && selectOption($event.target.value)"
        )
        .setAttribute(
            name: "x-on:submit.prevent",
            value: "submitFeedback($event.target, '\(data.url)')"
        )
    }

    @Builder<Element>
    func thankYouMessage() -> [Element] {
        let thankYou = data.thankYouMessage ?? Self.thankYou
        P(thankYou.resolved)
            .localized(thankYou)
            .class(styles.thankYouMessage)
            .setAttribute(name: "x-show", value: "showSuccess")
    }

    @Builder<Element>
    public func render() -> [Element] {
        DebugComment("YesNoRating widget")

        let successTitle = data.toastSuccessTitle ?? Self.toastSuccessTitle
        let successText = data.toastSuccessText ?? Self.toastSuccessText
        let errorTitle = data.toastErrorTitle ?? Self.toastErrorTitle
        let errorText = data.toastErrorText ?? Self.toastErrorText

        Script()
            .src("/js/raccoon-yes-no-rating.js")
            .setAttribute(name: "type", value: "text/javascript")

        Div {
            Div {
                headerRow()
                feedbackForm()
                thankYouMessage()
            }
            .class(styles.panelInner)
            .id("yesno-panel-\(data.sanitizedId())")
        }
        .class(styles.panel)
        .setAttribute(name: "x-data", value: xDataExpression())
        .setAttribute(name: "x-show", value: "visible")
        .setAttribute(
            name: "data-toast-success-title",
            value: successTitle.resolved
        )
        .setAttribute(
            name: "data-toast-success-text",
            value: successText.resolved
        )
        .setAttribute(
            name: "data-toast-error-title",
            value: errorTitle.resolved
        )
        .setAttribute(name: "data-toast-error-text", value: errorText.resolved)
        .setAttribute(
            name: "data-i18n-toast-success-title",
            value: "yesnorating.toastSuccessTitle"
        )
        .setAttribute(
            name: "data-i18n-toast-success-text",
            value: "yesnorating.toastSuccessText"
        )
        .setAttribute(
            name: "data-i18n-toast-error-title",
            value: "yesnorating.toastErrorTitle"
        )
        .setAttribute(
            name: "data-i18n-toast-error-text",
            value: "yesnorating.toastErrorText"
        )
    }
}
