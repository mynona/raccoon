/// Inherits ActionButtonStyles
///
public struct CarouselStyles {

    // MARK: keyboard keys
    public static let textColorKeyboardKeys: String = CommonStyles
        .textColorPlaceholder

    // MARK: caption
    public static let textColorCaption: String = [
        CommonStyles.textColorEmphasized,
        "md:text-base"
    ].joined(separator: " ")

    // MARK: indicator dots
    public static let backgroundColorIndicators: String =
        "bg-gray-600 dark:bg-gray-300"

    // MARK: carousel
    public static let carouselBackdrop: String = "bg-gray-200 dark:bg-black/90"

    // MARK: override icon button background color to inject bg-color
    public static let backgroundColorIcon = [
        ActionButtonStyles.backgroundColorIcon,
        "bg-white dark:bg-black",
    ]
    .joined(separator: " ")

    // MARK: cursor
    public static let cursorPointer = CommonStyles.cursorPointer

}
