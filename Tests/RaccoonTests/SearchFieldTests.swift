import HTML
import Raccoon
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("SearchField")
struct SearchFieldTests {

    @Test(
        "renders default search field with expected attributes, classes, and icon sizing"
    )
    func rendersDefaultSearchField() async throws {

        let html = renderHTML(SearchField().render())

        // Container classes
        #expect(html.contains("flex flex-row items-center w-full rounded-lg"))
        #expect(html.contains("py-2.5"))
        #expect(html.contains(SearchFieldStyles.searchContainerBorderColor))
        #expect(html.contains(SearchFieldStyles.searchContainerBorder))
        #expect(html.contains(SearchFieldStyles.searchContainerFocus))
        #expect(html.contains(SearchFieldStyles.searchContainerHover))
        #expect(!html.contains("rounded-lg bg-transparent"))
        #expect(html.contains("rounded-lg py-2.5"))

        // Leading icon (20px base size, pl-4)
        #expect(html.contains("pl-4"))
        #expect(html.contains(SearchFieldStyles.textColorIcon))
        #expect(html.contains("width=\"20px\""))
        #expect(html.contains("height=\"20px\""))

        // Input element
        #expect(html.contains("placeholder=\"Search\""))
        #expect(html.contains("aria-label=\"Search\""))
        #expect(html.contains("x-model=\"search\""))
        #expect(html.contains("x-ref=\"searchInput\""))
        #expect(html.contains("autocomplete=\"false\""))
        #expect(html.contains("autocapitalize=\"off\""))
        #expect(html.contains("autocorrect=\"off\""))
        #expect(html.contains("class=\"w-full"))
        #expect(html.contains(InputFieldStyles.inputReset))
        #expect(html.contains(SearchFieldStyles.textColorInput))

        // Clear button (type=button, aria-label, Alpine handlers, 20px icon, base padding)
        #expect(html.contains("type=\"button\""))
        #expect(html.contains("aria-label=\"Clear search\""))
        #expect(
            html.contains("x-show=\"search.length &gt; 0\"")
                || html.contains("x-show=\"search.length > 0\"")
        )
        #expect(
            html.contains(
                "@click=\"search = &#39;&#39;; $nextTick(() =&gt; { $refs.searchInput?.focus(); })\""
            )
                || html.contains(
                    "@click=\"search = ''; $nextTick(() => { $refs.searchInput?.focus(); })\""
                )
        )
        #expect(html.contains("p-2 min-h-full h-full mr-4"))
        #expect(html.contains(SearchFieldStyles.actionButton))
    }

    @Test("renders custom Alpine model, ref, and keyup debounce bindings")
    func rendersCustomAlpineBindings() async throws {

        let data = SearchFieldData(
            bindModel: "searchTerm",
            bindRef: "mySearchRef",
            bindKeyup: "getData()"
        )
        let html = renderHTML(SearchField(data).render())

        #expect(html.contains("x-model=\"searchTerm\""))
        #expect(html.contains("x-ref=\"mySearchRef\""))
        #expect(html.contains("@keyup.debounce=\"getData()\""))
        #expect(
            html.contains("x-show=\"searchTerm.length &gt; 0\"")
                || html.contains("x-show=\"searchTerm.length > 0\"")
        )
        #expect(
            html.contains(
                "@click=\"searchTerm = &#39;&#39;; $nextTick(() =&gt; { $refs.mySearchRef?.focus(); })\""
            )
                || html.contains(
                    "@click=\"searchTerm = ''; $nextTick(() => { $refs.mySearchRef?.focus(); })\""
                )
        )
    }

    @Test(
        "renders small size variant with compact icon, input, and clear button while container padding is constant"
    )
    func rendersSmallSizeVariant() async throws {

        let data = SearchFieldData(size: .sm)
        let html = renderHTML(SearchField(data).render())

        // Outer container padding remains constant (py-2.5) across all sizes
        #expect(html.contains("py-2.5"))

        // Icon container uses compact padding (pl-2 pr-1) and 16px dimension
        #expect(html.contains("pl-2 pr-1"))
        #expect(!html.contains("pl-4"))
        #expect(html.contains("width=\"16px\""))
        #expect(html.contains("height=\"16px\""))

        // Input element uses text-sm and compact padding
        #expect(html.contains("w-full px-2 py-1 text-sm"))

        // Clear button uses compact padding (p-1 mr-2) and 16px dimension
        #expect(html.contains("p-1 mr-2"))
        #expect(!html.contains("p-2 min-h-full h-full mr-4"))
    }

    @Test(
        "renders custom clear action, custom clear show, and supports omitting clear button"
    )
    func rendersClearButtonCustomExpressionsAndOmission() async throws {

        // Custom expressions
        let customData = SearchFieldData(
            bindClearAction: "clearSearch()",
            bindClearShow: "showClearSearchButton()"
        )
        let customHtml = renderHTML(SearchField(customData).render())
        #expect(customHtml.contains("@click=\"clearSearch()\""))
        #expect(customHtml.contains("x-show=\"showClearSearchButton()\""))

        // Disabled clear button
        let noClearData = SearchFieldData(hasClearButton: false)
        let noClearHtml = renderHTML(SearchField(noClearData).render())
        #expect(!noClearHtml.contains("<button"))
    }

    @Test("renders dual leading icons when loadingBind is provided")
    func rendersLoadingStateIcons() async throws {

        let loadingData = SearchFieldData(loadingBind: "isLoading")
        let html = renderHTML(SearchField(loadingData).render())

        #expect(html.contains("x-show=\"!isLoading\""))
        #expect(html.contains("x-show=\"isLoading\""))

        // When loadingBind is nil, no x-show attributes on leading icon container
        let standardHtml = renderHTML(SearchField().render())
        #expect(!standardHtml.contains("x-show=\"!isLoading\""))
        #expect(!standardHtml.contains("x-show=\"isLoading\""))
    }

    @Test(
        "forwards iconTitle to leading SVG when provided and omits it by default"
    )
    func forwardsIconTitle() async throws {

        // Opt-in icon title (e.g. CheckboxSelect use case)
        let titledData = SearchFieldData(iconTitle: "Search")
        let titledHtml = renderHTML(SearchField(titledData).render())
        #expect(
            titledHtml.contains("<svg")
                && titledHtml.contains("aria-label=\"Search\"")
        )

        // Default: iconTitle is nil, leading svg has role="presentation" and no aria-label
        let defaultHtml = renderHTML(SearchField().render())
        #expect(defaultHtml.contains("role=\"presentation\""))
        #expect(defaultHtml.contains("aria-hidden=\"true\""))
    }

    @Test(
        "toggles bg-transparent container class based on hasTransparentBackground"
    )
    func togglesTransparentBackground() async throws {

        let transparentData = SearchFieldData(hasTransparentBackground: true)
        let transparentHtml = renderHTML(
            SearchField(transparentData).render()
        )
        #expect(transparentHtml.contains("rounded-lg bg-transparent py-2.5"))

        let standardData = SearchFieldData(hasTransparentBackground: false)
        let standardHtml = renderHTML(SearchField(standardData).render())
        #expect(!standardHtml.contains("rounded-lg bg-transparent"))
        #expect(standardHtml.contains("rounded-lg py-2.5"))
    }

    @Test(
        "emits Matomo tracking attributes when tracker is provided with ACCEPTED or BANNER status, suppresses otherwise"
    )
    func handlesMatomoContentTracking() async throws {

        let tracker = MatomoContentTracker(
            name: "simple-table",
            piece: "search.clear",
            target: "my-table"
        )

        // 1. Default matomoStatus is .ACCEPTED -> emits tracker attributes unconditionally
        let defaultData = SearchFieldData(contentTracker: tracker)
        let defaultHtml = renderHTML(SearchField(defaultData).render())
        #expect(
            defaultHtml.contains("data-track-content=\"\"")
                || defaultHtml.contains("data-track-content")
        )
        #expect(defaultHtml.contains("data-content-name=\"simple-table\""))
        #expect(defaultHtml.contains("data-content-piece=\"search.clear\""))
        #expect(defaultHtml.contains("data-content-target=\"my-table\""))

        // 2. Explicit .BANNER status -> also emits tracker attributes
        let bannerData = SearchFieldData(
            matomoStatus: .BANNER,
            contentTracker: tracker
        )
        let bannerHtml = renderHTML(SearchField(bannerData).render())
        #expect(bannerHtml.contains("data-content-name=\"simple-table\""))

        // 3. .DECLINED status -> suppresses tracker attributes
        let declinedData = SearchFieldData(
            matomoStatus: .DECLINED,
            contentTracker: tracker
        )
        let declinedHtml = renderHTML(SearchField(declinedData).render())
        #expect(!declinedHtml.contains("data-track-content"))
        #expect(!declinedHtml.contains("data-content-name"))

        // 4. .DEACTIVATED status -> suppresses tracker attributes
        let deactivatedData = SearchFieldData(
            matomoStatus: .DEACTIVATED,
            contentTracker: tracker
        )
        let deactivatedHtml = renderHTML(
            SearchField(deactivatedData).render()
        )
        #expect(!deactivatedHtml.contains("data-track-content"))

        // 5. No contentTracker -> no tracking attributes
        let noTrackerData = SearchFieldData(
            matomoStatus: .ACCEPTED,
            contentTracker: nil
        )
        let noTrackerHtml = renderHTML(SearchField(noTrackerData).render())
        #expect(!noTrackerHtml.contains("data-track-content"))
    }

    @Test(
        "renders id, name, tabindex, aria-controls, pre-filled value, and disabled state"
    )
    func rendersOptionalDomAndAccessibilityAttributes() async throws {

        let fullData = SearchFieldData(
            id: "search-input-id",
            name: "searchFieldQuery",
            tabindex: "0",
            placeholder: "Filter rows...",
            ariaLabel: "Filter rows",
            clearAriaLabel: "Clear row filter",
            ariaControls: "table-body",
            value: "Initial text",
            state: .disabled
        )
        let html = renderHTML(SearchField(fullData).render())

        #expect(html.contains("id=\"search-input-id\""))
        #expect(html.contains("name=\"searchFieldQuery\""))
        #expect(html.contains("tabindex=\"0\""))
        #expect(html.contains("placeholder=\"Filter rows...\""))
        #expect(html.contains("aria-label=\"Filter rows\""))
        #expect(html.contains("aria-label=\"Clear row filter\""))
        #expect(html.contains("aria-controls=\"table-body\""))
        #expect(html.contains("value=\"Initial text\""))
        #expect(html.contains("disabled=\"\"") || html.contains("disabled"))
    }
}
