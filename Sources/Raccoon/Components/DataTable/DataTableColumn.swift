/// Sort direction of a `DataTable`.
public enum DataTableSortDirection: String, Sendable {
    case ascending = "asc"
    case descending = "desc"
}

/// Initial sort state of a `DataTable`.
public struct DataTableSort: Sendable {

    /// Key of the column to sort by.
    public let key: String

    /// Sort direction.
    public let direction: DataTableSortDirection

    /// Creates a sort state.
    ///
    /// - Parameters:
    ///   - key: Key of the column to sort by.
    ///   - direction: Sort direction.
    public init(key: String, direction: DataTableSortDirection = .ascending) {
        self.key = key
        self.direction = direction
    }
}

/// Column of a `DataTable`.
public struct DataTableColumn: Sendable {

    // MARK: - 1. Identity & Alpine Bindings
    /// JSON property of the row. Also used as sort and filter field name.
    public let key: String

    // MARK: - 2. Content & Accessibility
    /// Header text.
    public let label: String

    // MARK: - 3. Value & Options
    /// How the cell is rendered.
    public let cellType: DataTableCellType

    /// Filter definition. Required for `hasFiltering`.
    public let filter: DataTableFilter?

    // MARK: - 5. Presentation & State
    /// Horizontal alignment. Defaults to right for numbers and left otherwise.
    public let align: DataTableAlign

    /// Whether the column can be sorted. Sorting happens on the backend.
    public let hasSorting: Bool

    /// Whether the column can be filtered. Only `true` when a `filter` is defined.
    public let hasFiltering: Bool

    /// Whether the column can be hidden in the column configurator.
    public let isHideable: Bool

    /// Whether the column is visible until the user hides it.
    public let isVisibleByDefault: Bool

    /// Creates a column.
    ///
    /// - Parameters:
    ///   - key: JSON property of the row, also sort and filter field name.
    ///   - label: Header text.
    ///   - cellType: How the cell is rendered.
    ///   - filter: Filter definition.
    ///   - align: Horizontal alignment. Defaults to right for numbers and left otherwise.
    ///   - hasSorting: Whether the column can be sorted.
    ///   - hasFiltering: Whether the column can be filtered. Ignored (`false`) without a `filter`.
    ///   - isHideable: Whether the column can be hidden.
    ///   - isVisibleByDefault: Whether the column is visible until the user hides it.
    public init(
        // 1. Identity & Alpine Bindings
        key: String,

        // 2. Content & Accessibility
        label: String,

        // 3. Value & Options
        cellType: DataTableCellType = .text,
        filter: DataTableFilter? = nil,

        // 5. Presentation & State
        align: DataTableAlign? = nil,
        hasSorting: Bool = false,
        hasFiltering: Bool = true,
        isHideable: Bool = true,
        isVisibleByDefault: Bool = true
    ) {
        // 1. Identity & Alpine Bindings
        self.key = key

        // 2. Content & Accessibility
        self.label = label

        // 3. Value & Options
        self.cellType = cellType
        self.filter = filter

        // 5. Presentation & State
        switch cellType {
        case .integer, .double: self.align = align ?? .right
        default: self.align = align ?? .left
        }
        self.hasSorting = hasSorting
        self.hasFiltering = hasFiltering && filter != nil
        self.isHideable = isHideable
        self.isVisibleByDefault = isVisibleByDefault
    }
}
