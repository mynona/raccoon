import Foundation

/// Styles for `TablePaginator`.
/// Encapsulates all Tailwind classes and CommonStyles references for the table paginator component.
public struct TablePaginatorStyles {

    // MARK: - Layout & Container
    public static let container: String = [
        "mt-4 flex flex-wrap items-center justify-end gap-x-6 gap-y-2"
    ]
    .joined(separator: " ")

    public static let pageSizeSelectorContainer: String =
        "flex flex-row items-center gap-2"

    public static let navigationButtonGroup: String =
        "flex flex-row items-center gap-1"

    // MARK: - Typography & Labels
    public static let labelFont: String = ActionButtonStyles.font
    public static let labelTextSize: String = ActionButtonStyles.textSizeSmall
    public static let labelTextColor: String = CommonStyles.textColorDefault

    public static let label: String = [
        labelFont,
        labelTextSize,
        labelTextColor,
    ]
    .joined(separator: " ")

    // MARK: - Page Size Selector
    public static let select: String = [
        "rounded-md py-1.5 pl-2 pr-8 text-sm bg-transparent disabled:opacity-50",
        CommonStyles.inputBorder,
        CommonStyles.textColorDefault,
        CommonStyles.focusDefault,
    ]
    .joined(separator: " ")

    // MARK: - Navigation Buttons
    public static let navigationButtonEnabled: String = [
        "p-2",
        ActionButtonStyles.secondaryButton,
    ]
    .joined(separator: " ")

    public static let navigationButtonDisabled: String = [
        "p-2",
        ActionButtonStyles.disabledButton,
    ]
    .joined(separator: " ")

    public static let navigationButton: String = navigationButtonEnabled
}
