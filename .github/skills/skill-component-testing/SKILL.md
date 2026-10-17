---
name: skill-component-testing
description: Guides testing strategies, package architecture, and test execution for the raccoon workspace. Always use this skill when running, writing, reviewing, or debugging tests in this repo, or when working with the boundary between the pure Raccoon UI kit and the separate raccoon-raumnebenan package.
---

# Testing & Package Architecture Guide (Raccoon)

This repository contains the core, framework-neutral UI kit `Raccoon`. The domain-specific components and site templates (`RaccoonRaumnebenan`) live in the separate repository `raccoon-raumnebenan`, which depends on this package.

---

## 1. Package & Test Architecture

```text
Sources/
├── Raccoon/                     # Core UI Kit (100% agnostic, no Vapor, no domain packages)
│   ├── Components/              # UI components (Accordion, Button, Carousel, etc.)
│   ├── Templates/Core/          # TemplateRepresentable, renderString, builders
│   ├── Theme/                   # Theme tokens and style classes
│   └── LittleHelpers/           # General helpers (StableIdentifier, Matomo, SEO, etc.)
└── Preview/                     # Preview server (the only target that uses Vapor)

Tests/
└── RaccoonTests/                # Tests for the UI kit (no Vapor Application needed)
```

### Boundaries

1. **`Raccoon` must stay framework-neutral and domain-agnostic**:
   - No `import Vapor` or `import NIO` in `Sources/Raccoon`.
   - No `raumnebenan_api_dto`, `raumnebenan_library` or `OAuthHelpers` dependency, in the sources or in `RaccoonTests`.
   - Check with:
     ```bash
     swift build --target Raccoon
     ! grep -rnE 'import (Vapor|NIO)' Sources/Raccoon
     ! grep -rn 'raumnebenan_api_dto' Sources/Raccoon Tests/RaccoonTests
     ```
2. **`raccoon-raumnebenan` depends on `Raccoon`, never the reverse.** Domain components and their tests are added to that repository.
3. **Rendering is request-free**: `TemplateRepresentable.render()` takes no arguments. Apps wrap `renderString()` in their own response type.

---

## 2. Running Tests

| What you changed | Command | Why |
| :--- | :--- | :--- |
| A specific suite/test | `swift test --filter <SuiteOrTestName>` | Instant feedback (e.g. `swift test --filter CarouselTests`). |
| Anything in `Sources/Raccoon` / pre-PR | `swift test` | Runs the whole suite (about 1–2 s). |

---

## 3. Best Practices for Writing Tests

All tests use Apple's **Swift Testing** framework (`import Testing`):

1. **Suite & Test Annotations**: use `@Suite("ComponentName")` on structs and `@Test("descriptive test name")` on test functions.
2. **HTML Verification**: render components with a private `renderHTML` helper:
   ```swift
   private func renderHTML(_ elements: [any SGML.Element]) -> String {
       elements.map { Document(root: $0).render(indent: 0) }.joined()
   }
   ```
3. **No application or request needed**: render the component directly in a plain, synchronous test:
   ```swift
   @Test("renders button correctly")
   func testButton() {
       let html = renderHTML(ActionButton(ActionButtonData(...)).render())
       #expect(html.contains("..."))
   }
   ```
   Do not add `import Vapor` to a test in `RaccoonTests`.
4. **Full documents**: `SomeTemplate().renderString()` returns a complete document string or `nil`.
5. **Foundation**: files that use `Date`, `UUID` or `DateFormatter` need `import Foundation` themselves.
6. **Placing new tests**: add UI kit tests to `Tests/RaccoonTests/`. Tests for domain components or templates belong in the `raccoon-raumnebenan` repository.
