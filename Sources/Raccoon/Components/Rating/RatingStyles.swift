import Foundation

public struct RatingStyles {

    // MARK: - Floating Trigger
    public static let floatingContainer = "print:hidden fixed bottom-6 right-6 z-50"

    public static let triggerButton: String = [
        "group flex items-center justify-center h-8 min-w-8 p-1.5",
        CommonStyles.cornerRadiusFull,
        CommonStyles.cursorPointer,
        ActionButtonStyles.font,
        ActionButtonStyles.textSizeSmall,
        ActionButtonStyles.textColorSecondary,
        ActionButtonStyles.backgroundColorSecondary,
        ActionButtonStyles.borderSecondary,
        "shadow-md",
        ActionButtonStyles.focusDefault,
        ActionButtonStyles.hoverDefault,
        "transition-all duration-200 ease-in-out",
    ]
    .joined(separator: " ")

    public static let triggerText: String = [
        "overflow-hidden max-w-0 opacity-0 whitespace-nowrap",
        "group-hover:max-w-xs group-hover:opacity-100 group-hover:ml-2.5 group-hover:mr-1",
        "group-focus-visible:max-w-xs group-focus-visible:opacity-100 group-focus-visible:ml-2.5 group-focus-visible:mr-1",
        "transition-all duration-200 ease-in-out text-sm font-medium",
    ]
    .joined(separator: " ")

    // MARK: - Modal Dialog
    public static let modalWrapper =
        "fixed inset-0 z-50 flex min-h-screen items-center justify-center p-4 overflow-y-auto"

    public static let backdrop: String = [
        "fixed inset-0",
        CommonStyles.backdropColor,
        "z-40 backdrop-blur-sm",
    ]
    .joined(separator: " ")

    // MARK: container
    public static let containerFloating =
        "print:hidden fixed bottom-6 left-1/2 transform -translate-x-1/2 flex flex-col items-center z-50 px-4"
    public static let containerDefault = "relative"

    public static let panel = [
        CommonStyles.cornerRadiusLarge,
        "w-screen max-w-md"
    ].joined(separator: " ")

    public static let panelInner = [
        CommonStyles.cornerRadiusLarge,
        "relative p-4 w-full max-w-md bg-surface-rating"
    ].joined(separator: " ")
    public static let headerRow =
        "flex items-center justify-between gap-4 w-full mb-6"

    public static let question = [
        "flex-1 text-left",
        CommonStyles.textSizeLarge,
        CommonStyles.fontWeightSemibold,
        "text-on-surface-bright",
    ]
    .joined(separator: " ")
    public static let thankYouContainer =
        "flex items-center justify-center text-center py-1 px-1 gap-3 w-full"
    public static let thankYouMessage =
        "text-lg md:text-xl text-center text-on-surface-bright font-medium"
    public static let closeButton =
        "absolute top-2 right-2 p-2 text-gray-600 hover:text-gray-900 z-50"

    // MARK: focus
    public static let focusDefault: String = CommonStyles.focusDefault

    // MARK: hover
    public static let hoverDefault: String = CommonStyles.hoverDefault
}
