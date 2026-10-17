public struct SimpleTableStyles {
    public static let indicatorHover: String =
        "hover:bg-tertiary dark:hover:bg-on-surface/10"
    public static let columnSelectorBackground: String =
        "bg-white dark:bg-surface-dark shadow-lg border border-gray-200 dark:border-surface-dark rounded"
    public static let columnSelectorTitle: String = [
        CommonStyles.fontWeightSemibold,
        textColorNeutral,
    ]
    .joined(separator: " ")
    public static let columnSelectorOption: String = textColorNeutral

    // MARK: textColor
    public static let textColorNeutral: String = "text-black dark:text-gray-400"
    public static let emptyStateTextColor: String =
        "text-gray-500 dark:text-gray-400"

    // MARK: drag and drop
    public static let dropIndicatorColor: String =
        "bg-primary"

    // MARK: background
    public static let backgroundTransparent: String = CommonStyles
        .backgroundTransparent

    // MARK: cursor
    public static let cursorGrab: String = CommonStyles.cursorGrab

    // MARK: focus
    public static let focusDefault: String = CommonStyles.focusDefault

    // MARK: hover
    public static let hoverDefault: String = CommonStyles.hoverDefault
}
