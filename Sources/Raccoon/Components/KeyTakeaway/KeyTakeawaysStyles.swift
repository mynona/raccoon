public struct KeyTakeawaysStyles {

    // MARK: icon
    public static let iconColor: String = CommonStyles.textColorEmphasized

    // MARK: label
    public static let textLabel: String = [
        "!no-underline text-on-surface-bright ",
        CommonStyles.fontSans,
        CommonStyles.textSizeLarge,
        "sm:text-xl xl:text-2xl",
        CommonStyles.textColorEmphasized,
    ]
    .joined(separator: " ")

    // MARK: container
    public static let container: String =
        "border-l-4 border-primary"

    // MARK: prose
    public static let prose = CommonStyles.prose
}
