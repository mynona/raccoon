import Foundation

/// A language offered by the `LanguageSwitcher`.
public struct LanguageOption: Sendable, Equatable {

    /// Primary language subtag, e.g. "en" or "de". Subtags such as "en-GB" are reduced to "en".
    public let code: String

    /// Name of the language written in that language, e.g. "Deutsch" (not "German").
    public let name: String

    /// Creates a language option.
    ///
    /// - Parameters:
    ///   - code: Language code, e.g. "de". Anything after the first "-" or "_" is dropped and the code is lowercased.
    ///   - name: Name of the language in that language, e.g. "Deutsch".
    public init(code: String, name: String) {
        let primary =
            code.split(whereSeparator: { $0 == "-" || $0 == "_" })
            .first
            .map(String.init)
        self.code = (primary ?? code).lowercased()
        self.name = name
    }
}

/// Configuration data for the `LanguageSwitcher` component.
public struct LanguageSwitcherData: Sendable {

    // MARK: - 1. Identity & Alpine Bindings

    /// Unique identifier for the switcher.
    public let id: String

    // MARK: - 2. Content & Accessibility

    /// Accessible name of the switcher, e.g. "Language". The current language name is appended.
    public let ariaLabel: String

    // MARK: - 3. Value & Options

    /// The languages to offer. There is no built-in set; the caller decides.
    public let languages: [LanguageOption]

    /// Language used when `<html lang>` is missing or not part of `languages`.
    /// If it is not part of `languages` either, the first language is used.
    public let fallbackLanguage: String

    // MARK: - 4. Presentation & State

    /// State of the component (e.g. enabled, disabled, hidden, info).
    public let state: ComponentState

    /// Creates a configuration instance for `LanguageSwitcher`.
    ///
    /// - Parameters:
    ///   - id: Unique identifier for the switcher.
    ///   - ariaLabel: Accessible name of the switcher.
    ///   - languages: The languages to offer.
    ///   - fallbackLanguage: Language used when `<html lang>` is missing or unsupported.
    ///   - state: State of the component.
    public init(
        id: String = "language-switcher",
        ariaLabel: String = "Language",
        languages: [LanguageOption],
        fallbackLanguage: String = "en",
        state: ComponentState = .enabled
    ) {
        self.id = id
        self.ariaLabel = ariaLabel
        self.languages = languages
        self.fallbackLanguage = fallbackLanguage
        self.state = state
    }

    /// Code of the language rendered on the server.
    var initialCode: String {
        if languages.contains(where: { $0.code == fallbackLanguage }) {
            return fallbackLanguage
        }
        return languages.first?.code ?? ""
    }
}
