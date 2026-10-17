public struct LabelData: Sendable {

    public enum Position: Sendable {
        case left
        case right
    }

    public let id: String
    public let title: String?
    public let position: Position?
    public let size: ComponentSize
    public let isRequired: Bool
    public let isDisabled: Bool
    // Important: If you want to replace only the label text you must provide the value as 'newLabelText', otherwise it executes a function
    public let xhtml: String?

    /// Creates a new configuration instance for `Label`.
    ///
    /// - Parameters:
    ///   - id: Identifier referencing the associated form control (`for` attribute).
    ///   - title: Visible label text.
    ///   - position: Layout position (`left` or `right`).
    ///   - size: Text size of the label.
    ///   - isRequired: Whether to display a required field indicator.
    ///   - isDisabled: Whether the label reflects a disabled form control state.
    ///   - xhtml: Optional raw HTML string or dynamic Alpine text replacement expression.
    public init(
        id: String,
        title: String? = nil,
        position: Position = .left,
        size: ComponentSize = .sm,
        isRequired: Bool = true,
        isDisabled: Bool = false,
        xhtml: String? = nil
    ) {

        self.id = id
        self.title = title
        self.position = position
        self.size = size
        self.isRequired = isRequired
        self.isDisabled = isDisabled
        self.xhtml = xhtml
    }
}
