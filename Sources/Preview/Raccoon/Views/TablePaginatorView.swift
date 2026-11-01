import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct TablePaginatorView: TemplateRepresentable {

    let variants: [PreviewVariant<TablePaginatorData>] = [
        #previewVariant(
            tr(
                "Alpine Client Mode (Interactive)",
                [
                    "de": "Alpine-Client-Modus (Interaktiv)",
                    "fr": "Mode client Alpine (Interactif)",
                    "es": "Modo cliente Alpine (Interactivo)",
                    "it": "Modalità client Alpine (Interattiva)",
                    "pt": "Modo cliente Alpine (Interativo)",
                    "nl": "Alpine client-modus (Interactief)",
                    "da": "Alpine klienttilstand (Interaktiv)",
                    "sv": "Alpine klientläge (Interaktivt)",
                    "nb": "Alpine klientmodus (Interaktiv)",
                    "fi": "Alpine-asiakastila (Vuorovaikutteinen)",
                    "is": "Alpine biðlarahamur (Gagnvirkur)",
                    "el": "Λειτουργία πελάτη Alpine (Διαδραστική)",
                    "tr": "Alpine istemci modu (Etkileşimli)",
                    "hu": "Alpine kliens mód (Interaktív)",
                    "hr": "Alpine klijentski način (Interaktivno)",
                    "pl": "Tryb klienta Alpine (Interaktywny)",
                    "sk": "Režim klienta Alpine (Interaktívny)",
                    "cs": "Režim klienta Alpine (Interaktivní)",
                    "lb": "Alpine Client-Modus (Interaktiv)",
                ]
            ),
            TablePaginatorData(
                bindShow: "true",
                mode: .alpine
            )
        ),
        #previewVariant(
            tr(
                "Alpine Client Mode (Loading State)",
                [
                    "de": "Alpine-Client-Modus (Ladezustand)",
                    "fr": "Mode client Alpine (État de chargement)",
                    "es": "Modo cliente Alpine (Estado de carga)",
                    "it": "Modalità client Alpine (Stato di caricamento)",
                    "pt": "Modo cliente Alpine (Estado de carregamento)",
                    "nl": "Alpine client-modus (Laadstatus)",
                    "da": "Alpine klienttilstand (Indlæsningstilstand)",
                    "sv": "Alpine klientläge (Laddningstillstånd)",
                    "nb": "Alpine klientmodus (Lastetilstand)",
                    "fi": "Alpine-asiakastila (Lataustila)",
                    "is": "Alpine biðlarahamur (Hleðslustaða)",
                    "el": "Λειτουργία πελάτη Alpine (Κατάσταση φόρτωσης)",
                    "tr": "Alpine istemci modu (Yükleme durumu)",
                    "hu": "Alpine kliens mód (Betöltési állapot)",
                    "hr": "Alpine klijentski način (Stanje učitavanja)",
                    "pl": "Tryb klienta Alpine (Stan ładowania)",
                    "sk": "Režim klienta Alpine (Stav načítania)",
                    "cs": "Režim klienta Alpine (Stav načítání)",
                    "lb": "Alpine Client-Modus (Luedzoustand)",
                ]
            ),
            TablePaginatorData(
                bindIsLoading: "true",
                bindShow: "true",
                mode: .alpine
            )
        ),
        #previewVariant(
            tr(
                "SSR Link Mode (First Page)",
                [
                    "de": "SSR-Link-Modus (Erste Seite)",
                    "fr": "Mode lien SSR (Première page)",
                    "es": "Modo de enlace SSR (Primera página)",
                    "it": "Modalità link SSR (Prima pagina)",
                    "pt": "Modo de link SSR (Primeira página)",
                    "nl": "SSR-linkmodus (Eerste pagina)",
                    "da": "SSR-linktilstand (Første side)",
                    "sv": "SSR-länkläge (Första sidan)",
                    "nb": "SSR-lenkemodus (Første side)",
                    "fi": "SSR-linkkitila (Ensimmäinen sivu)",
                    "is": "SSR-tenglahamur (Fyrsta síða)",
                    "el": "Λειτουργία συνδέσμου SSR (Πρώτη σελίδα)",
                    "tr": "SSR bağlantı modu (İlk sayfa)",
                    "hu": "SSR hivatkozás mód (Első oldal)",
                    "hr": "Način SSR veze (Prva stranica)",
                    "pl": "Tryb linków SSR (Pierwsza strona)",
                    "sk": "Režim odkazu SSR (Prvá strana)",
                    "cs": "Režim odkazu SSR (První stránka)",
                    "lb": "SSR-Link-Modus (Éischt Säit)",
                ]
            ),
            TablePaginatorData(
                mode: .link(basePath: "/preview/table-paginator"),
                info: TablePaginatorInfo(page: 1, per: 10, total: 95),
                pageSizeOptions: [5, 10, 20, 50, 100]
            )
        ),
        #previewVariant(
            tr(
                "SSR Link Mode (Middle Page with Query Params)",
                [
                    "de": "SSR-Link-Modus (Mittlere Seite mit Abfrageparametern)",
                    "fr": "Mode lien SSR (Page centrale avec paramètres de requête)",
                    "es": "Modo de enlace SSR (Página intermedia con parámetros de consulta)",
                    "it": "Modalità link SSR (Pagina intermedia con parametri query)",
                    "pt": "Modo de link SSR (Página intermediária com parâmetros de consulta)",
                    "nl": "SSR-linkmodus (Middelste pagina met queryparameters)",
                    "da": "SSR-linktilstand (Midterside med forespørgselsparametre)",
                    "sv": "SSR-länkläge (Mittensida med frågeparametrar)",
                    "nb": "SSR-lenkemodus (Midtre side med spørringsparametere)",
                    "fi": "SSR-linkkitila (Keskisivu kyselyparametreilla)",
                    "is": "SSR-tenglahamur (Miðjusíða með fyrirspurnarbreytum)",
                    "el": "Λειτουργία συνδέσμου SSR (Μεσαία σελίδα με παραμέτρους ερωτήματος)",
                    "tr": "SSR bağlantı modu (Sorgu parametreli orta sayfa)",
                    "hu": "SSR hivatkozás mód (Középső oldal lekérdezési paraméterekkel)",
                    "hr": "Način SSR veze (Srednja stranica s parametrima upita)",
                    "pl": "Tryb linków SSR (Środkowa strona z parametrami zapytania)",
                    "sk": "Režim odkazu SSR (Prostredná strana s parametrami dotazu)",
                    "cs": "Režim odkazu SSR (Prostřední stránka s parametry dotazu)",
                    "lb": "SSR-Link-Modus (Mëttel Säit mat Ufrop-Parameteren)",
                ]
            ),
            TablePaginatorData(
                mode: .link(
                    basePath: "/preview/table-paginator",
                    queryParams: ["filter": "active"]
                ),
                info: TablePaginatorInfo(page: 5, per: 10, total: 95),
                pageSizeOptions: [5, 10, 20, 50, 100]
            )
        ),
        #previewVariant(
            tr(
                "SSR Link Mode (Last Page)",
                [
                    "de": "SSR-Link-Modus (Letzte Seite)",
                    "fr": "Mode lien SSR (Dernière page)",
                    "es": "Modo de enlace SSR (Última página)",
                    "it": "Modalità link SSR (Ultima pagina)",
                    "pt": "Modo de link SSR (Última página)",
                    "nl": "SSR-linkmodus (Laatste pagina)",
                    "da": "SSR-linktilstand (Sidste side)",
                    "sv": "SSR-länkläge (Sista sidan)",
                    "nb": "SSR-lenkemodus (Siste side)",
                    "fi": "SSR-linkkitila (Viimeinen sivu)",
                    "is": "SSR-tenglahamur (Síðasta síða)",
                    "el": "Λειτουργία συνδέσμου SSR (Τελευταία σελίδα)",
                    "tr": "SSR bağlantı modu (Son sayfa)",
                    "hu": "SSR hivatkozás mód (Utolsó oldal)",
                    "hr": "Način SSR veze (Zadnja stranica)",
                    "pl": "Tryb linków SSR (Ostatnia strona)",
                    "sk": "Režim odkazu SSR (Posledná strana)",
                    "cs": "Režim odkazu SSR (Poslední stránka)",
                    "lb": "SSR-Link-Modus (Lescht Säit)",
                ]
            ),
            TablePaginatorData(
                mode: .link(basePath: "/preview/table-paginator"),
                info: TablePaginatorInfo(page: 10, per: 10, total: 95),
                pageSizeOptions: [5, 10, 20, 50, 100]
            )
        ),
    ]

    func makeHtml(ctx: TablePaginatorData) -> String {
        let html = renderFragments(TablePaginator(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {
        Basic(title: "Table Paginator") {
            Div {
                showComponentTitle("Table Paginator")

                for variant in variants {
                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div {
                            TablePaginator(variant.data).render()
                        }
                        .setAttribute(
                            name: "x-data",
                            value: """
                                {
                                    page: 2,
                                    per: 10,
                                    total: 95,
                                    totalPages: 10,
                                    rangeLabel: '11 – 20 of 95',
                                    pageSizeOptions: [5, 10, 20, 50, 100],
                                    hasPrevious: true,
                                    hasNext: true,
                                    isLoading: false,
                                    hasSearched: true,
                                    changePageSize(val) { this.per = Number(val); },
                                    goToPage(p) { this.page = p; },
                                    previousPage() { if (this.page > 1) this.page--; },
                                    nextPage() { if (this.page < this.totalPages) this.page++; }
                                }
                                """
                        )
                        .class("mb-4 mt-6 max-w-4xl")
                    }
                }
            }
            .class("mt-4 space-y-6")
        }
        .render()
    }
}
