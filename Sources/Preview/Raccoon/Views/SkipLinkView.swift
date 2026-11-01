import HTML
import Raccoon
import SGML
import Vapor
import WebBuilders

struct SkipLinkView: TemplateRepresentable {

    let variants: [PreviewVariant<SkipLinkData>] = [
        #previewVariant(
            "Default Configuration",
            SkipLinkData()
        ),
        #previewVariant(
            "Custom Target and Localized Text",
            SkipLinkData(
                text: tr(
                    "Skip to article main content",
                    de: "Zum Hauptinhalt des Artikels springen",
                    fr: "Passer au contenu principal de l'article",
                    es: "Saltar al contenido principal del artículo",
                    it: "Vai al contenuto principale dell'articolo"
                ),
                targetId: "article-content"
            )
        ),
    ]

    func makeHtml(ctx: SkipLinkData) -> String {
        let html = renderFragments(SkipLink(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("SkipLink")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div {
                            P(
                                tr(
                                    "Tab to or focus the link below to see the skip link style:",
                                    de:
                                        "Springe mit der Tabulatortaste zum Link unten oder fokussiere ihn, um den Stil des Sprunglinks zu sehen:",
                                    fr:
                                        "Utilisez la touche Tab ou placez le focus sur le lien ci-dessous pour voir le style du lien d'évitement :",
                                    es:
                                        "Pulsa Tab o enfoca el enlace de abajo para ver el estilo del enlace de salto:",
                                    it:
                                        "Premi Tab o porta il focus sul link qui sotto per vedere lo stile del link di salto:"
                                )
                                .resolved
                            )
                            .class(
                                [
                                    "mb-2 text-sm",
                                    CommonStyles.textColorDefault,
                                ]
                                .joined(separator: " ")
                            )
                            SkipLink(variant.data).render()
                        }
                        .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
