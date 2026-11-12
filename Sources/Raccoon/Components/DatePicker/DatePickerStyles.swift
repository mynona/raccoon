import Foundation

/// Styles for `DatePicker`.
/// Encapsulates all Tailwind classes and CommonStyles references for the component.
public struct DatePickerStyles {
    public static let monthText: String = [
        CommonStyles.fontWeightSemibold,
        CommonStyles.textSizeLarge,
    ]
    .joined(separator: " ")

    public static let yearText: String = [
        CommonStyles.fontWeightNormal,
        CommonStyles.textSizeLarge,
    ]
    .joined(separator: " ")

    public static let weekDaysText: String = [
        CommonStyles.fontWeightNormal,
        "text-center p-1",
    ]
    .joined(separator: " ")

    public static let info: String = "border-b border-on-surface"
    public static let disabled: String =
        "disabled:text-on-disabled disabled:ring-on-disabled disabled:cursor-not-allowed ring-1 ring-on-disabled"
    public static let disabledInput: String = [
        CommonStyles.inputReset,
        CommonStyles.textColorDisabled,
        CommonStyles.cursorNotAllowed,
    ]
    .joined(separator: " ")

    public static let datepicker: String = [
        CommonStyles.backgroundLight,
        CommonStyles.cornerRadiusLarge,
        "border shadow-lg",
        CommonStyles.borderColorDefault,
        CommonStyles.textColorDefault,
    ]
    .joined(separator: " ")

    public static let errorBorder: String = CommonStyles.borderColorError
    public static let successBorder: String = CommonStyles.borderColorSuccess
    public static let regularBorder: String = CommonStyles.borderColorDefault

    // MARK: - Pill Input Bar & Steppers
    public static let pillContainer: String = [
        "flex items-center justify-between gap-2 w-full py-1 transition"
    ]
    .joined(separator: " ")

    public static let stepperButton: String = [
        CommonStyles.cursorPointer,
        CommonStyles.cornerRadiusMedium,
        CommonStyles.textColorDefault,
        CommonStyles.hoverDefault,
        CommonStyles.focusDefault,
        "p-1 inline-flex items-center justify-center transition-colors select-none",
    ]
    .joined(separator: " ")

    public static let textColorMuted: String = "text-on-surface-dim select-none"
    public static let pipeDelimiter: String =
        "text-on-surface-dim select-none font-light"

    public static let weekNumberBadge: String = [
        CommonStyles.fontMono,
        CommonStyles.textSizeSmall,
        "text-on-surface-dim select-none",
    ]
    .joined(separator: " ")

    // MARK: - Shortcuts Sidebar
    public static let shortcutsSidebar: String = [
        "p-3 flex flex-col space-y-3 shrink-0",
        CommonStyles.borderColorDefault,
        CommonStyles.backgroundLight,
    ]
    .joined(separator: " ")

    public static let shortcutButton: String = [
        "w-full text-left px-2.5 py-1.5 text-xs rounded-md transition font-medium border border-outline-variant dark:border-on-surface-dark",
        CommonStyles.cursorPointer,
        CommonStyles.textColorDefault,
        CommonStyles.backgroundLight,
        CommonStyles.hoverDefault,
        CommonStyles.focusDefault,
    ]
    .joined(separator: " ")

    public static let calendarGridContainer: String = "p-3 flex-1 min-w-[280px]"

    public static let dropdownTrigger: String = DropdownStyles.triggerButton
    public static let dropdownPanel: String = DropdownStyles.dropdownPanel
    public static let dropdownItem: String = DropdownStyles.menuItem

    public static let yearDropdownTrigger: String = [
        "inline-flex items-center gap-1 px-1.5 py-0.5 text-sm font-normal rounded-md border border-outline-variant transition",
        CommonStyles.cursorPointer,
        CommonStyles.textColorDefault,
        CommonStyles.hoverDefault,
        CommonStyles.focusDefault,
    ]
    .joined(separator: " ")

    // MARK: - Week Number Column in Calendar Grid
    public static let weekNumberColumn: String = [
        CommonStyles.fontMono,
        CommonStyles.textSizeTiny,
        "text-on-surface-dim border-r border-on-surface pr-1 select-none pointer-events-none",
    ]
    .joined(separator: " ")

    // MARK: - Day Cell Selection
    public static let daySelected: String = [
        CommonStyles.buttonTextColorPrimary,
        CommonStyles.buttonBackgroundColorPrimary,
    ]
    .joined(separator: " ")

    public static let dayUnselected: String = CommonStyles.textColorDefault

    public static let dayToday: String = [
        CommonStyles.fontWeightBold,
        "border",
        CommonStyles.borderColorTheme,
    ]
    .joined(separator: " ")

    public static let dayInRange: String = [
        "bg-surface-info text-on-surface-info rounded-none"
    ]
    .joined(separator: " ")

    // MARK: InputFieldStyles
    public static let inputFieldReset: String = InputFieldStyles.inputReset
    public static let textColorInput: String = InputFieldStyles.textColorInput
    public static let textColorDefault: String = InputFieldStyles
        .textColorDefault
    public static let textColorError: String = CommonStyles.textColorError
    public static let inputContainerBorder: String = InputFieldStyles
        .inputBorder
    public static let inputContainerHover: String = InputFieldStyles
        .inputContainerHover
    public static let inputContainerFocus: String = InputFieldStyles
        .inputContainerFocus

    // MARK: AppStyles
    public static let text: String = CommonStyles.textColorDefault

    // MARK: CommonStyles
    public static let textSizeSmall: String = CommonStyles.textSizeSmall
    public static let focusDefault: String = CommonStyles.focusDefault
    public static let hoverDefault: String = CommonStyles.hoverDefault
}
