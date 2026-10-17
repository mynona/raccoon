import Foundation

/// Styles for `DatePicker`.
/// Encapsulates all Tailwind classes and CommonStyles references for the component.
public struct DatePickerStyles {
    public static let monthText: String = [
        CommonStyles.fontWeightSemibold,
        CommonStyles.textSizeLarge,
    ].joined(separator: " ")

    public static let yearText: String = [
        CommonStyles.fontWeightNormal,
        CommonStyles.textSizeLarge
    ].joined(separator: " ")

    public static let weekDaysText: String = [
        CommonStyles.fontWeightNormal,
        "text-center p-1"
    ].joined(separator: " ")

    public static let info: String = "border-b border-on-surface"
    public static let disabled: String =
        "disabled:text-on-disabled disabled:ring-on-disabled disabled:cursor-not-allowed ring-1 ring-on-disabled"
    public static let disabledInput: String = [
        CommonStyles.inputReset,
        CommonStyles.textColorDisabled,
        CommonStyles.cursorNotAllowed
    ].joined(separator: " ")

    public static let datepicker: String = [
        CommonStyles.backgroundLight,
        CommonStyles.cornerRadiusMedium,
        "border shadow-md",
        CommonStyles.borderColorDefault,
        CommonStyles.textColorDefault
    ].joined(separator: " ")

    public static let errorBorder: String = CommonStyles.borderColorError
    public static let regularBorder: String = CommonStyles.borderColorDefault

    // MARK: - Day Cell Selection
    public static let daySelected: String = [
        CommonStyles.buttonTextColorPrimary,
        CommonStyles.buttonBackgroundColorPrimary
    ].joined(separator: " ")

    public static let dayUnselected: String = CommonStyles.textColorDefault

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
