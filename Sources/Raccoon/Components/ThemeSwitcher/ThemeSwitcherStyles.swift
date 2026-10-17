import Foundation

/// ThemeSwitcherStyles
///
/// Encapsulates all styling classes and design tokens for `ThemeSwitcher`.
public struct ThemeSwitcherStyles {

    // MARK: - Button
    public static let button: String = ActionButtonStyles.iconButton

    // MARK: - Container
    public static let container: String = "relative inline-block text-left m-0"

    // MARK: - Dropdown Panel
    public static let dropdownPanel: String = [
        "absolute left-0 mt-2 w-48 z-50 p-1 border shadow-md",
        CommonStyles.cornerRadiusMedium,
        CommonStyles.backgroundLight,
        CommonStyles.borderColorDefault,
    ]
    .joined(separator: " ")

    public static let dropdownPanelRight: String = [
        "absolute right-0 mt-2 w-48 z-50 p-1 border",
        CommonStyles.cornerRadiusMedium,
        CommonStyles.backgroundLight,
        CommonStyles.borderColorDefault,
    ]
    .joined(separator: " ")

    // MARK: - Menu List
    public static let menuList: String = "list-none m-0 p-2"

    // MARK: - Menu Item
    public static let menuItem: String = [
        "flex items-center justify-between w-full px-3 py-1 text-left transition-colors",
        CommonStyles.cursorPointer,
        CommonStyles.cornerRadiusMedium,
        CommonStyles.fontSans,
        CommonStyles.textSizeSmall,
        CommonStyles.textColorDefault,
    ]
    .joined(separator: " ")

    // MARK: - Active Checkmark Icon
    public static let activeIcon: String = [
        "shrink-0 ml-2 w-4 h-4",
        CommonStyles.textColorSuccess,
    ]
    .joined(separator: " ")

    // MARK: hover
    public static let hoverDefault: String = CommonStyles.hoverDefault

    // MARK: focus
    public static let focusDefault: String = CommonStyles.focusDefault
}
