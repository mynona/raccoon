public struct GlossaryStyles {

    // MARK: - Search Text Styles
    public static let textColorIcon: String = SearchFieldStyles.textColorIcon
    public static let textColorInput: String = SearchFieldStyles.textColorInput
    public static let textColorNoResults: String = SearchFieldStyles
        .textColorNoResults

    // MARK: - Search Container Styling
    public static let searchContainerPadding: String = SearchFieldStyles
        .searchContainerPadding
    public static let searchContainerBorderColor: String = SearchFieldStyles
        .searchContainerBorderColor
    public static let searchContainerBorder: String = SearchFieldStyles
        .searchContainerBorder
    public static let searchContainerFocus: String = SearchFieldStyles
        .searchContainerFocus
    public static let searchContainerHover: String = SearchFieldStyles
        .searchContainerHover

    // MARK: - Clear Button
    public static let actionButton: String = SearchFieldStyles.actionButton

    // MARK: - Section Header (Alphabet Register)
    public static let sectionTitle: String = [
        CommonStyles.fontMono,
        CommonStyles.fontWeightBold,
        CommonStyles.textSizeExtraLarge,
        CommonStyles.textColorDefault,
    ]
    .joined(separator: " ")

    public static let sectionHeaderContainer: String =
        "pt-8"

    // MARK: - No Results Container
    public static let noResultsContainer: String = [
        "py-8",
        CommonStyles.textSizeBase,
    ]
    .joined(separator: " ")
}
