import Raccoon

/// Styling for the `Basic` preview template.
/// Encapsulates all Tailwind classes and CommonStyles references.
public struct BasicStyles {

    // MARK: - HTML & Body
    public static let html: String = "h-full"

    public static let body: String = [
        "h-full min-h-screen",
        CommonStyles.backgroundLight,
        CommonStyles.textColorDefault,
        CommonStyles.fontSans,
    ]
    .joined(separator: " ")

    // MARK: - Layout
    public static let layout: String = "min-h-screen w-full flex flex-row"

    // MARK: - Sidebar
    public static let sidebar: String = [
        "w-60 shrink-0 h-screen sticky top-0",
        "flex flex-col border-r",
        CommonStyles.borderColorDefault,
        CommonStyles.backgroundLight,
    ]
    .joined(separator: " ")

    public static let sidebarHeader: String = [
        "flex items-center justify-between p-4 border-b shrink-0",
        CommonStyles.borderColorDefault,
    ]
    .joined(separator: " ")

    public static let sidebarControls: String =
        "flex items-center gap-2 shrink-0"

    public static let sidebarTitle: String = [
        "text-base font-bold tracking-tight",
        CommonStyles.textColorEmphasized,
        "hover:text-on-theme transition-colors",
    ]
    .joined(separator: " ")

    // MARK: - Search Field (SearchFieldStyles)
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
    public static let searchTextColorIcon: String = SearchFieldStyles
        .textColorIcon
    public static let searchTextColorInput: String = SearchFieldStyles
        .textColorInput
    public static let searchInputReset: String = InputFieldStyles.inputReset
    public static let searchClearButton: String = SearchFieldStyles.actionButton

    public static let sidebarNavContainer: String =
        "flex-1 flex flex-col overflow-hidden"

    public static let sidebarNav: String = [
        "flex-1 overflow-y-auto px-4 py-2 space-y-6"
    ]
    .joined(separator: " ")

    public static let groupTitle: String = [
        "px-2 mb-3 text-xs font-bold uppercase tracking-wider",
        CommonStyles.textColorEmphasized,
    ]
    .joined(separator: " ")

    public static let subGroupTitle: String = [
        "px-2 mb-2 text-xs font-semibold uppercase tracking-wider text-gray-700 dark:text-gray-300"
    ]
    .joined(separator: " ")

    public static let navSection: String = "mt-6 first:mt-2"

    // MARK: - Navigation List & Items (SimpleMenuStyles Delegation)
    public static let navList: String = "space-y-1"

    public static let navItem: String = SimpleMenuStyles.menuItem

    public static let navItemActive: String = [
        SimpleMenuStyles.menuItem,
        "font-semibold bg-tertiary dark:bg-surface-dark",
        CommonStyles.textColorSuccess,
    ]
    .joined(separator: " ")

    public static let activeIcon: String = SimpleMenuStyles.activeIcon

    // MARK: - Main
    public static let main: String = [
        "flex-1 w-full min-w-0 p-6 md:p-8 lg:p-10 overflow-y-auto"
    ]
    .joined(separator: " ")

    public static let contentContainer: String = "max-w-6xl mx-auto"
}
