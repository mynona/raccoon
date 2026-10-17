public struct SingleFileUploadStyles {
    public static let dragAndDropContainer: String = [
        CommonStyles.inputBorder,
        CommonStyles.hoverDefault,
        CommonStyles.focusDefault
    ].joined(separator: " ")


    /*
        "ring ring-1 ring-gray-400 hover:ring-2 hover:ring-hoverring focus-within:ring-2 focus-within:ring-focusring dark:ring-gray-400 dark:hover:ring-white dark:focus-within:ring-white"
*/
    public static let containerFont: String = [
        CommonStyles.fontSans,
        CommonStyles.fontWeightNormal,
    ]
    .joined(separator: " ")

    public static let textColorDefault: String = CommonStyles.textColorDefault
}
