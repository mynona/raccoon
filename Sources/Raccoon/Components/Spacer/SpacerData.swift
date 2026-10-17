/// A data model representing the amount of vertical spacing to apply in a layout.
///
/// The `space` value determines the padding-bottom (`pb`) utility class used in Tailwind CSS.
/// Values typically range from 1 to 9, where each step increases the spacing.
/// This value is used by the `Spacer` component to render responsive spacing.
///
/// Example:
/// ```swift
/// let spacer = SpacerData(space: 3)
/// ```
public struct SpacerData: Sendable {

    public let space: UInt

    /// Creates a new configuration instance for `Spacer`.
    ///
    /// - Parameters:
    ///   - space: Vertical spacing unit value (typically 1–9) for padding-bottom utility styling.
    public init(
        space: UInt
    ) {
        self.space = space
    }
}
