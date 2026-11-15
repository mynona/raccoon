import Foundation

/// Configuration data for the `YesNoRating` component. Serves as the public API contract.
public struct YesNoRatingData: Sendable {

    // MARK: - 1. Identity & Alpine Bindings

    /// Unique DOM identifier for the rating widget.
    public let id: String

    /// Submission URL endpoint for rating votes.
    public let url: String

    // MARK: - 2. Content & Accessibility

    /// Main prompt question displayed to the user.
    public let question: LocalizedText?

    /// Label displayed on the positive option button.
    public let yesLabel: LocalizedText?

    /// Label displayed on the negative option button.
    public let noLabel: LocalizedText?

    /// Prompt question displayed after selecting Yes.
    public let positiveFollowUpQuestion: LocalizedText?

    /// Prompt question displayed after selecting No.
    public let negativeFollowUpQuestion: LocalizedText?

    /// Options displayed when Yes is selected.
    public let positiveOptions: [LocalizedText]?

    /// Options displayed when No is selected.
    public let negativeOptions: [LocalizedText]?

    /// Label displayed above the optional feedback textarea.
    public let textareaLabel: LocalizedText?

    /// Label displayed on the cancel button.
    public let cancelLabel: LocalizedText?

    /// Label displayed on the submit button.
    public let submitLabel: LocalizedText?

    /// Success message displayed after submission.
    public let thankYouMessage: LocalizedText?

    /// Title of the toast notification shown on successful submission.
    public let toastSuccessTitle: LocalizedText?

    /// Body text of the toast notification shown on successful submission.
    public let toastSuccessText: LocalizedText?

    /// Title of the toast notification shown on submission error.
    public let toastErrorTitle: LocalizedText?

    /// Body text of the toast notification shown on submission error.
    public let toastErrorText: LocalizedText?

    /// Creates a new configuration instance for `YesNoRating`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the rating widget.
    ///   - url: Submission URL endpoint for rating votes.
    ///   - question: Main prompt question displayed to the user.
    ///   - yesLabel: Label displayed on the positive option button.
    ///   - noLabel: Label displayed on the negative option button.
    ///   - positiveFollowUpQuestion: Prompt question displayed after selecting Yes.
    ///   - negativeFollowUpQuestion: Prompt question displayed after selecting No.
    ///   - positiveOptions: Options displayed when Yes is selected.
    ///   - negativeOptions: Options displayed when No is selected.
    ///   - textareaLabel: Label displayed above the optional feedback textarea.
    ///   - cancelLabel: Label displayed on the cancel button.
    ///   - submitLabel: Label displayed on the submit button.
    ///   - thankYouMessage: Success message displayed after submission.
    ///   - toastSuccessTitle: Title of the toast notification shown on successful submission.
    ///   - toastSuccessText: Body text of the toast notification shown on successful submission.
    ///   - toastErrorTitle: Title of the toast notification shown on submission error.
    ///   - toastErrorText: Body text of the toast notification shown on submission error.
    public init(
        // 1. Identity & Alpine Bindings
        id: String,
        url: String,

        // 2. Content & Accessibility
        question: LocalizedText? = nil,
        yesLabel: LocalizedText? = nil,
        noLabel: LocalizedText? = nil,
        positiveFollowUpQuestion: LocalizedText? = nil,
        negativeFollowUpQuestion: LocalizedText? = nil,
        positiveOptions: [LocalizedText]? = nil,
        negativeOptions: [LocalizedText]? = nil,
        textareaLabel: LocalizedText? = nil,
        cancelLabel: LocalizedText? = nil,
        submitLabel: LocalizedText? = nil,
        thankYouMessage: LocalizedText? = nil,
        toastSuccessTitle: LocalizedText? = nil,
        toastSuccessText: LocalizedText? = nil,
        toastErrorTitle: LocalizedText? = nil,
        toastErrorText: LocalizedText? = nil
    ) {
        // 1. Identity & Alpine Bindings
        self.id = id
        self.url = url

        // 2. Content & Accessibility
        self.question = question
        self.yesLabel = yesLabel
        self.noLabel = noLabel
        self.positiveFollowUpQuestion = positiveFollowUpQuestion
        self.negativeFollowUpQuestion = negativeFollowUpQuestion
        self.positiveOptions = positiveOptions
        self.negativeOptions = negativeOptions
        self.textareaLabel = textareaLabel
        self.cancelLabel = cancelLabel
        self.submitLabel = submitLabel
        self.thankYouMessage = thankYouMessage
        self.toastSuccessTitle = toastSuccessTitle
        self.toastSuccessText = toastSuccessText
        self.toastErrorTitle = toastErrorTitle
        self.toastErrorText = toastErrorText
    }

    /// Returns a sanitized representation of `id` suitable for DOM element IDs.
    public func sanitizedId() -> String {
        String(
            self.id.map { char in
                if char.isLetter || char.isNumber || char == "-" || char == "_"
                {
                    return char
                }
                return "-"
            }
        )
    }
}
