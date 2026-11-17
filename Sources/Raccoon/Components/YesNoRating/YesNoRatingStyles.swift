import Foundation

/// Styles for `YesNoRating`.
/// Encapsulates all Tailwind classes and CommonStyles references for the component.
public struct YesNoRatingStyles {

    // MARK: - Layout & Containers

    public static let panel: String = [
        CommonStyles.cornerRadiusLarge,
        "w-full relative",
    ]
    .joined(separator: " ")

    public static let panelInner: String = [
        CommonStyles.cornerRadiusLarge,
        "relative p-4 sm:p-6 w-full bg-overlay-hover",
    ]
    .joined(separator: " ")

    public static let headerRow =
        "flex flex-wrap sm:flex-nowrap items-center justify-between gap-4 w-full"
    public static let followUpContainer = "w-full mt-4"
    public static let optionsList = "space-y-2 mb-4"
    public static let textareaContainer = "w-full mb-4"
    public static let actionRow = "flex items-center justify-end gap-3 pt-4"

    // MARK: - Typography & Headers

    public static let question: String = [
        "text-left",
        CommonStyles.textSizeBase,
        "sm:text-lg",
        CommonStyles.fontWeightSemibold,
        "text-on-surface-bright",
    ]
    .joined(separator: " ")

    public static let thankYouMessage =
        "text-lg md:text-xl text-center text-on-surface-bright py-4"

    // MARK: - Yes / No Buttons

    public static let yesNoButtonsGroup = "flex items-center gap-4 shrink-0"
    public static let yesNoButtonContent =
        "flex items-center justify-center gap-2"
    public static let yesNoButton: String = ActionButtonStyles.secondaryButton
    public static let yesNoButtonActive: String = ActionButtonStyles
        .primaryButton

    // MARK: - Form Actions

    public static let cancelButton: String = ActionButtonStyles.tertiaryButton
    public static let submitButton: String = ActionButtonStyles.primaryButton
    public static let submitButtonDisabled: String = ActionButtonStyles
        .disabledButton
}
