import Foundation

/// Styles for `SimpleMenu`.
/// Encapsulates all styling classes and design tokens for the simple menu component.
public struct SimpleMenuStyles {

    // MARK: - Container
    public static let container: String = "relative inline-block text-left m-0"

    // MARK: - Trigger Button
    public static let iconButton: String = ActionButtonStyles.iconButton

    public static let triggerButton: String = [
        "inline-flex items-center justify-between gap-2 px-3 py-1.5 text-sm",
        ActionButtonStyles.secondaryButton,
    ]
    .joined(separator: " ")

    // MARK: - Dropdown Panel
    public static let dropdownPanel: String = [
        "absolute left-0 mt-2 w-48 z-50 p-1 border shadow-md bg-white dark:bg-gray-900",
        CommonStyles.cornerRadiusMedium,
        CommonStyles.borderColorDefault,
    ]
    .joined(separator: " ")

    public static let dropdownPanelRight: String = [
        "absolute right-0 mt-2 w-48 z-50 p-1 border bg-white dark:bg-gray-900",
        CommonStyles.cornerRadiusMedium,
        CommonStyles.borderColorDefault,
    ]
    .joined(separator: " ")

    public static let dropdownPanelCenter: String = [
        "absolute left-1/2 -translate-x-1/2 mt-2 w-48 z-50 p-1 border shadow-md bg-white dark:bg-gray-900",
        CommonStyles.cornerRadiusMedium,
        CommonStyles.borderColorDefault,
    ]
    .joined(separator: " ")

    public static func dropdownPanel(width: String, align: ComponentPosition)
        -> String
    {
        if width == "w-48" {
            switch align {
            case .right: return dropdownPanelRight
            case .center: return dropdownPanelCenter
            default: return dropdownPanel
            }
        }
        let alignClass: String
        switch align {
        case .right: alignClass = "right-0"
        case .center: alignClass = "left-1/2 -translate-x-1/2"
        default: alignClass = "left-0"
        }
        return [
            "absolute \(alignClass) mt-2 \(width) z-50 p-1 border shadow-md bg-white dark:bg-gray-900",
            CommonStyles.cornerRadiusMedium,
            CommonStyles.borderColorDefault,
        ]
        .joined(separator: " ")
    }

    // MARK: - Menu List
    public static let menuList: String = "list-none m-0 p-2"

    // MARK: - Menu Item
    public static let menuItem: String = [
        "flex items-center justify-between w-full px-3 py-1 text-left transition-colors",
        CommonStyles.cursorPointer,
        CommonStyles.cornerRadiusMedium,
        CommonStyles.fontSans,
        CommonStyles.textNoWrap,
        CommonStyles.textSizeSmall,
        CommonStyles.textColorDefault,
        CommonStyles.hoverDefault,
        CommonStyles.focusDefault,
    ]
    .joined(separator: " ")

    // MARK: - Menu Item Disabled
    public static let menuItemDisabled: String = [
        "flex items-center justify-between w-full px-3 py-1 text-left opacity-40",
        CommonStyles.cursorNotAllowed,
        CommonStyles.cornerRadiusMedium,
        CommonStyles.fontSans,
        CommonStyles.textNoWrap,
        CommonStyles.textSizeSmall,
        CommonStyles.textColorDefault,
    ]
    .joined(separator: " ")

    // MARK: - Menu Item Content (Leading Icon + Title)
    public static let itemContent: String = "flex items-center gap-2 min-w-0"

    // MARK: - Option Leading Icon
    public static let optionIcon: String = "shrink-0 w-4 h-4"

    // MARK: - Active Checkmark Icon
    public static let activeIcon: String = [
        "shrink-0 ml-2 w-4 h-4",
        CommonStyles.textColorSuccess,
    ]
    .joined(separator: " ")

    // MARK: - Interaction States
    public static let hoverDefault: String = CommonStyles.hoverDefault
    public static let focusDefault: String = CommonStyles.focusDefault
}
