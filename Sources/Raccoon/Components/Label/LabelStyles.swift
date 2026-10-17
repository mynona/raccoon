public struct LabelStyles {

    // MARK: font
    public static let font: String = [
        CommonStyles.fontWeightMedium,
        "tracking-wide",
    ]
    .joined(separator: " ")

    // MARK: text color
    public static let textColorDefault: String = CommonStyles.textColorDefault
    public static let textColorDisabled: String = CommonStyles.textColorDisabled

    // MARK: text size
    public static let textSizeTiny: String = CommonStyles.textSizeTiny
    public static let textSizeBase: String = CommonStyles.textSizeBase
    public static let textSizeLarge: String = CommonStyles.textSizeLarge

    // MARK: cursor
    public static let cursorNotAllowed: String = CommonStyles.cursorNotAllowed
}
