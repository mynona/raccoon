---
name: skill-csp-alpine
description: How Raccoon runs Alpine.js under a strict Content-Security-Policy without 'unsafe-eval' (the `@alpinejs/csp` build). Always use this skill when writing or changing any Alpine attribute (`x-data`, `x-show`, `x-text`, `:attr`, `@event`, `x-model`, `x-for`, `x-if`, ...), an expression that a component builds in Swift or accepts from a caller (`clickAction`, `bindAction`, `bindId`, `xhtml`, ...), an `Alpine.data` / `Alpine.magic` / `Alpine.directive` in `Public/js`, the Alpine bundle, or when a console shows `CSP Parser Error` or `Undefined variable`.
---

# Alpine under CSP: no `eval`, restricted expressions

`script-src` has no `'unsafe-eval'`. Alpine therefore runs as the **`@alpinejs/csp` build**, which parses expressions itself instead of calling `new Function`. That parser is much smaller than JavaScript. An expression it cannot parse fails **at runtime in the browser**, not at build time, and only the affected binding stops working. The nonce side of the policy is in `skill-csp-nonce`.

## The bundle

- Source: `Theming/index.js` and the `tailwind` build import `@alpinejs/csp` (not `alpinejs`) plus the plugins `@alpinejs/focus`, `@alpinejs/sort` and `@alpinejs/ui`. `window.Alpine = Alpine` stays, because `@alpinejs/ui` reads the global.
- Output: `Public/js/raccoon-alpine-csp-bundle.js`. Pages load it after `raccoon-i18n.js` and `raccoon-alpine-helper.js`, and after any script that registers `Alpine.data` for the page.
- A script that registers `Alpine.data(...)` listens to `alpine:init` (or checks `window.Alpine`). It must be loaded **before** the bundle starts Alpine.
- Never add an Alpine build that needs `eval` back to the page, and never add `'unsafe-eval'` to a `SecurityHeadersMiddleware`.

## What an attribute may contain

The allowed subset, tested with `@alpinejs/csp` 3.17.5:

| Allowed | Not allowed: move into the component's JS file |
| --- | --- |
| Property access `a.b`, `a[0]`, `$el.dataset.x`, `$event.target.value` | Several statements (`a; b`), `if`, `const`, `let` |
| Literals: strings, numbers, booleans, `null`, `{ }`, `[ ]` | `?.`, `??`, `typeof`, `new`, `in`, `instanceof`, `**` |
| `+ - * / % ! && \|\| === !== < > <= >=`, ternary | Arrow functions, `function` |
| Assignment `open = false`, `n++`, `$store.x = v` | Template literals (use `'a' + b`) |
| `(a = 1) \|\| (b = 2)` for two assignments | Comma operator, `n += 1`, spread, destructuring |
| Method calls with simple arguments `close()`, `list.includes(x)` | Regex literals (pass a string, build the `RegExp` in JS) |
| Literal arguments to a factory `x-data="field({ max: 5, tags: ['a'] })"` | Globals: `window`, `document`, `Math`, `JSON`, `console`, `RaccoonI18n` |
| Magics `$el $refs $event $dispatch $id $store $nextTick $root` | `x-html`, assigning to a DOM property (`$el.value = ''`) |

Prefer **one method call** in the attribute (`@click="toggle()"`, `:class="classes"`) and put the logic in the component. Logic never lives in a Swift string.

## Where logic goes

1. A component with state or more than a trivial expression gets an `Alpine.data('name', ...)` factory in its own `Public/js/raccoon-<name>.js`. Swift passes values as **literal arguments** to `x-data="name({ ... })"`.
2. The `Alpine.data` name must be registered. `x-data="name(...)"` where `name` is only a `window.*` function does not work.
3. Behaviour that several components share goes into `raccoon-alpine-helper.js`:
   - magics `$t`, `$pick` (localisation), `$navigate`, `$postForm`, `$isDesktop`, `$returnToCallerPage`, `$clickFirstNavLink`
   - the `x-safe-html` directive, the replacement for `x-html` (server-sanitised HTML only)
   - layout components such as `dashboardLayout` and `frontendLayout`
4. Localised text in an expression is `$t('key', vars, 'Fallback')` or `$pick({...}, vars, 'Fallback')`. `LocalizedText.alpineExpression` emits exactly that. Never read `window.RaccoonI18n` in an attribute.
5. Events between components use `$dispatch('name', { detail })` and a `.window` listener, not `window.dispatchEvent(new CustomEvent(...))`.
6. Edit JS in `raccoon/Public/js` first (it is the single source), then copy it to every consumer. A new Swift attribute that calls a new method ships **together** with the JS, or the binding breaks silently.

## Expressions that callers pass in

Several component APIs accept a raw Alpine expression: `clickAction`, `bindAction`, `bindId`, `bindTooltipId`, `bindAriaExpanded`, `bindAriaPressed`, `bindShow`, `bindTitle`, `bindAriaLabel`, `visibleWhen`, `xhtml`, and the `DataTableAction` fields. They follow the same rules. Document the rule on the parameter, and write callers in the CSP-safe form (`(open = false) || ($store.modal = false)`, not `open = false, $store.modal = false`).

## Expressions that Swift assembles

A static check cannot see an expression that is built from pieces at runtime, for example `"'\(label): ' + (row['\(key)'] ?? '')"`. These are the ones that slip through. When a component builds an expression from a variable:

- write it in the allowed subset (`||` instead of `??`, `+` instead of a template literal);
- add a unit test that renders the component and asserts the output contains none of `??`, `?.`, `=>` and a backtick.

## Verify a change

Nothing checks Alpine expressions at build time, so a change is verified by running it under the real policy.

1. **Unit tests.** `swift test` must pass. Add a render test for every component that builds an expression (see above). Tests that assert old attribute strings are updated in the same change.
2. **Run the Preview with the real header.** `SecurityHeadersMiddleware` of the Preview sends `script-src 'self'` without `'unsafe-eval'`, so the browser itself rejects anything the CSP parser cannot handle. Start it with `swift run Preview`, or build the product first with `swift build --product Preview`.
3. **Open the changed page with the console visible and use the component:** open it, type, submit, sort, close, switch the language. Look for `CSP Parser Error`, `Undefined variable` and `Refused to ...` (a policy violation).
4. **Scan a page for forbidden syntax.** Paste this into the console to list every Alpine attribute that the CSP parser will reject:

   ```js
   const bad = /\?\?|\?\.|=>|`|\btypeof\b|\bnew\s+[A-Z]|\b(window|document|navigator|Math|JSON|Promise)\b|;\s*\S/;
   [...document.querySelectorAll('*')].flatMap((el) =>
     [...el.attributes]
       .filter((a) => /^(x-|:|@)/.test(a.name) && bad.test(a.value))
       .map((a) => `${a.name}=${a.value}`)
   );
   ```

   An empty array means no known-bad syntax on that page. A word inside a string literal (a URL such as `/cms/document/{id}`) also matches, so read each hit. Repeat the scan on pages that render lists and tables with callers' expressions, because those are built from data.
5. **Check every page type that uses the component**, not only the Preview page: a table, a form, a dialog and an edit page can each pass different expressions.

A clean console on one page does not prove the others. Expressions inside `x-for`, `x-if` and `x-show="false"` blocks are only parsed when they render.

## Reading the errors

| Console message | Cause | Fix |
| --- | --- | --- |
| `CSP Parser Error: Unexpected token: PUNCTUATION "?"` | `?.` or `??` | `\|\|`, a ternary, or a getter |
| `CSP Parser Error: Unexpected token` on `;`, `=>`, a backtick | Statement list, arrow function, template literal | Method, or string concatenation |
| `Undefined variable: window` (or `document`, `Math`, ...) | Global used in an expression | Method or getter in the JS file |
| `x is not defined` for an `Alpine.data` name | The factory script loads after Alpine started, or is missing | Load order; copy the JS file |
| A binding does nothing and no error | The error was swallowed in a `x-for` or a `:attr` | Look at the first error in the console, then read the attribute in the DOM |

Each row in a list (`x-for`, a table) logs its own error, so one bad expression in a 20-row table produces 20 identical errors. Fix the expression once.

## Plugins

`focus` (`x-trap`), `sort` (`x-sort`, `x-sort:handle`) and `ui` (`x-switch`, `x-combobox`) work with the CSP build. They run no `eval`. Only the expressions you write in their attributes are parsed, so the rules above apply to those. Give `x-sort` a method name (`x-sort="reorder"`), not an inline function, and write combobox helpers (`display-value`, `aria-activedescendant`) as methods or getters.

Rewrites that `x-combobox` needs:

| Breaks | Use instead |
| --- | --- |
| `:display-value="f => f ? f.name : ''"` | `:display-value="displayValue"` with `displayValue(f) { return f ? f.name : '' }` in the JS |
| `:aria-activedescendant="isOpen && $combobox.activeIndex !== null ? \`${id}-option-${$combobox.activeIndex}\` : null"` | A getter `activeDescendant` in the JS, reading `this.$combobox` |
| `:id="\`${$root.id}-option-${idx}\`"` | `:id="$root.id + '-option-' + idx"` |

If a plugin directive ever needs an expression the parser rejects: first move the logic into a method or getter and reference it by name; only for small cases such as a focus trap replace the directive with plain JS in the component file.

## Checklist

1. Is the expression one call, a literal, a property or a simple operator? If not, make it a method.
2. Does it use `window`, `document`, `Math` or `RaccoonI18n`? Move it to JS or use `$t` / `$pick`.
3. Is it built from variables in Swift? Use the allowed subset and add a render test.
4. Did the JS change? Copy it to every consumer and bump the git `revision:` of the library in each `Package.swift`.
5. `swift test` green.
6. Opened the page under the real header, used the component, ran the attribute scan, console empty.
