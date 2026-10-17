import Foundation

/// Configuration data for the `DatePicker` component.
public struct DatePickerData: Sendable {
    // MARK: - 1. Identity & Alpine Bindings
    public let id: String

    // MARK: - 2. Content & Accessibility
    public let label: LabelData?

    // MARK: - 3. Value & Options
    public let value: Date
    public let format: DatePickerFormat

    // MARK: - 4. Feedback & Validation
    public let errorMessages: ErrorMessageData?

    // MARK: - 5. Presentation & State
    public let state: ComponentState
    public let backgroundColor: String?

    /// Creates a new configuration instance for `DatePicker`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the date picker input.
    ///   - label: Optional label context displayed above the date picker.
    ///   - value: Initial date value.
    ///   - format: The date format mask (`DD.MM.YYYY`, `YYYY-MM-DD`, `DD/MM/YYYY`, `MM/DD/YYYY`). Defaults to `.DD_MM_YYYY`.
    ///   - state: Interaction state (`enabled`, `disabled`, `info`, `hidden`). Defaults to `.enabled`.
    ///   - errorMessages: Optional error message context displayed below the input.
    ///   - backgroundColor: Optional background color class override.
    public init(
        id: String,
        label: LabelData? = nil,
        value: Date,
        format: DatePickerFormat = .DD_MM_YYYY,
        state: ComponentState = .enabled,
        errorMessages: ErrorMessageData? = nil,
        backgroundColor: String? = nil
    ) {
        self.id = id
        self.label = label
        self.value = value
        self.format = format
        self.state = state
        self.errorMessages = errorMessages
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
            label: label,
            value: value,
            format: .DD_MM_YYYY,
            state: state,
            errorMessages: errorMessages,
            backgroundColor: backgroundColor
        )
    }
}
