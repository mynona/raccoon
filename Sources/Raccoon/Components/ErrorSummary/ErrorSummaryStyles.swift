public struct ErrorSummaryStyles {

    // MARK: container
    // The container is focusable (`tabindex="-1"`) so a failed submit can move focus to it and a
    // screen reader reads the list. It shows no focus ring itself: the links in the list do.
    public static let summary: String = [
        "flex flex-col gap-2 p-4 focus:outline-none",
        NotificationStyles.borderError,
        NotificationStyles.backgroundColorError,
        NotificationStyles.textError,
    ]
    .joined(separator: " ")

    // MARK: heading
    public static let heading: String = [
        CommonStyles.textSizeBase,
        NotificationStyles.titleFont,
    ]
    .joined(separator: " ")

    // MARK: list
    public static let list: String = "flex flex-col gap-1 m-0 p-0 list-none"
    public static let item: String = "flex items-start gap-2"

    // MARK: link
    // Underlined, so the link is not recognised by colour alone.
    public static let link: String = [
        "underline",
        ErrorMessageStyles.textSizeSmall,
        CommonStyles.cursorPointer,
        CommonStyles.focusDefault,
    ]
    .joined(separator: " ")
}
