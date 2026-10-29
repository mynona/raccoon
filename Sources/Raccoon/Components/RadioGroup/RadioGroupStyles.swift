/// Styles for `RadioGroup`.
public struct RadioGroupStyles {

    // MARK: - Layout
    public static let options = "space-y-5"
    public static let optionsAfterContent = "mt-3 space-y-5"

    // MARK: - Legend
    private static let legendBase: String = [
        "flex items-center space-x-1",
        LabelStyles.font,
    ]
    .joined(separator: " ")

    public static let legendRequired = "sr-only"

    /// Complete class set of the legend for the given size and state.
    public static func legend(size: ComponentSize, isDisabled: Bool) -> String {
        let textSize =
            switch size {
            case .sm: LabelStyles.textSizeTiny
            case .base: LabelStyles.textSizeBase
            case .xl: LabelStyles.textSizeLarge
            }
        let textColor =
            isDisabled
            ? [LabelStyles.textColorDisabled, LabelStyles.cursorNotAllowed].joined(separator: " ")
            : LabelStyles.textColorDefault
        return [legendBase, textSize, textColor].joined(separator: " ")
    }
}
