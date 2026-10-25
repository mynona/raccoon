---
name: skill-preview-app
description: Defines the architectural pattern, folder separation, template usage, and implementation standards for the preview app in Sources/Preview. Always use this skill whenever adjusting, extending, reviewing, adding new component previews, adding routes, or modifying templates/views in the preview application.
---

# Preview Application Architecture & Split Guide

This guide establishes the architectural boundaries, folder structure, template rules, and extension workflow for the preview application (`Sources/Preview/`).

---

## 1. Architectural Mission & Repository Separation

This repository's preview contains:

```text
Sources/Preview/
├── configure.swift                  # Server port (8090) and FileMiddleware setup
├── main.swift                       # Executable entrypoint
├── routes.swift                     # Clean top-level route collection registrations
│
├── Shared/                          # Shared domain-agnostic preview machinery
│   ├── Templates/                   # Standalone 'Basic' template, BasicStyles, PreviewNavigation
│   ├── Helpers/                     # showComponentPreview, showCode, showData, prettySwift, Helpers, TemplateRenderer
│   ├── DemoData/                    # DemoData, FakeSearchResults
│   ├── Simulation/                  # SimulationController (mock upload & search endpoints)
│   └── Views/                       # HomeView.swift (overview dashboard)
│
└── Raccoon/                         # Pure UI kit preview (100% domain-agnostic)
    ├── Controllers/                 # RaccoonPreviewController.swift (RouteCollection for all core components)
    └── Views/                       # All core UI component views (AccordionView, BadgeView, SearchFieldView, etc.)
```

---

## 2. Decoupling Rules & Boundaries

1. **The Raccoon preview must stay domain-agnostic**:
   - Views in `Sources/Preview/Raccoon/Views/` and `RaccoonPreviewController` only import `Raccoon`, `Vapor`, `HTML`, `SGML`, `SVG`, `WebBuilders`.
   - Views must stay minimal: don't carry unused properties, constructor parameters, or imports left over from a previous design. Every view's shape should be exactly what `render()` actually needs.
2. **`Shared/` is pure Raccoon**:
   - The `Basic` template, its styles, navigation data, and preview helpers must remain 100% pure Raccoon.
   - The preview renders through the Preview-local `TemplateRenderer` (`Shared/Helpers/TemplateRenderer.swift`), which wraps `TemplateRepresentable.renderString()` in a Vapor `Response`. `Basic` reads the current path from the task-local `PreviewRequest.path`, set by that renderer.
3. **Dedicated `RouteCollection` Separation**:
   - `RaccoonPreviewController`: Conforms to `RouteCollection, Sendable` and registers Home (`/`, `/preview`) and all core Raccoon component routes.
   - `SimulationController`: Conforms to `RouteCollection, Sendable` and registers test/simulation endpoints (`/success`, `/search`, `/upload`).
   - `routes.swift`: Cleanly registers the top-level route collections.
   - Every route handler method on every controller is marked `@Sendable`, with no stray/dead handler methods left unregistered.

---

## 3. The `Basic` Template Standards

All preview views render inside the standalone `Basic` template (`Sources/Preview/Shared/Templates/Basic.swift`).

### Rules for `Basic`
- **Standalone**: Does NOT inherit from or use `TemplateFrontend`, `MasterFrontend`, or `MasterHead`.
- **Minimal Metadata**: No SEO meta tags, no OpenGraph, no Matomo tracker scripts.
- **Dark / Light Mode & Theme Switcher**:
  - Embeds `DarkLightModeToggle.detectModeScript` and `ThemeSwitcher.detectThemeScript` inline in `<head>` to prevent theme and mode flashing on first paint.
  - Renders `DarkLightModeToggle(DarkLightModeToggleData(matomoStatus: .DEACTIVATED))` and `ThemeSwitcher(ThemeSwitcherData(align: .right, matomoStatus: .DEACTIVATED))` directly in the sidebar header without any artificial background color or wrapper frame.
  - Global `<kbd>Alt+M</kbd>` toggles modes from anywhere on the page.
- **Skip Link**:
  - Renders `SkipLink().render()` at the very top of `<body>`.
  - The main content area has `id="main"` and `role="main"` to receive skip link focus.
- **Sidebar Architecture**:
  - Sticky on the left: `w-60 shrink-0 h-screen sticky top-0 flex flex-col border-r`.
  - Has an explicit `style("width: 17rem; min-width: 17rem;")` for a stable 272px width.
  - Independent vertical scroll with `overflow-y-auto`.
  - Light mode readability: uses `CommonStyles.backgroundLight` (pure white in light mode), `CommonStyles.textColorHighContrast` (near-black text), and `text-black dark:text-gray-200` for links.
- **Sidebar Search Field**:
  - Directly uses the canonical `SearchField` component:
    - Configured with `SearchField(SearchFieldData(name: "sidebarSearchInput", bindModel: "search", bindRef: "searchInput", placeholder: "Filter components...", ariaLabel: "Filter components", size: .sm))`.
    - Compact size variant (`size: .sm`) applies 16px icon, `text-sm` input styling, and compact clear button padding while maintaining container padding (`py-2.5`).
    - Focus restoration on clear via `$nextTick`.
- **Template External Tab Links**:
  - All template previews (`TemplateAuth`, `TemplateCms`, `TemplateErrorCms`, `TemplateFrontend`, `TemplateSystem`) open in a new browser tab.
  - They have `isOpenInNewTab = true` in `PreviewNavigation.swift`.
  - In the sidebar, they render `target="_blank"`, `rel="noopener noreferrer"`, and an `Svg.icon(.arrow_up_right_square, width: 16, height: 16)` icon wrapped in a `Span` with `pr-2 flex items-center` to preserve the 16×16 minimum size.

---

## 4. How to Extend the Preview Application

### Adding a New Core Raccoon UI Kit Component
1. **Create the View**:
   - Add `Sources/Preview/Raccoon/Views/<ComponentName>View.swift`.
   - Wrap output in `Basic(title: "<ComponentName>") { ... }.render()`.
   - Do NOT add domain imports (`raumnebenan_api_dto`, `OAuthHelpers`); this package has no such dependency.
2. **Add the Controller Route**:
   - In `Sources/Preview/Raccoon/Controllers/RaccoonPreviewController.swift`:
     - Add route registration in `boot(routes:)`: `preview.get("<route-slug>", use: get<ComponentName>)`.
     - Add action method: `@Sendable func get<ComponentName>(_ request: Request) async throws -> Response { request.templates.renderHtml(<ComponentName>View()) }`.
3. **Add Navigation Entry**:
   - In `Sources/Preview/Shared/Templates/PreviewNavigation.swift`:
     - Add `PreviewNavItem(title: "<ComponentName>", url: "/preview/<route-slug>")` under the `Raccoon` group.

---

## 5. Verification Checklist

Whenever modifying the preview application:
- [ ] `swift build --target Preview` succeeds without warnings or errors.
- [ ] `swift test` passes.
- [ ] No file under `Sources/` imports `RaccoonRaumnebenan`, `OAuthHelpers` or `raumnebenan_api_dto`.
- [ ] No view carries an unused property, constructor parameter, or import left over from a previous refactor (verify by checking it's actually read inside `render(_:)`).
- [ ] All controller structs conform to `RouteCollection, Sendable`, and every route handler method is marked `@Sendable`.
- [ ] No dead/unregistered handler methods remain in a controller (every `func` in a controller is wired up in `boot(routes:)` or is a legitimate private helper it calls).
- [ ] The sidebar is positioned on the left with independent scrolling.
- [ ] Search field uses `SearchField` component (`size: .sm`) with working clear button.
- [ ] Light mode and dark mode both maintain WCAG AA contrast.
- [ ] Template links open in a new tab with `arrow-up-right-square` (16×16) and `pr-2`.
