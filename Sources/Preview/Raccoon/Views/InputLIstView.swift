import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct InputListView: TemplateRepresentable {

    let variants: [PreviewVariant<InputListData>] = [
        #previewVariant(
            tr(
                "Dynamic URL List",
                [
                    "de": "Dynamische URL-Liste",
                    "fr": "Liste d'URL dynamique",
                    "es": "Lista de URL dinámica",
                    "it": "Elenco URL dinamico",
                    "pt": "Lista dinâmica de URLs",
                    "nl": "Dynamische URL-lijst",
                    "da": "Dynamisk URL-liste",
                    "sv": "Dynamisk URL-lista",
                    "nb": "Dynamisk URL-liste",
                    "fi": "Dynaaminen URL-luettelo",
                    "is": "Kvikur vefslóðalisti",
                    "el": "Δυναμική λίστα διευθύνσεων URL",
                    "tr": "Dinamik URL listesi",
                    "hu": "Dinamikus URL-lista",
                    "hr": "Dinamički popis URL-ova",
                    "pl": "Dynamiczna lista adresów URL",
                    "sk": "Dynamický zoznam URL",
                    "cs": "Dynamický seznam URL",
                    "lb": "Dynamesch URL-Lëscht",
                ]
            ),
            InputListData(
                id: "refs",
                label: LabelData(id: "refs", title: "References"),
                values: ["https://vapor.codes", "https://swift.org"],
                validationType: .url
            )
        )
    ]

    func makeHtml(ctx: InputListData) -> String {
        let html = renderFragments(InputList(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("InputList")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { InputList(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
