import Foundation
import HTML
import SGML
import WebBuilders

/// Language of the page that is rendered right now, and the texts that the page used.
///
/// Set once per page with `I18n.render(language:collectsUsedKeys:_:)`. Components never take a language.
public final class I18nContext: @unchecked Sendable {
    /// Base language of the page (`de-AT` becomes `de`).
    public let language: String

    private let collects: Bool
    private let lock = NSLock()
    private var used: Set<String> = []

    public init(language: String, collectsUsedKeys: Bool = false) {
        self.language = I18nContext.baseLanguage(language)
        self.collects = collectsUsedKeys
    }

    /// `de-AT` -> `de`, empty -> `en`.
    public static func baseLanguage(_ tag: String) -> String {
        let base = tag.lowercased()
            .split(whereSeparator: { $0 == "-" || $0 == "_" })
            .first.map(String.init)
        return (base?.isEmpty ?? true) ? "en" : base!
    }

    func record(_ key: String) {
        guard collects else { return }
        lock.lock()
        used.insert(key)
        lock.unlock()
    }

    /// Full keys (`namespace.key`) of the built-in texts that were rendered, sorted.
    public var usedKeys: [String] {
        lock.lock()
        defer { lock.unlock() }
        return used.sorted()
    }
}

public enum I18n {
    /// The page that is rendered right now. English, without collecting, by default.
    @TaskLocal public static var context = I18nContext(language: "en")

    /// Renders `body` for one page language. Set `collectsUsedKeys` when the page writes `I18n.scripts()`.
    public static func render<T>(
        language: String,
        collectsUsedKeys: Bool = false,
        _ body: () -> T
    ) -> T {
        $context.withValue(
            I18nContext(language: language, collectsUsedKeys: collectsUsedKeys),
            operation: body
        )
    }

    /// The browser store. Idempotent. Only needed for live language switching.
    public static func engine() -> Script {
        Script()
            .src("/js/i18n.js")
            .setAttribute(name: "type", value: "text/javascript")
    }

    /// Store plus the translations of the built-in texts this page used. Write it once, after the body content.
    @Builder<Element>
    public static func scripts() -> [Element] {
        engine()
        pageDictionary()
    }

    /// Registers all languages for exactly the built-in keys that were rendered on this page.
    static func pageDictionary() -> Script {
        var byNamespace: [String: [String: [String: String]]] = [:]
        for fullKey in context.usedKeys {
            guard let dot = fullKey.firstIndex(of: ".") else { continue }
            let namespace = String(fullKey[..<dot])
            let key = String(fullKey[fullKey.index(after: dot)...])
            for (language, text) in Translations.all[namespace]?[key] ?? [:] {
                byNamespace[namespace, default: [:]][language, default: [:]][
                    key
                ] = text
            }
        }
        // namespace -> language -> key -> text, each level as sorted JSON
        let json = jsonObject(
            byNamespace.mapValues { languages in
                jsonObject(languages.mapValues(jsonStrings))
            }
        )
        .replacingOccurrences(of: "</", with: "<\\/")
        return Script(
            "(function(d){var i=window.RaccoonI18n;if(!i)return;Object.keys(d).forEach(function(n){i.register(n,d[n])})})(\(json));"
        )
    }

    /// JSON object with sorted keys, so the rendered HTML is stable. Values are already JSON.
    static func jsonObject(_ rawValues: [String: String]) -> String {
        "{"
            + rawValues.sorted { $0.key < $1.key }
            .map {
                "\(JavaScriptEscaper.jsonStringLiteral($0.key)):\($0.value)"
            }
            .joined(separator: ",") + "}"
    }

    /// JSON object of strings with sorted keys.
    static func jsonStrings(_ values: [String: String]) -> String {
        jsonObject(values.mapValues { JavaScriptEscaper.jsonStringLiteral($0) })
    }
}

/// Built-in translations: `[namespace: [key: [language: text]]]`. One table per component, listed in `all`.
public enum Translations {
    public static let all: [String: [String: [String: String]]] = [
        "label": label,
        "actionbutton": actionbutton,
        "avatar": avatar,
        "breadcrumb": breadcrumb,
        "toggleswitch": toggleswitch,
        "copytoclipboard": copytoclipboard,
        "darklightmodetoggle": darklightmodetoggle,
        "glossary": glossary,
        "linkbutton": linkbutton,
        "pagination": pagination,
        "searchfield": searchfield,
    ]

    static let label: [String: [String: String]] = [
        "required": [
            "en": "(required)",
            "de": "(erforderlich)",
            "fr": "(obligatoire)",
            "es": "(obligatorio)",
            "it": "(obbligatorio)",
        ]
    ]
}
