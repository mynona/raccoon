public struct ReferencesStyles {

    // MARK: font
    public static let fontWeightBold: String = CommonStyles.fontWeightBold

    // MAK: references
    public static let references: String = [
        CommonStyles.fontSans,
        CommonStyles.textColorDefault,
        "dark:print:prose-strong:!text-black prose-sm sm:prose-base xl:prose-lg",
    ]
    .joined(separator: " ")

    public static let referencesContainer: String = [
        CommonStyles.cornerRadiusMedium,
        "max-w-none bg-overlay-hover print:!bg-white print:text-print",
    ]
    .joined(separator: " ")

    // MARK: prose
    public static let prose: String = CommonStyles.prose

}
