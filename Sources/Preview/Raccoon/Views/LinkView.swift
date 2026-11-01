import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct LinkView: TemplateRepresentable {

    let variants: [PreviewVariant<HyperLinkData>] = [
        #previewVariant(
            tr(
                "Centered External Link with Tooltip",
                [
                    "de": "Zentrierter externer Link mit Tooltip",
                    "fr": "Lien externe centré avec infobulle",
                    "es": "Enlace externo centrado con información",
                    "it": "Collegamento esterno centrato con tooltip",
                    "pt": "Link externo centrado com dica",
                    "nl": "Gecentreerde externe link met tooltip",
                    "da": "Centreret eksternt link med tooltip",
                    "sv": "Centrerad extern länk med verktygstips",
                    "nb": "Sentrert ekstern lenke med verktøytips",
                    "fi": "Keskitetty ulkoinen linkki työkaluvihjeellä",
                    "is": "Miðjaður ytri tengill með vísbendingu",
                    "el": "Κεντραρισμένος εξωτερικός σύνδεσμος με επεξήγηση",
                    "tr": "İpucu ile ortalanmış harici bağlantı",
                    "hu": "Középre zárt külső hivatkozás eszköztippel",
                    "hr": "Centrirana vanjska veza s opisom",
                    "pl": "Wyśrodkowany link zewnętrzny z etykietą",
                    "sk": "Vycentrovaný externý odkaz s popisom",
                    "cs": "Vycentrovaný externí odkaz s nápovědou",
                    "lb": "Zentréierten externe Link mat Tooltip",
                ]
            ),
            HyperLinkData(
                label: tr(
                    "Some label",
                    de: "Eine Beschriftung",
                    fr: "Un libellé",
                    es: "Una etiqueta",
                    it: "Un'etichetta"
                ),
                ariaLabel: tr(
                    "Some aria label",
                    de: "Ein Aria-Label",
                    fr: "Un aria-label",
                    es: "Un aria-label",
                    it: "Un aria-label"
                ),
                href: "#",
                target: .blank,
                rel: .nofollow,
                tooltip: tr(
                    "Some tooltip",
                    de: "Ein Tooltip",
                    fr: "Une infobulle",
                    es: "Una información",
                    it: "Un tooltip"
                ),
                icon: .airplane,
                iconSize: 16,
                align: .center,
                isFocusable: true,
                isUnderlined: true,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Left-Aligned Internal Link",
                [
                    "de": "Linksbündiger interner Link",
                    "fr": "Lien interne aligné à gauche",
                    "es": "Enlace interno alineado a la izquierda",
                    "it": "Collegamento interno allineato a sinistra",
                    "pt": "Link interno alinhado à esquerda",
                    "nl": "Links uitgelijnde interne link",
                    "da": "Venstrejusteret internt link",
                    "sv": "Vänsterjusterad intern länk",
                    "nb": "Venstrejustert intern lenke",
                    "fi": "Vasemmalle tasattu sisäinen linkki",
                    "is": "Vinstrijafnaður innri tengill",
                    "el": "Στοιχισμένος αριστερά εσωτερικός σύνδεσμος",
                    "tr": "Sola hizalı dahili bağlantı",
                    "hu": "Balra zárt belső hivatkozás",
                    "hr": "Lijevo poravnata unutarnja veza",
                    "pl": "Wyrównany do lewej link wewnętrzny",
                    "sk": "Vľavo zarovnaný interný odkaz",
                    "cs": "Vlevo zarovnaný interní odkaz",
                    "lb": "Lénksbünnegen interne Link",
                ]
            ),
            HyperLinkData(
                label: tr(
                    "Some label",
                    de: "Eine Beschriftung",
                    fr: "Un libellé",
                    es: "Una etiqueta",
                    it: "Un'etichetta"
                ),
                ariaLabel: tr(
                    "Some aria label",
                    de: "Ein Aria-Label",
                    fr: "Un aria-label",
                    es: "Un aria-label",
                    it: "Un aria-label"
                ),
                href: "#",
                tooltip: tr(
                    "Some tooltip",
                    de: "Ein Tooltip",
                    fr: "Une infobulle",
                    es: "Una información",
                    it: "Un tooltip"
                ),
                icon: .airplane,
                iconSize: 16,
                align: .left,
                isFocusable: true,
                isUnderlined: true,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Large Icon without Underline",
                [
                    "de": "Großes Icon ohne Unterstreichung",
                    "fr": "Grande icône sans soulignement",
                    "es": "Icono grande sin subrayar",
                    "it": "Icona grande non sottolineata",
                    "pt": "Ícone grande sem sublinhado",
                    "nl": "Groot pictogram zonder onderstreping",
                    "da": "Stort ikon uden understregning",
                    "sv": "Stor ikon utan understrykning",
                    "nb": "Stort ikon uten understreking",
                    "fi": "Suuri kuvake ilman alleviivausta",
                    "is": "Stórt tákn án undirstrikunar",
                    "el": "Μεγάλο εικονίδιο χωρίς υπογράμμιση",
                    "tr": "Altçizgisiz büyük simge",
                    "hu": "Nagy ikon aláhúzás nélkül",
                    "hr": "Velika ikona bez podcrtavanja",
                    "pl": "Duża ikona bez podkreślenia",
                    "sk": "Veľká ikona bez podčiarknutia",
                    "cs": "Velká ikona bez podtržení",
                    "lb": "Grousst Ikon ouni Ënnerstrach",
                ]
            ),
            HyperLinkData(
                label: tr(
                    "Some label",
                    de: "Eine Beschriftung",
                    fr: "Un libellé",
                    es: "Una etiqueta",
                    it: "Un'etichetta"
                ),
                ariaLabel: nil,
                href: "#",
                icon: .airplane,
                iconSize: 48,
                align: .left,
                isFocusable: true,
                isUnderlined: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Non-Focusable Link",
                [
                    "de": "Nicht fokussierbarer Link",
                    "fr": "Lien non focalisable",
                    "es": "Enlace no enfocable",
                    "it": "Collegamento non focalizzabile",
                    "pt": "Link não focalizável",
                    "nl": "Niet-focusseerbare link",
                    "da": "Ikke-fokuserbart link",
                    "sv": "Icke-fokuserbar länk",
                    "nb": "Ikke-fokuserbar lenke",
                    "fi": "Ei-tarkennettava linkki",
                    "is": "Ófókusbær tengill",
                    "el": "Μη εστιάσιμος σύνδεσμος",
                    "tr": "Odaklanamayan bağlantı",
                    "hu": "Nem fókuszálható hivatkozás",
                    "hr": "Veza bez mogućnosti fokusiranja",
                    "pl": "Link bez możliwości ustawienia fokusu",
                    "sk": "Nezamerateľný odkaz",
                    "cs": "Nezaměřitelný odkaz",
                    "lb": "Net-fokusséierbare Link",
                ]
            ),
            HyperLinkData(
                label: tr(
                    "Some label",
                    de: "Eine Beschriftung",
                    fr: "Un libellé",
                    es: "Una etiqueta",
                    it: "Un'etichetta"
                ),
                ariaLabel: nil,
                href: "#",
                icon: .airplane,
                iconSize: 16,
                align: .left,
                isFocusable: false,
                isUnderlined: true,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Multiline Text Wrapping with Icon",
                [
                    "de": "Mehrzeiliger Textumbruch mit Icon",
                    "fr": "Retour à la ligne multiligne avec icône",
                    "es": "Ajuste de texto multilínea con icono",
                    "it": "A capo multilinea con icona",
                    "pt": "Quebra de texto em várias linhas com ícone",
                    "nl": "Tekstomloop over meerdere regels met pictogram",
                    "da": "Tekstombrydning over flere linjer med ikon",
                    "sv": "Fler raders textbrytning med ikon",
                    "nb": "Flerlinjet tekstbryting med ikon",
                    "fi": "Monirivinen tekstinkierto kuvakkeella",
                    "is": "Margra lína textaskipting með tákni",
                    "el": "Αναδίπλωση κειμένου πολλών γραμμών με εικονίδιο",
                    "tr": "Simgeli çok satırlı metin kaydırma",
                    "hu": "Többsoros szövegtördelés ikonnal",
                    "hr": "Prijelom teksta u više redaka s ikonom",
                    "pl": "Wielowierszowe zawijanie tekstu z ikoną",
                    "sk": "Viacriadkové zalamovanie textu s ikonou",
                    "cs": "Víceřádkové zalamování textu s ikonou",
                    "lb": "Méizeilegen Textëmbroch mat Ikon",
                ]
            ),
            HyperLinkData(
                label:
                    tr(
                        "This is a detailed hyperlink text explaining an external resource across multiple wrapped lines with vertical centering",
                        de:
                            "Dies ist ein ausführlicher Hyperlink-Text, der eine externe Ressource über mehrere umbrochene Zeilen mit vertikaler Zentrierung erklärt",
                        fr:
                            "Ceci est un texte de lien détaillé qui explique une ressource externe sur plusieurs lignes avec centrage vertical",
                        es:
                            "Este es un texto de hipervínculo detallado que explica un recurso externo en varias líneas con centrado vertical",
                        it:
                            "Questo è un testo di collegamento dettagliato che spiega una risorsa esterna su più righe con centratura verticale"
                    ),
                ariaLabel: tr(
                    "Detailed resource documentation",
                    de: "Ausführliche Dokumentation der Ressource",
                    fr: "Documentation détaillée de la ressource",
                    es: "Documentación detallada del recurso",
                    it: "Documentazione dettagliata della risorsa"
                ),
                href: "#",
                icon: .airplane,
                iconSize: 20,
                align: .left,
                isFocusable: true,
                isUnderlined: true,
                contentTracker: tracker
            )
        ),
    ]

    func makeHtml(ctx: HyperLinkData) -> String {
        let html = renderFragments(HyperLink(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Hyperlink")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { HyperLink(variant.data).render() }
                            .class("mb-4 mt-12 flex justify-center")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
