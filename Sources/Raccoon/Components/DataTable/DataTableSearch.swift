/// Free-text search above a `DataTable`.
///
/// The term is sent as a query parameter. Nothing is loaded while the term is shorter than `minLength`;
/// the table shows `hint` instead. An empty term resets the table to that state.
public struct DataTableSearch: Sendable {

    // MARK: - 1. Identity & Alpine Bindings
    /// Query parameter name of the search term.
    public let param: String

    // MARK: - 2. Content & Accessibility
    /// Accessible name of the search field.
    public let label: String

    /// Placeholder of the search field.
    public let placeholder: String

    /// Accessible name of the clear button.
    public let clearLabel: String

    /// Text shown instead of rows while the term is too short (`{min}`).
    public let hint: String

    // MARK: - 3. Value & Options
    /// Minimum number of characters before the backend is asked.
    public let minLength: Int

    /// Creates a search definition.
    ///
    /// - Parameters:
    ///   - param: Query parameter name of the search term.
    ///   - label: Accessible name of the search field.
    ///   - placeholder: Placeholder of the search field.
    ///   - clearLabel: Accessible name of the clear button.
    ///   - hint: Text shown while the term is too short (`{min}`).
    ///   - minLength: Minimum number of characters before the backend is asked.
    public init(
        // 1. Identity & Alpine Bindings
        param: String = "q",

        // 2. Content & Accessibility
        label: String = "Search",
        placeholder: String = "Search…",
        clearLabel: String = "Clear search",
        hint: String = "Enter at least {min} characters to start the search.",

        // 3. Value & Options
        minLength: Int = 3
    ) {
        self.param = param
        self.label = label
        self.placeholder = placeholder
        self.clearLabel = clearLabel
        self.hint = hint
        self.minLength = max(1, minLength)
    }
}
