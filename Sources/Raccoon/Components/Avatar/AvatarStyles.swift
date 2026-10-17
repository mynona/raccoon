public struct AvatarStyles {

    // MARK: image avatar
    public static let imageBorder: String =
        "border-2 border-on-theme"

    // MARK: text avatar with initials
    public static let initialsBorder: String =
        "border-2 border-on-theme"
    public static let initialsFont: String = [
        CommonStyles.fontWeightNormal,
        "tracking-wider",
    ]
    .joined(separator: " ")
    public static let initialsText: String = CommonStyles.textColorEmphasized

    // MARK: text size
    public static let textSizeBase = CommonStyles.textSizeBase
    public static let textSizeSmall = CommonStyles.textSizeSmall
    public static let textSizeLarge = CommonStyles.textSizeLarge
}
