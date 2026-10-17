public struct ToggleSwitchStyles {

    public static let cornerRadiusFull = CommonStyles.cornerRadiusFull

    // MARK: label
    public static let label: String = [
        CommonStyles.fontSans,
        CommonStyles.fontWeightMedium,
        CommonStyles.textColorDefault,
        "tracking-wide",
    ]
    .joined(separator: " ")

    // MARK: checkbox
    public static let toggleChecked: String = "bg-on-success"
    public static let toggleUnchecked: String = "bg-gray-300 dark:bg-gray-500"
    public static let toggleKnob: String = [
        CommonStyles.backgroundLight,
        cornerRadiusFull,
        "transition"
    ].joined(separator: " ")


    // MARK: textSize
    public static let textSizeSmall = CommonStyles.textSizeSmall
    public static let textSizeBase = CommonStyles.textSizeBase
    public static let textSizeLarge = CommonStyles.textSizeLarge

    // MARK: cursor
    public static let cursorPointer: String = CommonStyles.cursorPointer
    public static let cursorNotAllowed: String = CommonStyles.cursorNotAllowed

    // MARK: hover
    public static let hoverDefault: String = CommonStyles.hoverDefault

    // MARK: focus
    public static let focusDefault: String = CommonStyles.focusDefault

}
