/// Styles for `DataTable`. Table tokens are shared with `SimpleTable` through `TableStyles`.
public struct DataTableStyles {

    // MARK: - Buttons
    public static let iconButton: String = ActionButtonStyles.iconButton
    public static let primaryButton: String = ActionButtonStyles.primaryButton
    public static let secondaryButton: String = ActionButtonStyles
        .secondaryButton
    public static let tertiaryButton: String = ActionButtonStyles
        .tertiaryButton
    public static let warningButton: String = ActionButtonStyles.warningButton

    // MARK: - Layout
    public static let root: String = "pt-12 pb-14"
    public static let toolbar: String =
        "flex flex-row justify-between w-full items-center px-3 pb-3"
    public static let toolbarActions: String =
        "flex flex-row items-center space-x-4"

    // MARK: - Filter bar (proposal A)
    public static let filterBar: String = [
        "flex flex-row items-center justify-between w-full px-3 py-1",
        TableStyles.tableBorder,
        TableStyles.tableBorderColor,
    ]
    .joined(separator: " ")
    public static let filterBarLeft: String =
        "flex flex-row items-center"
    public static let filterBarRight: String =
        "flex flex-row items-center ml-auto"
    public static let filterToggle: String = [
        CommonStyles.cursorPointer,
        ActionButtonStyles.font,
        CommonStyles.textSizeSmall,
        "inline-flex flex-row items-center space-x-2 py-1.5 px-2 rounded",
        "hover:bg-tertiary",
        CommonStyles.focusDefault,
    ]
    .joined(separator: " ")
    public static let filterToggleContent: String =
        "flex flex-row items-center space-x-2"
    public static let filterCount: String = [
        "inline-flex items-center justify-center min-w-5 h-5 px-1.5 text-xs font-semibold rounded-full",
        MultiSelectStyles.optionSelected,
    ]
    .joined(separator: " ")
    public static let clearAllButton: String = [
        CommonStyles.cursorPointer,
        ActionButtonStyles.font,
        CommonStyles.textSizeSmall,
        "ml-3 pl-3 border-l",
        TableStyles.tableBorderColor,
        "underline text-on-surface-dim hover:text-on-surface",
        CommonStyles.focusDefault,
    ]
    .joined(separator: " ")

    // MARK: - Filter panel
    public static let filterPanel: String = [
        "grid gap-4 grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 px-3 py-5 border-b",
        TableStyles.tableBorderColor,
    ]
    .joined(separator: " ")
    public static let filterPanelActions: String =
        "flex flex-row items-end space-x-4 sm:col-span-2 lg:col-span-3"
    public static let dateRange: String = "grid grid-cols-2 gap-2"

    // MARK: - Filter chips (same look as selected MultiSelect options)
    public static let chipList: String = [
        "flex flex-wrap items-center gap-3 py-3 px-3 border-b",
        TableStyles.tableBorderColor,
    ]
    .joined(separator: " ")
    public static let chip: String = [
        "inline-flex items-center p-1 px-2 cursor-pointer",
        MultiSelectStyles.optionSelected,
        InputFieldStyles.inputContainerFocus,
        InputFieldStyles.inputContainerHover,
    ]
    .joined(separator: " ")
    public static let chipIcon: String = "pl-1"

    // MARK: - Table
    public static let scrollRegion: String = [
        "overflow-x-auto",
        CommonStyles.focusDefault,
    ]
    .joined(separator: " ")
    public static let table: String = [
        "min-w-full",
        TableStyles.tableBorder,
        TableStyles.tableBorderColor,
    ]
    .joined(separator: " ")
    public static let alignRight: String = "text-right justify-end"
    public static let alignCenter: String = "text-center justify-center"
    public static let alignLeft: String = "text-left justify-start"
    public static let numeric: String = "tabular-nums"
    public static let sortButton: String = [
        "inline-flex flex-row items-center space-x-2 cursor-pointer w-full",
        CommonStyles.focusDefault,
        TableStyles.thHover,
    ]
    .joined(separator: " ")
    public static let rowNumber: String = [
        "tabular-nums",
        TableStyles.tdBodyPadding,
        TableStyles.tdBodyTextFont,
        TableStyles.tdBodyTextSize,
        TableStyles.tdBodyTextColor,
    ]
    .joined(separator: " ")

    // MARK: - States
    public static let skeletonCell: String = [
        "block h-4 w-full bg-black/10 dark:bg-white/10 animate-pulse motion-reduce:animate-none",
        CommonStyles.cornerRadiusTiny,
    ]
    .joined(separator: " ")
    public static let emptyState: String = [
        "flex flex-row items-center space-x-4 px-2 py-4 text-left",
        SimpleTableStyles.emptyStateTextColor,
    ]
    .joined(separator: " ")
    public static let errorBanner: String = "mb-4"
    public static let linkButton: String = [
        "underline cursor-pointer",
        CommonStyles.focusDefault,
    ]
    .joined(separator: " ")

    // MARK: - Cells
    public static let badge: String = [
        "inline-block border px-2 py-0.5 text-xs",
        CommonStyles.cornerRadiusTiny,
        TableStyles.tableBorderColor,
    ]
    .joined(separator: " ")
    public static let cellLink: String = "underline"
    public static let cellList: String = "list-disc pl-4"
    public static let actionList: String = "flex flex-row flex-wrap gap-2"
    public static let icon: String = "w-4 h-4 inline-block"
    public static let toggle: String = [
        "relative inline-flex py-1 w-9 flex-none cursor-pointer transition",
        CommonStyles.cornerRadiusFull,
        CommonStyles.focusDefault,
    ].joined(separator: " ")
    public static let iconCell: String = "inline-flex items-center space-x-2"
}
