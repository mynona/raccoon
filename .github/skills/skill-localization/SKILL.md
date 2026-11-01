---
name: skill-localization
description: How localization (i18n) works in Raccoon and how consumers use it. Always use this skill when adding or changing any user-visible text in a component, adding or editing a `Translations+*.swift` table, using `LocalizedText`, `I18n.render`, `I18n.scripts()` or the `LanguageSwitcher`, or when explaining to an app developer how to render a Raccoon page in a language.
---

# Localization in Raccoon

Raccoon renders HTML on the server in **one page language** and ships a tiny browser store (`Public/js/i18n.js`) so the language can also be switched live without a reload. Components never take a language parameter.

Code lives in `Sources/Raccoon/LittleHelpers/Localization/`:

| File | Purpose |
|---|---|
| `LocalizedText.swift` | `LocalizedText` value type, `.localized(...)` HTML modifiers, `alpineExpression` |
| `I18n.swift` | `I18nContext`, `I18n.render`, `I18n.scripts()/engine()`, and the `Translations.all` registry |
| `Translations+<Component>.swift` | One table per component (built-in texts, 20 languages) |
| `Public/js/i18n.js` | Browser store `window.RaccoonI18n` (`register`, `t`, `pick`, `language`) |

Tests: `Tests/RaccoonTests/I18n*Tests.swift`, `LocalizedTextTests.swift`.

## 1. The three kinds of `LocalizedText`

| Kind | Create with | Who provides translations | Marker for live switching |
|---|---|---|---|
| Built-in | `LocalizedText("label.required", "(required)")` | Raccoon (`Translations`) | yes (`data-i18n`) |
| Consumer text | `LocalizedText(en: "Save", translations: ["de": "Speichern"])` | The consumer | yes (`data-i18n-values`) |
| Plain | `"Save"` (string literal) or `LocalizedText(verbatim:)` | none, shown as given | no |

Rules:
- Placeholders are `{{name}}` (no spaces), values go in `variables:`. Never use Swift `\(...)` interpolation in built-in texts. Use `.with(variables:)` to declare once and fill later.
- Consumer language codes are **base codes in lower case** (`de`, not `de-AT`; an `assert` enforces it). `en` is the required base text; other languages are optional. A missing translation falls back to English.
- `no`/`nn` are mapped to `nb`; `I18nContext.baseLanguage(_:)` does the normalisation.
- Never interpolate a `LocalizedText` into a `String` (`"\(data.title)"`): it yields English only. Use `.resolved`.
- Supported built-in languages (20): `en de fr es it pt nl lb da sv nb fi is el tr hu hr pl sk cs`.

## 2. Consumer usage

### 2.1 Render a page in a language

```swift
let html = I18n.render(language: "de", collectsUsedKeys: true) {
    page.renderString(type: .html5, minify: false, indent: 0)   // any Raccoon components
}
```

- `language` may be a full tag (`de-AT` → `de`). The default context is English.
- The context is a `@TaskLocal`, so it applies to everything rendered inside the closure (also on concurrent requests). Resolve the language per request (query, cookie, `Accept-Language`) as the Preview app does in `Sources/Preview/Shared/Helpers/TemplateRenderer.swift` (`?lang=de`, remembered in a `preview-lang` cookie).
- Set `collectsUsedKeys: true` whenever the page writes `I18n.scripts()` (below).

### 2.2 Texts passed into components

Every user-facing field in `*Data` types is a `LocalizedText` (e.g. `label`, `ariaLabel`, `tooltip`). Pass whichever kind fits:

```swift
ActionButtonData(
    label: LocalizedText(en: "Save", translations: ["de": "Speichern", "fr": "Enregistrer"]),
    ariaLabel: "Save the form",   // plain: same in every language
    tooltip: nil                  // nil: the component's built-in translated default (if it has one)
)
```

Omitted optional texts use the built-in, already translated defaults.

### 2.3 Live language switching (optional)

Write the scripts **once, after the body content**:

```swift
Html {
    Head { ... }
    Body {
        content
        I18n.scripts()                     // store + dictionary of the built-in keys this page used
        Script().src("/js/bundle-min.js")
    }
}
.lang(language)                            // <html lang> is the single source of truth
```

- `I18n.engine()` is only the store script (`/js/i18n.js`), idempotent; `I18n.scripts()` = engine + page dictionary. The dictionary contains only the keys actually rendered (`collectsUsedKeys`), keeping pages small.
- The consumer must serve `Public/js/i18n.js` at `/js/i18n.js`.
- Changing `<html lang>` re-translates all marked elements. Consumer texts carry their own translations in `data-i18n-values`; built-in texts come from the dictionary.
- Content that cannot be translated in the browser (e.g. markdown/HTML demo content) must be re-rendered on the server. The Preview app observes `<html lang>`, stores the choice in the `preview-lang` cookie and reloads (see `Sources/Preview/Shared/Templates/Basic.swift`).

### 2.4 `LanguageSwitcher`

```swift
LanguageSwitcher(
    LanguageSwitcherData(
        languages: LanguageOption.builtIn,   // or a subset / custom LanguageOption(code:name:)
        fallbackLanguage: "en"
    )
).render()
```

Names are written in their own language, with a `lang` attribute; no flags. It sets `<html lang>` to the base subtag. There is no default language set: the caller chooses.

### 2.5 Texts in custom Alpine/JS

Use `text.alpineExpression` inside a `:aria-label` / `x-text` binding. It calls `RaccoonI18n.t` / `pick` and falls back to the resolved text when the store is not loaded.

## 3. Contributor usage: texts inside components

Never hard-code a visible or accessible string in a component. Steps:

1. **Declare** a static built-in text in the component, key `namespace.key`:
   ```swift
   private static let required = LocalizedText("label.required", "(required)")
   ```
   The namespace is lowercase letters/digits (usually the lowercased component name). The English default must be identical to the `en` entry in the table.
2. **Add the translation** in `Translations+<Component>.swift` (`extension Translations { static let <namespace>: [String: [String: String]] = [key: [lang: text]] }`) with **all 20 languages**, and register the table in `Translations.all` in `I18n.swift`. Placeholder sets must equal English in every language.
3. **Render** with `.resolved` plus a marker, so the browser can re-translate:
   ```swift
   Span(Self.required.resolved).localized(Self.required)                // text of a leaf element
   Button { ... }.localized(.ariaLabel, data.ariaLabel ?? Self.label)   // aria-label / title / placeholder / alt
   ```
   - `.localized(_:)` only on leaf elements without child elements; plain texts get no marker automatically.
   - Attributes supported: `LocalizableAttribute` (`ariaLabel`, `title`, `placeholder`, `alt`).
   - For texts only shown by a script, call `recordUse()` (internal) so the key reaches the page dictionary, or use `alpineExpression`.
4. **Data API:** expose user-facing strings as `LocalizedText` / `LocalizedText?` in `*Data` (see `skill-component-data`), document that `nil` falls back to the translated built-in default, and that `LocalizedText(en:translations:)` adds translations.
5. **Fallback chain:** requested language → English. Don't add language-specific logic to components.

Keys used only in hand-written Alpine expressions are invisible to the validator: add them to `allowedUnusedKeys` in `I18nValidationTests.swift` with a Swift comment next to the usage (`carousel.slide` is the existing example).

## 4. Verify

```sh
swift test --filter I18nValidationTests   # all 20 languages present, placeholders match, Swift default == en, no unknown/unused keys
swift test --filter I18nPageTests         # one store script, one dictionary, each key once, small output
swift test --filter I18nStoreTests
swift test --filter LocalizedTextTests
swift test                                # before finishing
```

`I18nValidationTests` scans `Sources/Raccoon` for `LocalizedText("ns.key", "English")` literals, so write the key and the English default as plain string literals on the call (no constants, no interpolation) for the check to see them.

Also check the new text in the Preview app (`Sources/Preview`) in a non-English language, e.g. `?lang=de`.
