/// Inherits from InputFieldStyles, ActionButtonStyles
///
public struct SingleSelectStyles {
    public static let textColorDisabled = CommonStyles.textColorDisabled
    public static let borderColorDisabled = CommonStyles.borderColorDisabled
    public static let borderColorDefault = CommonStyles.inputBorder
    public static let infoTextColor = CommonStyles.textColorDefault
    public static let infoBorder = CommonStyles.inputBorder
    // OptionItems
    public static let optionItem: String = [
        CommonStyles.cornerRadiusTiny,
        CommonStyles.backgroundLight,
        ].joined(separator: " ")

    // MARK: background
    public static let backgroundTransparent: String = CommonStyles
        .backgroundTransparent

    // MARK: option list
    public static let optionSelectedIcon: String = CommonStyles.textColorSuccess
    public static let optionTextSize: String = CommonStyles.textSizeSmall
    public static let optionListDivide: String =
        "divide-outline"
    public static let emptyStateTextColor: String = CommonStyles.textColorDefault

    // MARK: hover
    public static let hoverDefault: String = CommonStyles.hoverDefault

    // MARK: focus
    public static let focusDefault: String = CommonStyles.focusDefault

}
