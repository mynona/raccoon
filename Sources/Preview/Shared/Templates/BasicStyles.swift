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

    // MARK: - Top Bar (Header)
    public static let banner: String = [
        "flex-initial sticky top-0 print:hidden shadow-2xs z-20",
        CommonStyles.backgroundLight,
    ]
    .joined(separator: " ")

    public static let headerContainer: String = "pr-4 pl-4 lg:pl-80"

    public static let headerContent: String = [
        "pt-3 pb-3 md:pt-4 md:pb-4 xl:pt-6 xl:pb-6 border-b-2",
        CommonStyles.borderColorTheme,
    ]
    .joined(separator: " ")

    public static let headerRow: String = "flex items-center justify-between w-full"

    public static let topBarControls: String =
        "flex-initial flex items-center gap-x-4 topbar-sidebar-padding"

    public static let topBarRight: String =
        "flex-initial flex items-center"

    public static let burgerButton: String = [
        ActionButtonStyles.iconButton,
        "-mt-1 md:mt-0 lg:hidden",
    ]
    .joined(separator: " ")

    // MARK: - Mobile Drawer
    public static let mobileContainer: String =
        "fixed inset-0 h-screen lg:hidden z-30"

    public static let mobileDialog: String = [
        "absolute h-screen flex flex-col top-0 left-0 w-11/12 md:w-80 z-20",
        CommonStyles.backgroundLight,
    ]
    .joined(separator: " ")

    public static let mobileScrollArea: String =
        "flex-1 overflow-y-auto overscroll-contain top-0 shadow-2xl"

    public static let mobileContentWrapper: String = "p-4 xl:pt-6"

    public static let stickyCloseButtonWrapper: String = [
        "sticky top-0 z-30 pb-6",
        CommonStyles.backgroundLight,
    ]
    .joined(separator: " ")

    public static let closeButton: String = [
        ActionButtonStyles.iconButton,
        "-mt-1 md:mt-2.5",
    ]
    .joined(separator: " ")

    // MARK: - Desktop Sidebar
    public static let desktopSidebar: String = [
        "hidden lg:fixed lg:inset-y-0 lg:z-20 lg:flex lg:w-80 lg:flex-col border-r",
        CommonStyles.borderColorDefault,
    ]
    .joined(separator: " ")

    public static let desktopSidebarContent: String = [
        "flex-1 overflow-y-auto overscroll-contain top-0 p-4 xl:pt-6 shadow-xl",
        CommonStyles.backgroundLight,
    ]
    .joined(separator: " ")

    public static let sidebarBodyContent: String = "flex flex-col"

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

    public static let sidebarNav: String = "flex-1 space-y-6"

    public static let groupTitle: String = [
        "px-2 mb-3 text-xs font-bold uppercase tracking-wider",
        CommonStyles.textColorEmphasized,
    ]
    .joined(separator: " ")

    public static let subGroupTitle: String = [
        "px-2 mb-2 text-xs font-semibold uppercase tracking-wider",
        CommonStyles.textColorDefault,
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
    public static let main: String = "lg:pl-80 w-full min-w-0"

    public static let mainNoPadding: String = "lg:pl-80 w-full min-w-0"

    public static let contentContainer: String =
        "p-6 md:p-8 lg:p-10 max-w-6xl mx-auto"
}
