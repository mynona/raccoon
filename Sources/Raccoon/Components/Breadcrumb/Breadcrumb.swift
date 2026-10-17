import HTML
import SGML
import SVG
import WebBuilders

public struct Breadcrumb: TemplateRepresentable {
    let data: BreadcrumbData
    typealias styles = BreadcrumbStyles

    public init(
        _ data: BreadcrumbData
    ) {
        self.data = data
    }

    @Builder<Element>
    func showHome() -> [Element] {
        if data.hasHome {
            Li {

                A {

                    Div {

                        Svg.icon(
                            .house,
                            title: "Home",
                            width: 16,
                            height: 16,
                            role: .img
                        )
                        .class("inline-block md:hidden")

                        P("Home")
                            .class("hidden md:inline-block")

                    }
                    .class("flex flex-row items-center")
                }
                .href(data.homeUrl)
                .hrefLang(data.homeHreflang)
                .ariaLabel("Home")
                .addClass(styles.itemActive)
                // Matomo
                .if(
                    data.matomoStatus == .ACCEPTED
                        || data.matomoStatus == .BANNER
                ) {

                    $0
                        .flagAttribute("data-track-content")
                        .setAttribute(
                            name: "data-content-name",
                            value: "breadcrumb"
                        )
                        .setAttribute(
                            name: "data-content-piece",
                            value: "breadcrumb.home"
                        )
                        .setAttribute(
                            name: "data-content-target",
                            value: data.homeUrl.hasSuffix("/")
                                ? String(data.homeUrl.dropLast()) : data.homeUrl
                        )

                }

                Span {
                    Svg.icon(.chevron_right, width: 12, height: 12)
                }
                .setAttribute(
                    name: "aria-hidden",
                    value: "true"
                )
                .class(styles.itemSeparatorColor)
            }
            .class(styles.item)

        }
    }

    @Builder<Element>
    func showPath(path: BreadcrumbPath, totalPaths: Int) -> [Element] {
        if path.isCurrentPathSegment {

            Li {

                let abbreviation =
                    (totalPaths <= 2)
                    ? path.title
                    : "…"

                Span {
                    // Single viewport-independent accessible name for the current segment
                    Span(path.title)
                        .class("sr-only")

                    Span(abbreviation)
                        .setAttribute(
                            name: "aria-hidden",
                            value: "true"
                        )
                        .class("inline-block md:hidden")
                    Span(path.title)
                        .setAttribute(
                            name: "aria-hidden",
                            value: "true"
                        )
                        .class("hidden md:inline-block")
                }
                .setAttribute(
                    name: "aria-current",
                    value: "page"
                )
                .class(styles.itemCurrentText)

            }
            .class(styles.itemCurrent)

        }
        else {

            Li {

                A(path.title)
                    .href(path.href)
                    .hrefLang(path.hreflang)
                    .class(styles.itemActive)

                Span {
                    Svg.icon(.chevron_right, width: 12, height: 12)
                }
                .setAttribute(
                    name: "aria-hidden",
                    value: "true"
                )
                .class(styles.itemSeparatorColor)
            }
            .class(styles.item)
            // Matomo
            .if(data.matomoStatus == .ACCEPTED || data.matomoStatus == .BANNER)
            {

                $0
                    .flagAttribute("data-track-content")
                    .setAttribute(
                        name: "data-content-name",
                        value: "breadcrumb"
                    )
                    .setAttribute(
                        name: "data-content-piece",
                        value: "breadcrumb.pathsegment"
                    )
                    .setAttribute(
                        name: "data-content-target",
                        value: "\(path.href)"
                    )

            }

        }
    }

    @Builder<Element>
    public func render() -> [Element] {

        if let paths = data.paths {

            DebugComment("Breadcrumbs")
            Nav {
                Ol {
                    showHome()
                    for path in paths {
                        showPath(
                            path: path,
                            totalPaths: paths.count
                        )
                    }
                }
                .class(styles.list)
            }
            .setAttribute(
                name: "aria-label",
                value: "Breadcrumb"
            )
            .class(styles.nav)

        }

    }

}
