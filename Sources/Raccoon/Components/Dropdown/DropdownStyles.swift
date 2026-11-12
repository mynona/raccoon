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

    // MARK: - Field container (label and trigger inside one border, as in `InputField`)
    public static let fieldContainer: String = "px-3 pb-1.5 pt-2.5"
    public static let inputContainerBorder: String = InputFieldStyles
        .inputContainerBorder
    public static let inputContainerHover: String = InputFieldStyles
        .inputContainerHover
    public static let inputContainerFocus: String = InputFieldStyles
        .inputContainerFocus

    public static let triggerButtonField: String = [
        "flex items-center justify-between w-full p-0 text-sm leading-6 text-left transition-colors bg-transparent focus:outline-none",
        CommonStyles.cursorPointer,
        CommonStyles.textColorDefault,
    ]
    .joined(separator: " ")

    // MARK: - Trigger state colours (as in `InputField`: error, success, default)
    public static let borderColorDefault: String = CommonStyles.borderColorDefault
    public static let borderColorError: String = CommonStyles.borderColorError
    public static let borderColorSuccess: String = CommonStyles.borderColorSuccess

    // MARK: - Trigger Icon (same colour as the SearchField icon)
    public static let triggerGap: String = "gap-2"
    public static let triggerContent: String = "flex items-center gap-2"
    public static let triggerIcon: String = SearchFieldStyles.textColorIcon

    // MARK: - Dropdown Panel
    public static let dropdownPanel: String = [
        "absolute left-1/2 -translate-x-1/2 mt-2 min-w-full w-max z-50 p-1 border shadow-md",
        CommonStyles.cornerRadiusMedium,
        CommonStyles.backgroundLight,
        CommonStyles.borderColorDefault,
    ]
    .joined(separator: " ")

    // MARK: - Menu List
    public static let menuList: String = SimpleMenuStyles.menuList

    // MARK: - Menu Item
    public static let menuItem: String = SimpleMenuStyles.menuItem

    // MARK: - Menu Item Content
    public static let itemContent: String = SimpleMenuStyles.itemContent

    // MARK: - Option Leading Icon
    public static let optionIcon: String = SimpleMenuStyles.optionIcon

    // MARK: - Active Checkmark Icon
    public static let activeIcon: String = SimpleMenuStyles.activeIcon

    // MARK: - Info Display
    public static let infoBorder: String = SingleSelectStyles.infoBorder
    public static let infoTextColor: String = SingleSelectStyles.infoTextColor

    // MARK: - Interaction States
    public static let hoverDefault: String = CommonStyles.hoverDefault
    public static let focusDefault: String = CommonStyles.focusDefault
}
