import HTML

/// Configuration data for the `FormBuilder` component.
public struct FormBuilderData: Sendable {

    // MARK: - 1. Identity & Alpine Bindings
    public let id: String
    public let action: String?
    public let method: HTML.MethodAttributeValue

    // MARK: - 2. Content & Accessibility
    public let ariaLabel: LocalizedText?

    // MARK: - 3. Value & Options
    public let csrfToken: String?
    public let fields: [FormField]
    public let actions: [FormAction]

    // MARK: - 4. Feedback & Validation
    public let errorMessages: ErrorMessageData?
    public let validationMethod: FormValidationMethod

    // MARK: - 5. Presentation & State
    public let layout: FormLayout

    // MARK: - 6. Analytics & Tracking
    public let isTracked: Bool

    /// Creates a new configuration instance for `FormBuilder`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier. Also used as form `name` and as Matomo form name.
    ///   - action: Target URL. When `nil` the form is submitted to the current URL.
    ///   - method: HTTP method of the form (`get` or `post`).
    ///   - ariaLabel: Accessible name of the form for screen readers.
    ///   - csrfToken: CSRF token. When set, a hidden `X-CSRF-Token` field is added.
    ///   - fields: Fields rendered in the given order.
    ///   - actions: Buttons and links shown below the fields, in the given order.
    ///   - errorMessages: Form-level errors shown above the fields, for example a failed login.
    ///   - validationMethod: How problems with the fields are reported. `.none` (default) adds nothing.
    ///     `.errorSummary` renders a summary of every field-level and form-level error above the first
    ///     field and moves focus to it on a failed submit. Form-level errors are folded into the summary
    ///     instead of the separate error block. `.submit` renders no summary: the submit button is
    ///     `aria-disabled` while a field has a client-side error.
    ///   - layout: Context of the form (`page` or `dialog`).
    ///   - isTracked: Whether the form is tracked as a form in Matomo (`data-matomo-name`).
    public init(
        // 1. Identity & Alpine Bindings
        id: String,
        action: String? = nil,
        method: HTML.MethodAttributeValue = .post,

        // 2. Content & Accessibility
        ariaLabel: LocalizedText? = nil,

        // 3. Value & Options
        csrfToken: String? = nil,
        fields: [FormField] = [],
        actions: [FormAction] = [],

        // 4. Feedback & Validation
        errorMessages: ErrorMessageData? = nil,
        validationMethod: FormValidationMethod = .none,

        // 5. Presentation & State
        layout: FormLayout = .page,

        // 6. Analytics & Tracking
        isTracked: Bool = true
    ) {
        // 1. Identity & Alpine Bindings
        self.id = id
        self.action = action
        self.method = method

        // 2. Content & Accessibility
        self.ariaLabel = ariaLabel

        // 3. Value & Options
        self.csrfToken = csrfToken
        self.fields = fields
        self.actions = actions

        // 4. Feedback & Validation
        self.errorMessages = errorMessages
        self.validationMethod = validationMethod

        // 5. Presentation & State
        self.layout = layout

        // 6. Analytics & Tracking
        self.isTracked = isTracked
    }
}
