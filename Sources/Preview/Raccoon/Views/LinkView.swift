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
                label: tr(
                    "Some label",
                    de: "Eine Beschriftung",
                    fr: "Un libellé",
                    es: "Una etiqueta",
                    it: "Un'etichetta"
                ),
                ariaLabel: tr(
                    "Some aria label",
                    de: "Ein Aria-Label",
                    fr: "Un aria-label",
                    es: "Un aria-label",
                    it: "Un aria-label"
                ),
                href: "#",
                target: .blank,
                rel: .nofollow,
                tooltip: tr(
                    "Some tooltip",
                    de: "Ein Tooltip",
                    fr: "Une infobulle",
                    es: "Una información",
                    it: "Un tooltip"
                ),
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
                label: tr(
                    "Some label",
                    de: "Eine Beschriftung",
                    fr: "Un libellé",
                    es: "Una etiqueta",
                    it: "Un'etichetta"
                ),
                ariaLabel: tr(
                    "Some aria label",
                    de: "Ein Aria-Label",
                    fr: "Un aria-label",
                    es: "Un aria-label",
                    it: "Un aria-label"
                ),
                href: "#",
                tooltip: tr(
                    "Some tooltip",
                    de: "Ein Tooltip",
                    fr: "Une infobulle",
                    es: "Una información",
                    it: "Un tooltip"
                ),
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
                label: tr(
                    "Some label",
                    de: "Eine Beschriftung",
                    fr: "Un libellé",
                    es: "Una etiqueta",
                    it: "Un'etichetta"
                ),
                ariaLabel: nil,
                href: "#",
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
                label: tr(
                    "Some label",
                    de: "Eine Beschriftung",
                    fr: "Un libellé",
                    es: "Una etiqueta",
                    it: "Un'etichetta"
                ),
                ariaLabel: nil,
                href: "#",
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
                    tr(
                        "This is a detailed hyperlink text explaining an external resource across multiple wrapped lines with vertical centering",
                        de:
                            "Dies ist ein ausführlicher Hyperlink-Text, der eine externe Ressource über mehrere umbrochene Zeilen mit vertikaler Zentrierung erklärt",
                        fr:
                            "Ceci est un texte de lien détaillé qui explique une ressource externe sur plusieurs lignes avec centrage vertical",
                        es:
                            "Este es un texto de hipervínculo detallado que explica un recurso externo en varias líneas con centrado vertical",
                        it:
                            "Questo è un testo di collegamento dettagliato che spiega una risorsa esterna su più righe con centratura verticale"
                    ),
                ariaLabel: tr(
                    "Detailed resource documentation",
                    de: "Ausführliche Dokumentation der Ressource",
                    fr: "Documentation détaillée de la ressource",
                    es: "Documentación detallada del recurso",
                    it: "Documentazione dettagliata della risorsa"
                ),
                href: "#",
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
