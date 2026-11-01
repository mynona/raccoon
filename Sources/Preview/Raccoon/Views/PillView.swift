import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct PillView: TemplateRepresentable {

    let variants: [PreviewVariant<PillData>] = [
        #previewVariant(
            tr(
                "Neutral Counter",
                [
                    "de": "Neutraler Zähler",
                    "fr": "Compteur neutre",
                    "es": "Contador neutral",
                    "it": "Contatore neutro",
                    "pt": "Contador neutro",
                    "nl": "Neutrale teller",
                    "da": "Neutral tæller",
                    "sv": "Neutral räknare",
                    "nb": "Nøytral teller",
                    "fi": "Neutraali laskuri",
                    "is": "Hlutlaus teljari",
                    "el": "Ουδέτερος μετρητής",
                    "tr": "Nötr sayaç",
                    "hu": "Semleges számláló",
                    "hr": "Neutralni brojač",
                    "pl": "Neutralny licznik",
                    "sk": "Neutrálne počítadlo",
                    "cs": "Neutrální počítadlo",
                    "lb": "Neutrale Zielt",
                ]
            ),
            PillData(
                42,
                variant: .neutral
            )
        ),
        #previewVariant(
            tr(
                "Theme Accent Counter",
                [
                    "de": "Theme-Akzent-Zähler",
                    "fr": "Compteur d'accent de thème",
                    "es": "Contador de acento de tema",
                    "it": "Contatore accento del tema",
                    "pt": "Contador de destaque do tema",
                    "nl": "Thema-accentteller",
                    "da": "Tema-accenttæller",
                    "sv": "Temaaccenträknare",
                    "nb": "Temaaksentteller",
                    "fi": "Teeman korostuslaskuri",
                    "is": "Þemaáhersluteljari",
                    "el": "Μετρητής έμφασης θέματος",
                    "tr": "Tema vurgulu sayaç",
                    "hu": "Témahangsúlyos számláló",
                    "hr": "Brojač naglaska teme",
                    "pl": "Licznik z akcentem motywu",
                    "sk": "Počítadlo s akcentom motívu",
                    "cs": "Počítadlo s akcentem motivu",
                    "lb": "Theme-Akzent-Zielt",
                ]
            ),
            PillData(
                3124,
                variant: .theme
            )
        ),
        #previewVariant(
            tr(
                "Success Status Text",
                [
                    "de": "Erfolgs-Statustext",
                    "fr": "Texte d'état de succès",
                    "es": "Texto de estado de éxito",
                    "it": "Testo di stato successo",
                    "pt": "Texto de status de sucesso",
                    "nl": "Successtatustekst",
                    "da": "Successtatustekst",
                    "sv": "Framgångsstatustext",
                    "nb": "Suksess-statustekst",
                    "fi": "Onnistumistilan teksti",
                    "is": "Árangursstöðutexti",
                    "el": "Κείμενο κατάστασης επιτυχίας",
                    "tr": "Başarılı durum metni",
                    "hu": "Sikeres állapot szöveg",
                    "hr": "Tekst statusa uspjeha",
                    "pl": "Tekst stanu powodzenia",
                    "sk": "Text stavu úspechu",
                    "cs": "Text stavu úspěchu",
                    "lb": "Erfollegs-Statustext",
                ]
            ),
            PillData(
                tr("New", de: "Neu", fr: "Nouveau", es: "Nuevo", it: "Nuovo"),
                variant: .success,
                size: .base
            )
        ),
        #previewVariant(
            tr(
                "Large Error Status Text",
                [
                    "de": "Großer Fehler-Statustext",
                    "fr": "Grand texte d'état d'erreur",
                    "es": "Texto grande de estado de error",
                    "it": "Testo grande di stato errore",
                    "pt": "Texto grande de status de erro",
                    "nl": "Grote foutstatustekst",
                    "da": "Stor fejstatustekst",
                    "sv": "Stor felstatustext",
                    "nb": "Stor feilstatustekst",
                    "fi": "Suuri virhetilan teksti",
                    "is": "Stór villustöðutexti",
                    "el": "Μεγάλο κείμενο κατάστασης σφάλματος",
                    "tr": "Büyük hata durumu metni",
                    "hu": "Nagy hibaállapot szöveg",
                    "hr": "Veliki tekst statusa pogreške",
                    "pl": "Duży tekst stanu błędu",
                    "sk": "Veľký text stavu chyby",
                    "cs": "Velký text stavu chyby",
                    "lb": "Grousse Feeler-Statustext",
                ]
            ),
            PillData(
                tr(
                    "Failed",
                    de: "Fehlgeschlagen",
                    fr: "Échec",
                    es: "Fallido",
                    it: "Non riuscito"
                ),
                variant: .error,
                size: .xl
            )
        ),
    ]

    func makeHtml(ctx: PillData) -> String {
        let html = renderFragments(Pill(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {
        Basic {
            Div {
                showComponentTitle("Pill")

                for variant in variants {
                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Pill(variant.data).render() }
                            .class("mb-4 mt-4")
                    }
                }
            }
            .class("mt-4 space-y-6")
        }
        .render()
    }
}
