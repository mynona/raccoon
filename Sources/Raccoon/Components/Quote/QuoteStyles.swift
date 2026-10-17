public struct QuoteStyles {

    // MARK: quote
    public static let quote: String = [
        CommonStyles.fontSerif,
        CommonStyles.textColorSuccess,
        CommonStyles.textSizeExtraLarge,
        "md:text-3xl lg:text-4xl",
    ]
    .joined(separator: " ")

    // MARK: citation
    public static let citation: String = [
        CommonStyles.fontSans,
        CommonStyles.fontWeightSemibold,
        CommonStyles.textSizeSmall,
        CommonStyles.textColorSuccess,
    ]
    .joined(separator: " ")

    // MARK: container
    public static let container: String =
        "border-l-4 border-on-theme"
}
