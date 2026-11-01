/// Configuration data for a group of form fields rendered as `<fieldset>` with a `<legend>`.
public struct FormGroupData: Sendable {

    // MARK: - 1. Identity & Alpine Bindings
    public let id: String?

    // MARK: - 2. Content & Accessibility
    public let legend: LocalizedText

    // MARK: - 3. Value & Options
    public let fields: [FormField]

    // MARK: - 5. Presentation & State
    public let isLegendVisible: Bool

    /// Creates a new configuration instance for a group of form fields.
    ///
    /// - Parameters:
    ///   - id: Optional DOM identifier of the `<fieldset>`.
    ///   - legend: Title of the group. Always present in the DOM so assistive technology can announce it.
    ///   - fields: Fields of the group, rendered in the given order.
    ///   - isLegendVisible: Whether the legend is shown. When `false` it is only available to screen readers.
    public init(
        // 1. Identity & Alpine Bindings
        id: String? = nil,

        // 2. Content & Accessibility
        legend: LocalizedText,

        // 3. Value & Options
        fields: [FormField],

        // 5. Presentation & State
        isLegendVisible: Bool = false
    ) {
        // 1. Identity & Alpine Bindings
        self.id = id

        // 2. Content & Accessibility
        self.legend = legend

        // 3. Value & Options
        self.fields = fields

        // 5. Presentation & State
        self.isLegendVisible = isLegendVisible
    }
}
