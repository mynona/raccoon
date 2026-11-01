import Foundation
import HTML
import SGML
import WebBuilders

/// A text that can be shown in several languages.
///
/// Three kinds, one type:
/// - **Built-in text:** `LocalizedText("label.required", "(required)")`. The translations are part of Raccoon
///   (`Translations`), a consumer never provides them. Used for the defaults inside components.
/// - **Consumer text with translations:** `LocalizedText(en: "Save", translations: ["de": "Speichern"])`.
///   English is required. Other languages are optional and can be added without any API change.
/// - **Plain text:** a string literal (`label: "Save"`) or `LocalizedText(verbatim:)`. It is shown as given
///   in every language and gets no marker.
///
/// Placeholders use `{{name}}` (no spaces), values go in `variables`. The page language comes from
/// `I18n.context`; a missing translation falls back to English.
public struct LocalizedText: Sendable, Hashable, ExpressibleByStringLiteral,
    CustomStringConvertible
{
    /// `namespace.key` of a built-in text, empty for consumer and plain texts.
    public let key: String
    /// The English text with `{{placeholders}}`.
    public let template: String
    public let variables: [String: String]
    /// Consumer translations by language code (without English), empty for built-in and plain texts.
    public let translations: [String: String]
    /// The English text with all variables substituted (computed once).
    public let english: String

    /// Built-in text. The English default is written next to the key and checked against `Translations`.
    public init(
        _ key: String,
        _ english: String,
        variables: [String: String] = [:]
    ) {
        self.key = key
        self.template = english
        self.variables = variables
        self.translations = [:]
        self.english = LocalizedText.substitute(english, variables)
    }

    /// Consumer text. `translations` maps a base language code (`de`, not `de-AT`) to the text.
    public init(
        en english: String,
        translations: [String: String] = [:],
        variables: [String: String] = [:]
    ) {
        assert(
            translations.keys.allSatisfy { I18nContext.baseLanguage($0) == $0 },
            "LocalizedText: use base language codes in lower case (de, not de-AT)"
        )
        self.key = ""
        self.template = english
        self.variables = variables
        self.translations = translations.filter { $0.key != "en" }
        self.english = LocalizedText.substitute(english, variables)
    }

    /// A plain text: shown as given in every language, no marker.
    public init(verbatim value: String) {
        self.init("", value)
    }

    public init(stringLiteral value: String) {
        self.init("", value)
    }

    /// The same text with other values for its `{{placeholders}}`. Use it to declare a text once
    /// and fill it in where it is shown.
    public func with(variables: [String: String]) -> LocalizedText {
        if !key.isEmpty {
            return LocalizedText(key, template, variables: variables)
        }
        return LocalizedText(
            en: template,
            translations: translations,
            variables: variables
        )
    }

    /// `false` for plain texts: they are never translated and get no marker.
    public var isTranslatable: Bool { !key.isEmpty || !translations.isEmpty }

    /// Safety net: a `LocalizedText` that is interpolated into a `String` by mistake
    /// (`"\(data.title)"`) compiles. It then yields the English text, not a debug dump.
    /// The translation is lost there, so migrate such sites explicitly (use `.resolved`).
    public var description: String { english }

    fileprivate static func substitute(
        _ template: String,
        _ variables: [String: String]
    ) -> String {
        guard !variables.isEmpty else { return template }
        return variables.reduce(template) {
            $0.replacingOccurrences(of: "{{\($1.key)}}", with: $1.value)
        }
    }

    /// Marks a built-in text as used by the page without resolving it (for texts that a script shows),
    /// so that it lands in the page dictionary.
    func recordUse() {
        if !key.isEmpty { I18n.context.record(key) }
    }

    /// The text in the language of the page that is rendered right now (`I18n.context`).
    /// Falls back to the English text. Plain texts are returned as given.
    public var resolved: String {
        if !key.isEmpty {
            let context = I18n.context
            context.record(key)
            if context.language == "en" { return english }
            guard let dot = key.firstIndex(of: "."),
                let text = Translations.all[String(key[..<dot])]?[
                    String(key[key.index(after: dot)...])
                ]?[context.language]
            else { return english }
            return LocalizedText.substitute(text, variables)
        }
        guard !translations.isEmpty,
            let text = translations[I18n.context.language]
        else { return english }
        return LocalizedText.substitute(text, variables)
    }

    /// English plus the consumer translations, for the browser store.
    fileprivate var markerValues: [String: String] {
        translations.merging(["en": template]) { current, _ in current }
    }

    /// The marker attributes of a translatable text: the key (built-in) or the `-values` map (consumer),
    /// plus `data-i18n-vars` when there are variables. `base` is `data-i18n` or `data-i18n-<attribute>`.
    func markerAttributes(base: String) -> [(name: String, value: String)] {
        var result: [(name: String, value: String)] = []
        if !key.isEmpty {
            result.append((base, key))
        }
        else {
            result.append(
                (
                    "\(base)-values",
                    JavaScriptEscaper.htmlAttributeEscape(
                        I18n.jsonStrings(markerValues)
                    )
                )
            )
        }
        if !variables.isEmpty {
            result.append(
                (
                    "data-i18n-vars",
                    JavaScriptEscaper.htmlAttributeEscape(
                        I18n.jsonStrings(variables)
                    )
                )
            )
        }
        return result
    }

    /// JavaScript expression for Alpine bindings (`:aria-label`, `x-text`, ...).
    /// It falls back to the resolved text if the store is not loaded.
    /// The result is safe inside a double-quoted HTML attribute.
    public var alpineExpression: String {
        let fallback = JavaScriptEscaper.alpineStringLiteral(resolved)
        guard isTranslatable else {
            return fallback.replacingOccurrences(of: "\"", with: "&quot;")
        }
        let values =
            variables.isEmpty
            ? "null"
            : "{"
                + variables.sorted { $0.key < $1.key }
                .map {
                    "\($0.key):\(JavaScriptEscaper.alpineStringLiteral($0.value))"
                }
                .joined(separator: ",") + "}"
        let call: String
        if key.isEmpty {
            let map =
                "{"
                + markerValues.sorted { $0.key < $1.key }
                .map {
                    "\(JavaScriptEscaper.alpineStringLiteral($0.key)):\(JavaScriptEscaper.alpineStringLiteral($0.value))"
                }
                .joined(separator: ",") + "}"
            call = "RaccoonI18n.pick(\(map),\(values),\(fallback))"
        }
        else {
            call =
                "RaccoonI18n.t(\(JavaScriptEscaper.alpineStringLiteral(key)),\(values),\(fallback))"
        }
        return "(window.RaccoonI18n?\(call):\(fallback))"
            .replacingOccurrences(of: "\"", with: "&quot;")
    }
}

/// Attributes that the browser store can translate.
public enum LocalizableAttribute: String, Sendable {
    case ariaLabel = "aria-label"
    case title
    case placeholder
    case alt
}

extension SGML.Attributes where Self: SGML.Mutable {

    private func localizedMarkers(_ text: LocalizedText, base: String) -> Self {
        text.markerAttributes(base: base)
            .reduce(self) {
                $0.setAttribute(name: $1.name, value: $1.value)
            }
    }

    /// Marks the text content of a leaf element as translatable. The element content itself must be
    /// `text.resolved`. Use it only on elements without child elements. Plain texts get no marker.
    public func localized(_ text: LocalizedText) -> Self {
        guard text.isTranslatable else { return self }
        return localizedMarkers(text, base: "data-i18n")
    }

    /// Sets an attribute to the resolved text and, for translatable texts, adds the marker.
    /// Plain texts only set the value.
    public func localized(
        _ attribute: LocalizableAttribute,
        _ text: LocalizedText
    ) -> Self {
        let valueSet = setAttribute(
            name: attribute.rawValue,
            value: JavaScriptEscaper.htmlAttributeEscape(text.resolved)
        )
        guard text.isTranslatable else { return valueSet }
        return valueSet.localizedMarkers(
            text,
            base: "data-i18n-\(attribute.rawValue)"
        )
    }
}
