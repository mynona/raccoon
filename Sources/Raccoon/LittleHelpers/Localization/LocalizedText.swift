import Foundation
import HTML
import SGML

/// A translatable string: a stable key plus the English default that Swift renders.
///
/// Placeholders use `{{name}}` (no spaces). The English default is always rendered
/// by Swift, so content exists without JavaScript. The browser store replaces it
/// with the translation for `<html lang>`.
public struct LocalizedText: Sendable, Equatable {
    public let key: String
    public let template: String
    public let variables: [String: String]

    public init(
        _ key: String,
        _ english: String,
        variables: [String: String] = [:]
    ) {
        self.key = key
        self.template = english
        self.variables = variables
    }

    /// The English text with all variables substituted.
    public var english: String {
        variables.reduce(template) {
            $0.replacingOccurrences(of: "{{\($1.key)}}", with: $1.value)
        }
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

    private func localizedVariables(_ text: LocalizedText) -> Self {
        guard !text.variables.isEmpty else { return self }
        return setAttribute(
            name: "data-i18n-vars",
            value: JavaScriptEscaper.htmlAttributeEscape(
                JavaScriptEscaper.jsonEncode(text.variables)
            )
        )
    }

    /// Marks the text content of a leaf element as translatable.
    /// Use it only on elements without child elements.
    public func localized(_ text: LocalizedText) -> Self {
        setAttribute(name: "data-i18n", value: text.key)
            .localizedVariables(text)
    }

    /// Sets an attribute to the English default and marks it as translatable.
    public func localized(
        _ attribute: LocalizableAttribute,
        _ text: LocalizedText
    ) -> Self {
        setAttribute(
            name: attribute.rawValue,
            value: JavaScriptEscaper.htmlAttributeEscape(text.english)
        )
        .setAttribute(name: "data-i18n-\(attribute.rawValue)", value: text.key)
        .localizedVariables(text)
    }
}

/// Custom vocabulary for one component namespace, keyed by language.
public struct LocalizedStrings: Sendable, Equatable {
    public let values: [String: [String: String]]

    public init(_ values: [String: [String: String]]) {
        self.values = values
    }

    /// Inline script that registers the vocabulary as an override in the browser store.
    public func scriptElement(namespace: String) -> Script {
        let json = JavaScriptEscaper.jsonEncode(values, fallback: "{}")
            .replacingOccurrences(of: "</", with: "<\\/")
        return Script(
            "window.RaccoonI18n&&window.RaccoonI18n.override(\(JavaScriptEscaper.jsonStringLiteral(namespace)),\(json));"
        )
    }
}
