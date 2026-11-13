public struct MultiSelectStyles {

    public static let textColorDisabled = CommonStyles.textColorDisabled
    public static let iconColorDropdown = CommonStyles.textColorDefault
    public static let borderColorDisabled = CommonStyles.borderColorDisabled
    public static let infoTextColor = CommonStyles.textColorDefault
    public static let infoBorder = "border-b border-gray-300 border-gray-400"
    // Option values
    public static let optionInfo: String = [
        CommonStyles.backgroundLight,
        CommonStyles.textSizeTiny,
        "rounded text-gray-700 dark:text-gray-700"
    ].joined(separator: " ")
    public static let optionSelected = [
        CommonStyles.cornerRadiusTiny,
        CommonStyles.textSizeTiny,
        "bg-tertiary text-on-surface"
    ].joined(separator: " ")


    public static let optionContainer: String = [
        CommonStyles.cornerRadiusTiny,
        CommonStyles.backgroundLight,
        "shadow-none ring-0 border-0 focus:ring-0 focus:outline-hidden focus-within:outline-hidden focus-visible:outline-hidden ring-1 ring-gray-300 print:bg-white dark:ring-gray-400"
    ].joined(separator: " ")

    // MARK: background
    public static let backgroundTransparent: String = CommonStyles
        .backgroundTransparent

    // MARK: option list — shared with SingleSelect
    public static let optionSelectedIcon: String = SingleSelectStyles
        .optionSelectedIcon
    public static let optionTextSize: String = SingleSelectStyles.optionTextSize
    public static let optionListDivide: String = SingleSelectStyles
        .optionListDivide
    public static let emptyStateTextColor: String = SingleSelectStyles
        .emptyStateTextColor
    public static let selectionBorderColor: String = "border-gray-300"
}
