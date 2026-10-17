/// Configuration data for the `CodeBlock` component.
public struct CodeBlockData: Sendable {

    public let code: String

    /// Creates a new configuration instance for `CodeBlock`.
    ///
    /// - Parameters:
    ///   - code: Source code text to display in the formatted code block.
    public init(
        code: String
    ) {
        self.code = code
    }
}
