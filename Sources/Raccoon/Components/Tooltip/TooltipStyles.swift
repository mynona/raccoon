public struct TooltipStyles {

    // MARK: font
    public static let font: String = CommonStyles.fontWeightMedium

    // MARK: text
    public static let text: String = [
        CommonStyles.textNoWrap,
        CommonStyles.textSizeTiny,
        CommonStyles.textColorInverse,
    ]
    .joined(separator: " ")

    // MARK: cornerRadius
    public static let cornerRadius: String = CommonStyles.cornerRadiusTiny

    // MARK: background
    public static let backgroundColor: String = CommonStyles.backgroundInverse

}
