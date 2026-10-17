import Foundation

/// Styles for `TabGroup`.
/// Encapsulates all Tailwind classes and CommonStyles references for the component.
public struct TabGroupStyles {

    // MARK: - Reusable Primitives
    public static let font: String = [
        CommonStyles.fontSans,
        CommonStyles.fontWeightMedium,
        CommonStyles.textNoWrap,
    ]
    .joined(separator: " ")

    public static let fontActive: String = [
        CommonStyles.fontSans,
        CommonStyles.fontWeightBold,
        CommonStyles.textNoWrap,
    ]
    .joined(separator: " ")

    public static let textSizeSmall: String = CommonStyles.textSizeSmall
    public static let textSizeBase: String = CommonStyles.textSizeBase
    public static let textSizeLarge: String = CommonStyles.textSizeLarge

    // MARK: - Text Colors
    public static let textColorActive: String = [
        "text-on-theme print:text-black",
        "forced-colors:text-[Highlight]",
    ]
    .joined(separator: " ")
    public static let textColorInactive: String = CommonStyles.textColorDefault
    public static let textColorDisabled: String = CommonStyles.textColorDisabled

    // MARK: - Borders & Dividers
    public static let borderColorDefault: String = CommonStyles
        .borderColorDefault
    public static let borderColorTheme: String = CommonStyles.borderColorTheme
    public static let borderColorDisabled: String = CommonStyles
        .borderColorDisabled

    // MARK: - Focus & Hover Rings
    public static let focusDefault: String = CommonStyles.focusDefault
    public static let hoverDefault: String = CommonStyles.hoverDefault

    // MARK: - Cursors
    public static let cursorPointer: String = CommonStyles.cursorPointer
    public static let cursorNotAllowed: String = CommonStyles.cursorNotAllowed

    // MARK: - Tab List Containers
    public static let tabListHorizontal: String = [
        "-mb-px flex gap-8 overflow-x-auto border-b",
        borderColorDefault,
    ]
    .joined(separator: " ")

    public static let tabListHorizontalUnderline: String = [
        "-mb-px flex gap-8 overflow-x-auto border-b",
        borderColorDefault,
    ]
    .joined(separator: " ")

    public static let tabListHorizontalPills: String = [
        "isolate flex overflow-x-auto border border-outline divide-x [&>button]:flex-1",
        CommonStyles.divideColorDefault,
        CommonStyles.cornerRadiusLarge,
        CommonStyles.backgroundLight,
    ]
    .joined(separator: " ")

    public static let tabListVertical: String = [
        "flex flex-col gap-2 border-r pr-4 min-w-48",
        borderColorDefault,
    ]
    .joined(separator: " ")

    public static let tabListVerticalPills: String = [
        "isolate flex flex-col min-w-48 border border-outline divide-y",
        CommonStyles.divideColorDefault,
        CommonStyles.cornerRadiusLarge,
        CommonStyles.backgroundLight,
    ]
    .joined(separator: " ")

    // MARK: - Tab Button Base: Underline
    public static let tabUnderlineButtonBase: String = [
        "enabled:cursor-pointer",
        textSizeSmall,
        "relative inline-flex items-center justify-center gap-2 px-3 py-3 -mb-px border-b-2 text-sm transition rounded-t-md",
        "[[aria-orientation=vertical]>&]:-mb-0 [[aria-orientation=vertical]>&]:-mr-px",
        "[[aria-orientation=vertical]>&]:border-b-0 [[aria-orientation=vertical]>&]:border-r-2",
        "[[aria-orientation=vertical]>&]:rounded-t-none [[aria-orientation=vertical]>&]:rounded-l-md",
        "[[aria-orientation=vertical]>&]:px-4 [[aria-orientation=vertical]>&]:py-3",
        "enabled:hover:bg-on-surface/5",
        "focus-visible:z-10 focus-visible:outline-2 focus-visible:-outline-offset-2 focus-visible:outline-focusring",
        "forced-colors:focus-visible:outline-[Highlight]",
    ]
    .joined(separator: " ")

    public static let tabButtonBase: String = tabUnderlineButtonBase

    // MARK: - Composed Variants: Underline
    public static let tabUnderlineActive: String = [
        fontActive,
        textColorActive,
        "border-b-on-theme print:border-b-black forced-colors:border-b-[Highlight]",
        "[[aria-orientation=vertical]>&]:border-r-on-theme",
        "[[aria-orientation=vertical]>&]:forced-colors:border-r-[Highlight]",
    ]
    .joined(separator: " ")

    public static let tabUnderlineInactive: String = [
        font,
        textColorInactive,
        "border-b-transparent",
        "[[aria-orientation=vertical]>&]:border-r-transparent",
    ]
    .joined(separator: " ")

    public static let tabUnderlineDisabled: String = [
        tabUnderlineButtonBase,
        font,
        "border-b-transparent [[aria-orientation=vertical]>&]:border-r-transparent",
    ]
    .joined(separator: " ")

    // MARK: - Composed Variants: Pills
    public static let tabPillsButtonBase: String = [
        "enabled:cursor-pointer",
        textSizeSmall,
        "relative inline-flex min-w-max min-h-11 items-center justify-center gap-2 px-4 py-4 border-b-2",
        "first:rounded-ss-lg last:rounded-ee-lg",
        "[[aria-orientation=horizontal]>&]:first:rounded-es-lg [[aria-orientation=horizontal]>&]:last:rounded-se-lg",
        "[[aria-orientation=vertical]>&]:first:rounded-se-lg [[aria-orientation=vertical]>&]:last:rounded-es-lg",
        "enabled:hover:bg-on-surface/5 focus-visible:z-10 focus-visible:outline-2 focus-visible:-outline-offset-2 focus-visible:outline-focusring",
        "forced-colors:focus-visible:outline-[Highlight]",
    ]
    .joined(separator: " ")

    public static let tabPillsActive: String = [
        fontActive,
        CommonStyles.textColorEmphasized,
        "border-b-on-theme print:border-b-black forced-colors:border-b-[Highlight]",
    ]
    .joined(separator: " ")

    public static let tabPillsInactive: String = [
        font,
        textColorInactive,
        CommonStyles.backgroundTransparent,
        "border-b-transparent",
    ]
    .joined(separator: " ")

    public static let tabPillsDisabled: String = [
        tabPillsButtonBase,
        font,
        "border-b-transparent",
    ]
    .joined(separator: " ")

    // MARK: - Tab Disabled State
    public static let tabDisabled: String = [
        cursorNotAllowed,
        textColorDisabled,
        "opacity-50",
    ]
    .joined(separator: " ")

    // MARK: - Badges & Pills (PillStyles Delegation)
    public static let pillActive: String = PillStyles.style(
        variant: .theme,
        size: .base
    )
    public static let pillInactive: String = PillStyles.style(
        variant: .neutral,
        size: .base
    )
    public static let badgeActive: String = pillActive
    public static let badgeInactive: String = pillInactive

    // MARK: - Panels & Content
    public static let panelContainer: String = "py-4 px-1"
    public static let panelProse: String = CommonStyles.prose
    public static let panelReset: String = CommonStyles.proseReset

    // MARK: - Group Border
    public static let groupBorder: String = [
        "border rounded-md p-4",
        borderColorDefault,
    ]
    .joined(separator: " ")
}
