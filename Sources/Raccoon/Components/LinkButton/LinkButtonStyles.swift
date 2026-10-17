import Foundation

/// Styles for `LinkButton`.
/// Encapsulates button variants by delegating to `ActionButtonStyles`.
public struct LinkButtonStyles {

    // MARK: - ActionButtonStyles Delegation
    public static let primaryButton: String =
        ActionButtonStyles.primaryButton
    public static let secondaryButton: String =
        ActionButtonStyles.secondaryButton
    public static let tertiaryButton: String =
        ActionButtonStyles.tertiaryButton
    public static let warningButton: String =
        ActionButtonStyles.warningButton
    public static let iconButton: String =
        ActionButtonStyles.iconButton

}
