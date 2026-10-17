import Foundation

/// Supported date formats for the `DatePicker` component.
/// Named directly after the international format masks (e.g. `YYYY-MM-DD`, `DD.MM.YYYY`, `DD/MM/YYYY`, `MM/DD/YYYY`).
public enum DatePickerFormat: String, Sendable, CaseIterable, ExpressibleByStringLiteral {
    /// European dot format: DD.MM.YYYY (e.g. 06.02.1973) - standard in DACH (Austria, Germany, Switzerland) and Nordic/Eastern European countries.
    case dd_mm_yyyy = "DD.MM.YYYY"
    /// ISO 8601 international standard format: YYYY-MM-DD (e.g. 1973-02-06).
    case yyyy_mm_dd = "YYYY-MM-DD"
    /// European slash format: DD/MM/YYYY (e.g. 06/02/1973) - standard in UK, Ireland, France, Spain, etc.
    case dd_slash_mm_slash_yyyy = "DD/MM/YYYY"
    /// US format: MM/DD/YYYY (e.g. 02/06/1973).
    case mm_dd_yyyy = "MM/DD/YYYY"

    // MARK: - Pattern-based Static Constants
    public static let DD_MM_YYYY: DatePickerFormat = .dd_mm_yyyy
    public static let YYYY_MM_DD: DatePickerFormat = .yyyy_mm_dd
    public static let DD_SLASH_MM_SLASH_YYYY: DatePickerFormat = .dd_slash_mm_slash_yyyy
    public static let MM_DD_YYYY: DatePickerFormat = .mm_dd_yyyy

    // MARK: - Regional Convenience Aliases
    public static let dach: DatePickerFormat = .dd_mm_yyyy
    public static let DACH: DatePickerFormat = .dd_mm_yyyy
    public static let dachRegion: DatePickerFormat = .dd_mm_yyyy
    public static let austrian: DatePickerFormat = .dd_mm_yyyy
    public static let Austrian: DatePickerFormat = .dd_mm_yyyy

    public static let iso: DatePickerFormat = .yyyy_mm_dd
    public static let ISO: DatePickerFormat = .yyyy_mm_dd

    public static let uk: DatePickerFormat = .dd_slash_mm_slash_yyyy
    public static let UK: DatePickerFormat = .dd_slash_mm_slash_yyyy

    public static let us: DatePickerFormat = .mm_dd_yyyy
    public static let US: DatePickerFormat = .mm_dd_yyyy

    public init(stringLiteral value: String) {
        switch value.uppercased().trimmingCharacters(in: .whitespaces) {
        case "YYYY-MM-DD", "YYYY_MM_DD", "YYY-MM-DD", "ISO":
            self = .yyyy_mm_dd
        case "DD/MM/YYYY", "DD_SLASH_MM_SLASH_YYYY", "UK":
            self = .dd_slash_mm_slash_yyyy
        case "MM/DD/YYYY", "MM_DD_YYYY", "US":
            self = .mm_dd_yyyy
        case "DD.MM.YYYY", "DD_MM_YYYY", "DACH", "AUSTRIAN":
            self = .dd_mm_yyyy
        default:
            self = DatePickerFormat(rawValue: value) ?? .dd_mm_yyyy
        }
    }

    /// Input placeholder matching the format.
    public var placeholder: String {
        switch self {
        case .dd_mm_yyyy:
            return "DD.MM.YYYY"
        case .yyyy_mm_dd:
            return "YYYY-MM-DD"
        case .dd_slash_mm_slash_yyyy:
            return "DD/MM/YYYY"
        case .mm_dd_yyyy:
            return "MM/DD/YYYY"
        }
    }

    /// Date format string used by `DateFormatter`.
    public var dateFormat: String {
        switch self {
        case .dd_mm_yyyy:
            return "dd.MM.yyyy"
        case .yyyy_mm_dd:
            return "yyyy-MM-dd"
        case .dd_slash_mm_slash_yyyy:
            return "dd/MM/yyyy"
        case .mm_dd_yyyy:
            return "MM/dd/yyyy"
        }
    }
}
