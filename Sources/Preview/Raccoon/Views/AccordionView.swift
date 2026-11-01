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
                tr(
                    "Bordered with HTML Content",
                    [
                        "de": "Mit Rahmen und HTML-Inhalt",
                        "fr": "Avec bordure et contenu HTML",
                        "es": "Con borde y contenido HTML",
                        "it": "Con bordo e contenuto HTML",
                        "pt": "Com borda e conteúdo HTML",
                        "nl": "Met rand en HTML-inhoud",
                        "da": "Med kant og HTML-indhold",
                        "sv": "Med ram och HTML-innehåll",
                        "nb": "Med ramme og HTML-innhold",
                        "fi": "Reunuksella ja HTML-sisällöllä",
                        "is": "Með ramma og HTML-efni",
                        "el": "Με περίγραμμα και περιεχόμενο HTML",
                        "tr": "Kenarlıklı ve HTML içerikli",
                        "hu": "Szegéllyel és HTML tartalommal",
                        "hr": "S obrubom i HTML sadržajem",
                        "pl": "Z obramowaniem i zawartością HTML",
                        "sk": "S okrajom a HTML obsahom",
                        "cs": "S rámečkem a HTML obsahem",
                        "lb": "Mat Kader an HTML-Inhalt",
                    ]
                ),
                AccordionData(
                    label: tr(
                        "What is product thinking?",
                        de: "Was ist Produktdenken?",
                        fr: "Qu'est-ce que la réflexion produit ?",
                        es: "¿Qué es el pensamiento de producto?",
                        it: "Che cos'è il pensiero di prodotto?"
                    ),
                    content: .html(
                        tr(
                            "Product thinking means solving the <em>right</em> problems, not just building features.",
                            de:
                                "Produktdenken bedeutet, die <em>richtigen</em> Probleme zu lösen, nicht nur Features zu bauen.",
                            fr:
                                "La réflexion produit consiste à résoudre les <em>bons</em> problèmes, pas seulement à développer des fonctionnalités.",
                            es:
                                "El pensamiento de producto consiste en resolver los problemas <em>correctos</em>, no solo en crear funcionalidades.",
                            it:
                                "Il pensiero di prodotto significa risolvere i problemi <em>giusti</em>, non solo sviluppare funzionalità."
                        )
                    ),
                    icon: .journal_text,
                    isLabelMonospaced: true,
                    hasBorder: true,
                    matomoStatus: .DECLINED
                )
            ),
            #previewVariant(
                tr(
                    "Borderless with Markdown & Matomo",
                    [
                        "de": "Rahmenlos mit Markdown & Matomo",
                        "fr": "Sans bordure avec Markdown et Matomo",
                        "es": "Sin borde con Markdown y Matomo",
                        "it": "Senza bordo con Markdown e Matomo",
                        "pt": "Sem borda com Markdown e Matomo",
                        "nl": "Zonder rand met Markdown & Matomo",
                        "da": "Uden kant med Markdown og Matomo",
                        "sv": "Utan ram med Markdown och Matomo",
                        "nb": "Uten ramme med Markdown og Matomo",
                        "fi": "Ilman reunuksia Markdownilla ja Matomolla",
                        "is": "Án ramma með Markdown og Matomo",
                        "el": "Χωρίς περίγραμμα με Markdown και Matomo",
                        "tr": "Kenarlıksız, Markdown ve Matomo ile",
                        "hu": "Szegély nélkül Markdownnal és Matomóval",
                        "hr": "Bez obruba s Markdownom i Matomom",
                        "pl": "Bez obramowania z Markdown i Matomo",
                        "sk": "Bez okraja s Markdownom a Matomom",
                        "cs": "Bez rámečku s Markdownem a Matomem",
                        "lb": "Ouni Kader mat Markdown a Matomo",
                    ]
                ),
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
                tr(
                    "Borderless with Custom Elements",
                    [
                        "de": "Rahmenlos mit benutzerdefinierten Elementen",
                        "fr": "Sans bordure avec éléments personnalisés",
                        "es": "Sin borde con elementos personalizados",
                        "it": "Senza bordo con elementi personalizzati",
                        "pt": "Sem borda com elementos personalizados",
                        "nl": "Zonder rand met aangepaste elementen",
                        "da": "Uden kant med brugerdefinerede elementer",
                        "sv": "Utan ram med anpassade element",
                        "nb": "Uten ramme med tilpassede elementer",
                        "fi": "Ilman reunuksia mukautetuilla elementeillä",
                        "is": "Án ramma með sérsniðnum einingum",
                        "el": "Χωρίς περίγραμμα με προσαρμοσμένα στοιχεία",
                        "tr": "Kenarlıksız, özel öğelerle",
                        "hu": "Szegély nélkül egyéni elemekkel",
                        "hr": "Bez obruba s prilagođenim elementima",
                        "pl": "Bez obramowania z niestandardowymi elementami",
                        "sk": "Bez okraja s vlastnými prvkami",
                        "cs": "Bez rámečku s vlastními prvky",
                        "lb": "Ouni Kader mat personaliséierten Elementer",
                    ]
                ),
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
