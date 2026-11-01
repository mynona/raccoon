/// One selectable value of an enumeration filter.
public struct DataTableFilterOption: Sendable {

    /// Visible text of the option.
    public let title: String

    /// Value sent to the backend.
    public let value: String

    /// Creates a filter option.
    ///
    /// - Parameters:
    ///   - title: Visible text of the option.
    ///   - value: Value sent to the backend.
    public init(title: String, value: String) {
        self.title = title
        self.value = value
    }
}

/// Comparison operator of a filter. It is fixed by the table configuration, never chosen by the user.
public enum DataTableFilterOperator: String, Sendable {
    case contains
    case eq
    case neq
    case gt
    case gte
    case lt
    case lte
    case startsWith
    case endsWith
    case between
}

/// Control style of a boolean filter.
public enum DataTableBooleanFilterStyle: Sendable {
    /// Yes / No / All dropdown (`eq true`, `eq false`, no filter).
    case dropdown
    /// Checkbox (checked = `eq true`, unchecked = no filter).
    case check
}

/// Filter definition of a column: which control is shown and how the value is sent.
public struct DataTableFilter: Sendable {

    /// Kind of filter control.
    public enum Kind: Sendable {
        case text
        case integer
        case double
        case enumeration([DataTableFilterOption])
        case boolean(DataTableBooleanFilterStyle)
        /// One date selected with a single-date `DatePicker`. Sent as `yyyy-MM-dd` with the filter operator (default `eq`).
        case date
        /// Date range selected with a range `DatePicker`. Sent as `yyyy-MM-dd,yyyy-MM-dd` with `between`.
        case dateRange
    }

    // MARK: - 2. Content & Accessibility
    /// Visible label of the filter control. Defaults to the column label.
    public let label: String?

    /// Placeholder of text and number controls.
    public let placeholder: String?

    // MARK: - 3. Value & Options
    /// Kind of filter control.
    public let kind: Kind

    /// Operator sent to the backend. `dateRange` always uses `between`.
    public let `operator`: DataTableFilterOperator

    // MARK: - 5. Presentation & State
    /// Display format of date pickers (`date` and `dateRange`). The value sent to the backend is always `yyyy-MM-dd`.
    public let dateFormat: DatePickerFormat

    /// First year offered by date pickers (`date` and `dateRange`), e.g. the year of the oldest record.
    public let minYear: Int?

    /// Last year offered by date pickers (`date` and `dateRange`), e.g. the year of the newest record.
    public let maxYear: Int?

    /// Creates a filter definition.
    ///
    /// - Parameters:
    ///   - label: Visible label of the filter control. Defaults to the column label.
    ///   - placeholder: Placeholder of text and number controls.
    ///   - kind: Kind of filter control.
    ///   - operator: Operator sent to the backend. Defaults to the usual operator of the kind.
    ///   - dateFormat: Display format of date pickers.
    ///   - minYear: First year offered by date pickers.
    ///   - maxYear: Last year offered by date pickers.
    public init(
        // 2. Content & Accessibility
        label: String? = nil,
        placeholder: String? = nil,

        // 3. Value & Options
        kind: Kind,
        operator: DataTableFilterOperator? = nil,

        // 5. Presentation & State
        dateFormat: DatePickerFormat = .DD_MM_YYYY,
        minYear: Int? = nil,
        maxYear: Int? = nil
    ) {
        // 2. Content & Accessibility
        self.label = label
        self.placeholder = placeholder

        // 3. Value & Options
        self.kind = kind
        if let `operator` {
            self.operator = `operator`
        }
        else {
            switch kind {
            case .text: self.operator = .contains
            case .dateRange: self.operator = .between
            default: self.operator = .eq
            }
        }

        // 5. Presentation & State
        self.dateFormat = dateFormat
        self.minYear = minYear
        self.maxYear = maxYear
    }
}
