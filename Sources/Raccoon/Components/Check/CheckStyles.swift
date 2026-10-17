public struct CheckStyles {

    public static let textFontDefault = [
        CommonStyles.fontWeightNormal,
        CommonStyles.textSizeSmall,
        "leading-6",
    ]
    .joined(separator: " ")
    public static let textColorLabelDisabled = CommonStyles.textColorDisabled
    public static let textColorCheckbox =
        "text-primary-dim accent-white dark:accent-black disabled:text-on-disabled print:text-black"

    // MARK: CommonStyles
    public static let textColorLabel = CommonStyles.textColorDefault
    public static let focusDefault = CommonStyles.focusDefaultCheckbox
    public static let hoverDefault = CommonStyles.hoverDefaultCheckbox

}
