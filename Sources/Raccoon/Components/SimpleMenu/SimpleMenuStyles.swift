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

    public static func dropdownPanel(width: String, align: ComponentPosition)
        -> String
    {
        if width == "w-48" {
            return align == .right ? dropdownPanelRight : dropdownPanel
        }
        let alignClass = align == .right ? "right-0" : "left-0"
        return [
            "absolute \(alignClass) mt-2 \(width) z-50 p-1 border shadow-md",
            CommonStyles.cornerRadiusMedium,
            CommonStyles.backgroundLight,
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
        CommonStyles.textSizeSmall,
        CommonStyles.textColorDefault,
        CommonStyles.hoverDefault,
        CommonStyles.focusDefault,
    ]
    .joined(separator: " ")

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
