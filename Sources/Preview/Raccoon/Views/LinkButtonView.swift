import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct LinkButtonView: TemplateRepresentable {

    let variants: [(String, LinkButtonData)] = [
        (
            """
            // .primary
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                tooltip: "Tooltip",
                tooltipPosition: .bottom,
                href: "#",
                hreflang: "en-US",
                buttonType: .primary,
                icon: .airplane,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        (
            """
            // .primary + no icon
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                hreflang: "en-US",
                buttonType: .primary,
                icon: nil,
                iconSize: nil,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        (
            """
            // .primary + fullWidth
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                tooltip: "Tooltip",
                tooltipPosition: .bottom,
                href: "#",
                hreflang: "en-US",
                buttonType: .primary,
                icon: .airplane,
                iconSize: 16,
                hasFullWidth: true,
                contentTracker: tracker
            )
        ),
        (
            """
            // .primary + inverted
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                hreflang: "en-US",
                buttonType: .primary,
                icon: .airplane,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        // secondary
        (
            """
            // .secondary
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                hreflang: "en-US",
                buttonType: .secondary,
                icon: .camera,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        (
            """
            //
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                hreflang: "en-US",
                buttonType: .secondary,
                icon: nil,
                iconSize: nil,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        (
            """
            //
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                hreflang: "en-US",
                buttonType: .secondary,
                icon: .camera,
                iconSize: 16,
                hasFullWidth: true,
                contentTracker: tracker
            )
        ),
        (
            """
            //
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                hreflang: "en-US",
                buttonType: .secondary,
                icon: .camera,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        // tertiary
        (
            """
            // .tertiary
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                hreflang: "en-US",
                buttonType: .tertiary,
                icon: .cake,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        (
            """
            // .tertiary + no icon
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                hreflang: "en-US",
                buttonType: .tertiary,
                icon: nil,
                iconSize: nil,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        (
            """
            // .tertiary + fullWidth
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                hreflang: "en-US",
                buttonType: .tertiary,
                icon: .cake,
                iconSize: 16,
                hasFullWidth: true,
                contentTracker: tracker
            )
        ),
        (
            """
            // .tertiary + inverted
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                hreflang: "en-US",
                buttonType: .tertiary,
                icon: .cake,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        // warning
        (
            """
            // .warning
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                tooltip: "Tooltip",
                tooltipPosition: .bottom,
                href: "#",
                hreflang: "en-US",
                buttonType: .warning,
                icon: .tree,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        (
            """
            // .warning + no icon
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                hreflang: "en-US",
                buttonType: .warning,
                icon: nil,
                iconSize: nil,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        (
            """
            // .warning + fullWidth
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                hreflang: "en-US",
                buttonType: .warning,
                icon: .tree,
                iconSize: 16,
                hasFullWidth: true,
                contentTracker: tracker
            )
        ),
        (
            """
            // .warning + inverted
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                hreflang: "en-US",
                buttonType: .warning,
                icon: .tree,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        // icon
        (
            """
            // .icon
            """,
            LinkButtonData(
                label: nil,
                ariaLabel: "aria-label",
                tooltip: "Tooltip",
                tooltipPosition: .bottom,
                href: "#",
                hreflang: "en-US",
                buttonType: .icon,
                icon: .mouse,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        (
            """
            // .icon + fullWidth
            """,
            LinkButtonData(
                label: nil,
                ariaLabel: "aria-label",
                tooltip: "Tooltip",
                tooltipPosition: .top,
                href: "#",
                hreflang: "en-US",
                buttonType: .icon,
                icon: .mouse,
                iconSize: 16,
                hasFullWidth: true,
                contentTracker: tracker
            )
        ),
        (
            """
            // .icon + inverted
            """,
            LinkButtonData(
                label: nil,
                ariaLabel: "aria-label",
                href: "#",
                hreflang: "en-US",
                buttonType: .icon,
                icon: .mouse,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        (
            """
            // Multiline wrapping with icon
            """,
            LinkButtonData(
                label:
                    "This is a very long link button label that exceeds container width and wraps onto multiple lines cleanly with vertical centering",
                ariaLabel: "Detailed long link button",
                href: "#",
                hreflang: "en-US",
                buttonType: .primary,
                icon: .airplane,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
    ]

    func makeHtml(ctx: LinkButtonData) -> String {
        let html = renderFragments(LinkButton(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("LinkButton")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { LinkButton(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
