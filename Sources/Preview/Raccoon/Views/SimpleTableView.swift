import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct SimpleTableView: TemplateRepresentable {

    let variants: [PreviewVariant<SimpleTableData>] = [
        #previewVariant(
            tr(
                "Structured Data Table with Caption",
                [
                    "de": "Strukturierte Datentabelle mit Beschriftung",
                    "fr": "Tableau de données structurées avec légende",
                    "es": "Tabla de datos estructurados con leyenda",
                    "it": "Tabella di dati strutturati con didascalia",
                    "pt": "Tabela de dados estruturados com legenda",
                    "nl": "Gestructureerde gegevenstabel met bijschrift",
                    "da": "Struktureret datatabel med billedtekst",
                    "sv": "Strukturerad datatabell med bildtext",
                    "nb": "Strukturert datatabell med bildetekst",
                    "fi": "Rakenteinen datataulukko kuvatekstillä",
                    "is": "Skipulögð gagnatafla með skýringatexta",
                    "el": "Δομημένος πίνακας δεδομένων με λεζάντα",
                    "tr": "Başlıklı yapılandırılmış veri tablosu",
                    "hu": "Strukturált adattáblázat képaláírással",
                    "hr": "Tablica strukturiranih podataka s opisom",
                    "pl": "Tabela danych ustrukturyzowanych z podpisem",
                    "sk": "Tabuľka štruktúrovaných údajov s popisom",
                    "cs": "Tabulka strukturovaných dat s popiskem",
                    "lb": "Strukturéiert Datentabell mat Iwwerschrëft",
                ]
            ),
            SimpleTableData(
                meta: DemoData.simpleTableMeta,
                rows: DemoData.simpleTableRows,
                caption: tr(
                    "Types of Growth Loops",
                    de: "Arten von Wachstumsschleifen",
                    fr: "Types de boucles de croissance",
                    es: "Tipos de bucles de crecimiento",
                    it: "Tipi di cicli di crescita"
                )
            )
        )
    ]

    func makeHtml(ctx: SimpleTableData) -> String {
        let html = renderFragments(SimpleTable(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("SimpleTable")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { SimpleTable(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
