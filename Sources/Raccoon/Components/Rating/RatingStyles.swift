import Foundation

public struct RatingStyles {

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
    public static let question = [
        "text-center",
        CommonStyles.textSizeLarge,
        CommonStyles.fontWeightSemibold,
        "text-on-surface-bright",
    ]
    .joined(separator: " ")
    public static let thankYouMessage =
        "text-lg md:text-xl text-center text-on-surface-bright"
    public static let closeButton =
        "absolute top-2 right-2 p-2 text-gray-600 hover:text-gray-900 z-50"

    // MARK: feedback textarea
    public static let textareaTextSize = "sm:text-sm"

    // MARK: focus
    public static let focusDefault: String = CommonStyles.focusDefault

    // MARK: hover
    public static let hoverDefault: String = CommonStyles.hoverDefault
}
