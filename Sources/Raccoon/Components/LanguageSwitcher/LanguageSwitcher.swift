import HTML
import SGML
import SVG
import WebBuilders

/// LanguageSwitcher
///
/// A `Dropdown` with a globe icon that lets users pick the page language.
/// Language names are written in their own language and carry a `lang` attribute
/// so that screen readers pronounce them correctly. No flags are used.
///
/// The current language is read from `<html lang>` (fallback "en"). Choosing a language
/// sets `<html lang>` to the primary subtag only (e.g. "en", never "en-GB").
public struct LanguageSwitcher: TemplateRepresentable {
    let data: LanguageSwitcherData
    typealias styles = LanguageSwitcherStyles

    public init(_ data: LanguageSwitcherData) {
        self.data = data
    }

    private static let language = LocalizedText(
        "languageswitcher.language",
        "Language"
    )

    @Builder<Element>
    public func render() -> [Element] {
        DebugComment("Language switcher")
        Script()
            .src("/js/languageswitcher.js")
            .setAttribute(name: "type", value: "text/javascript")

        let options = data.languages.map {
            OptionValue(title: $0.name, value: $0.code, lang: $0.code)
        }

        // The script builds "<label>: <language>" for the button, so the label is a plain text
        // in the page language (a marker would overwrite it with the label alone).
        let ariaLabel = (data.ariaLabel ?? Self.language).resolved

        let dropdown = DropdownData(
            id: data.id,
            placeholderAriaLabelText: LocalizedText(verbatim: ariaLabel),
            value: data.initialCode,
            options: options,
            state: data.state,
            icon: .globe
        )

        let fallback = JavaScriptEscaper.escapeSingleQuotedString(
            data.initialCode
        )
        let label = JavaScriptEscaper.escapeSingleQuotedString(ariaLabel)

        Div {
            Dropdown(dropdown).render()
        }
        .setAttribute(
            name: "x-data",
            value:
                "languageSwitcher({ fallback: '\(fallback)', ariaLabel: '\(label)' })"
        )
        .class(styles.container)
    }
}
