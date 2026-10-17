---
name: skill-component-performance
description: Performance rules, cost model, and measurement workflow for Raccoon's nested server-side rendering (swift-web-standards → DOM → HTML string). Use this skill whenever you create, edit, refactor, or review anything that renders HTML in Sources/Raccoon/Components, Sources/Raccoon/Article, Sources/Raccoon/Templates, Sources/Raccoon/Theme, or Sources/Raccoon/Svg, including *Styles.swift class strings and MasterHead. Also use it when someone asks whether a component is fast, why a page is slow, how many allocations or how much memory a render costs, or how to benchmark, profile, or set performance budgets, even if they do not say "performance".
---

# Raccoon rendering performance

Raccoon renders every page on every request, and nothing is cached between requests. Components
are nested: route → `Template*` → `Master*` + `MasterHead` → `PageHeader` → `FrontendNav` →
`LinkList` → `HyperLink` → `Svg.icon`. So **a component's cost is paid once per instance, on
every request**. A leaf such as `ActionButton` that appears 100 times on a page matters more than
the whole template around it.

Use this skill so that new components are cheap by construction, and so that changes are
measured instead of guessed.

## The cost model

Every element passes through three phases (details: `references/rendering-pipeline.md`):

| Phase | What it does | ~Share |
|---|---|---|
| 1 build | `render()` creates tag structs; **every modifier copies the attribute store** | 55–60 % |
| 2 convert | `.node` builds a second tree; tag name via reflection, attributes re-joined | ~20 % |
| 3 serialize | `DOMRenderer` concatenates strings recursively; each ancestor re-copies its subtree | ~20 % |

Measured anchors (release, full pipeline):

| Thing | mallocs |
|---|---|
| one element (`Span("x")`) | ~11 |
| one wrapper `Div` | +17 |
| one `Comment` node | +5 |
| `.class("a","b","c","d","e","f")` vs `.class("a b c d e f")` | 40 vs 20 |
| `Svg.icon`: old modifier chain / current (prebuilt attributes, raw paths) / direct `String` | 119 / 51 / 1 |
| `static let Head` vs the same markup pre-rendered to a `String` | 405 vs 17 |
| `renderMarkdownAsHTML` for one sentence | 108 (413 K instructions) |
| `HyperLink` / `ActionButton` / `ActionButton` + tooltip | 151 / 335 / 737 |

> **cost per page ≈ cost per render × instances per page.** Rank work by this product.

## Rules, ordered by impact

### 1. Fewer elements per instance

Each element costs ~11–17 mallocs in all three phases, and depth adds re-copying in phase 3.
Put classes, ARIA, and Alpine attributes on an element that already exists instead of wrapping
it. Common offenders are an icon wrapped in `Div` + `Span`, layout `Div`s that only forward
`flex`, and a `Div` whose only job is to host one child.

Semantics and accessibility win over element count. Never replace `Button`/`A`/`Li`/`Nav` with
`Div` to save an element.

### 2. Fewer modifiers per element

`modify { var copy = self }` copies the `AttributeStore` on every `.setAttribute`/`.addClass`/
`.id`/…, and the cost per modifier grows with the attribute count (229 → 445 ns from 5 → 40
attributes).

- Use one class string per element. Combine the static classes into a single literal or a
  `*Styles` constant, choose variant and size classes with a `switch` into a `String`, and
  apply them in one `.class(...)`. Avoid variadic `.class("a", "b", "c")`, which is one
  `addClass` call per argument.
- `.if(cond) { … }` itself is cheap: the closure is non-escaping, ~10 ns. The modifiers inside
  it are what cost. Keep `.if` for genuinely optional attributes. Do not rewrite working `.if`
  code for speed alone.
- Do not emit attributes that carry no information for this instance: empty `x-data="{ }"`,
  `x-ref` without a tooltip, a duplicated `id`.

### 3. Pre-render constant markup; generate constant-shaped markup directly

- A `static let` element tree only skips phase 1. A `static let html: String` embedded with
  `InlineText(html, isRaw: true)` skips all three phases (405 → 17 mallocs).
- Markup with a fixed shape and only a few varying values, such as **SVG icons**, can be written
  straight into a `String` with byte-identical output. See `references/svg-icons.md`.
- Constraints:
  - Only for **trusted** constant markup. The renderer escapes nothing, so escape any
    interpolated value yourself (`JavaScriptEscaper`).
  - `InlineText` is `FlowContent`/`PhrasingContent` but not `MetadataContent`. Inside `Head {}`
    it is **silently dropped** by `Builder+Extensions.swift`.

### 4. Keep heavy work out of `render`

- **Markdown:** `renderMarkdownAsHTML` is the most expensive call on the render path. Convert at
  save time or in the data layer, and pass pre-rendered `html` where the component accepts it
  (`Accordion`, `TabGroup`).
- Create `DateFormatter`, `JSONEncoder`, regexes, and environment lookups once (`static let`, or
  at startup), never per render. This also applies to `getEnvironmentVariable`.
- If you must cache a sub-render, use a bounded `Hashable` struct key in a `Mutex`
  (`Synchronization`). Never use unbounded user content as a key, because the cache then grows
  forever.

### 5. Do work only when the feature is on

Compute fallback IDs (`StableIdentifier.unique`), tooltip wiring, escaping, and
`trimmingCharacters` inside the branch that needs them, and only once. Optional features must
cost **zero elements and zero attributes** when unused. The plain variant of a component is
the one rendered most often.

```swift
let tooltipReference: String? =
    if data.tooltip != nil {
        data.tooltipId ?? "tooltip-\(StableIdentifier.unique(data.tooltip ?? data.label ?? "button"))"
    } else {
        nil
    }
```

### 6. Strings: allocate once

- Pass an existing `String` directly. Do not write `"\(label)"`.
- Build a value that several attributes share (canonical URL, tooltip event payload) once,
  into a `let`.
- Chains of `replacingOccurrences` run one full pass and one allocation each. Keep them out of
  hot leaves, or run them once per page.

### 7. No `Comment` nodes in leaf components

Each `Comment` costs +5 mallocs plus bytes, ×100 per page. Use Swift `// MARK:` comments
instead. Template-level region comments are fine.

### 8. Builder hygiene (cheap, but correct)

- `if/else`, `if let`, and `switch` inside builders are cheap. `buildEither` just returns an
  array. Prefer `??` for clarity and to avoid duplicated tags, not for speed.
- Embedding `[Element]` in `FlowContent` builders (`Body`, `Li`, `A`, `P`, `Section`) runs a
  `compactMap` cast per element and drops anything that is not `FlowContent`. Prefer
  embedding nested component output directly in a `Div`/`Span`/`Button` when that element is
  semantically right anyway.

### 9. Templates, masters, and the network

- Keep constant `<head>` parts in `MasterHead` `static let` collections. Use
  `seoMetadata(seo:defaultDescription:)` for the dynamic parts.
- Never preconnect to your own origin. Only preconnect to third parties used on that page.
  Preload only the 1–2 fonts needed above the fold.
- Render with `minify: true`. The indented renderer is slower and produces more bytes.
- Do not render the same subtree twice (for example desktop and mobile navigation) if CSS can
  reposition one copy. Paginate long lists. Peak memory per request is ~3× page size: the
  element structs, the DOM nodes, and the output string are alive at the same time.

## Workflow: creating or changing a component

1. **Classify frequency.** Is it a leaf rendered many times per page (button, link, badge,
   icon, list row), a composite rendered a few times, or a once-per-page part? Leaves get the
   strictest budget.
2. **Sketch the DOM first.** Write down the element skeleton and count elements and attributes
   for the plain variant. Each optional feature should add nothing when it is off. Starting
   budgets for new leaves: ≤ 4 elements, ≤ 200 mallocs (≤ 350 with icon).
3. **Write `render`** following the rules above. Styles come from `*Styles` constants (see
   `skill-component-styles`), and data shape follows `skill-component-data`.
4. **Measure** (`references/measuring-performance.md`):
   - Add a render-budget test (`assets/RenderBudgetTests.swift`). It is deterministic and safe
     for CI.
   - For leaves or any optimization claim, run the `package-benchmark` suite
     (`assets/performance-package/`). Compare `mallocCountTotal` and `instructions` against a
     baseline.
5. **Refactors must render identical HTML** unless the change intentionally removes markup.
   Assert byte equality first, then compare numbers. Removing markup changes behavior and needs
   an accessibility check.
6. **Lock in gains.** Lower the budget or threshold in the same change.

## Review checklist

- [ ] Frequency classified. Cost per render × instances per page considered.
- [ ] No wrapper element that could be replaced by attributes on an existing element.
- [ ] One class string per element. No variadic `.class("a", "b", …)`. Variant and size come
      from a `switch`.
- [ ] Optional features (tooltip, Alpine, tracking, icon) add **zero** elements and attributes
      when unused. No empty `x-data="{ }"` or orphan `x-ref`.
- [ ] Fallback IDs and escaping are computed lazily and once.
- [ ] No `Comment` nodes in leaf components.
- [ ] No Markdown parsing, formatter or encoder creation, regex compilation, or environment
      lookup per render.
- [ ] Constant markup is pre-rendered. Icons go through the cheapest available path. No raw
      `InlineText` inside `Head {}`.
- [ ] Interpolated values in raw strings are escaped. Performance work never removes escaping.
- [ ] Budget test added or updated. Benchmark numbers attached for optimization claims.

## References

- `references/rendering-pipeline.md` — how the builder, modifiers, DOM conversion, and
  serializer work in swift-web-standards beta.4, with the full measured cost table. Read it
  when a rule seems surprising, or after a dependency upgrade.
- `references/measuring-performance.md` — choosing a tool, budget tests, package-benchmark
  (allocations, instructions, baselines, CI thresholds), Instruments (re-sign the binary with
  `get-task-allow`), interpreting results, and a memory/allocation playbook.
- `references/svg-icons.md` — `Svg.icon` analysis and improvement options (prebuilt
  attributes 119 → 51 mallocs, direct markup → 1, caching, byte trimming, sprites).
- `assets/RenderBudgetTests.swift` — Swift Testing template for structural budgets.
- `assets/performance-package/` — standalone `package-benchmark` package. Copy it to
  `<repo>/Performance`.
