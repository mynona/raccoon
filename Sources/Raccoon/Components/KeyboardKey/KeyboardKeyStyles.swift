public struct KeyboardKeyStyles {

    // MARK: font
    public static let font: String = [
        CommonStyles.fontMono,
        CommonStyles.fontWeightSemibold,
    ]
    .joined(separator: " ")

    // MARK: text
    public static let text: String = [
        CommonStyles.textSizeSmall,
        CommonStyles.textColorDefault,
    ]
    .joined(separator: " ")

    // MARK: background
    public static let background: String = [
        "bg-surface-alt",
        CommonStyles.cornerRadiusMedium,
    ]
    .joined(separator: " ")

    // MARK: border
    public static let border: String = [
        "border border-outline",
        CommonStyles.borderColorDefault,
    ]
    .joined(separator: " ")
}
