import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct LinkView: TemplateRepresentable {

    let variants: [PreviewVariant<HyperLinkData>] = [
        #previewVariant(
            """
            // .center
            """,
            HyperLinkData(
                label: "Some label",
                ariaLabel: "Some aria label",
                href: "#",
                hreflang: "en-US",
                target: .blank,
                rel: .nofollow,
                tooltip: "Some tooltip",
                icon: .airplane,
                iconSize: 16,
                align: .center,
                isFocusable: true,
                isUnderlined: true,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // .left
            """,
            HyperLinkData(
                label: "Some label",
                ariaLabel: "Some aria label",
                href: "#",
                hreflang: "en-US",
                tooltip: "Some tooltip",
                icon: .airplane,
                iconSize: 16,
                align: .left,
                isFocusable: true,
                isUnderlined: true,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // .left + not underlined + no aria label + iconSize(48)
            """,
            HyperLinkData(
                label: "Some label",
                ariaLabel: nil,
                href: "#",
                hreflang: "en-US",
                icon: .airplane,
                iconSize: 48,
                align: .left,
                isFocusable: true,
                isUnderlined: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // focusable = false
            """,
            HyperLinkData(
                label: "Some label",
                ariaLabel: nil,
                href: "#",
                hreflang: "en-US",
                icon: .airplane,
                iconSize: 16,
                align: .left,
                isFocusable: false,
                isUnderlined: true,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // Multiline wrapping
            """,
            HyperLinkData(
                label:
                    "This is a detailed hyperlink text explaining an external resource across multiple wrapped lines with vertical centering",
                ariaLabel: "Detailed resource documentation",
                href: "#",
                hreflang: "en-US",
                icon: .airplane,
                iconSize: 20,
                align: .left,
                isFocusable: true,
                isUnderlined: true,
                contentTracker: tracker
            )
        ),
    ]

    func makeHtml(ctx: HyperLinkData) -> String {
        let html = renderFragments(HyperLink(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Hyperlink")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { HyperLink(variant.data).render() }
                            .class("mb-4 mt-12 flex justify-center")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
