# raccoon

UI web components built with [swift-web-standards](https://github.com/binarybirds/swift-web-standards), Tailwind CSS and Alpine.js

## Requirements

- Swift 6.2+
- macOS 15+

## Preview 

### Live

> [https://raccoon-preview.onrender.com](https://raccoon-preview.onrender.com) 
>
> Hosted on a free tier; initial spin-up can take up to 50 seconds


### Local preview

Build the local preview

```bash
swift run Preview
```

The server starts on:

```
http://127.0.0.1:8090
```

## UI Kit

### Usage

Example: generate the html code for an accordion.

```
import Raccoon

let html = renderHTML(
            Accordion(
                AccordionData(
                    label: "What is Vapor?",
                    content: .html("A Swift web framework.")
                )
            )
            .render()
```

### Components

| Component | Description |
|---|---|
| `Accordion` | Expandable content section supporting HTML and Markdown |
| `ActionButton` | Interactive button supporting primary, secondary, warning, delete, and link variants |
| `AudioPlayer` | Audio player widget with playback controls and track information |
| `Avatar` | User or entity avatar with image and placeholder support |
| `Badge` | Inline status and indicator badge in various color schemes |
| `Breadcrumb` | Hierarchical navigational breadcrumb trail |
| `ByMeACoffee` | Buy-me-a-coffee donation and support widget |
| `Carousel` | Interactive image and content slider |
| `Check` | Standalone checkbox input with custom label and styling |
| `CheckboxSelect` | Multi-option checkbox group with optional search filtering |
| `CodeBlock` | Syntax-styled code presentation block with language display |
| `CookieBanner` | GDPR-compliant cookie consent banner |
| `CopyToClipboard` | Text copy widget with visual feedback confirmation |
| `DarkLightModeToggle` | Colour mode switch with localStorage persistence and Alt+M shortcut |
| `DataTable` | Accessible API-driven data table supporting server-side sorting, filtering, search, and pagination |
| `DatePicker` | Date selection input with calendar picker |
| `Definition` | Definition term and description block for explanatory content |
| `DeleteModal` | Confirmation modal dialog for delete and destructive actions |
| `Dropdown` | Accessible single-option form dropdown without search, styling-matched to `SimpleMenu` and interchangeable with `SingleSelect` |
| `ErrorMessage` | Inline validation and error notification element |
| `ErrorSummary` | Summary of a form's problems with the count and a link to each field, rendered by `FormBuilder` with `validationMethod: .errorSummary` |
| `FileList` | List view displaying downloadable files with metadata |
| `FormBuilder` | Declarative form builder rendering accessible form fields, groups, and actions in page or dialog layouts |
| `Glossary` | Searchable glossary overview and index |
| `GlossaryEntry` | Individual term definition entry within a glossary |
| `HelperText` | Contextual hint and helper text below input fields |
| `HiddenField` | Hidden HTML form input for CSRF tokens and internal state |
| `HyperLink` | Styled anchor link with external link indicator |
| `InputField` | Text and data input field with label and validation states |
| `InputList` | Dynamic key-value or item list input control |
| `KeyboardKey` | Visual keyboard key representation (`<kbd>`) |
| `KeyTakeaways` | Highlighted key takeaways box for articles and summaries |
| `Label` | Accessible form field label with required marker support |
| `LanguageSwitcher` | Accessible dropdown for selecting page language with native language names and globe icon |
| `LinkButton` | Anchor link styled as an action button |
| `LinkList` | Curated list of hyperlinks with optional icons and descriptions |
| `Logo` | Brand logo renderer with size and theme variants |
| `MarkdownBlock` | Markdown-rendered content block converted to accessible HTML |
| `MatomoTracker` | Consent-aware Matomo analytics tags with no-JavaScript fallback |
| `Mermaid` | Interactive client-side Mermaid diagram rendering component |
| `MultipleFileUpload` | Drag-and-drop multiple file upload zone with preview list |
| `MultiSelect` | Select input allowing multiple concurrent selections with tags |
| `Notification` | Floating or banner alert notifications (info, success, warning, error) |
| `Pagination` | Page navigation bar with next, previous, and page numbers |
| `PasswordInput` | Masked password input field with reveal/hide toggle |
| `Pill` | Rounded pill badge displaying a counter or text label |
| `Quote` | Blockquote element for quotations and citations |
| `Radio` | Standalone radio button input with label, helper text, and validation states |
| `RadioGroup` | Accessible group of related radio buttons rendered as a fieldset with keyboard arrow navigation |
| `Rating` | Star rating component supporting inline and floating display modes |
| `References` | Scholarly and external reference list for articles |
| `SearchField` | Standardized search field component with leading icon, Alpine bindings, and focus-restoring clear button |
| `SimpleMenu` | Accessible floating dropdown menu supporting both SSR link navigation and Alpine.js interactive modes |
| `SimpleTable` | Accessible data table with header and row formatting |
| `SingleFileUpload` | Single-file drag-and-drop upload input with status feedback |
| `SingleSelect` | Accessible dropdown single-option selector |
| `SkipLink` | Accessible keyboard skip navigation link targeting main landmark content |
| `Spacer` | Configurable spacing element for vertical layout flow |
| `Stepper` | Multi-step progress indicator supporting horizontal and vertical orientations |
| `TabGroup` | Tabbed navigation and content container supporting pills and underlined variants |
| `TablePaginator` | Standardized data table paginator supporting client-side Alpine.js and SSR navigation modes |
| `TextAreaField` | Multi-line text input field with optional counter |
| `ThemeSwitcher` | Accessible color theme dropdown switcher with localStorage persistence |
| `ToggleSwitch` | Accessible binary toggle switch control |
| `Tooltip` | Hover- and focus-activated contextual tooltip |
| `ViewMaskedSecret` | Revealable secret / masked credential viewer |

## Localization (i18n)

Raccoon components render on the server in one page language and include a lightweight client-side store (`Public/js/i18n.js`) allowing live language switching in the browser without a full page reload.

### Rendering in a language

Wrap page rendering in `I18n.render(language:)`:

```swift
import Raccoon

let html = I18n.render(language: "de", collectsUsedKeys: true) {
    page.renderString(type: .html5, minify: false, indent: 0)
}
```

The rendering context is task-local, making it thread-safe for concurrent server requests.

### LocalizedText

All user-facing component strings accept `LocalizedText`:

- **Built-in texts:** Components provide default strings translated across 20 European languages (`en`, `de`, `fr`, `es`, `it`, `pt`, `nl`, `lb`, `da`, `sv`, `nb`, `fi`, `is`, `el`, `tr`, `hu`, `hr`, `pl`, `sk`, `cs`). Passing `nil` for optional text properties falls back to the translated built-in default.
- **Consumer translations:** Supply custom translations with `LocalizedText(en: "Save", translations: ["de": "Speichern"])`.
- **Plain literals:** Plain string literals (`"Save"`) are displayed verbatim in every language.

```swift
ActionButton(
    ActionButtonData(
        label: LocalizedText(en: "Save", translations: ["de": "Speichern", "fr": "Enregistrer"]),
        ariaLabel: "Save the document",
        tooltip: nil // Uses built-in translated default tooltip
    )
).render()
```

### Client-side switching

To enable dynamic language switching in the browser:

1. Serve `Public/js/i18n.js` at `/js/i18n.js`.
2. Output `I18n.scripts()` once near the end of `<body>` to emit the client engine and the dictionary of keys used on the page:

```swift
Body {
    content
    I18n.scripts()
}
.lang(language)
```

3. Changing `<html lang="...">` (for example, via the built-in `LanguageSwitcher` component) instantly re-translates marked elements without reloading the page.

## Matomo (optional)

Each component has integrated Matomo for analytics to track component usage.

If not deliberately requested via the component configuration, no Matomo classes are generated.

## Theming & Alpine.js

Raccoon components output semantic Tailwind CSS utility classes and declarative Alpine.js attributes. Consuming applications define their visual theme, colors, typography, and dark mode via Tailwind CSS v4, and bundle Alpine.js with the required accessibility plugins.

All theming guides, build configurations, plugin requirements, and customization instructions are documented in **[`Theming/README.md`](./Theming/README.md)**.

## Running Tests

```bash
swift test
```

To run a specific test suite:

```bash
swift test --filter "AccordionTests"
```

## Package Structure

```
Sources/
  Raccoon/                      # Core domain-agnostic UI kit
    Components/                 # Reusable UI components
    Enums/                      # Shared enumerations (ComponentSize, ComponentState, etc.)
    LittleHelpers/              # Utility functions, SEO, localization (i18n), and Matomo tracking
    Svg/                        # SVG icon rendering (Svg, SvgIcon)
    Templates/                  # Core rendering protocol (TemplateRepresentable, renderString)
    Theme/                      # CommonStyles design tokens and Tailwind theme classes

  Preview/                      # Executable target — preview server
    Raccoon/                    # Core UI component previews and controllers
    Shared/                     # Basic preview template, navigation, helpers, mock simulation
    configure.swift             # Application configuration
    main.swift                  # Executable entrypoint
    routes.swift                # Route registration

Tests/
  RaccoonTests/                 # Unit and integration tests for core Raccoon UI kit
```

## Attribution & Copyright

### Boostrap icons

This project uses [Bootstrap Icons](https://github.com/twbs/icons).

- **Bootstrap Icons**: Copyright (c) 2019–present The Bootstrap Authors. Licensed under the [MIT License](https://github.com/twbs/icons/blob/main/LICENSE). Sourced from [https://github.com/twbs/icons](https://github.com/twbs/icons).

