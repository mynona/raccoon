# Rendering pipeline internals and cost model

Read this when you need to understand *why* a pattern is slow, when a measurement surprises you,
or before touching `TemplateCore/` or `Builder+Extensions.swift`.

Verified against `swift-web-standards` **1.0.0-beta.4** (`.build/checkouts/swift-web-standards`).
Re-check the files listed below after a dependency upgrade — several costs live upstream.

## Contents

1. [The nested pipeline](#1-the-nested-pipeline)
2. [Phase 1 — build](#2-phase-1--build-renderrequest--element)
3. [Phase 2 — convert](#3-phase-2--convert-element--dom-node)
4. [Phase 3 — serialize](#4-phase-3--serialize-node--string)
5. [Raccoon-specific glue](#5-raccoon-specific-glue)
6. [Measured costs](#6-measured-costs)
7. [What is cheap (do not optimize)](#7-what-is-cheap-do-not-optimize)

---

## 1. The nested pipeline

```
Route handler
  └─ TemplateFrontend / TemplateCms / TemplateSystem / TemplateAuth   (layout: header, nav, main, footer)
       └─ MasterFrontend / MasterCms / …                              (Html + MasterHead.*Head)
            └─ components: PageHeader → FrontendNav → LinkList → HyperLink → Svg.icon …
TemplateRenderer.renderHtml → Document(type: .html, root:).render(indent: 0)
```

Every component conforms to `TemplateRepresentable` and returns `[Element]` from
`render(_ request:)`. A parent embeds a child by calling `Child(data).render(request)` inside its
own builder. Nothing is cached between requests, so each element is paid for on every request,
once per instance. A `HyperLink` inside a `LinkList` inside `FrontendNav` inside `PageHeader` is
paid for as many times as it appears on the page.

Every element goes through three phases:

| Phase | What happens | Share of time (measured) |
|---|---|---|
| 1 build | `render(request)` creates value-type tag structs and applies modifiers | ~55–60 % |
| 2 convert | `Document.render` walks `.node` and builds a second tree of `DOM.Node` | ~20 % |
| 3 serialize | `DOMRenderer.renderInline` turns the node tree into a `String` | ~20 % |

A `static let` tree skips phase 1 only. A pre-rendered `String` skips all three phases.

## 2. Phase 1 — build (`render(request)` → `[Element]`)

**Result builder** — `WebBuilders/Builder.swift`

- `buildExpression(_ e: Element)` wraps every statement in a one-element array `[e]`.
- `buildBlock(_ components: [Element]...)` flattens with `flatMap { $0 }`. Each statement costs
  one small array plus a copy during the flatten.
- `buildEither`, `buildOptional`, `buildArray` simply return or flatten `[Element]`. There are
  no nested generic types, so `if/else` in a builder costs about the same as a plain statement.

**Modifiers** — `SGML/Traits/Mutable.swift`, `SGML/Traits/Attributes.swift`

```swift
public func modify(_ block: (inout Self) -> Void) -> Self {
    var mutableSelf = self      // copy of the struct
    block(&mutableSelf)         // mutating a shared AttributeStore buffer → copy-on-write
    return mutableSelf
}
```

Every `.setAttribute`, `.addClass`, `.id`, `.ariaLabel`, … goes through `modify`. The
`AttributeStore` (`OrderedDictionary<String, [String?]>`) is still referenced by the original
value, so the mutation copies the whole store. The cost per modifier therefore grows with the
number of attributes already set:

| Chained `.setAttribute` calls | ns per modifier |
|---|---|
| 5 | 229 |
| 10 | 249 |
| 20 | 335 |
| 40 | 445 |

**Class helpers** — `HTML/Attributes/Global/ClassAttributeModifier.swift`

- `.class("a", "b", "c")` (variadic) calls `addClass` once per value. That means N `modify`
  copies, and `AttributeStore.add` also runs a `contains` duplicate check each time.
- `.class("a b c")` with one string is one `addClass` call: **2× fewer mallocs, 4.4× faster**.
- `addClass(nil)` is a cheap no-op (`value?.attributeValue`), but it still runs `modify`.

**`.if(_:_:else:)`** — `Mutable.swift`

The true-closure is non-escaping. The `else:` closure is optional, so it is formally escaping,
but no context is captured in practice. With a `false` condition, eight chained `.if` calls cost
~70 ns in total. **`.if` is not a meaningful cost. The modifiers inside it are.**

## 3. Phase 2 — convert (`Element` → DOM `Node`)

`SGML/Tags/StandardTag.swift`:

```swift
public var node: Node {
    StandardNode(name: Self.name, properties: attributes.properties, children: children.map(\.node))
}
```

- `Tag.name` defaults to `String(describing: self).lowercased()` (`SGML/Tags/Tag.swift`). This
  uses runtime reflection plus a lowercase allocation **for every element, on every request**.
  HTML tags in beta.4 do not override it.
- `AttributeStore.properties` maps every attribute and runs `joined(separator: " ")` on each
  value list. That is one new `String` per multi-value attribute (`class`).
- `children.map(\.node)` allocates a new array per element.

So every element pays for its tag name and its attributes again, after it was built. This is
why a `static let` `Head` still costs **405 mallocs per request**.

## 4. Phase 3 — serialize (`Node` → `String`)

`DOM/DOMRenderer.swift`, `renderInline`:

```swift
case let node as StandardNode:
    let openingTag = renderStandardOpening(node)        // attributes map + joined + interpolation
    let closingTag = renderStandardClosing(node)
    let childrenInline = node.children.map { renderInline($0) }.joined()
    return openingTag + childrenInline + closingTag
```

- Each level builds the full string of its subtree and returns it, and the parent copies it
  again. Every byte is copied once per ancestor. Depth costs about 1 µs per extra wrapper level
  for 50 leaves. That is moderate, but it adds up for wrappers inside high-frequency components.
- Dispatch is a chain of `as?` casts on an existential `Node`.
- **No escaping happens anywhere.** Text and attribute values are written verbatim. Escaping is
  the component's job (`JavaScriptEscaper`). Performance work must never remove escaping, and
  raw pre-rendered strings may only contain trusted, constant markup.

`indent > 0` (`minify: false`) uses `renderWithIndentation`, which is slower and produces more
bytes. Production must render with `minify: true` (the default).

## 5. Raccoon-specific glue

`Sources/Raccoon/Templates/TemplateCore/Builder+Extensions.swift` bridges `[Element]` into the
`FlowContent` builders (`Body`, `Li`, `A`, `P`, `Section`, …) and the `MetadataContent` builder
(`Head`):

```swift
expression.compactMap { $0 as? any FlowContent }
```

- This adds one dynamic existential cast per element, at every place a component's
  `render(request)` output is embedded in a FlowContent parent.
- **Correctness trap:** elements that are not `FlowContent` / `MetadataContent` are **silently
  dropped**. For example, `InlineText` is `FlowContent` but not `MetadataContent`, so it
  disappears inside `Head {}`.
- `Div`, `Span`, `Button` take `@Builder<Element>` and need no cast. Do not swap a semantic
  element (`Li`, `Nav`, `A`) for a `Div` to avoid the cast. Semantics and accessibility come
  first, and the cast is cheap compared with an extra element.

`InlineText(_:isRaw:)` conforms to `FlowContent` and `PhrasingContent`. A pre-rendered string
can therefore be embedded anywhere in `Body`, `Div`, `Span`, `Button`, `Li`, `A`, … but not in
`Head`.

## 6. Measured costs

Release build, Apple Silicon, `package-benchmark` + jemalloc. Malloc counts are deterministic.
Time is indicative only.

| Scenario | mallocs | instructions | wall clock |
|---|---|---|---|
| `Span("x")`, full pipeline | 11 | 24 K | — |
| `Div { Span("x") }` (one wrapper) | 28 | 60 K | — |
| `Div { Comment("Button"); Span("x") }` | 33 | 73 K | — |
| `Div {}.class("a","b","c","d","e","f")` | 40 | 77 K | 1.80 µs |
| `Div {}.class("a b c d e f")` | 20 | 40 K | 0.41 µs |
| `Div` + 10 `.setAttribute` | 57 | 113 K | 2.5 µs |
| `Svg.icon(.check)` → html (486 bytes), old modifier chain | 119 | 234 K | ~13 µs |
| `Svg.icon(.check)` current (prebuilt attributes, raw paths) | 51 | — | ~4.4 µs |
| same bytes written directly into a `String` | 1 | 7.7 K | ~1.2 µs |
| same bytes from a `Mutex` cache (struct key) | 0 | 1 K | ~0.9 µs |
| `MasterHead.cmsHead` (`static let`) | 405 | 813 K | ~35 µs |
| same head pre-rendered to `String` | 17 | 41 K | ~1.6 µs |
| `renderMarkdownAsHTML` (one sentence) | 108 | 413 K | ~43 µs |
| `"tooltip-\(UUID()…)"` | 2 | 6 K | — |
| `HyperLink` label only | 151 | 315 K | ~13 µs |
| `ActionButton` label + icon | 335 | 678 K | ~29 µs |
| `ActionButton` label + icon + tooltip | 737 | 1 599 K | ~72 µs |
| 100 × `ActionButton` in one `Div` | ~17 000 | 36 M | ~2.9 ms, 151 KB HTML |

Rules of thumb:

- One element costs ~11–17 mallocs.
- One modifier costs ~2–3 mallocs, and more on elements that already have many attributes.
- An inline SVG icon built as a DOM tree costs about as much as 8–10 elements. Its 12
  modifiers on one element hit the copy-on-write growth described in §2.
- Markdown parsing is the single most expensive thing you can do in `render`.

## 7. What is cheap (do not optimize)

- `if / else` / `if let` / `switch` inside builders. Prefer `??` for readability and to avoid
  duplicated tags, not for speed.
- `.if(condition) { … }` itself.
- A `switch` that selects a style constant.
- `StableIdentifier.hash` (FNV-1a over a short string). `StableIdentifier.unique` (UUID) costs
  only ~2 mallocs, but keep it lazy anyway.

Spend the effort on **element count, modifier count, repeated heavy sub-renders (icons,
Markdown), and constant subtrees.**
