import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct AccordionView: TemplateRepresentable {

    var variants: [PreviewVariant<AccordionData>] {
        [
            #previewVariant(
                """
                // Border 
                """,
                AccordionData(
                    label: tr(
                        "What is product thinking?",
                        de: "Was ist Product Thinking?",
                        fr: "Qu'est-ce que le product thinking ?",
                        es: "¿Qué es el product thinking?",
                        it: "Che cos'è il product thinking?"
                    ),
                    content: .html(
                        tr(
                            "Product thinking means solving the <em>right</em> problems, not just building features.",
                            de:
                                "Product Thinking bedeutet, die <em>richtigen</em> Probleme zu lösen, nicht nur Features zu bauen.",
                            fr:
                                "Le product thinking consiste à résoudre les <em>bons</em> problèmes, pas seulement à développer des fonctionnalités.",
                            es:
                                "El product thinking consiste en resolver los problemas <em>correctos</em>, no solo en crear funcionalidades.",
                            it:
                                "Il product thinking significa risolvere i problemi <em>giusti</em>, non solo sviluppare funzionalità."
                        )
                    ),
                    icon: .journal_text,
                    isLabelMonospaced: true,
                    hasBorder: true,
                    matomoStatus: .DECLINED
                )
            ),
            #previewVariant(
                """
                // No border + with Matomo
                """,
                AccordionData(
                    label: tr(
                        "No border applied",
                        de: "Kein Rahmen angewendet",
                        fr: "Aucune bordure appliquée",
                        es: "Sin borde aplicado",
                        it: "Nessun bordo applicato"
                    ),
                    content: .markdown(
                        tr(
                            "# Content",
                            de: "# Inhalt",
                            fr: "# Contenu",
                            es: "# Contenido",
                            it: "# Contenuto"
                        )
                    ),
                    hasBorder: false,
                    matomoStatus: .ACCEPTED
                )
            ),
            #previewVariant(
                """
                // element
                """,
                AccordionData(
                    label: tr(
                        "No border applied",
                        de: "Kein Rahmen angewendet",
                        fr: "Aucune bordure appliquée",
                        es: "Sin borde aplicado",
                        it: "Nessun bordo applicato"
                    ),
                    content: .element {
                        H1(
                            tr(
                                "H1 Header",
                                de: "H1-Überschrift",
                                fr: "Titre H1",
                                es: "Encabezado H1",
                                it: "Intestazione H1"
                            )
                            .resolved
                        )
                        .class("test")
                        P(
                            tr(
                                "Paragraph",
                                de: "Absatz",
                                fr: "Paragraphe",
                                es: "Párrafo",
                                it: "Paragrafo"
                            )
                            .resolved
                        )
                    },
                    hasBorder: false
                )
            ),
        ]
    }

    func makeHtml(ctx: AccordionData) -> String {
        let html = renderFragments(Accordion(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Accordion")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Accordion(variant.data).render() }
                            .class("mb-4 mt-4")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
