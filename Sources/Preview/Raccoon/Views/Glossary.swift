import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct GlossaryView: TemplateRepresentable {

    let variants: [PreviewVariant<GlossaryData>] = [
        #previewVariant(
            tr(
                "With In-Page Search",
                [
                    "de": "Mit seiteninterner Suche",
                    "fr": "Avec recherche sur la page",
                    "es": "Con búsqueda en la página",
                    "it": "Con ricerca nella pagina",
                    "pt": "Com busca na página",
                    "nl": "Met in-pagina zoeken",
                    "da": "Med søgning på siden",
                    "sv": "Med sökning på sidan",
                    "nb": "Med søk på siden",
                    "fi": "Sivunsisäisellä haulla",
                    "is": "Með leit á síðu",
                    "el": "Με αναζήτηση εντός σελίδας",
                    "tr": "Sayfa içi arama ile",
                    "hu": "Oldalon belüli kereséssel",
                    "hr": "S pretraživanjem na stranici",
                    "pl": "Z wyszukiwaniem na stronie",
                    "sk": "S vyhľadávaním na stránke",
                    "cs": "S vyhledáváním na stránce",
                    "lb": "Mat Säiten-interner Sich",
                ]
            ),
            GlossaryData(
                entries: [
                    GlossaryEntryData(
                        term: tr(
                            "Alpine garden",
                            de: "Alpinum",
                            fr: "Jardin alpin",
                            es: "Jardín alpino",
                            it: "Giardino alpino"
                        ),
                        definition: tr(
                            "A garden area planted with alpine plants.",
                            de: "Anlage mit Alpenpflanzen",
                            fr: "Aménagement planté de plantes alpines.",
                            es: "Zona ajardinada con plantas alpinas.",
                            it: "Area allestita con piante alpine."
                        )
                    ),
                    GlossaryEntryData(
                        term: tr(
                            "API",
                            de: "API",
                            fr: "API",
                            es: "API",
                            it: "API"
                        ),
                        definition: tr(
                            "Application Programming Interface – an interface for communication between software systems.",
                            de:
                                "Application Programming Interface – eine Schnittstelle zur Kommunikation zwischen Softwaresystemen.",
                            fr:
                                "Application Programming Interface – une interface de communication entre systèmes logiciels.",
                            es:
                                "Application Programming Interface: una interfaz de comunicación entre sistemas de software.",
                            it:
                                "Application Programming Interface – un'interfaccia per la comunicazione tra sistemi software."
                        )
                    ),
                    GlossaryEntryData(
                        term: tr(
                            "Accordion",
                            de: "Akkordeon",
                            fr: "Accordéon",
                            es: "Acordeón",
                            it: "Fisarmonica"
                        ),
                        definition: tr(
                            "A UI element that lets content be expanded and collapsed.",
                            de:
                                "Ein UI-Element, mit dem Inhalte ein- und ausgeklappt werden können.",
                            fr:
                                "Un élément d'interface qui permet de déplier et de replier du contenu.",
                            es:
                                "Un elemento de interfaz que permite expandir y contraer contenido.",
                            it:
                                "Un elemento dell'interfaccia che permette di espandere e comprimere i contenuti."
                        )
                    ),
                    GlossaryEntryData(
                        term: tr(
                            "beinhalten",
                            de: "beinhalten",
                            fr: "beinhalten",
                            es: "beinhalten",
                            it: "beinhalten"
                        ),
                        definition: tr(
                            "The German word *beinhalten* should not be hyphenated between *n* and *h*.",
                            de:
                                "Das Wort *beinhalten* sollte nicht zwischen *n* und *h* getrennt werden.",
                            fr:
                                "Le mot allemand *beinhalten* ne doit pas être coupé entre *n* et *h*.",
                            es:
                                "La palabra alemana *beinhalten* no debe dividirse entre *n* y *h*.",
                            it:
                                "La parola tedesca *beinhalten* non va divisa tra *n* e *h*."
                        )
                    ),
                    GlossaryEntryData(
                        term: tr(
                            "Build tool",
                            de: "Build-Tool",
                            fr: "Outil de build",
                            es: "Herramienta de compilación",
                            it: "Strumento di build"
                        ),
                        definition: tr(
                            "Software that automates building executable programs from source code.",
                            de:
                                "Software zur Automatisierung der Erstellung von ausführbaren Programmen aus Quellcode.",
                            fr:
                                "Logiciel qui automatise la création de programmes exécutables à partir du code source.",
                            es:
                                "Software que automatiza la creación de programas ejecutables a partir del código fuente.",
                            it:
                                "Software che automatizza la creazione di programmi eseguibili a partire dal codice sorgente."
                        )
                    ),
                    GlossaryEntryData(
                        term: tr(
                            "Heliskiing",
                            de: "Heliskiing",
                            fr: "Heliskiing",
                            es: "Heliskiing",
                            it: "Heliskiing"
                        ),
                        definition: tr(
                            "A descent from a mountain peak to which the skier has been brought by helicopter.",
                            de:
                                "Abfahrt von einem Berggipfel, zu dem der Skiläufer mit einem Helikopter gebracht worden ist.",
                            fr:
                                "Descente depuis un sommet où le skieur a été déposé en hélicoptère.",
                            es:
                                "Descenso desde una cima a la que el esquiador ha sido llevado en helicóptero.",
                            it:
                                "Discesa da una vetta raggiunta dallo sciatore in elicottero."
                        )
                    ),
                    GlossaryEntryData(
                        term: tr(
                            "Hotfix",
                            de: "Hotfix",
                            fr: "Correctif d'urgence",
                            es: "Parche urgente",
                            it: "Hotfix"
                        ),
                        definition: tr(
                            "An urgent bug fix that is deployed directly to the production environment.",
                            de:
                                "Eine dringende Fehlerbehebung, die direkt in die Produktionsumgebung eingespielt wird.",
                            fr:
                                "Une correction urgente de bug déployée directement en production.",
                            es:
                                "Una corrección urgente de errores que se despliega directamente en producción.",
                            it:
                                "Una correzione urgente di un bug rilasciata direttamente in produzione."
                        )
                    ),
                    GlossaryEntryData(
                        term: tr(
                            "Logout",
                            de: "Abmeldung",
                            fr: "Déconnexion",
                            es: "Cierre de sesión",
                            it: "Disconnessione"
                        ),
                        definition: tr(
                            "Signing out.",
                            de: "Das Abmelden",
                            fr: "Le fait de se déconnecter.",
                            es: "Salir de la cuenta.",
                            it: "L'uscita dall'account."
                        )
                    ),
                    GlossaryEntryData(
                        term: tr(
                            "Lazy loading",
                            de: "Verzögertes Laden",
                            fr: "Chargement différé",
                            es: "Carga diferida",
                            it: "Caricamento differito"
                        ),
                        definition: tr(
                            "A design pattern in which resources are only loaded when they are actually needed.",
                            de:
                                "Ein Entwurfsmuster, bei dem Ressourcen erst dann geladen werden, wenn sie tatsächlich benötigt werden.",
                            fr:
                                "Un modèle de conception où les ressources ne sont chargées que lorsqu'elles sont réellement nécessaires.",
                            es:
                                "Un patrón de diseño en el que los recursos solo se cargan cuando realmente se necesitan.",
                            it:
                                "Un modello di progettazione in cui le risorse vengono caricate solo quando servono davvero."
                        )
                    ),
                    GlossaryEntryData(
                        term: tr(
                            "Tribute band",
                            de: "Tribute-Band",
                            fr: "Groupe hommage",
                            es: "Banda tributo",
                            it: "Tribute band"
                        ),
                        definition: tr(
                            "A band that imitates a famous band.",
                            de: "Musikband, die eine berühmte Band nachahmt.",
                            fr:
                                "Groupe de musique qui imite un groupe célèbre.",
                            es: "Banda de música que imita a una banda famosa.",
                            it: "Gruppo musicale che imita una band famosa."
                        )
                    ),
                ],
                hasSearch: true
            )
        ),
        #previewVariant(
            tr(
                "Without Search",
                [
                    "de": "Ohne Suche",
                    "fr": "Sans recherche",
                    "es": "Sin búsqueda",
                    "it": "Senza ricerca",
                    "pt": "Sem busca",
                    "nl": "Zonder zoeken",
                    "da": "Uden søgning",
                    "sv": "Utan sökning",
                    "nb": "Uten søk",
                    "fi": "Ilman hakua",
                    "is": "Án leitar",
                    "el": "Χωρίς αναζήτηση",
                    "tr": "Aramasız",
                    "hu": "Keresés nélkül",
                    "hr": "Bez pretraživanja",
                    "pl": "Bez wyszukiwania",
                    "sk": "Bez vyhľadávania",
                    "cs": "Bez vyhledávání",
                    "lb": "Ouni Sich",
                ]
            ),
            GlossaryData(
                entries: [
                    GlossaryEntryData(
                        term: tr(
                            "Alpine garden",
                            de: "Alpinum",
                            fr: "Jardin alpin",
                            es: "Jardín alpino",
                            it: "Giardino alpino"
                        ),
                        definition: tr(
                            "A garden area planted with alpine plants.",
                            de: "Anlage mit Alpenpflanzen",
                            fr: "Aménagement planté de plantes alpines.",
                            es: "Zona ajardinada con plantas alpinas.",
                            it: "Area allestita con piante alpine."
                        )
                    ),
                    GlossaryEntryData(
                        term: tr(
                            "API",
                            de: "API",
                            fr: "API",
                            es: "API",
                            it: "API"
                        ),
                        definition: tr(
                            "Application Programming Interface – an interface.",
                            de:
                                "Application Programming Interface – Schnittstelle.",
                            fr:
                                "Application Programming Interface – une interface.",
                            es:
                                "Application Programming Interface: una interfaz.",
                            it:
                                "Application Programming Interface – un'interfaccia."
                        )
                    ),
                    GlossaryEntryData(
                        term: tr(
                            "Heliskiing",
                            de: "Heliskiing",
                            fr: "Heliskiing",
                            es: "Heliskiing",
                            it: "Heliskiing"
                        ),
                        definition: tr(
                            "A descent from a mountain peak to which the skier has been brought by helicopter.",
                            de:
                                "Abfahrt von einem Berggipfel, zu dem der Skiläufer mit einem Helikopter gebracht worden ist.",
                            fr:
                                "Descente depuis un sommet où le skieur a été déposé en hélicoptère.",
                            es:
                                "Descenso desde una cima a la que el esquiador ha sido llevado en helicóptero.",
                            it:
                                "Discesa da una vetta raggiunta dallo sciatore in elicottero."
                        )
                    ),
                    GlossaryEntryData(
                        term: tr(
                            "Logout",
                            de: "Abmeldung",
                            fr: "Déconnexion",
                            es: "Cierre de sesión",
                            it: "Disconnessione"
                        ),
                        definition: tr(
                            "Signing out.",
                            de: "Das Abmelden",
                            fr: "Le fait de se déconnecter.",
                            es: "Salir de la cuenta.",
                            it: "L'uscita dall'account."
                        )
                    ),
                ],
                hasSearch: false
            )
        ),
    ]

    func makeHtml(ctx: GlossaryData) -> String {
        let html = renderFragments(Glossary(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Glossary")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Glossary(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
