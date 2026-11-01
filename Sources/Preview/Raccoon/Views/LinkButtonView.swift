import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct LinkButtonView: TemplateRepresentable {

    let variants: [PreviewVariant<LinkButtonData>] = [
        #previewVariant(
            """
            // With translations (en, de, fr) and icon-only with the built-in fallback label
            """,
            LinkButtonData(
                label: LocalizedText(
                    en: "Save",
                    translations: ["de": "Speichern", "fr": "Enregistrer"]
                ),
                tooltip: LocalizedText(
                    en: "Save your changes",
                    translations: [
                        "de": "Änderungen speichern",
                        "fr": "Enregistrer vos modifications",
                    ]
                ),
                tooltipPosition: .bottom,
                href: "#",
                buttonType: .primary,
                icon: .airplane,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // Icon only, no texts: the aria-label "Link" is built in and translated
            """,
            LinkButtonData(
                href: "#",
                buttonType: .icon,
                icon: nil,
                iconSize: nil,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // .primary
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                tooltip: "Tooltip",
                tooltipPosition: .bottom,
                href: "#",
                buttonType: .primary,
                icon: .airplane,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // .primary + no icon
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                buttonType: .primary,
                icon: nil,
                iconSize: nil,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // .primary + fullWidth
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                tooltip: "Tooltip",
                tooltipPosition: .bottom,
                href: "#",
                buttonType: .primary,
                icon: .airplane,
                iconSize: 16,
                hasFullWidth: true,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // .primary + inverted
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                buttonType: .primary,
                icon: .airplane,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        // secondary
        #previewVariant(
            """
            // .secondary
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                buttonType: .secondary,
                icon: .camera,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            //
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                buttonType: .secondary,
                icon: nil,
                iconSize: nil,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            //
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                buttonType: .secondary,
                icon: .camera,
                iconSize: 16,
                hasFullWidth: true,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            //
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                buttonType: .secondary,
                icon: .camera,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        // tertiary
        #previewVariant(
            """
            // .tertiary
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                buttonType: .tertiary,
                icon: .cake,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // .tertiary + no icon
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                buttonType: .tertiary,
                icon: nil,
                iconSize: nil,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // .tertiary + fullWidth
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                buttonType: .tertiary,
                icon: .cake,
                iconSize: 16,
                hasFullWidth: true,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // .tertiary + inverted
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                buttonType: .tertiary,
                icon: .cake,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        // warning
        #previewVariant(
            """
            // .warning
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                tooltip: "Tooltip",
                tooltipPosition: .bottom,
                href: "#",
                buttonType: .warning,
                icon: .tree,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // .warning + no icon
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                buttonType: .warning,
                icon: nil,
                iconSize: nil,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // .warning + fullWidth
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                buttonType: .warning,
                icon: .tree,
                iconSize: 16,
                hasFullWidth: true,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // .warning + inverted
            """,
            LinkButtonData(
                label: "Label",
                ariaLabel: "aria-label",
                href: "#",
                buttonType: .warning,
                icon: .tree,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        // icon
        #previewVariant(
            """
            // .icon
            """,
            LinkButtonData(
                label: nil,
                ariaLabel: "aria-label",
                tooltip: "Tooltip",
                tooltipPosition: .bottom,
                href: "#",
                buttonType: .icon,
                icon: .mouse,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // .icon + fullWidth
            """,
            LinkButtonData(
                label: nil,
                ariaLabel: "aria-label",
                tooltip: "Tooltip",
                tooltipPosition: .top,
                href: "#",
                buttonType: .icon,
                icon: .mouse,
                iconSize: 16,
                hasFullWidth: true,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // .icon + inverted
            """,
            LinkButtonData(
                label: nil,
                ariaLabel: "aria-label",
                href: "#",
                buttonType: .icon,
                icon: .mouse,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // Multiline wrapping with icon
            """,
            LinkButtonData(
                label:
                    "This is a very long link button label that exceeds container width and wraps onto multiple lines cleanly with vertical centering",
                ariaLabel: "Detailed long link button",
                href: "#",
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

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { LinkButton(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
