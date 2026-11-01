import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ToggleSwitchView: TemplateRepresentable {

    let variants: [PreviewVariant<ToggleSwitchData>] = [
        #previewVariant(
            tr(
                "Off State with Label",
                [
                    "de": "Aus-Zustand mit Beschriftung",
                    "fr": "État inactif avec étiquette",
                    "es": "Estado desactivado con etiqueta",
                    "it": "Stato disattivato con etichetta",
                    "pt": "Estado desligado com etiqueta",
                    "nl": "Uit-status met label",
                    "da": "Fra-tilstand med etiket",
                    "sv": "Avstängt tillstånd med etikett",
                    "nb": "Av-tilstand med etikett",
                    "fi": "Pois-tila nimikkeellä",
                    "is": "Slökkt staða með merki",
                    "el": "Ανενεργή κατάσταση με ετικέτα",
                    "tr": "Etiketli kapalı durum",
                    "hu": "Kikapcsolt állapot címkével",
                    "hr": "Isključeno stanje s oznakom",
                    "pl": "Stan wyłączony z etykietą",
                    "sk": "Vypnutý stav so štítkom",
                    "cs": "Vypnutý stav s popiskem",
                    "lb": "Aus-Zoustand mat Etikett",
                ]
            ),
            ToggleSwitchData(
                id: "ts-1",
                label: LabelData(
                    id: "ts-1",
                    title: tr(
                        "label",
                        de: "Beschriftung",
                        fr: "libellé",
                        es: "etiqueta",
                        it: "etichetta"
                    )
                ),
                isSelected: false,
                size: .base,
                state: .enabled,
                apiURL: nil
            )
        ),
        #previewVariant(
            tr(
                "On State Disabled without Label",
                [
                    "de": "Ein-Zustand deaktiviert ohne Beschriftung",
                    "fr": "État actif désactivé sans étiquette",
                    "es": "Estado activado deshabilitado sin etiqueta",
                    "it": "Stato attivato disabilitato senza etichetta",
                    "pt": "Estado ligado desativado sem etiqueta",
                    "nl": "Aan-status uitgeschakeld zonder label",
                    "da": "Til-tilstand deaktiveret uden etiket",
                    "sv": "Aktiverat tillstånd inaktiverat utan etikett",
                    "nb": "På-tilstand deaktivert uten etikett",
                    "fi": "Päällä-tila pois käytöstä ilman nimikettä",
                    "is": "Kveikt staða óvirk án merkis",
                    "el": "Ενεργή κατάσταση απενεργοποιημένη χωρίς ετικέτα",
                    "tr": "Etiketsiz devre dışı açık durum",
                    "hu": "Bekapcsolt állapot letiltva címke nélkül",
                    "hr": "Uključeno stanje onemogućeno bez oznake",
                    "pl": "Stan włączony wyłączony bez etykiety",
                    "sk": "Zapnutý stav zakázaný bez štítku",
                    "cs": "Zapnutý stav zakázán bez popisku",
                    "lb": "Un-Zoustand desaktivéiert ouni Etikett",
                ]
            ),
            ToggleSwitchData(
                id: "ts-2",
                label: nil,
                isSelected: true,
                size: .base,
                state: .disabled,
                apiURL: nil
            )
        ),
        #previewVariant(
            tr(
                "On State Small with Left Label",
                [
                    "de": "Ein-Zustand klein mit linker Beschriftung",
                    "fr": "État actif petit avec étiquette à gauche",
                    "es": "Estado activado pequeño con etiqueta a la izquierda",
                    "it": "Stato attivato piccolo con etichetta a sinistra",
                    "pt": "Estado ligado pequeno com etiqueta à esquerda",
                    "nl": "Aan-status klein met linkerlabel",
                    "da": "Til-tilstand lille med venstre etiket",
                    "sv": "Aktiverat tillstånd litet med vänster etikett",
                    "nb": "På-tilstand liten med venstre etikett",
                    "fi": "Päällä-tila pieni vasemmalla nimikkeellä",
                    "is": "Kveikt staða lítil með vinstra merki",
                    "el": "Ενεργή κατάσταση μικρή με αριστερή ετικέτα",
                    "tr": "Sol etiketli küçük açık durum",
                    "hu": "Bekapcsolt állapot kicsi bal oldali címkével",
                    "hr": "Uključeno stanje malo s lijevom oznakom",
                    "pl": "Stan włączony mały z lewą etykietą",
                    "sk": "Zapnutý stav malý s ľavým štítkom",
                    "cs": "Zapnutý stav malý s levým popiskem",
                    "lb": "Un-Zoustand kleng mat lénkser Etikett",
                ]
            ),
            ToggleSwitchData(
                id: "ts-3",
                label: LabelData(
                    id: "ts-3",
                    title: tr(
                        "label",
                        de: "Beschriftung",
                        fr: "libellé",
                        es: "etiqueta",
                        it: "etichetta"
                    ),
                    position: .left
                ),
                isSelected: true,
                size: .sm,
                state: .enabled,
                apiURL: "some-api-url"
            )
        ),
        #previewVariant(
            tr(
                "On State Extra Large with Right Label",
                [
                    "de": "Ein-Zustand extra groß mit rechter Beschriftung",
                    "fr": "État actif très grand avec étiquette à droite",
                    "es": "Estado activado extragrande con etiqueta a la derecha",
                    "it": "Stato attivato extra large con etichetta a destra",
                    "pt": "Estado ligado extra grande com etiqueta à direita",
                    "nl": "Aan-status extra groot met rechterlabel",
                    "da": "Til-tilstand ekstra stor med højre etiket",
                    "sv": "Aktiverat tillstånd extra stort med höger etikett",
                    "nb": "På-tilstand ekstra stor med høyre etikett",
                    "fi": "Päällä-tila erittäin suuri oikealla nimikkeellä",
                    "is": "Kveikt staða mjög stór með hægra merki",
                    "el": "Ενεργή κατάσταση πολύ μεγάλη με δεξιά ετικέτα",
                    "tr": "Sağ etiketli ekstra büyük açık durum",
                    "hu": "Bekapcsolt állapot extra nagy jobb oldali címkével",
                    "hr": "Uključeno stanje vrlo veliko s desnom oznakom",
                    "pl": "Stan włączony bardzo duży z prawą etykietą",
                    "sk": "Zapnutý stav extra veľký s pravým štítkom",
                    "cs": "Zapnutý stav extra velký s pravým popiskem",
                    "lb": "Un-Zoustand extra grouss mat rietser Etikett",
                ]
            ),
            ToggleSwitchData(
                id: "ts-5",
                label: LabelData(
                    id: "ts-5",
                    title: tr(
                        "label",
                        de: "Beschriftung",
                        fr: "libellé",
                        es: "etiqueta",
                        it: "etichetta"
                    ),
                    position: .right
                ),
                isSelected: true,
                size: .xl,
                state: .enabled,
                apiURL: "some-api-url"
            )
        ),
    ]

    func makeHtml(ctx: ToggleSwitchData) -> String {
        let html = renderFragments(ToggleSwitch(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("ToggleSwitch")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { ToggleSwitch(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
