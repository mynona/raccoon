import Foundation

/// Styles for `Toast`.
/// Encapsulates all Tailwind classes and CommonStyles references for the toast component.
public struct ToastStyles {

    // MARK: - Viewport Container
    /// Returns the composed Tailwind classes for the toast viewport container based on screen anchor position.
    public static func container(position: ToastPosition) -> String {
        let base = "fixed z-50 flex flex-col gap-2 p-4 pointer-events-none w-full max-w-sm sm:max-w-md"
        switch position {
        case .bottomEnd:
            return "\(base) bottom-0 right-0 sm:bottom-4 sm:right-4 items-end"
        case .bottomStart:
            return "\(base) bottom-0 left-0 sm:bottom-4 sm:left-4 items-start"
        case .bottomCenter:
            return "\(base) bottom-0 left-1/2 -translate-x-1/2 sm:bottom-4 items-center"
        case .topEnd:
            return "\(base) top-0 right-0 sm:top-4 sm:right-4 items-end"
        case .topStart:
            return "\(base) top-0 left-0 sm:top-4 sm:left-4 items-start"
        case .topCenter:
            return "\(base) top-0 left-1/2 -translate-x-1/2 sm:top-4 items-center"
        }
    }

    // MARK: - Card Base
    /// Base styling for each individual toast card.
    /// Includes solid backgroundLight to guarantee full opacity over underlying page content.
    public static let cardBase: String = [
        "pointer-events-auto relative overflow-hidden w-full shadow-xl border p-4",
        CommonStyles.cornerRadiusLarge,
        CommonStyles.backgroundLight,
        "transition-all duration-300 ease-out motion-reduce:transition-none",
    ]
    .joined(separator: " ")

    // MARK: - Severity Variants
    /// Styling for informational toast cards.
    public static let variantInfo: String = [
        NotificationStyles.backgroundColorInfo,
        NotificationStyles.borderInfo,
        NotificationStyles.textInfo,
    ]
    .joined(separator: " ")

    /// Styling for success toast cards.
    public static let variantSuccess: String = [
        NotificationStyles.backgroundColorSuccess,
        NotificationStyles.borderSuccess,
        NotificationStyles.textSuccess,
    ]
    .joined(separator: " ")

    /// Styling for warning toast cards.
    public static let variantWarning: String = [
        NotificationStyles.backgroundColorWarning,
        NotificationStyles.borderWarning,
        NotificationStyles.textWarning,
    ]
    .joined(separator: " ")

    /// Styling for error toast cards.
    public static let variantError: String = [
        NotificationStyles.backgroundColorError,
        NotificationStyles.borderError,
        NotificationStyles.textError,
    ]
    .joined(separator: " ")

    // MARK: - Typography
    /// Font styling for toast titles.
    public static let titleFont: String = [
        CommonStyles.fontWeightSemibold,
        CommonStyles.textSizeSmall,
        "leading-5",
    ]
    .joined(separator: " ")

    /// Font styling for toast detail messages.
    public static let textFont: String = [
        CommonStyles.fontWeightNormal,
        CommonStyles.textSizeSmall,
        "mt-1 leading-5",
    ]
    .joined(separator: " ")

    // MARK: - Close Button
    /// Accessible close button styling delegating to ActionButtonStyles.iconButton for standard Raccoon focus and hover rings.
    public static let closeButton: String = [
        ActionButtonStyles.iconButton,
        "flex items-center justify-center shrink-0 -mr-1 -mt-1",
    ]
    .joined(separator: " ")

    // MARK: - Accessibility Announcer
    /// Visually hidden utility class for pre-mounted ARIA live region announcers.
    public static let announcer: String = "sr-only"
}
