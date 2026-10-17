public struct RatingData: Sendable {

    public enum RatingType: String, Codable, Sendable {
        case thumbsUpDown
        case fiveStars
    }

    public let id: String
    public let url: String
    public let ErrorMessageInvalidFeedback: String
    public let ratingType: RatingType
    public let question: String?
    public let positiveFollowUpQuestion: String?
    public let negativeFollowUpQuestion: String?
    public let isFloating: Bool
    public let isShownOnScroll: Bool
    public let cookieName: String

    /// Creates a new configuration instance for `Rating`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the rating widget.
    ///   - url: Submission URL endpoint for rating votes.
    ///   - ratingType: Rating presentation mode (`thumbsUpDown` or `fiveStars`).
    ///   - question: Main prompt question displayed to the user.
    ///   - positiveFollowUpQuestion: Prompt shown after positive rating.
    ///   - negativeFollowUpQuestion: Prompt shown after negative rating.
    ///   - ErrorMessageInvalidFeedback: Validation message when feedback text is too short.
    ///   - cookieName: Name of cookie used to store rated status.
    ///   - isFloating: Whether widget floats fixed in page viewport.
    ///   - isShownOnScroll: Whether widget reveals upon user scrolling down.
    public init(
        id: String,
        url: String,
        ratingType: RatingType = .thumbsUpDown,
        question: String? = nil,
        positiveFollowUpQuestion: String? = nil,
        negativeFollowUpQuestion: String? = nil,
        ErrorMessageInvalidFeedback: String =
            "Feedback is less than minimum of 5 characters.",
        cookieName: String = "raumnebenan-matomo",
        isFloating: Bool = false,
        isShownOnScroll: Bool = false
    ) {
        self.id = id
        self.url = url
        self.ErrorMessageInvalidFeedback = ErrorMessageInvalidFeedback
        //
        self.ratingType = ratingType
        self.question = question
        self.positiveFollowUpQuestion = positiveFollowUpQuestion
        self.negativeFollowUpQuestion = negativeFollowUpQuestion
        self.isFloating = isFloating
        self.isShownOnScroll = isShownOnScroll
        self.cookieName = cookieName
    }

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

    public func withFloating(_ f: Bool) -> RatingData {
        RatingData(
            id: self.id,
            url: self.url,
            ratingType: self.ratingType,
            question: self.question,
            positiveFollowUpQuestion: self.positiveFollowUpQuestion,
            negativeFollowUpQuestion: self.negativeFollowUpQuestion,
            ErrorMessageInvalidFeedback: self.ErrorMessageInvalidFeedback,
            cookieName: self.cookieName,
            isFloating: f,
            isShownOnScroll: self.isShownOnScroll
        )
    }
}
