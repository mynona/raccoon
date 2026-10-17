import HTML
import SGML
import SVG
import WebBuilders

/// Standardized table paginator component following Raccoon conventions and Material paginator interaction standards.
///
/// Supports two modes:
/// 1. `.alpine`: Interactive client-side/AJAX state driven by Alpine.js.
/// 2. `.link`: Server-side rendered (SSR) standard navigation with query params (`?page=X&per=Y`).
public struct TablePaginator: TemplateRepresentable {

    let data: TablePaginatorData
    typealias styles = TablePaginatorStyles

    /// Creates a new `TablePaginator` component instance.
    ///
    /// - Parameter data: Configuration data model for the paginator.
    public init(_ data: TablePaginatorData = TablePaginatorData()) {
        self.data = data
    }

    private func buildUrl(
        basePath: String,
        queryParams: [String: String],
        page: Int,
        per: Int
    ) -> String {
        var params = queryParams
        params["page"] = String(page)
        params["per"] = String(per)
        let queryString = params.sorted { $0.key < $1.key }
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
        return "\(basePath)?\(queryString)"
    }

    // MARK: - Navigation Buttons

    @Builder<Element>
    private func showNavigationButton(
        icon: SvgIcon,
        label: String,
        click: String?,
        disabled: String
    ) -> [Element] {
        Button {
            Svg.icon(icon, width: 16, height: 16)
        }
        .type(.button)
        .ariaLabel(label)
        .if(click != nil) {
            guard let click else { return $0 }
            return $0.setAttribute(name: "@click", value: click)
        }
        .setAttribute(name: ":disabled", value: disabled)
        .setAttribute(
            name: ":class",
            value:
                "(\(disabled)) ? '\(styles.navigationButtonDisabled)' : '\(styles.navigationButtonEnabled)'"
        )
        .class(styles.navigationButtonEnabled)
    }

    @Builder<Element>
    private func showLinkNavigationButton(
        icon: SvgIcon,
        label: String,
        url: String?,
        isEnabled: Bool
    ) -> [Element] {
        if isEnabled, let url {
            A {
                Svg.icon(icon, width: 16, height: 16)
            }
            .href(url)
            .ariaLabel(label)
            .class(styles.navigationButtonEnabled)
        }
        else {
            Button {
                Svg.icon(icon, width: 16, height: 16)
            }
            .type(.button)
            .ariaLabel(label)
            .disabled()
            .class(styles.navigationButtonDisabled)
        }
    }

    // MARK: - Page Size Selector

    @Builder<Element>
    private func showPageSizeSelector() -> [Element] {
        switch data.mode {
        case .alpine:
            Div {
                Span(data.itemsPerPageLabel)
                    .class(styles.label)

                let options = data.pageSizeOptions.map { size in
                    let changeHandler =
                        data.onPageSizeChange != nil
                        ? "\(size)"
                        : "\(size)"
                    return SimpleMenuOption(
                        id: String(size),
                        title: String(size),
                        clickAction: "changePageSize(\(changeHandler))",
                        bindSelected: "\(size) === \(data.bindPer)"
                    )
                }

                SimpleMenu(
                    SimpleMenuData(
                        id: data.selectId,
                        bindTriggerText: data.bindPer,
                        ariaLabel: data.itemsPerPageLabel,
                        options: options,
                        width: "w-28"
                    )
                )
                .render()
            }
            .class(styles.pageSizeSelectorContainer)

        case .link(let basePath, let queryParams):
            if let info = data.info {
                Div {
                    Span(data.itemsPerPageLabel)
                        .class(styles.label)

                    let options = data.pageSizeOptions.map { size in
                        let url = buildUrl(
                            basePath: basePath,
                            queryParams: queryParams,
                            page: 1,
                            per: size
                        )
                        return SimpleMenuOption(
                            id: String(size),
                            title: String(size),
                            isSelected: size == info.per,
                            href: url
                        )
                    }

                    SimpleMenu(
                        SimpleMenuData(
                            id: data.selectId,
                            ariaLabel: data.itemsPerPageLabel,
                            triggerText: String(info.per),
                            options: options,
                            width: "w-28"
                        )
                    )
                    .render()
                }
                .class(styles.pageSizeSelectorContainer)
            }
        }
    }

    // MARK: - Range Label

    @Builder<Element>
    private func showRangeLabel() -> [Element] {
        switch data.mode {
        case .alpine:
            P("")
                .setAttribute(name: "x-text", value: data.bindRangeLabel)
                .setAttribute(name: "aria-live", value: "polite")
                .class(styles.label)

        case .link:
            if let info = data.info {
                P(info.rangeLabel)
                    .setAttribute(name: "aria-live", value: "polite")
                    .class(styles.label)
            }
        }
    }

    // MARK: - Navigation Buttons Group

    @Builder<Element>
    private func showNavigationButtons() -> [Element] {
        switch data.mode {
        case .alpine:
            Div {
                showNavigationButton(
                    icon: .chevron_double_left,
                    label: data.firstPageAriaLabel,
                    click: data.onFirstPage,
                    disabled:
                        "!(\(data.bindHasPrevious)) || \(data.bindIsLoading)"
                )
                showNavigationButton(
                    icon: .chevron_left,
                    label: data.previousPageAriaLabel,
                    click: data.onPreviousPage,
                    disabled:
                        "!(\(data.bindHasPrevious)) || \(data.bindIsLoading)"
                )
                showNavigationButton(
                    icon: .chevron_right,
                    label: data.nextPageAriaLabel,
                    click: data.onNextPage,
                    disabled: "!(\(data.bindHasNext)) || \(data.bindIsLoading)"
                )
                showNavigationButton(
                    icon: .chevron_double_right,
                    label: data.lastPageAriaLabel,
                    click: data.onLastPage,
                    disabled: "!(\(data.bindHasNext)) || \(data.bindIsLoading)"
                )
            }
            .class(styles.navigationButtonGroup)

        case .link(let basePath, let queryParams):
            if let info = data.info {
                let firstUrl = buildUrl(
                    basePath: basePath,
                    queryParams: queryParams,
                    page: 1,
                    per: info.per
                )
                let prevUrl = buildUrl(
                    basePath: basePath,
                    queryParams: queryParams,
                    page: max(1, info.page - 1),
                    per: info.per
                )
                let nextUrl = buildUrl(
                    basePath: basePath,
                    queryParams: queryParams,
                    page: min(info.totalPages, info.page + 1),
                    per: info.per
                )
                let lastUrl = buildUrl(
                    basePath: basePath,
                    queryParams: queryParams,
                    page: info.totalPages,
                    per: info.per
                )

                Div {
                    showLinkNavigationButton(
                        icon: .chevron_double_left,
                        label: data.firstPageAriaLabel,
                        url: firstUrl,
                        isEnabled: info.hasPrevious
                    )
                    showLinkNavigationButton(
                        icon: .chevron_left,
                        label: data.previousPageAriaLabel,
                        url: prevUrl,
                        isEnabled: info.hasPrevious
                    )
                    showLinkNavigationButton(
                        icon: .chevron_right,
                        label: data.nextPageAriaLabel,
                        url: nextUrl,
                        isEnabled: info.hasNext
                    )
                    showLinkNavigationButton(
                        icon: .chevron_double_right,
                        label: data.lastPageAriaLabel,
                        url: lastUrl,
                        isEnabled: info.hasNext
                    )
                }
                .class(styles.navigationButtonGroup)
            }
        }
    }

    // MARK: - Render

    @Builder<Element>
    public func render() -> [Element] {
        Nav {
            showPageSizeSelector()
            showRangeLabel()
            showNavigationButtons()
        }
        .ariaLabel(data.ariaLabel)
        .if(data.bindShow != nil) {
            guard let bindShow = data.bindShow else { return $0 }
            return $0.setAttribute(name: "x-show", value: bindShow)
                .flagAttribute("x-cloak")
        }
        .class(styles.container)
    }
}
