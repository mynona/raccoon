import HTML
import SGML
import WebBuilders

public struct Pagination: TemplateRepresentable {
    let data: PaginationData
    typealias styles = PaginationStyles

    public init(
        _ data: PaginationData,
    ) {
        self.data = data
    }

    enum Direction {
        case first, last
    }

    @Builder<Element>
    func showMainLink() -> [Element] {
        if let tableOfContent = data.tableOfContent {
            Div {
                LinkButton(
                    LinkButtonData(
                        label: tableOfContent.title,
                        ariaLabel: tableOfContent.title,
                        href: data.hrefBase,
                        hreflang: AppValues.lang,
                        buttonType: .tertiary,
                        icon: .newspaper,
                        iconSize: 16,
                        hasFullWidth: false,
                        hasTruncation: true,
                        contentTracker: MatomoContentTracker(
                            name: "pagination",
                            piece: "mainLink",
                            target: data.hrefBase
                        )
                    )
                )
                .render()
            }
        }
    }

    @Builder<Element>
    func showBoundaryButton(
        direction: Direction,
        destination: String,
        title: String
    ) -> [Element] {
        Li {
            LinkButton(
                LinkButtonData(
                    label: nil,
                    ariaLabel: (direction == .first)
                        ? "First page: \(title)" : "Last page: \(title)",
                    tooltip: (direction == .first) ? "First page" : "Last page",
                    tooltipPosition: .bottom,
                    href: destination,
                    hreflang: AppValues.lang,
                    buttonType: .secondary,
                    icon: (direction == .first ? .skip_start : .skip_end),
                    iconSize: 16,
                    hasFullWidth: false,
                    contentTracker: MatomoContentTracker(
                        name: "pagination",
                        piece: (direction == .first) ? "firstPage" : "lastPage",
                        target: destination
                    )
                )
            )
            .render()
        }
    }

    @Builder<Element>
    func showSelectedItem(title: String, index: Int) -> [Element] {
        Li {
            Span("Current page: \(title), page number: \(index)")
                .class("sr-only")
            Span("\(index)")
        }
        .setAttribute(name: "aria-current", value: "page")
        .class(styles.cursorNotAllowed)
        .addClass("px-4 py-1.5 transition")
        .addClass(styles.font)
        .addClass(styles.textSizeBase)
        .addClass(styles.currentItemTextColor)
        .addClass(styles.currentItemBackgroundColor)
        .addClass(styles.currentItemBorder)
    }

    @Builder<Element>
    func showPageItem(
        page: (offset: Int, element: (title: String, friendly_url: String)),
        isOuter: Bool = false
    ) -> [Element] {
        let pageNumber = page.offset + 1
        Li {
            LinkButton(
                LinkButtonData(
                    label: "\(pageNumber)",
                    ariaLabel: "Page \(pageNumber): \(page.element.title)",
                    tooltip: "Page \(pageNumber)",
                    tooltipPosition: .bottom,
                    href: "\(data.hrefBase)/\(page.element.friendly_url)",
                    hreflang: AppValues.lang,
                    buttonType: .secondary,
                    hasFullWidth: false,
                    contentTracker: MatomoContentTracker(
                        name: "pagination",
                        piece: "page-\(pageNumber)",
                        target: "\(data.hrefBase)/\(page.element.friendly_url)"
                    )
                )
            )
            .render()
        }
        .if(isOuter) {
            $0.class("hidden md:inline-block")
        }
    }

    func computeVisiblePageIndices(total: Int, activeIndex: Int) -> [Int] {
        guard total > 0 else {
            return []
        }
        let start = max(0, activeIndex - 2)
        let end = min(total - 1, activeIndex + 2)
        return Array(start...end)
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Pagination")
        if data.pages.count > 1,
            let activeIndex = data.pages.firstIndex(where: { $0.selected })
        {

            Nav {

                Div {

                    showMainLink()

                    Ul {

                        // MARK: first page button
                        if activeIndex > 0 {
                            let firstPage = data.pages[0]
                            showBoundaryButton(
                                direction: .first,
                                destination:
                                    "\(data.hrefBase)/\(firstPage.friendly_url)",
                                title: firstPage.title
                            )
                        }

                        // MARK: pages (two pages before and two pages after current page)
                        let visibleIndices = computeVisiblePageIndices(
                            total: data.pages.count,
                            activeIndex: activeIndex
                        )

                        for idx in visibleIndices {
                            let page = data.pages[idx]
                            if idx == activeIndex {
                                showSelectedItem(
                                    title: page.title,
                                    index: idx + 1
                                )
                            }
                            else {
                                showPageItem(
                                    page: (
                                        offset: idx,
                                        element: (
                                            title: page.title,
                                            friendly_url: page.friendly_url
                                        )
                                    ),
                                    isOuter: abs(idx - activeIndex) > 1
                                )
                            }
                        }

                        // MARK: last page button
                        if activeIndex < data.pages.count - 1 {
                            let lastPage = data.pages[data.pages.count - 1]
                            showBoundaryButton(
                                direction: .last,
                                destination:
                                    "\(data.hrefBase)/\(lastPage.friendly_url)",
                                title: lastPage.title
                            )
                        }

                    }
                    .setAttribute(name: "aria-label", value: "Story pagination")
                    .class("flex flex-row space-x-2 items-center")

                }
                .class(
                    "flex flex-col sm:flex-row flex-wrap gap-4 justify-center sm:justify-between items-center w-full"
                )

            }
            .ariaLabel("Pagination")
            .class("mt-12 print:hidden grid justify-items-start w-full")

        }

    }
}
