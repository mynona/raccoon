import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct CodeBlockView: TemplateRepresentable {

    let variants: [PreviewVariant<CodeBlockData>] = [
        #previewVariant(
            tr(
                "Short Snippet",
                [
                    "de": "Kurzer Codeausschnitt",
                    "fr": "Court extrait",
                    "es": "Fragmento corto",
                    "it": "Breve frammento",
                    "pt": "Trecho curto",
                    "nl": "Kort fragment",
                    "da": "Kort kodestykke",
                    "sv": "Kort kodavsnitt",
                    "nb": "Kort kodesnutt",
                    "fi": "Lyhyt katkelma",
                    "is": "Stuttur bútur",
                    "el": "Σύντομο απόσπασμα",
                    "tr": "Kısa kod parçacığı",
                    "hu": "Rövid kódrészlet",
                    "hr": "Kratki isječak",
                    "pl": "Krótki fragment",
                    "sk": "Krátky fragment kódu",
                    "cs": "Krátký úryvek kódu",
                    "lb": "Kuerze Code-Ausschnëtt",
                ]
            ),
            CodeBlockData(
                code:
                    """
                    line 1
                    line 2
                    line 3
                    line 4
                    line 5
                    """
            )
        ),
        #previewVariant(
            tr(
                "Long Snippet with Scroll",
                [
                    "de": "Langer Codeausschnitt mit Bildlauf",
                    "fr": "Long extrait avec défilement",
                    "es": "Fragmento largo con desplazamiento",
                    "it": "Frammento lungo con scorrimento",
                    "pt": "Trecho longo com rolagem",
                    "nl": "Lang fragment met scrollen",
                    "da": "Langt kodestykke med rulning",
                    "sv": "Långt kodavsnitt med rullning",
                    "nb": "Lang kodesnutt med rulling",
                    "fi": "Pitkä katkelma vierityksellä",
                    "is": "Langur bútur með skruni",
                    "el": "Μεγάλο απόσπασμα με κύλιση",
                    "tr": "Kaydırmalı uzun kod parçacığı",
                    "hu": "Hosszú kódrészlet görgetéssel",
                    "hr": "Duguljasti isječak s pomicanjem",
                    "pl": "Długi fragment z przewijaniem",
                    "sk": "Dlhý fragment kódu s posúvaním",
                    "cs": "Dlouhý úryvek kódu s posouváním",
                    "lb": "Laange Code-Ausschnëtt mat Scroll",
                ]
            ),
            CodeBlockData(
                code:
                    """
                    line 1 Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. 
                    line 2
                    line 3
                    line 4
                    line 5
                    line 6
                    line 7
                    line 8
                    line 10
                    line 11
                    line 12
                    line 13
                    line 14
                    line 15
                    line 16
                    line 17
                    line 18
                    line 19
                    line 20
                    line 21
                    line 22
                    line 23
                    line 24
                    line 25
                    line 26
                    line 27
                    line 28
                    line 29
                    line 30
                    """
            )
        ),
    ]

    func makeHtml(ctx: CodeBlockData) -> String {
        let html = renderFragments(CodeBlock(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("CodeBlock")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { CodeBlock(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
