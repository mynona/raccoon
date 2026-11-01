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
                label: tr(
                    "Save",
                    de: "Speichern",
                    fr: "Enregistrer",
                    es: "Guardar",
                    it: "Salva"
                ),
                tooltip: tr(
                    "Save your changes",
                    de: "Änderungen speichern",
                    fr: "Enregistrer vos modifications",
                    es: "Guardar los cambios",
                    it: "Salva le modifiche"
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
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                tooltip: tr(
                    "Tooltip",
                    de: "Tooltip",
                    fr: "Infobulle",
                    es: "Información",
                    it: "Tooltip"
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
            // .primary + no icon
            """,
            LinkButtonData(
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
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
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                tooltip: tr(
                    "Tooltip",
                    de: "Tooltip",
                    fr: "Infobulle",
                    es: "Información",
                    it: "Tooltip"
                ),
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
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
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
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
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
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
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
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
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
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
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
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
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
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
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
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
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
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
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
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                tooltip: tr(
                    "Tooltip",
                    de: "Tooltip",
                    fr: "Infobulle",
                    es: "Información",
                    it: "Tooltip"
                ),
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
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
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
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
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
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
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
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                tooltip: tr(
                    "Tooltip",
                    de: "Tooltip",
                    fr: "Infobulle",
                    es: "Información",
                    it: "Tooltip"
                ),
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
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                tooltip: tr(
                    "Tooltip",
                    de: "Tooltip",
                    fr: "Infobulle",
                    es: "Información",
                    it: "Tooltip"
                ),
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
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
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
                    tr(
                        "This is a very long link button label that exceeds container width and wraps onto multiple lines cleanly with vertical centering",
                        de:
                            "Dies ist eine sehr lange Link-Button-Beschriftung, die die Containerbreite überschreitet und sauber über mehrere Zeilen mit vertikaler Zentrierung umbricht",
                        fr:
                            "Ceci est un libellé de bouton lien très long qui dépasse la largeur du conteneur et s'étend proprement sur plusieurs lignes avec centrage vertical",
                        es:
                            "Esta es una etiqueta de botón de enlace muy larga que supera el ancho del contenedor y se distribuye limpiamente en varias líneas con centrado vertical",
                        it:
                            "Questa è un'etichetta molto lunga che supera la larghezza del contenitore e va a capo in modo ordinato su più righe con centratura verticale"
                    ),
                ariaLabel: tr(
                    "Detailed long link button",
                    de: "Ausführlicher langer Link-Button",
                    fr: "Long bouton lien détaillé",
                    es: "Botón de enlace largo y detallado",
                    it: "Pulsante link lungo e dettagliato"
                ),
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
