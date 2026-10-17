public struct DefinitionStyles {
    public static let icon: String = CommonStyles.textColorEmphasized
    public static let term: String = [
        CommonStyles.fontSans,
        CommonStyles.textSizeLarge,
        "sm:text-xl xl:text-2xl",
        CommonStyles.textColorEmphasized,
        CommonStyles.proseNon
    ].joined(separator: " ")

    public static let container: String =
        "bg-black/5 dark:bg-white/5"

    // MARK: CommonStyles
    public static let prose = CommonStyles.prose
}
