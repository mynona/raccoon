import Foundation

/// Styles for `Stepper`.
/// Encapsulates all Tailwind classes and CommonStyles design tokens for the component.
public struct StepperStyles {

    // MARK: - Navigation Container
    public static let nav: String = "w-auto"

    // MARK: - Lists
    public static let listVertical: String = "overflow-hidden"
    public static let listHorizontal: String = "flex items-center"

    // MARK: - Items (Vertical)
    public static let itemVertical: String = "relative pb-10"
    public static let itemVerticalLast: String = "relative"

    // MARK: - Items (Horizontal)
    public static let itemHorizontal: String = "relative pr-8 sm:pr-20"
    public static let itemHorizontalFullWidth: String =
        "relative flex-1 pr-8 sm:pr-20"
    public static let itemHorizontalLast: String = "relative"

    // MARK: - Connecting Lines (Vertical)
    public static let lineVerticalBase: String =
        "absolute top-4 left-4 mt-0.5 -ml-px h-full w-0.5"
    public static let lineVerticalComplete: String = [
        lineVerticalBase,
        CommonStyles.progressBarActive,
    ]
    .joined(separator: " ")
    public static let lineVerticalUpcoming: String = [
        lineVerticalBase,
        CommonStyles.progressBarInactive,
    ]
    .joined(separator: " ")

    // MARK: - Connecting Lines (Horizontal)
    public static let lineHorizontalContainer: String =
        "absolute inset-0 flex items-center"
    public static let lineHorizontalComplete: String = [
        "h-0.5 w-full",
        CommonStyles.progressBarActive,
    ]
    .joined(separator: " ")
    public static let lineHorizontalUpcoming: String = [
        "h-0.5 w-full",
        CommonStyles.progressBarInactive,
    ]
    .joined(separator: " ")

    // MARK: - Step Containers & Triggers (Vertical)
    public static let stepTriggerVertical: String = [
        "group relative flex items-start",
        CommonStyles.cursorPointer,
        CommonStyles.focusDefault,
    ]
    .joined(separator: " ")
    public static let stepStaticVertical: String =
        "group relative flex items-start"

    // MARK: - Step Containers & Triggers (Horizontal)
    public static let stepTriggerHorizontal: String = [
        "group relative flex size-8 items-center justify-center rounded-full",
        CommonStyles.cursorPointer,
        CommonStyles.focusDefault,
    ]
    .joined(separator: " ")
    public static let stepStaticHorizontal: String =
        "group relative flex size-8 items-center justify-center rounded-full"
    public static let interactiveFocus: String = [
        CommonStyles.cursorPointer,
        CommonStyles.focusDefault,
    ]
    .joined(separator: " ")

    // MARK: - Circle Wrappers & Base
    public static let circleWrapperVertical: String = "flex h-9 items-center"
    public static let iconWrapper: String = "relative inline-flex"
    public static let circleBase: String =
        "relative z-10 flex size-8 items-center justify-center rounded-full"

    // Completed: filled with progress active color, white/black text/icon
    public static let circleComplete: String = [
        circleBase,
        CommonStyles.progressBarActive,
        CommonStyles.textColorWhite,
        "group-hover:opacity-90 transition",
    ]
    .joined(separator: " ")

    // Current: border with theme color, surface background
    public static let circleCurrent: String = [
        circleBase,
        "border-2",
        CommonStyles.borderColorTheme,
        CommonStyles.backgroundLight,
    ]
    .joined(separator: " ")

    // Upcoming: border with default border color, surface background
    public static let circleUpcoming: String = [
        circleBase,
        "border-2",
        CommonStyles.borderColorDefault,
        CommonStyles.backgroundLight,
        "group-hover:border-on-surface-bright transition",
    ]
    .joined(separator: " ")

    // MARK: - Inner Dots
    public static let dotCurrent: String = [
        "size-2.5 rounded-full",
        CommonStyles.progressBarActive,
    ]
    .joined(separator: " ")

    public static let dotUpcoming: String = [
        "size-2.5 rounded-full bg-transparent group-hover:bg-on-surface/20 transition"
    ]
    .joined(separator: " ")

    // MARK: - Circle Text & Numbers
    public static let circleTextCurrent: String = [
        CommonStyles.fontSans,
        CommonStyles.textSizeSmall,
        CommonStyles.fontWeightBold,
        CommonStyles.textColorSuccess,
    ]
    .joined(separator: " ")

    public static let circleTextUpcoming: String = [
        CommonStyles.fontSans,
        CommonStyles.textSizeSmall,
        CommonStyles.fontWeightMedium,
        CommonStyles.textColorDisabled,
    ]
    .joined(separator: " ")

    // MARK: - Circle Custom Icons
    public static let iconCurrent: String = CommonStyles.textColorSuccess
    public static let iconUpcoming: String = CommonStyles.textColorDisabled

    // MARK: - Text Content (Vertical)
    public static let textContainerVertical: String =
        "ml-4 flex min-w-0 flex-col"

    public static let titleBase: String = [
        CommonStyles.fontSans,
        CommonStyles.textSizeSmall,
        CommonStyles.fontWeightMedium,
    ]
    .joined(separator: " ")

    public static let titleComplete: String = [
        titleBase,
        CommonStyles.textColorEmphasized,
    ]
    .joined(separator: " ")

    public static let titleCurrent: String = [
        titleBase,
        CommonStyles.fontWeightBold,
        CommonStyles.textColorSuccess,
    ]
    .joined(separator: " ")

    public static let titleUpcoming: String = [
        titleBase,
        CommonStyles.textColorDisabled,
    ]
    .joined(separator: " ")

    public static let descriptionBase: String = [
        CommonStyles.fontSans,
        CommonStyles.textSizeSmall,
    ]
    .joined(separator: " ")

    public static let descriptionComplete: String = [
        descriptionBase,
        CommonStyles.textColorDefault,
    ]
    .joined(separator: " ")

    public static let descriptionCurrent: String = [
        descriptionBase,
        CommonStyles.textColorDefault,
    ]
    .joined(separator: " ")

    public static let descriptionUpcoming: String = [
        descriptionBase,
        CommonStyles.textColorDisabled,
    ]
    .joined(separator: " ")

    // MARK: - Accessibility
    public static let srOnly: String = "sr-only"

    // MARK: - Interaction States
    public static let stepDisabled: String = [
        CommonStyles.cursorNotAllowed,
        "opacity-60 pointer-events-none",
    ]
    .joined(separator: " ")
}
