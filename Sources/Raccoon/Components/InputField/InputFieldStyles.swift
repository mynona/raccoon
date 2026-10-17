public struct InputFieldStyles {
    public static let inputReset: String = CommonStyles.inputReset
    public static let inputBorder: String = CommonStyles.inputBorder
    public static let inputContainerBorder: String = CommonStyles.inputBorder
    public static let inputContainerHover: String = CommonStyles.hoverDefault
    public static let inputContainerFocus: String = CommonStyles.focusDefault
    public static let fontMono: String = CommonStyles.fontMono
    public static let fontSans: String = CommonStyles.fontSans

    public static let textSizeSmall: String = [
        CommonStyles.textSizeSmall,
        "leading-6",
    ]
    .joined(separator: " ")

    // Same size without the line-height, for validation messages.
    public static let errorTextSize: String = CommonStyles.textSizeSmall

    public static let textColorDefault: String = CommonStyles.textColorDefault
    public static let textColorInput: String = CommonStyles.textColorInput
    public static let textColorPlaceholder: String = CommonStyles
        .textColorPlaceholder
    public static let textColorError: String = CommonStyles.textColorError
    public static let textColorSuccess: String = CommonStyles.textColorSuccess
    public static let borderColorDefault: String = CommonStyles
        .borderColorDefault
    public static let borderColorError: String = CommonStyles.borderColorError
    public static let borderColorSuccess: String = CommonStyles
        .borderColorSuccess

    public static let cursorPointer = CommonStyles.cursorPointer
    public static let cursorNotAllowed = CommonStyles.cursorNotAllowed
}
