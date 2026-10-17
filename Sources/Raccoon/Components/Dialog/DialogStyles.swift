public struct DialogStyles {
    public static let title: String = [
        CommonStyles.fontSerif,
        CommonStyles.fontWeightSemibold,
        "text-left text-3xl pb-4 mr-8"
    ].joined(separator: " ")

    public static let textFont: String = CommonStyles.fontSans
    public static let textColor: String = CommonStyles.textColorDefault
    public static let backgroundShadow: String = ""  // shadow-lg dark:shadow-none"
    public static let backgroundMargin: String = "mx-4 my-8"
    public static let backgroundPadding: String = "p-6"
    public static let backgroundRadius: String = CommonStyles.cornerRadiusLarge
    public static let backgroundColorDefault: String = CommonStyles
        .backgroundLight
    public static let backgroundBorderDefault: String = CommonStyles.inputBorder
    public static let backgroundColorDisabled: String =
        "bg-disabled print:bg-white"
    public static let backgroundBorderDisabled: String =
        "border border-disabled dark:border-0"
    public static let backgroundColorWarning: String =
        "bg-gray-50 dark:bg-gray-950"
    public static let backgroundBorderWarning: String = "border-0"
    public static let hover: String = CommonStyles.hoverDefault
    public static let focus: String = CommonStyles.focusDefault
    public static let closeButtonAbsolutePosition: String =
        "absolute right-6 top-7"
}
