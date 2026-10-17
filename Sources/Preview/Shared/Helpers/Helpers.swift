import HTML
import Raccoon
import SGML
import SwiftSoup
import Vapor

func prettyHTML(_ html: String) -> String {
    do {
        let doc = try SwiftSoup.parseBodyFragment(html)

        let settings = doc.outputSettings()
        settings.prettyPrint(pretty: true)
        settings.indentAmount(indentAmount: 4)
        settings.outline(outlineMode: true)
        settings.syntax(syntax: .html)
        settings.escapeMode(.base)

        // Extract only the fragment inside <body>
        if let body = doc.body() {
            return try body.html()
        }

        return html
    }
    catch {
        return html
    }
}

// MARK: - code display
func escapeHTML(_ string: String) -> String {
    string
        .replacingOccurrences(of: "&", with: "&amp;")
        .replacingOccurrences(of: "<", with: "&lt;")
        .replacingOccurrences(of: ">", with: "&gt;")
        .replacingOccurrences(of: "\"", with: "&quot;")
        .replacingOccurrences(of: "'", with: "&#39;")
}

func unescapeHTML(_ string: String) -> String {
    string
        .replacingOccurrences(of: "&quot;", with: "\"")
        .replacingOccurrences(of: "&#39;", with: "'")
        .replacingOccurrences(of: "&lt;", with: "<")
        .replacingOccurrences(of: "&gt;", with: ">")
        .replacingOccurrences(of: "&amp;", with: "&")
}

// MARK: - Page wrapper

func previewPage(
    title: String,
    body: String,
    showBack: Bool = true,
    headerExtra: String = ""
) -> String {
    let backNav =
        showBack
        ? #"<nav class="mb-6"><a href="/" class="text-sm underline opacity-60">← All components</a></nav>"#
        : ""
    return """
        <!doctype html>
        <html lang="en">
        <head>
          <meta charset="utf-8">
          <title>Preview – \(title)</title>
          <link rel="stylesheet" href="/css/ibm-plex.css">
          <link rel="stylesheet" href="/css/raumnebenan-min.css">
          <script src="/js/bundle-min.js" defer></script>
          <script type="text/javascript">
            document.addEventListener('alpine:init', () => {
              const m = localStorage.getItem('colorMode')
              Alpine.store('lightMode', m === 'light')
              Alpine.store('iconSearch', { query: '' })
            })
          </script>
            <script type="text/javascript">
            // detect-mode.js — mirrors prod MasterFrontend.swift
            window.explicitelyPreferScheme = false;
            if (window.localStorage) {
              if (localStorage.getItem('colorMode') === 'dark') {
                document.documentElement.classList.add('dark')
                window.explicitelyPreferScheme = 'dark'
              } else if (localStorage.getItem('colorMode') === 'light') {
                document.documentElement.classList.remove('dark')
                window.explicitelyPreferScheme = 'light'
              }
            }
            if (localStorage.getItem("colorMode") === null) {
              if (window.explicitelyPreferScheme !== 'light' && window.matchMedia('(prefers-color-scheme:dark)').matches) {
                document.documentElement.classList.add('dark')
                localStorage.setItem('colorMode', 'dark')
              } else {
                localStorage.setItem('colorMode', 'light')
              }
            }
            </script>
        </head>
        <body class="bg-white dark:bg-surface-dark text-black dark:text-white">
          <header class="sticky top-0 z-20 flex items-center justify-between px-8 py-3 shadow-sm bg-white dark:bg-surface-dark border-b border-gray-200 dark:border-gray-700">
            <div>\(backNav)</div>
            \(headerExtra)
            <div x-data="{
              setColorMode(m) {
                if (m === 'dark') {
                  document.documentElement.classList.add('dark')
                  localStorage.setItem('colorMode', 'dark')
                } else {
                  document.documentElement.classList.remove('dark')
                  localStorage.setItem('colorMode', 'light')
                }
              }
            }">
              <button type="button"
                aria-label="Switch dark and light mode"
                x-cloak
                @click="$store.lightMode = !$store.lightMode; setColorMode($store.lightMode ? 'light' : 'dark')"
                class="text-sm px-3 py-1 rounded border border-gray-400 dark:border-gray-600 hover:bg-gray-100 dark:hover:bg-gray-800">
                <span x-show="!$store.lightMode">☀️ Light</span>
                <span x-show="$store.lightMode">🌙 Dark</span>
              </button>
            </div>
          </header>
          <div class="p-8 space-y-8">
          <h1 class="text-2xl font-bold border-b border-gray-300 dark:border-gray-700 pb-2">\(title)</h1>
          \(body)
          </div>
        </body>
        </html>
        """
}

// MARK: - Render helpers

/// Renders an array of SGML Elements to a concatenated HTML string.
///
/// The elements are `@autoclosure`d so the render itself happens inside the suspended scope:
/// these fragments are shown as source samples, not inserted into the document, so they must not
/// trip the duplicate-id warning.
func renderFragments(_ elements: @autoclosure () -> [any SGML.Element])
    -> String
{

    elements().map { Document(root: $0).render(indent: 0) }.joined()

}

/// Wraps rendered HTML in a labelled variant block.
func variant(_ configuration: String, html: String) -> String {
    let formattedHtml = prettyHTML(html)
    let escapedHtml = escapeHTML(formattedHtml)
    let classOverflow =
        "whitespace-pre-wrap break-words overflow-x-auto max-w-full"
    return
        """
        <section class="space-y-2 mb-24">
        <div class=""><p>&nbsp;</p></div>
        <pre class="w-full border border-black dark:border-gray-400 p-4 bg-gray-200 dark:bg-black \(classOverflow)">\(configuration)</pre>
          <div class="mt-8 mb-8">\(html)</div>
          <pre class="w-full border border-black dark:border-gray-400 p-4 \(classOverflow)"><code class="language-html \(classOverflow)">\(escapedHtml)</code></pre>
        </section>
        """
}

// MARK: - Shared sample data

/// No-op Matomo tracker used across preview routes.
let tracker = MatomoContentTracker(
    name: "Preview",
    piece: "preview",
    target: "#"
)
