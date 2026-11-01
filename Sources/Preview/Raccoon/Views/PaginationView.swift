import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct PaginationView: TemplateRepresentable {

    let variants: [PreviewVariant<PaginationData>] = [
        #previewVariant(
            tr(
                "Middle Page with Table of Contents",
                [
                    "de": "Mittlere Seite mit Inhaltsverzeichnis",
                    "fr": "Page centrale avec table des matières",
                    "es": "Página intermedia con tabla de contenido",
                    "it": "Pagina intermedia con indice",
                    "pt": "Página intermediária com sumário",
                    "nl": "Middelste pagina met inhoudsopgave",
                    "da": "Midterside med indholdsfortegnelse",
                    "sv": "Mittensida med innehållsförteckning",
                    "nb": "Midtre side med innholdsfortegnelse",
                    "fi": "Keskisivu sisällysluettelolla",
                    "is": "Miðjusíða með efnisyfirliti",
                    "el": "Μεσαία σελίδα με πίνακα περιεχομένων",
                    "tr": "İçindekiler tablolu orta sayfa",
                    "hu": "Középső oldal tartalomjegyzékkel",
                    "hr": "Srednja stranica sa sadržajem",
                    "pl": "Środkowa strona ze spisem treści",
                    "sk": "Prostredná strana s obsahom",
                    "cs": "Prostřední stránka s obsahem",
                    "lb": "Mëttel Säit mat Inhaltsverzeechnes",
                ]
            ),
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
            tr(
                "First Page with Table of Contents",
                [
                    "de": "Erste Seite mit Inhaltsverzeichnis",
                    "fr": "Première page avec table des matières",
                    "es": "Primera página con tabla de contenido",
                    "it": "Prima pagina con indice",
                    "pt": "Primeira página com sumário",
                    "nl": "Eerste pagina met inhoudsopgave",
                    "da": "Første side med indholdsfortegnelse",
                    "sv": "Första sidan med innehållsförteckning",
                    "nb": "Første side med innholdsfortegnelse",
                    "fi": "Ensimmäinen sivu sisällysluettelolla",
                    "is": "Fyrsta síða með efnisyfirliti",
                    "el": "Πρώτη σελίδα με πίνακα περιεχομένων",
                    "tr": "İçindekiler tablolu ilk sayfa",
                    "hu": "Első oldal tartalomjegyzékkel",
                    "hr": "Prva stranica sa sadržajem",
                    "pl": "Pierwsza strona ze spisem treści",
                    "sk": "Prvá strana s obsahom",
                    "cs": "První stránka s obsahem",
                    "lb": "Éischt Säit mat Inhaltsverzeechnes",
                ]
            ),
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
            tr(
                "Near-Start Page without TOC",
                [
                    "de": "Seite nahe am Anfang ohne Inhaltsverzeichnis",
                    "fr": "Page proche du début sans table des matières",
                    "es": "Página cerca del inicio sin tabla de contenido",
                    "it": "Pagina vicina all'inizio senza indice",
                    "pt": "Página próxima ao início sem sumário",
                    "nl": "Pagina nabij begin zonder inhoudsopgave",
                    "da": "Side tæt på start uden indholdsfortegnelse",
                    "sv": "Sida nära början utan innehållsförteckning",
                    "nb": "Side nær starten uten innholdsfortegnelse",
                    "fi": "Alun lähellä oleva sivu ilman sisällysluetteloa",
                    "is": "Síða nærri byrjun án efnisyfirlits",
                    "el": "Σελίδα κοντά στην αρχή χωρίς πίνακα περιεχομένων",
                    "tr": "İçindekiler tablosuz başa yakın sayfa",
                    "hu": "Kezdethez közeli oldal tartalomjegyzék nélkül",
                    "hr": "Stranica blizu početka bez sadržaja",
                    "pl": "Strona blisko początku bez spisu treści",
                    "sk": "Strana blízko začiatku bez obsahu",
                    "cs": "Stránka blízko začátku bez obsahu",
                    "lb": "Säit no beim Ufank ouni Inhaltsverzeechnes",
                ]
            ),
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
            tr(
                "Last Page without TOC",
                [
                    "de": "Letzte Seite ohne Inhaltsverzeichnis",
                    "fr": "Dernière page sans table des matières",
                    "es": "Última página sin tabla de contenido",
                    "it": "Ultima pagina senza indice",
                    "pt": "Última página sem sumário",
                    "nl": "Laatste pagina zonder inhoudsopgave",
                    "da": "Sidste side uden indholdsfortegnelse",
                    "sv": "Sista sidan utan innehållsförteckning",
                    "nb": "Siste side uten innholdsfortegnelse",
                    "fi": "Viimeinen sivu ilman sisällysluetteloa",
                    "is": "Síðasta síða án efnisyfirlits",
                    "el": "Τελευταία σελίδα χωρίς πίνακα περιεχομένων",
                    "tr": "İçindekiler tablosuz son sayfa",
                    "hu": "Utolsó oldal tartalomjegyzék nélkül",
                    "hr": "Zadnja stranica bez sadržaja",
                    "pl": "Ostatnia strona bez spisu treści",
                    "sk": "Posledná strana bez obsahu",
                    "cs": "Poslední stránka bez obsahu",
                    "lb": "Lescht Säit ouni Inhaltsverzeechnes",
                ]
            ),
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
            tr(
                "Two Pages Only",
                [
                    "de": "Nur zwei Seiten",
                    "fr": "Deux pages seulement",
                    "es": "Solo dos páginas",
                    "it": "Solo due pagine",
                    "pt": "Apenas duas páginas",
                    "nl": "Slechts twee pagina's",
                    "da": "Kun to sider",
                    "sv": "Endast två sidor",
                    "nb": "Kun to sider",
                    "fi": "Vain kaksi sivua",
                    "is": "Aðeins tvær síður",
                    "el": "Μόνο δύο σελίδες",
                    "tr": "Yalnızca iki sayfa",
                    "hu": "Csak két oldal",
                    "hr": "Samo dvije stranice",
                    "pl": "Tylko dwie strony",
                    "sk": "Iba dve strany",
                    "cs": "Pouze dvě stránky",
                    "lb": "Nëmmen zwou Säiten",
                ]
            ),
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
            tr(
                "Large Dataset (100 Pages Windowed)",
                [
                    "de": "Großer Datensatz (100 Seiten gefenstert)",
                    "fr": "Grand jeu de données (100 pages fenêtrées)",
                    "es": "Gran conjunto de datos (100 páginas paginadas)",
                    "it": "Grande set di dati (100 pagine con finestra)",
                    "pt": "Grande conjunto de dados (100 páginas paginadas)",
                    "nl": "Grote gegevensset (100 pagina's met venster)",
                    "da": "Stort datasæt (100 sider vinduesopdelt)",
                    "sv": "Stor datamängd (100 sidor fönstrade)",
                    "nb": "Stort datasett (100 sider vindusdelt)",
                    "fi": "Suuri aineisto (100 sivua ikkunoitu)",
                    "is": "Stórt gagnasett (100 síður í gluggum)",
                    "el": "Μεγάλο σύνολο δεδομένων (100 σελίδες με παράθυρο)",
                    "tr": "Büyük veri kümesi (100 sayfa pencereli)",
                    "hu": "Nagy adatkészlet (100 lapozott oldal)",
                    "hr": "Veliki skup podataka (100 stranica s prozorom)",
                    "pl": "Duży zbiór danych (100 stron z oknem)",
                    "sk": "Veľký súbor údajov (100 strán v okne)",
                    "cs": "Velká datová sada (100 stránek v okně)",
                    "lb": "Grousse Datesaz (100 Säite gefënstert)",
                ]
            ),
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
            tr(
                "Truncated Long TOC Title",
                [
                    "de": "Gekürzter langer Inhaltsverzeichnis-Titel",
                    "fr": "Titre long de table des matières tronqué",
                    "es": "Título largo de tabla de contenido truncado",
                    "it": "Titolo lungo dell'indice troncato",
                    "pt": "Título longo do sumário truncado",
                    "nl": "Afgekorte lange inhoudsopgawetitel",
                    "da": "Afkortet lang indholdsfortegnelsestitel",
                    "sv": "Avkortad lång innehållsförteckningstitel",
                    "nb": "Avkortet lang innholdsfortegnelsestittel",
                    "fi": "Katkaistu pitkä sisällysluettelon otsikko",
                    "is": "Styttur langur efnisyfirlitstitill",
                    "el": "Συντομευμένος μεγάλος τίτλος πίνακα περιεχομένων",
                    "tr": "Kısaltılmış uzun içindekiler tablosu başlığı",
                    "hu": "Csonkolt hosszú tartalomjegyzék-cím",
                    "hr": "Skraćeni dugački naslov sadržaja",
                    "pl": "Skrócony długi tytuł spisu treści",
                    "sk": "Skrátený dlhý názov obsahu",
                    "cs": "Zkrácený dlouhý název obsahu",
                    "lb": "Gekierzte laangen Inhaltsverzeechnes-Titel",
                ]
            ),
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
