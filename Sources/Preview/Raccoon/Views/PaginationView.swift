import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct PaginationView: TemplateRepresentable {

    let variants: [PreviewVariant<PaginationData>] = [
        #previewVariant(
            "Middle Page with Table of Contents",
            PaginationData(
                tableOfContent: PaginationItem(
                    title: tr(
                        "Table of content",
                        de: "Inhaltsverzeichnis",
                        fr: "Table des matières",
                        es: "Tabla de contenido",
                        it: "Indice"
                    ),
                    order: 0,
                    friendly_url: "table-of-content-link"
                ),
                pages: (1...10)
                    .map { i in
                        PaginationItem(
                            title: tr(
                                "Chapter {{n}}",
                                de: "Kapitel {{n}}",
                                fr: "Chapitre {{n}}",
                                es: "Capítulo {{n}}",
                                it: "Capitolo {{n}}"
                            )
                            .with(variables: ["n": "\(i)"]),
                            order: i,
                            friendly_url: "chapter-\(i)",
                            selected: i == 4
                        )
                    },
                hrefBase: "base-url"
            )
        ),
        #previewVariant(
            "First Page with Table of Contents",
            PaginationData(
                tableOfContent: PaginationItem(
                    title: tr(
                        "Table of content",
                        de: "Inhaltsverzeichnis",
                        fr: "Table des matières",
                        es: "Tabla de contenido",
                        it: "Indice"
                    ),
                    order: 0,
                    friendly_url: "table-of-content-link"
                ),
                pages: (1...10)
                    .map { i in
                        PaginationItem(
                            title: tr(
                                "Chapter {{n}}",
                                de: "Kapitel {{n}}",
                                fr: "Chapitre {{n}}",
                                es: "Capítulo {{n}}",
                                it: "Capitolo {{n}}"
                            )
                            .with(variables: ["n": "\(i)"]),
                            order: i,
                            friendly_url: "chapter-\(i)",
                            selected: i == 1
                        )
                    },
                hrefBase: "base-url"
            )
        ),
        #previewVariant(
            "Near-Start Page without TOC",
            PaginationData(
                tableOfContent: nil,
                pages: (1...10)
                    .map { i in
                        PaginationItem(
                            title: tr(
                                "Chapter {{n}}",
                                de: "Kapitel {{n}}",
                                fr: "Chapitre {{n}}",
                                es: "Capítulo {{n}}",
                                it: "Capitolo {{n}}"
                            )
                            .with(variables: ["n": "\(i)"]),
                            order: i,
                            friendly_url: "chapter-\(i)",
                            selected: i == 2
                        )
                    },
                hrefBase: "base-url"
            )
        ),
        #previewVariant(
            "Last Page without TOC",
            PaginationData(
                tableOfContent: nil,
                pages: (1...10)
                    .map { i in
                        PaginationItem(
                            title: tr(
                                "Chapter {{n}}",
                                de: "Kapitel {{n}}",
                                fr: "Chapitre {{n}}",
                                es: "Capítulo {{n}}",
                                it: "Capitolo {{n}}"
                            )
                            .with(variables: ["n": "\(i)"]),
                            order: i,
                            friendly_url: "chapter-\(i)",
                            selected: i == 10
                        )
                    },
                hrefBase: "base-url"
            )
        ),
        #previewVariant(
            "Two Pages Only",
            PaginationData(
                tableOfContent: nil,
                pages: [
                    PaginationItem(
                        title: tr(
                            "First",
                            de: "Erstes",
                            fr: "Premier",
                            es: "Primero",
                            it: "Primo"
                        ),
                        order: 1,
                        friendly_url: "first",
                        selected: true
                    ),
                    PaginationItem(
                        title: tr(
                            "Second",
                            de: "Zweites",
                            fr: "Deuxième",
                            es: "Segundo",
                            it: "Secondo"
                        ),
                        order: 2,
                        friendly_url: "second",
                        selected: false
                    ),
                ],
                hrefBase: "base-url"
            )
        ),
        #previewVariant(
            "Large Dataset (100 Pages Windowed)",
            PaginationData(
                tableOfContent: PaginationItem(
                    title: tr(
                        "Overview",
                        de: "Übersicht",
                        fr: "Aperçu",
                        es: "Resumen",
                        it: "Panoramica"
                    ),
                    order: 0,
                    friendly_url: "overview"
                ),
                pages: (1...100)
                    .map { i in
                        PaginationItem(
                            title: tr(
                                "Chapter {{n}}",
                                de: "Kapitel {{n}}",
                                fr: "Chapitre {{n}}",
                                es: "Capítulo {{n}}",
                                it: "Capitolo {{n}}"
                            )
                            .with(variables: ["n": "\(i)"]),
                            order: i,
                            friendly_url: "chapter-\(i)",
                            selected: i == 42
                        )
                    },
                hrefBase: "base-url"
            )
        ),
        #previewVariant(
            "Truncated Long TOC Title",
            PaginationData(
                tableOfContent: PaginationItem(
                    title: tr(
                        "Comprehensive Table of Contents for Deep Dive",
                        de:
                            "Ausführliches Inhaltsverzeichnis für die Vertiefung",
                        fr:
                            "Table des matières détaillée pour l'approfondissement",
                        es: "Tabla de contenido completa para profundizar",
                        it: "Indice completo per l'approfondimento"
                    ),
                    order: 0,
                    friendly_url: "table-of-content-link"
                ),
                pages: (1...10)
                    .map { i in
                        PaginationItem(
                            title: tr(
                                "Chapter {{n}}",
                                de: "Kapitel {{n}}",
                                fr: "Chapitre {{n}}",
                                es: "Capítulo {{n}}",
                                it: "Capitolo {{n}}"
                            )
                            .with(variables: ["n": "\(i)"]),
                            order: i,
                            friendly_url: "chapter-\(i)",
                            selected: i == 4
                        )
                    },
                hrefBase: "base-url"
            )
        ),
    ]

    func makeHtml(ctx: PaginationData) -> String {
        let html = renderFragments(Pagination(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Pagination")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Pagination(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
