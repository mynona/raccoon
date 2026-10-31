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

    @Builder<Element>
    public func render() -> [Element] {
        DebugComment("Language switcher")
        Script()
            .src("/js/languageswitcher.js")
            .setAttribute(name: "type", value: "text/javascript")

        let options = data.languages.map {
            OptionValue(title: $0.name, value: $0.code, lang: $0.code)
        }

        let dropdown = DropdownData(
            id: data.id,
            placeholderAriaLabelText: data.ariaLabel,
            value: data.initialCode,
            options: options,
            state: data.state,
            icon: .globe
        )

        let fallback = JavaScriptEscaper.escapeSingleQuotedString(
            data.initialCode
        )
        let label = JavaScriptEscaper.escapeSingleQuotedString(data.ariaLabel)

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
