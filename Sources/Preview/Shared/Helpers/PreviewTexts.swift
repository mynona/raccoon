import Raccoon

/// The texts of the Preview app that no Raccoon component renders (see `Translations+Preview.swift`).
/// Component names, the name `Raccoon`, theme names and the `//` comments of the variants are fixed.
enum PreviewTexts {
    /// The fixed product name that fills the `{{name}}` placeholders.
    static let productName = "Raccoon"

    static let preview = LocalizedText(
        "preview.preview",
        "Preview"
    )
    static let tabsLabel = LocalizedText(
        "preview.tabsLabel",
        "Preview, API, and HTML code"
    )
    static let filterPlaceholder = LocalizedText(
        "preview.filterPlaceholder",
        "Filter components..."
    )
    static let filterLabel = LocalizedText(
        "preview.filterLabel",
        "Filter components"
    )
    static let sectionComponents = LocalizedText(
        "preview.sectionComponents",
        "Components"
    )
    static let pageTitle = LocalizedText(
        "preview.pageTitle",
        "Preview – {{title}}"
    )
    static let homeTitle = LocalizedText(
        "preview.homeTitle",
        "{{name}} Component Preview"
    )
    static let overview = LocalizedText(
        "preview.overview",
        "Overview"
    )
    static let homeIntro = LocalizedText(
        "preview.homeIntro",
        "Welcome to the {{name}} component and template preview environment. Select a component or template from the sidebar to inspect its rendering, data model, and HTML output."
    )
    static let kitTitle = LocalizedText(
        "preview.kitTitle",
        "{{name}} UI Kit"
    )
    static let kitText = LocalizedText(
        "preview.kitText",
        "Core domain-agnostic UI components ({{count}} components)."
    )
    static let browse = LocalizedText(
        "preview.browse",
        "Browse {{name}} components"
    )
    static let simulateError = LocalizedText(
        "preview.simulateError",
        "Simulate an error"
    )
    static let backToNormal = LocalizedText(
        "preview.backToNormal",
        "Back to normal"
    )
    static let dataTableIntro = LocalizedText(
        "preview.dataTableIntro",
        "Rows are loaded from /simulation/raccoons, which answers after half a second. Sorting, filtering and paging run in that endpoint. "
    )
    static let uploadSingle = LocalizedText(
        "preview.uploadSingle",
        "Test live single upload against fake endpoint:"
    )
    static let uploadMultiple = LocalizedText(
        "preview.uploadMultiple",
        "Test live multiple upload against fake endpoint:"
    )
    static let scrollDepth = LocalizedText(
        "preview.scrollDepth",
        "Scroll Depth: "
    )
    static let threshold = LocalizedText(
        "preview.threshold",
        "80% Threshold: "
    )
    static let testBed = LocalizedText(
        "preview.testBed",
        "Interactive Scroll Test Bed (80% Threshold)"
    )
    static let pageTop = LocalizedText(
        "preview.pageTop",
        "Page Top (0% scroll)"
    )
    static let milestone = LocalizedText(
        "preview.milestone",
        "Content milestone ~{{percent}}%"
    )
    static let reached = LocalizedText(
        "preview.reached",
        "80% SCROLL THRESHOLD REACHED"
    )
    static let articleEnd = LocalizedText(
        "preview.articleEnd",
        "Article End — In-Page Docking Spot"
    )
    static let pageBottom = LocalizedText(
        "preview.pageBottom",
        "Page Bottom (100% scroll)"
    )
}

/// A demo text with all languages of the Preview. Every text that a variant passes into a component
/// uses it, so that nothing is missed (`Translations` for the built-in texts do not apply to demo content).
func tr(
    _ en: String,
    de: String,
    fr: String,
    es: String,
    it: String
) -> LocalizedText {
    LocalizedText(
        en: en,
        translations: ["de": de, "fr": fr, "es": es, "it": it]
    )
}
