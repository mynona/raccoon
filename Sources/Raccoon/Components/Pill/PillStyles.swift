import Foundation

/// Styles for `Pill`.
/// Encapsulates all Tailwind classes and CommonStyles references for the component.
public struct PillStyles {

    // MARK: - Reusable Primitives
    public static let font: String = [
        CommonStyles.fontSans,
        CommonStyles.fontWeightMedium,
        CommonStyles.textNoWrap,
    ]
    .joined(separator: " ")

    // MARK: - Base & Shape
    public static let base: String = [
        font,
        CommonStyles.cornerRadiusFull,
        "inline-flex items-center justify-center transition",
    ]
    .joined(separator: " ")

    // MARK: - Sizing
    public static let sizeSm: String = "text-xs px-2 py-0.5"
    public static let sizeBase: String = "text-xs px-2.5 py-0.5"
    public static let sizeXl: String = "text-sm px-3 py-1"

    // MARK: - Variants
    public static let neutral: String = [
        "bg-on-surface/10 text-on-surface print:text-print"
    ]
    .joined(separator: " ")

    public static let theme: String = [
        "bg-on-theme/15 text-on-theme print:text-print forced-colors:text-[Highlight]"
    ]
    .joined(separator: " ")

    public static let success: String = [
        "bg-on-success/15 text-on-success print:text-print"
    ]
    .joined(separator: " ")

    public static let error: String = [
        "bg-on-error-variant/15 text-on-error-variant print:text-print"
    ]
    .joined(separator: " ")

    // MARK: - Composed Styles
    /// Returns the complete class list for a given pill variant and size.
    ///
    /// - Parameters:
    ///   - variant: The visual color variant.
    ///   - size: Sizing preset.
    /// - Returns: A joined string of Tailwind utility classes.
    public static func style(
        variant: PillVariant,
        size: ComponentSize = .base
    ) -> String {
        let sizeClass: String = {
            switch size {
            case .sm:
                return sizeSm
            case .base:
                return sizeBase
            case .xl:
                return sizeXl
            }
        }()

        let variantClass: String = {
            switch variant {
            case .neutral:
                return neutral
            case .theme:
                return theme
            case .success:
                return success
            case .error:
                return error
            }
        }()

        return [base, sizeClass, variantClass].joined(separator: " ")
    }
}
