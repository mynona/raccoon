---
name: skill-csp-nonce
description: Content-Security-Policy rules for Raccoon, raccoon-raumnebenan and the apps (blog, cms, oauth_server, oauth_client, preview apps). Always use this skill when adding or changing any `Script(...)`, inline `<script>`, `onerror`/`on...=` attribute, JSON data block, a `SecurityHeadersMiddleware`, a template or layout `<head>`, or any JS file that a page loads.
---

# CSP: no inline scripts, nonce only where unavoidable

Policy: `script-src 'self' 'nonce-<per request>' 'unsafe-eval' <hosts>`. There is **no `'unsafe-inline'`**. `'unsafe-eval'` is needed by Alpine, `unpkg.com` by Mermaid. Style attributes and inline `<style>` are out of scope (`style-src` keeps `'unsafe-inline'`).

## Rules for `Raccoon` (public library)

- **A component never renders an inline script.** Only `Script().src("/js/...")`. `Sources/Raccoon` must contain no `Script(<content>)`. `NoInlineScriptTests` fails otherwise. `I18n.swift` is the only allowed file: it writes the dictionary as `<script type="application/json" data-raccoon-i18n>`, which is data, never executed.
- **No CSP or nonce code in Raccoon.** Do not add a nonce parameter to a component.
- **Per-page values go into `data-*` attributes** of the external script, not into JS source. Example: `MatomoTracker` renders `<script src="/js/matomo-tracker.js" data-site-id=...>`. The HTML renderer does **not** escape attribute values, so pass every value through `JavaScriptEscaper.htmlAttributeEscape`.
- **No inline event handlers** (`onerror`, `onclick`, ...). A nonce does not apply to attributes. Use Alpine (`x-on:error="method($event)"`, `@click`) with the method in the component's JS, or one capturing listener in a JS file (`picture-fallback.js`).
- `DarkLightModeToggle.detectModeScript` and `ThemeSwitcher.detectThemeScript` are public **strings** that consumers render inline in `<head>` (they must run before first paint). Raccoon does not render them.

## JavaScript files

- **`raccoon/Public/js` is the single source for every JS file**, also app-specific ones (`redirect.js`, `anchor-header-offset.js`). Change it there first, then copy it to `blog`, `cms`, `oauth_server`, `raccoon-raumnebenan` `Public/js`. The `tailwind` build copies only some files (see `tailwind/package.json`), and never deletes, so remove renamed files by hand.
- JS used only by the two Preview apps lives in `raccoon/Public/js-preview` (whitelisted in `.gitignore`).
- New HTML that needs a new JS file or a new JS method must ship **together** with the copied JS in every repo, or the feature breaks silently.

## The nonce (`raccoon-raumnebenan`, file `Templates/Core/CSPNonce.swift`)

Only the raumnebenan layouts have inline scripts (dark mode and theme detection in `MasterHead`, Alpine `modal` store and `callerPage` in `TemplateFrontend`, `returnToCallerPage` in `TemplateAuth`).

- `Request.cspNonce`: one random 16-byte base64 value per request, created lazily, stored on the `Request`.
- `TemplateRenderer.renderHtml` binds the task-local `CSPNonce.current` around the **synchronous** render.
- `Script.inline(_ code:)` renders an inline script and adds `nonce="..."` when `CSPNonce.current` is set. Use it for every inline script in layouts and templates.
- Each app's own `SecurityHeadersMiddleware` puts `'nonce-\(request.cspNonce)'` into `script-src`. Each repo keeps its own middleware and host list. Do not merge them. Register it before `ErrorMiddlewareHelper`, so error pages get the header too.
- **Keep the nonce on the `Request`.** Do not set a task-local in the middleware instead: future-based Vapor middleware (sessions) runs `next.respond` outside the task and the value would be lost.
- **`Script.inline` only works for code that runs inside `renderHtml`.** Page content built earlier in a controller (builder closures) does not see the nonce. So page-level scripts must be external files.
- **Heads must be computed, not stored.** `MasterHead.commonMetadata`, `cmsHead` and `systemHead` are `static var`. A `static let` head would share one nonce across all requests.
- `application/ld+json` and other non-JS `<script type>` are not executed and need no nonce.

## Exceptions

- `oauth_client` does not use Raccoon. It has its own `Request.cspNonce` (`Middleware/Request+CSPNonce.swift`) and sets `nonce` on the one inline script in `ViewRedirect.swift`.
- The two Preview apps have their own strict `SecurityHeadersMiddleware`. `raccoon`'s Preview has no inline script at all (its scripts are in `Public/js-preview`).

## Adding or changing a script: checklist

1. Can it be an external JS file with `data-*` config? Do that, in `raccoon/Public/js`.
2. Is it a handler attribute? Use `x-on:` or a JS listener.
3. Unavoidable inline script in a layout (needs to run before first paint)? Use `Script.inline` in `raccoon-raumnebenan`, and only inside `renderHtml`.
4. Do not add `'unsafe-inline'` to `script-src` again. With a nonce present browsers ignore it anyway.
5. Copy changed JS to the dependent repos and bump the `raccoon` / `raccoon-raumnebenan` revisions (git `revision:` in each `Package.swift`).
