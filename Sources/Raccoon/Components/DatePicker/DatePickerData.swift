import Foundation

/// Configuration data for the `DatePicker` component.
public struct DatePickerData: Sendable {
    // MARK: - 1. Identity & Alpine Bindings

    /// Unique DOM identifier for the primary date input and hidden form field.
    public let id: String

    /// Optional DOM identifier and form field name for the range end date (defaults to `"\(id)_end"`).
    public let endId: String?

    // MARK: - 2. Content & Accessibility

    /// Optional label context displayed above the date picker.
    public let label: LabelData?

    // MARK: - 3. Value & Options

    /// Initial single date value or range start date. `nil` starts the picker without a selection (e.g. filters).
    public let value: Date?

    /// Optional range end date value when `isRange` is `true`.
    public let endValue: Date?

    /// The date format mask (`DD.MM.YYYY`, `YYYY-MM-DD`, `DD/MM/YYYY`, `MM/DD/YYYY`). Defaults to `.DD_MM_YYYY`.
    public let format: DatePickerFormat

    /// First year offered in the year selection. Defaults to 50 years before the displayed year (not before 1900).
    public let minYear: Int?

    /// Last year offered in the year selection. Defaults to 50 years after the displayed year (not after 2100).
    public let maxYear: Int?

    // MARK: - 4. Feedback & Validation

    /// Optional error message context displayed below the input.
    public let errorMessages: ErrorMessageData?

    // MARK: - 5. Presentation & State

    /// Interaction state (`enabled`, `disabled`, `info`, `hidden`). Defaults to `.enabled`.
    public let state: ComponentState

    /// Whether the date picker operates in date range selection mode. Defaults to `false`.
    public let isRange: Bool

    /// Optional background color class override.
    public let backgroundColor: String?

    /// Creates a new configuration instance for `DatePicker`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the date picker input.
    ///   - endId: Optional DOM identifier and form field name for the range end date.
    ///   - label: Optional label context displayed above the date picker.
    ///   - value: Initial date value (or range start date). `nil` starts without a selection.
    ///   - endValue: Optional range end date value.
    ///   - format: The date format mask (`DD.MM.YYYY`, `YYYY-MM-DD`, `DD/MM/YYYY`, `MM/DD/YYYY`). Defaults to `.DD_MM_YYYY`.
    ///   - minYear: First year offered in the year selection.
    ///   - maxYear: Last year offered in the year selection.
    ///   - errorMessages: Optional error message context displayed below the input.
    ///   - state: Interaction state (`enabled`, `disabled`, `info`, `hidden`). Defaults to `.enabled`.
    ///   - isRange: Whether to enable date range selection mode. Defaults to `false`.
    ///   - backgroundColor: Optional background color class override.
    public init(
        id: String,
        endId: String? = nil,
        label: LabelData? = nil,
        value: Date? = nil,
        endValue: Date? = nil,
        format: DatePickerFormat = .DD_MM_YYYY,
        minYear: Int? = nil,
        maxYear: Int? = nil,
        state: ComponentState = .enabled,
        errorMessages: ErrorMessageData? = nil,
        isRange: Bool = false,
        backgroundColor: String? = nil
    ) {
        self.id = id
        self.endId = endId
        self.label = label
        self.value = value
        self.endValue = endValue
        self.format = format
        self.minYear = minYear
        self.maxYear = maxYear
        self.state = state
        self.errorMessages = errorMessages
        self.isRange = isRange
        self.backgroundColor = backgroundColor
    }

    /// Convenience initializer maintaining exact backward compatibility with the legacy parameter order.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the date picker input.
    ///   - label: Optional label context displayed above the date picker.
    ///   - value: Initial date value.
    ///   - state: Interaction state (`enabled`, `disabled`, `info`, `hidden`).
    ///   - errorMessages: Optional error message context displayed below the input.
    ///   - backgroundColor: Optional background color class override.
    public init(
        id: String,
        label: LabelData? = nil,
        value: Date,
        state: ComponentState,
        errorMessages: ErrorMessageData? = nil,
        backgroundColor: String? = nil
    ) {
        self.init(
            id: id,
            endId: nil,
            label: label,
            value: value,
            endValue: nil,
            format: .DD_MM_YYYY,
            state: state,
            errorMessages: errorMessages,
            isRange: false,
            backgroundColor: backgroundColor
        )
    }
}
