import Foundation

/// Configuration data for `Rating`. Serves as the public API contract.
public struct RatingData: Sendable {

    public enum RatingType: String, Codable, Sendable {
        case thumbsUpDown
        case fiveStars
    }

    // MARK: - 1. Identity & Alpine Bindings

    /// Unique DOM identifier for the rating widget.
    public let id: String

    /// Submission URL endpoint for rating votes.
    public let url: String

    /// Name of cookie used to store rated status.
    public let cookieName: String

    // MARK: - 2. Content & Accessibility

    /// Main prompt question displayed to the user.
    public let question: LocalizedText?

    /// Tooltip text displayed for the floating trigger button. Defaults to "Suggest an improvement".
    public let tooltip: LocalizedText?

    /// Prompt shown after positive rating.
    public let positiveFollowUpQuestion: LocalizedText?

    /// Prompt shown after negative rating.
    public let negativeFollowUpQuestion: LocalizedText?

    /// Title of the toast notification shown on submission error.
    public let toastErrorTitle: LocalizedText?

    /// Body text of the toast notification shown on submission error.
    public let toastErrorText: LocalizedText?

    // MARK: - 3. Value & Options

    /// Rating presentation mode (`thumbsUpDown` or `fiveStars`).
    public let ratingType: RatingType

    /// Selectable category options for the category dropdown in the feedback modal.
    public let categoryOptions: [OptionValue]

    // MARK: - 4. Feedback & Validation

    /// Validation message when feedback text is too short.
    public let ErrorMessageInvalidFeedback: LocalizedText?

    // MARK: - 5. Presentation & State

    /// Whether a category dropdown is rendered in the feedback modal.
    public let hasCategory: Bool

    /// Whether Likert rating controls (thumbs or stars) are displayed.
    public let hasLikertRating: Bool

    /// Whether widget floats fixed in page viewport (defaults to `true`).
    public let isFloating: Bool

    /// Whether widget reveals upon user scrolling down (defaults to `false`).
    public let isShownOnScroll: Bool

    // MARK: - 6. Analytics & Tracking

    /// Tracking consent status for Matomo analytics.
    public let matomoStatus: MatomoStatus

    /// Matomo content tracking configuration.
    public let contentTracker: MatomoContentTracker?

    /// Creates a new configuration instance for `Rating`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the rating widget.
    ///   - url: Submission URL endpoint for rating votes.
    ///   - cookieName: Name of cookie used to store rated status.
    ///   - question: Main prompt question displayed to the user.
    ///   - tooltip: Tooltip text displayed for the floating trigger button.
    ///   - positiveFollowUpQuestion: Prompt shown after positive rating.
    ///   - negativeFollowUpQuestion: Prompt shown after negative rating.
    ///   - toastErrorTitle: Title of the toast notification shown on submission error.
    ///   - toastErrorText: Body text of the toast notification shown on submission error.
    ///   - ratingType: Rating presentation mode (`thumbsUpDown` or `fiveStars`).
    ///   - categoryOptions: Selectable category options for the category dropdown.
    ///   - ErrorMessageInvalidFeedback: Validation message when feedback text is too short.
    ///   - hasCategory: Whether a category dropdown is rendered in the feedback modal.
    ///   - hasLikertRating: Whether Likert rating controls are displayed.
    ///   - isFloating: Whether widget floats fixed in page viewport.
    ///   - isShownOnScroll: Whether widget reveals upon user scrolling down.
    ///   - matomoStatus: Tracking consent status for Matomo analytics.
    ///   - contentTracker: Matomo content tracking configuration.
    public init(
        // 1. Identity & Alpine Bindings
        id: String,
        url: String,
        cookieName: String = "raumnebenan-matomo",

        // 2. Content & Accessibility
        question: LocalizedText? = nil,
        tooltip: LocalizedText? = nil,
        positiveFollowUpQuestion: LocalizedText? = nil,
        negativeFollowUpQuestion: LocalizedText? = nil,
        toastErrorTitle: LocalizedText? = nil,
        toastErrorText: LocalizedText? = nil,

        // 3. Value & Options
        ratingType: RatingType = .thumbsUpDown,
        categoryOptions: [OptionValue] = [],

        // 4. Feedback & Validation
        ErrorMessageInvalidFeedback: LocalizedText? = nil,

        // 5. Presentation & State
        hasCategory: Bool = false,
        hasLikertRating: Bool = true,
        isFloating: Bool = true,
        isShownOnScroll: Bool = false,

        // 6. Analytics & Tracking
        matomoStatus: MatomoStatus = .DECLINED,
        contentTracker: MatomoContentTracker? = nil
    ) {
        // 1. Identity & Alpine Bindings
        self.id = id
        self.url = url
        self.cookieName = cookieName

        // 2. Content & Accessibility
        self.question = question
        self.tooltip = tooltip
        self.positiveFollowUpQuestion = positiveFollowUpQuestion
        self.negativeFollowUpQuestion = negativeFollowUpQuestion
        self.toastErrorTitle = toastErrorTitle
        self.toastErrorText = toastErrorText

        // 3. Value & Options
        self.ratingType = ratingType
        self.categoryOptions = categoryOptions

        // 4. Feedback & Validation
        self.ErrorMessageInvalidFeedback = ErrorMessageInvalidFeedback

        // 5. Presentation & State
        self.hasCategory = hasCategory
        self.hasLikertRating = hasLikertRating
        self.isFloating = isFloating
        self.isShownOnScroll = isShownOnScroll

        // 6. Analytics & Tracking
        self.matomoStatus = matomoStatus
        self.contentTracker = contentTracker
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
            cookieName: self.cookieName,
            question: self.question,
            tooltip: self.tooltip,
            positiveFollowUpQuestion: self.positiveFollowUpQuestion,
            negativeFollowUpQuestion: self.negativeFollowUpQuestion,
            toastErrorTitle: self.toastErrorTitle,
            toastErrorText: self.toastErrorText,
            ratingType: self.ratingType,
            categoryOptions: self.categoryOptions,
            ErrorMessageInvalidFeedback: self.ErrorMessageInvalidFeedback,
            hasCategory: self.hasCategory,
            hasLikertRating: self.hasLikertRating,
            isFloating: f,
            isShownOnScroll: self.isShownOnScroll,
            matomoStatus: self.matomoStatus,
            contentTracker: self.contentTracker
        )
    }
}
