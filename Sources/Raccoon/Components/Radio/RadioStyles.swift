/// Styles for `Radio`. Mirrors the look of `CheckStyles` with a round control.
public struct RadioStyles {

    // MARK: - Layout
    public static let container = "relative flex items-start"
    public static let inputWrapper = "flex h-6 items-center"
    public static let labelWrapper = "ml-3"

    // MARK: - Input
    private static let input =
        "radio-input h-4 w-4 text-primary-dim disabled:text-on-disabled print:text-print"

    public static let inputEnabled: String = [
        input,
        CommonStyles.focusDefaultRadio,
        CommonStyles.hoverDefaultRadio,
    ]
    .joined(separator: " ")

    public static let inputDisabled: String = [
        input,
        CommonStyles.cursorNotAllowed,
    ]
    .joined(separator: " ")

    // MARK: - Label
    public static let labelEnabled: String = [
        CheckStyles.textFontDefault,
        CheckStyles.textColorLabel,
    ]
    .joined(separator: " ")

    public static let labelDisabled: String = [
        CheckStyles.textFontDefault,
        CheckStyles.textColorLabelDisabled,
        CommonStyles.cursorNotAllowed,
    ]
    .joined(separator: " ")
}
