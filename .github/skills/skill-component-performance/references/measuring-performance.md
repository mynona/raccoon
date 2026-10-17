# Measuring render performance and memory

Read this before and after changing a component, template, or anything on the render path, or
when someone asks "is this faster?" / "how much memory does this allocate?".

Every recipe here was verified on this repo (macOS, Swift 6.4, release builds).

## Contents

1. [Which tool for which question](#1-which-tool-for-which-question)
2. [Render budgets in unit tests (deterministic, CI-safe)](#2-render-budgets-in-unit-tests)
3. [package-benchmark: allocations, instructions, time](#3-package-benchmark)
4. [Before/after workflow for a refactor](#4-beforeafter-workflow-for-a-refactor)
5. [Instruments: who allocates, where time goes](#5-instruments)
6. [Interpreting results](#6-interpreting-results)
7. [Reducing allocations and memory — playbook](#7-reducing-allocations-and-memory--playbook)

---

## 1. Which tool for which question

| Question | Tool | Setup cost | Deterministic |
|---|---|---|---|
| Did this change add elements, attributes, comments, or bytes? | Render budget test (§2) | none, runs in `swift test` | ✅ |
| How many heap allocations / CPU instructions per render? | `package-benchmark` + jemalloc (§3) | `brew install jemalloc`, separate package | ✅ (mallocs, instructions) |
| Is it faster? By how much? | `package-benchmark` baseline compare (§4) | same | ⚠️ wall clock is noisy |
| *Which line* allocates or burns CPU? | Instruments Allocations / Time Profiler (§5) | Xcode installed | — |

**Prefer malloc count and instructions over wall-clock time.** They are reproducible across runs
and machines, so a regression of 335 → 360 mallocs is a real signal. A 5 % wall-clock change
usually is not.

Always measure **release builds** (`-c release`). Debug builds are 5–20× slower and can show a
different ranking of costs.

## 2. Render budgets in unit tests

Template: [`assets/RenderBudgetTests.swift`](../assets/RenderBudgetTests.swift).

It walks the DOM tree a component produces and counts `elements`, `attributes`, `comments`,
`maxDepth`, and `bytes`. Element and attribute counts track cost closely: every element is
~11–17 mallocs, and every attribute is paid in all three render phases.

Setup (one-time):

1. Copy the template to `Tests/AppTests/RenderBudgetTests.swift`.
2. Add the DOM product to the `AppTests` target in `Package.swift`:
   `.product(name: "DOM", package: "swift-web-standards"),`
3. `swift test --filter "Render budgets"`

How to use it:

- Add one test per **high-frequency component variant** (plain / with icon / with tooltip). Use
  the *plain* variant to assert that optional features cost nothing when unused.
- Budgets are ceilings, set to the currently measured value. When an optimization lowers them,
  lower the budget in the same change. That locks the gain in.
- A failing budget is a review prompt, not an automatic "no". A justified a11y element can
  raise the budget. Record why in the test comment.

## 3. package-benchmark

Template package: [`assets/performance-package/`](../assets/performance-package/), built on
[ordo-one/package-benchmark](https://github.com/ordo-one/package-benchmark), the standard Swift
server benchmarking tool.

It lives in its own package (`<repo>/Performance`) and depends on the library via
`.package(path: "..")`. The library manifest stays clean, so consumers never resolve the
benchmark dependencies.

Setup (one-time):

```bash
brew install jemalloc                       # Linux: apt-get install -y libjemalloc-dev
cp -R .github/skills/skill-component-performance/assets/performance-package Performance
# If the repo folder is not named `raccoon`, change `package: "raccoon"` in Performance/Package.swift.
```

Run:

```bash
cd Performance
swift package --disable-sandbox benchmark                          # everything
swift package --disable-sandbox benchmark --filter "ActionButton/.*"
swift package --disable-sandbox benchmark --format markdown         # tables to paste into a PR
swift package --disable-sandbox benchmark --filter "Pattern/.*"    # re-verify the skill's cost table
```

The first build compiles Vapor in release mode (~2 min). Later runs are incremental.

Metrics configured in the template:

| Metric | Meaning | Use for |
|---|---|---|
| `mallocCountTotal` | heap allocations per iteration | **primary** regression signal |
| `instructions` | CPU instructions retired | **primary** CPU signal, very stable |
| `wallClock`, `cpuTotal` | time | relative comparison only; jemalloc inflates absolute values |
| `peakMemoryResident` | process peak RSS | coarse, catches leaks or retained caches growing |

`memoryLeaked` is not produced by this malloc backend on macOS. It is left out of the template.

Writing a benchmark:

- Always render through the `html(_:)` helper. It runs the full pipeline (build → node →
  string) like `TemplateRenderer`. Benchmarking only `render(request)` hides ~40 % of the cost.
- Name benchmarks `<Component>/<variant>` so `--filter` works.
- Add a composite benchmark (e.g. `Page/100×ActionButton`) for components that are nested many
  times. This catches costs that only show up multiplied.
- Wrap results in `blackHole(...)` so the optimizer cannot remove the work.
- The `html()` helper adds one allocation (`joined()`) compared with the numbers in
  `rendering-pipeline.md §6`. Compare like with like.

## 4. Before/after workflow for a refactor

```bash
cd Performance
git stash                                   # or check out the base branch
swift package --disable-sandbox --allow-writing-to-package-directory benchmark baseline update main
git stash pop                               # back to your change
swift package --disable-sandbox benchmark baseline compare main --format markdown   # side-by-side table
swift package --disable-sandbox benchmark baseline check main                       # exit ≠ 0 on regression
```

Baselines are stored in `Performance/.benchmarkBaselines/`.

For CI, store absolute ceilings instead of comparing branches:

```bash
swift package --disable-sandbox --allow-writing-to-package-directory benchmark thresholds update
swift package --disable-sandbox benchmark thresholds check          # fails if p90 exceeds stored thresholds
```

Thresholds are written to `Performance/Thresholds/`. Commit them.

**Refactors must produce identical HTML.** Before comparing numbers, assert that the rendered
string is byte-identical to the old output, unless the change intentionally removes markup such
as comments or redundant wrappers. A faster component that renders different HTML is a
behavior change and must be reviewed as one, including accessibility.

## 5. Instruments

Use this when the numbers say *something* is expensive but not *what*.

SwiftPM release binaries are ad-hoc signed without `get-task-allow`. Without it, Allocations
fails with *"Failed to attach to target process"*. Re-sign the binary first:

```bash
cat > /tmp/debuggable.entitlements <<'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict><key>com.apple.security.get-task-allow</key><true/></dict></plist>
EOF

cd Performance
swift build -c release --product RaccoonBenchmarks
codesign --force --sign - --entitlements /tmp/debuggable.entitlements .build/release/RaccoonBenchmarks

xcrun xctrace record --template Allocations --time-limit 60s \
  --output /tmp/raccoon-alloc.trace \
  --launch -- .build/release/RaccoonBenchmarks --filter "ActionButton/label\+icon"
open /tmp/raccoon-alloc.trace
```

Use `--template "Time Profiler"` for CPU. In the Allocations view:

- **Statistics → "# Transient"** is the number of short-lived allocations per render. This is
  what to reduce.
- **"# Persistent"** growing over time means something is retained, for example an unbounded
  cache. That is a memory leak in practice.
- **Call Tree → Invert + Hide System Libraries** attributes allocations to Raccoon frames
  (`ActionButton.render`, `Svg.icon`, `renderMarkdownAsHTML`).

## 6. Interpreting results

Current reference points (template benchmarks, release, Apple Silicon):

| Benchmark | mallocs | instructions |
|---|---|---|
| `HyperLink/label` | 151 | 315 K |
| `ActionButton/label+icon` | 335 | 678 K |
| `ActionButton/label+icon+tooltip` | 737 | 1.6 M |
| `MasterHead/cmsHead` | 406 | 816 K |
| `Page/100×ActionButton` | ~17 K | 36 M |

To estimate a component's real cost per page:

> **cost per page ≈ cost per render × instances per page**

A leaf component at 335 mallocs × 100 instances = 33 500 mallocs per request. That one number
outweighs everything a single-instance template does. Rank optimization targets by this
product, not by cost per render.

Rough budgets for **new** components, for the plain variant without optional features:

| Kind | Elements | mallocs (benchmark) |
|---|---|---|
| Leaf (link, badge, button, check) | ≤ 4 | ≤ 200 (≤ 350 with icon) |
| Composite rendered a few times (card, accordion item) | ≤ 15 | ≤ 1 000 |
| Once-per-page (header, footer, nav) | as needed | measure; pre-render constant parts |

## 7. Reducing allocations and memory — playbook

Ordered by typical gain. Measure after each step.

1. **Remove elements.** Wrapper `Div`/`Span`s cost ~17 mallocs each, plus depth in serialize. Move
   classes and attributes onto the element that already exists.
2. **Pre-render constant markup** to a `static let html: String` and embed it with
   `InlineText(html, isRaw: true)`. This cuts a subtree to ~17 mallocs no matter how big it is.
   Only for trusted constant markup, and not inside `Head {}` (see `rendering-pipeline.md` §5).
3. **Generate repetitive, purely constant-shaped markup directly as a `String`** instead of a DOM
   tree. The main case is SVG icons: identical bytes, 51 (current `Svg.icon`) → 1 malloc,
   no cache, no lock. If generating directly is not practical, **cache** the rendered string with
   a bounded `Hashable` struct key (not a `String` key, which allocates) in a `Mutex` from
   `Synchronization`. Never key a cache on unbounded user content without an eviction limit.
   That is a memory leak in practice.
4. **Collapse modifiers.** Use one class string per element, built with a `switch` into a
   `String`, then one `.class(...)`. Each modifier copies the attribute store.
5. **Do work only when the feature is on.** Tooltip IDs, Alpine attributes, escaping,
   `trimmingCharacters`: compute inside the branch that uses them, and once.
6. **Hoist expensive objects** (`DateFormatter`, `JSONEncoder`, regexes, environment lookups) to
   `static let` or to the data layer. Never create them per render.
7. **Move Markdown out of the request.** `renderMarkdownAsHTML` costs ~108 mallocs and 413 K
   instructions for one sentence. Convert at save time, or pass pre-rendered `html` where the
   component accepts it (`Accordion`, `TabGroup`).

Memory note: during `TemplateRenderer.renderHtml` three representations of the page are alive
at the same time: the element structs, the DOM node tree, and the growing output string. Peak
memory per request therefore scales with page size × 3, plus the intermediate subtree strings
in `renderInline`. Fewer elements and fewer attributes reduce all three. Paginate long lists
instead of rendering hundreds of rows. Do not render the same subtree twice (for example
desktop and mobile navigation) if CSS can rearrange one copy.
