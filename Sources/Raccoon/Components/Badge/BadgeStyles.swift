public struct BadgeStyles {

    // MARK: counter
    public static let counterBorderColor: String =
        "border-on-surface-bright"
    public static let counterTextColor: String =
        "text-on-surface-bright"

    // MARK: icon '#'
    public static let iconBorder: String =
        "border border-on-surface-bright"

    // MARK: label
    public static let labelText: String =
        "text-on-surface-bright"

    // MARK: font
    public static let font: String = [
        CommonStyles.fontSans,
        CommonStyles.fontWeightNormal,
    ]
    .joined(separator: " ")

    public static let fontSans: String = CommonStyles.fontSans

    // MARK: text
    public static let textSize: String = [
        CommonStyles.textSizeSmall,
        "lg:text-base",
    ]
    .joined(separator: " ")

    // MARK: hover
    public static let hoverDefault: String = CommonStyles.hoverDefault

    // MARK: focus
    public static let focusReset: String = CommonStyles.focusReset
    public static let focusDefault: String = CommonStyles.focusDefault

    // MARK: cursor
    public static let cursorPointer: String = CommonStyles.cursorPointer
}
