public struct DeleteModalStyles {
    public static let textColor: String = CommonStyles.textColorEmphasized


    //    "text-gray-950 dark:text-gray-200 print:text-black"
    public static let emphasisFont: String = CommonStyles.fontWeightSemibold
    public static let backdrop: String = [
        "fixed inset-0",
        CommonStyles.backdropColor,
        "z-9 backdrop-blur-sm",
    ]
    .joined(separator: " ")
}
