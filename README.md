# swift-web-components

Swift package providing reusable UI components for raumnebenan.de, built with [swift-web-standards](https://github.com/binarybirds/swift-web-standards) and Tailwind CSS.

## Requirements

- Swift 6.2+
- macOS 15+

## Preview Server

The package includes a `Preview` executable target — a local Vapor server that renders all components in isolation.

## Components

The library is the domain-agnostic UI kit **`Raccoon`**. The domain-specific components and site templates for raumnebenan.de live in the separate package [raccoon-raumnebenan](https://github.com/mynona/raccoon-raumnebenan), which depends on this one.

Components render without a web framework: `TemplateRepresentable.render()` returns the element tree and `renderString()` produces a complete document string. Wrap that string in your framework's response type (Vapor, Hummingbird, ...).

### Core UI Components (`Sources/Raccoon/Components`)

57 domain-agnostic UI components:

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
| `DatePicker` | Date selection input with calendar picker |
| `Definition` | Definition term and description block for explanatory content |
| `DeleteModal` | Confirmation modal dialog for delete and destructive actions |
| `Dropdown` | Accessible single-option form dropdown without search, styling-matched to `SimpleMenu` and interchangeable with `SingleSelect` |
| `ErrorMessage` | Inline validation and error notification element |
| `FileList` | List view displaying downloadable files with metadata |
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
| `LinkButton` | Anchor link styled as an action button |
| `LinkList` | Curated list of hyperlinks with optional icons and descriptions |
| `Logo` | Brand logo renderer with size and theme variants |
| `MarkdownBlock` | Markdown-rendered content block converted to accessible HTML |
| `MatomoTracker` | Consent-aware Matomo analytics tags with no-JavaScript fallback |
| `Mermaid` | Interactive client-side Mermaid diagram rendering component |
| `MultiSelect` | Select input allowing multiple concurrent selections with tags |
| `MultipleFileUpload` | Drag-and-drop multiple file upload zone with preview list |
| `Notification` | Floating or banner alert notifications (info, success, warning, error) |
| `Pagination` | Page navigation bar with next, previous, and page numbers |
| `PasswordInput` | Masked password input field with reveal/hide toggle |
| `Quote` | Blockquote element for quotations and citations |
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
| `ToggleSwitch` | Accessible binary toggle switch control |
| `Tooltip` | Hover- and focus-activated contextual tooltip |
| `ViewMaskedSecret` | Revealable secret / masked credential viewer |

### Start the preview

```bash
swift run Preview
```

The server starts on:

```
http://127.0.0.1:8090
```

### Dark / light mode

The preview includes a toggle button in the top-right corner that mirrors the dark/light mode behaviour of the production site.

## Styling with Tailwind CSS Themes

Raccoon components output semantic Tailwind CSS utility classes rather than shipping pre-compiled, rigid styles. Consuming applications define their visual theme, colors, typography, and dark mode via Tailwind CSS v4.

### 1. Configure Source Scanning

In your application's Tailwind CSS entrypoint (`input.css`), configure `@source` to scan Raccoon's Swift files for class detection:

```css
@import "tailwindcss";

/* Scan Raccoon Swift files in your SwiftPM package checkout */
@source ".build/checkouts/raccoon/**/*.swift";

/* Custom variant for class-based dark mode toggling */
@custom-variant dark (&:where(.dark, .dark *));
```

### 2. Define Theme Tokens (`@theme`)

Raccoon components consume semantic design tokens (surfaces, buttons, focus rings, status indicators) mapped via Tailwind's `@theme` directive:

```css
@theme {
  /* Font Families */
  --font-sans: 'Inter', system-ui, -apple-system, sans-serif;
  --font-serif: 'Merriweather', Georgia, serif;
  --font-mono: 'SFMono-Regular', Menlo, Monaco, Consolas, monospace;

  /* Surfaces & Backgrounds */
  --color-surface: #ffffff;
  --color-surface-dark: #1f2937;
  --color-inverse-surface: #111827;
  --color-scrim: rgba(0, 0, 0, 0.5);

  /* Typography Colors */
  --color-on-surface: #111827;
  --color-on-surface-bright: #000000;
  --color-on-surface-dim: #6b7280;
  --color-on-inverse-surface: #ffffff;

  /* Primary Button / Actions */
  --color-primary: #111827;
  --color-on-primary: #ffffff;

  /* Secondary Button / Outlined */
  --color-secondary: transparent;
  --color-on-secondary: #111827;

  /* Tertiary Button / Soft Background */
  --color-tertiary: #f3f4f6;
  --color-on-tertiary: #111827;

  /* Disabled State */
  --color-disabled: #f3f4f6;
  --color-on-disabled: #9ca3af;

  /* Focus & Hover Rings */
  --color-focusring: #2563eb;
  --color-hoverring: #111827;

  /* Status Colors */
  --color-on-theme: #2563eb;
  --color-on-success: #16a34a;
  --color-error: #dc2626;
  --color-on-error: #ffffff;
  --color-on-error-variant: #dc2626;
}
```

### 3. Dark Mode Theme Overrides

Override the theme variables inside `.dark` within `@layer base` to support dark mode:

```css
@layer base {
  .dark {
    /* Surfaces */
    --color-surface: #111827;
    --color-surface-dark: #0f172a;
    --color-inverse-surface: #f9fafb;

    /* Typography */
    --color-on-surface: #f9fafb;
    --color-on-surface-bright: #ffffff;
    --color-on-surface-dim: #9ca3af;
    --color-on-inverse-surface: #111827;

    /* Buttons */
    --color-primary: #3b82f6;
    --color-on-primary: #111827;
    --color-secondary: transparent;
    --color-on-secondary: #60a5fa;
    --color-tertiary: rgba(59, 130, 246, 0.1);
    --color-on-tertiary: #93c5fd;
    --color-disabled: #1f2937;
    --color-on-disabled: #4b5563;

    /* Focus & Hover Rings */
    --color-hoverring: #ffffff;
    --color-focusring: #60a5fa;

    /* Status Colors */
    --color-on-theme: #60a5fa;
    --color-on-success: #4ade80;
    --color-on-error-variant: #f87171;
  }
}
```

### 4. Build the Stylesheet

Compile and minify your CSS bundle using the Tailwind CLI:

```bash
npx @tailwindcss/cli -i ./input.css -o ./Public/css/main.css --minify
```

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
    Components/                 # 57 reusable UI components
    Enums/                      # Shared enumerations (ComponentSize, ComponentState, etc.)
    LittleHelpers/              # Utility functions, SEO, and Matomo tracking
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
