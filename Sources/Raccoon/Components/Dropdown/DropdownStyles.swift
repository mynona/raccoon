import Foundation

/// Styles for `Dropdown`.
/// Follows `SimpleMenuStyles` floating panel design while providing form-field trigger styling.
public struct DropdownStyles {

    // MARK: - Container
    public static let container: String = "relative w-full text-left m-0"

    // MARK: - Trigger Button
    public static let triggerButton: String = [
        "flex items-center justify-between w-full rounded-md px-3 py-2 text-sm text-left transition-colors",
        CommonStyles.cursorPointer,
        CommonStyles.inputBorder,
        CommonStyles.textColorDefault,
        CommonStyles.backgroundLight,
        CommonStyles.focusDefault,
    ]
    .joined(separator: " ")

    public static let triggerButtonDisabled: String = [
        "flex items-center justify-between w-full rounded-md px-3 py-2 text-sm text-left cursor-not-allowed opacity-50",
        CommonStyles.inputBorder,
        CommonStyles.textColorDisabled,
        CommonStyles.backgroundLight,
    ]
    .joined(separator: " ")

    // MARK: - Trigger Icon (same colour as the SearchField icon)
    public static let triggerGap: String = "gap-2"
    public static let triggerContent: String = "flex items-center gap-2"
    public static let triggerIcon: String = SearchFieldStyles.textColorIcon

    // MARK: - Dropdown Panel
    public static let dropdownPanel: String = [
        "absolute left-0 mt-2 w-full z-50 p-1 border shadow-md",
        CommonStyles.cornerRadiusMedium,
        CommonStyles.backgroundLight,
        CommonStyles.borderColorDefault,
    ]
    .joined(separator: " ")

    // MARK: - Menu List
    public static let menuList: String = SimpleMenuStyles.menuList

    // MARK: - Menu Item
    public static let menuItem: String = SimpleMenuStyles.menuItem

    // MARK: - Active Checkmark Icon
    public static let activeIcon: String = SimpleMenuStyles.activeIcon

    // MARK: - Info Display
    public static let infoBorder: String = SingleSelectStyles.infoBorder
    public static let infoTextColor: String = SingleSelectStyles.infoTextColor

    // MARK: - Interaction States
    public static let hoverDefault: String = CommonStyles.hoverDefault
    public static let focusDefault: String = CommonStyles.focusDefault
}
