public struct BreadcrumbStyles {

    // MARK: container
    public static let nav: String = "w-full mt-4"

    // MARK: list (horizontal scrolling only)
    public static let list: String = [
        "relative",
        "flex flex-row items-center gap-1",
        "w-full min-h-14 py-2",
        "overflow-x-auto overflow-y-hidden",
        "overscroll-x-contain pl-2",
    ].joined(separator: " ")

    // MARK: item
    public static let item: String =
    "flex-none shrink-0 flex items-center gap-1 whitespace-nowrap"
    public static let itemCurrent: String =
    "flex-none shrink-0 whitespace-nowrap"

    public static let itemActive: String = [
        CommonStyles.fontSans,
        CommonStyles.linkDecoration,
        CommonStyles.linkDecorationWeight,
        HyperLinkStyles.hover,
        HyperLinkStyles.visited,
        HyperLinkStyles.active,
        CommonStyles.focusDefault,
        "focus-within:!no-underline focus:!no-underline focus:rounded",
    ].joined(separator: " ")

    public static let itemSeparatorColor: String = CommonStyles.textColorDefault

    // MARK: current
    public static let itemCurrentText: String = [
        CommonStyles.fontSans,
        CommonStyles.fontWeightBold,
        CommonStyles.textColorSuccess,
        CommonStyles.textNoWrap,
    ].joined(separator: " ")

}
