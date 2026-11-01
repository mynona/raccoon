import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct KeyTakeawayView: TemplateRepresentable {

    let variants: [PreviewVariant<KeyTakeawaysData>] = [
        #previewVariant(
            "Markdown List with Lightbulb Icon",
            KeyTakeawaysData(
                title: tr(
                    "Key Takeaways",
                    de: "Wichtige Erkenntnisse",
                    fr: "Points clés",
                    es: "Puntos clave",
                    it: "Punti chiave"
                ),
                contentAsMarkdown:
                    tr(
                        "- Start with user problems, not solutions.\n- Validate early and often.\n- Measure outcomes, not outputs.",
                        de:
                            "- Beginne mit den Problemen der Nutzer, nicht mit Lösungen.\n- Validiere früh und oft.\n- Messe Ergebnisse, nicht Outputs.",
                        fr:
                            "- Partez des problèmes des utilisateurs, pas des solutions.\n- Validez tôt et souvent.\n- Mesurez les résultats, pas les livrables.",
                        es:
                            "- Empieza por los problemas de los usuarios, no por las soluciones.\n- Valida pronto y a menudo.\n- Mide los resultados, no los entregables.",
                        it:
                            "- Parti dai problemi degli utenti, non dalle soluzioni.\n- Valida presto e spesso.\n- Misura i risultati, non gli output."
                    ),
                icon: .lightbulb
            )
        )
    ]

    func makeHtml(ctx: KeyTakeawaysData) -> String {
        let html = renderFragments(KeyTakeaways(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("KeyTakeaways")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { KeyTakeaways(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
