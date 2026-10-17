import Foundation

/// Available color themes defined in the application stylesheet.
public enum AppTheme: String, CaseIterable, Sendable {
    /// Default green theme (Raumnebenan).
    case raumnebenan = "raumnebenan"
    /// High-contrast black and white theme.
    case blackAndWhite = "black-and-white"
    /// Beacon blue theme.
    case beaconBlue = "beacon-blue"

    /// The human-readable label shown in the dropdown menu.
    public var displayName: String {
        switch self {
        case .raumnebenan:
            return "raumnebenan"
        case .blackAndWhite:
            return "black and white"
        case .beaconBlue:
            return "beacon blue"
        }
    }

    /// The `data-theme` attribute value applied to `<html>`.
    public var domValue: String {
        rawValue
    }
}

/// Configuration data for the `ThemeSwitcher` component.
public struct ThemeSwitcherData: Sendable {

    public typealias ThemeOption = AppTheme

    // MARK: - 1. Identity & Alpine Bindings

    /// Optional unique DOM identifier for the switcher.
    public let id: String?

    // MARK: - 2. Content & Accessibility

    /// Accessible name for screen readers.
    public let ariaLabel: String

    // MARK: - 3. Value & Options

    /// The default theme when none is stored.
    public let defaultTheme: AppTheme

    /// The list of available themes to display in the dropdown.
    public let themes: [AppTheme]

    // MARK: - 5. Presentation & State

    /// Alignment of the dropdown menu panel relative to the trigger button.
    public let align: ComponentPosition

    // MARK: - 6. Analytics & Tracking

    /// Matomo tracking consent status.
    public let matomoStatus: MatomoStatus

    /// Creates a new configuration instance for `ThemeSwitcher`.
    ///
    /// - Parameters:
    ///   - id: Optional unique DOM identifier for the switcher.
    ///   - ariaLabel: Accessible name for screen readers.
    ///   - defaultTheme: The default theme when none is stored.
    ///   - themes: The list of available themes to display in the dropdown.
    ///   - align: Alignment of the dropdown menu panel relative to the trigger button.
    ///   - matomoStatus: Matomo tracking consent status.
    public init(
        id: String? = nil,
        ariaLabel: String = "Select color theme",
        defaultTheme: AppTheme = .raumnebenan,
        themes: [AppTheme] = AppTheme.allCases,
        align: ComponentPosition = .left,
        matomoStatus: MatomoStatus = .DECLINED
    ) {
        self.id = id
        self.ariaLabel = ariaLabel
        self.defaultTheme = defaultTheme
        self.themes = themes
        self.align = align
        self.matomoStatus = matomoStatus
    }
}
