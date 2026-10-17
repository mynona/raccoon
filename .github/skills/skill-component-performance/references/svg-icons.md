# SVG icons (`Sources/Raccoon/Svg`)

Read this when you create or change anything in `Svg.swift` / `SvgIcon.swift`, add an icon to a
high-frequency component, or see `Svg.icon` in a profile.

## Why icons matter

`Svg.icon` is called from 117 places, mostly inside leaf components (`ActionButton`,
`LinkButton`, `HyperLink`, `Badge`, `Notification`, …). These are rendered 30–150 times per
page, so icon cost is multiplied by every icon-bearing instance.

## How it works today

```swift
public static func icon(_ icon: SvgIcon, title: String? = nil, width: Int = 16,
                        height: Int = 16, role: AccessibiliyRoleSvg = .presentation) -> SVG
```

1. Copies one of 4 prebuilt `AttributeStore`s (`IconAttributes`, one per role × with/without
   `aria-label`). They hold all 12 attributes in the final order. Only `aria-label` and, for
   non-16 px sizes, `width`/`height`/`style` are replaced. Replacing keeps the position, so the
   attribute order is stable. Never chain modifiers here: each one copies the attribute store.
2. `pathMarkup(for:)` runs `getPathsForIcon(icon)` (a `switch` over 2 078 cases, compiled to a
   jump table) and writes all `<path d="…"></path>` into one string. That string is the single
   raw `InlineText` child, so there is no `Path` element per path.
3. The parent converts only the `svg` element to a DOM node and serializes 12 attributes.

The returned `SVG` still supports `getAttribute`/`setAttribute`/`addClass`. Its `children` are
one raw `InlineText` instead of `Path` elements. With the indented renderer (`minify: false`)
the paths stay on the `<svg>` line.

Measured (release, full pipeline to html):

| Strategy | Output | mallocs | time |
|---|---|---|---|
| modifier chain + `Path` per path (before 2026-10), `.check` | 486 bytes | 119 | ~10–13 µs |
| same, `.fingerprint` (5 paths) | — | 229 | ~20 µs |
| **current `Svg.icon`** (prebuilt attributes + raw paths), `.check` 16 px | identical bytes | **51** | ~4.4 µs |
| current `Svg.icon`, 24 px / `.fingerprint` (5 paths) | identical bytes | 57 / 51 | ~4.9 / 4.5 µs |
| direct `String` generation (no DOM) | identical bytes | 1 | ~1.2 µs |
| cached rendered `String` (`Mutex`, struct key) | identical bytes | 0 | ~0.9 µs |

`Tests/AppTests/SvgTests.swift` keeps the old modifier chain as a reference and asserts
byte-identical output for every icon × role × size × title. Keep that test green when changing
`Svg.icon`.

## Improvement options (in recommended order)

### 1. Generate the markup directly as a `String` (additive API)

`Svg.icon` already uses the cheapest path that keeps its `-> SVG` contract. The next step is a
new, additive function next to it.

Icons are constant-shaped, trusted markup. Only `width`, `height`, `role`, and `title` vary,
and the paths are compile-time constants. Building a DOM tree for them is pure overhead.

```swift
// Sketch — must reproduce today's attribute order exactly; verify with a byte-equality test.
static func iconMarkup(_ icon: SvgIcon, title: String?, width: Int, height: Int,
                       role: AccessibiliyRoleSvg) -> String {
    let paths = getPathsForIcon(icon)
    let w = width == 0 ? "100%" : "\(width)px"
    let h = height == 0 ? "100%" : "\(height)px"
    var s = ""
    s.reserveCapacity(420 + paths.reduce(0) { $0 + $1.utf8.count + 22 })
    s += #"<svg viewBox="0 0 16 16""#
    // …same attributes, same order as Svg.icon…
    // title is the only non-constant text → JavaScriptEscaper.htmlAttributeEscape(title)
    for p in paths { s += #"<path d=""#; s += p; s += #""></path>"# }
    s += "</svg>"
    return s
}
// Embed: InlineText(Svg.iconMarkup(...), isRaw: true) — valid in Div/Span/Button/Li/A/… (not Head).
```

- No cache, no lock, no memory growth, and it works for every size/role/title combination.
- Escape `title` (`JavaScriptEscaper.htmlAttributeEscape`). The renderer escapes nothing.
- Migration path: add the new function next to `Svg.icon`, add a byte-equality test across a
  sample of icons × sizes × roles × title, then switch `Svg.icon` call sites in leaf components
  first, since they give the most gain. `Svg.icon` returns `SVG`. No caller chains modifiers on
  it today, so a `String`/`InlineText`-returning variant is a drop-in at call sites wrapped in a
  `Div`/`Span`.
- Phrasing context: `InlineText` is `PhrasingContent`, so it can sit directly in `Span`/`Button`.
  This may also let the caller drop the wrapper `Div` that exists only to host the `SVG`, which
  saves another ~17 mallocs.

### 2. Cache the rendered string (only if 1 is not possible)

Use `Mutex<[IconKey: String]>` with `struct IconKey: Hashable { icon, width, height, role }`.
Do not use a `String` key, because building it allocates on every lookup. Do not cache
variants with a `title` unless the title set is bounded. The key space (2 078 icons × a few
sizes × 2 roles) is bounded, but the cache still holds memory for the process lifetime.

### 3. Reduce bytes per icon (visual / a11y review required)

486 bytes for a single-path icon. ~330 of those bytes are boilerplate attributes repeated for
every icon on the page (100 icons ≈ 33 KB of HTML before compression). Candidates, each needing
a conscious decision, **not** a blind removal:

| Attribute | Notes |
|---|---|
| `xmlns="http://www.w3.org/2000/svg"` | Not needed for inline SVG in HTML documents. |
| `focusable="false"` | Legacy IE/old-Edge workaround. Check the browser support matrix before removing. |
| `preserveAspectRatio="xMinYMin meet"` | Only differs from the default when the box is not square. |
| inline `style` repeating `width/height` + `min-*` + `flex-shrink:0` | Guards against layout shift before CSS loads. Could become one CSS rule for `svg[aria-hidden]` / a utility class if CSS is always render-blocking. |
| `role="presentation"` **and** `aria-hidden="true"` | `aria-hidden` alone hides it. Check the a11y skills before changing. |

Load `frontend-a11y` / `svg` skills before touching accessibility attributes.

### 4. Sprites / `<use>` (architectural, only for icon-heavy pages)

`<svg><use href="/icons.svg#check"/></svg>` cuts icon markup to ~60 bytes, but it adds a network
request and caching concerns, and the styling model changes (`currentColor` still works).
An alternative is an inline `<symbol>` sprite per page, which needs request-scoped tracking of
the icons used. Consider it only if HTML size, not CPU, is the measured bottleneck.

## Rules for new icon code

- Do not build icons with the DOM builder inside high-frequency components. Use the direct
  markup path once it exists.
- Do not add per-icon attributes. Every attribute is multiplied by every icon on every page.
- Keep path data as compile-time literals (`switch` → array literal). Do not load or parse
  icons at runtime.
- When adding a new icon size or role, measure `Svg/icon*` with
  `swift package benchmark --filter "Svg/.*"` (see `measuring-performance.md`).
