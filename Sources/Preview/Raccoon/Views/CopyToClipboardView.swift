import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct CopyToClipboardView: TemplateRepresentable {

    let variants: [PreviewVariant<CopyToClipboardData>] = [
        #previewVariant(
            tr(
                "Horizontal Layout",
                [
                    "de": "Horizontales Layout",
                    "fr": "Disposition horizontale",
                    "es": "Diseño horizontal",
                    "it": "Disposizione orizzontale",
                    "pt": "Layout horizontal",
                    "nl": "Horizontale indeling",
                    "da": "Vandret layout",
                    "sv": "Horisontell layout",
                    "nb": "Horisontalt oppsett",
                    "fi": "Vaakasuuntainen asettelu",
                    "is": "Lárétt uppsetning",
                    "el": "Οριζόντια διάταξη",
                    "tr": "Yatay düzen",
                    "hu": "Vízszintes elrendezés",
                    "hr": "Vodoravni raspored",
                    "pl": "Układ poziomy",
                    "sk": "Horizontálne rozloženie",
                    "cs": "Horizontální rozvržení",
                    "lb": "Horizontaalt Layout",
                ]
            ),
            CopyToClipboardData(
                value: "sk-abc123XYZ",
                responseType: .inlineHorizontal
            )
        ),
        #previewVariant(
            tr(
                "Vertical Layout",
                [
                    "de": "Vertikales Layout",
                    "fr": "Disposition verticale",
                    "es": "Diseño vertical",
                    "it": "Disposizione verticale",
                    "pt": "Layout vertical",
                    "nl": "Verticale indeling",
                    "da": "Lodret layout",
                    "sv": "Vertikal layout",
                    "nb": "Vertikalt oppsett",
                    "fi": "Pystysuuntainen asettelu",
                    "is": "Lóðrétt uppsetning",
                    "el": "Κάθετη διάταξη",
                    "tr": "Dikey düzen",
                    "hu": "Függőleges elrendezés",
                    "hr": "Okomiti raspored",
                    "pl": "Układ pionowy",
                    "sk": "Vertikálne rozloženie",
                    "cs": "Vertikální rozvržení",
                    "lb": "Vertikaalt Layout",
                ]
            ),
            CopyToClipboardData(
                value: "sk-abc123XYZ",
                responseType: .inlineVertical
            )
        ),
        #previewVariant(
            tr(
                "Toast Feedback",
                [
                    "de": "Toast-Rückmeldung",
                    "fr": "Notification toast",
                    "es": "Notificación toast",
                    "it": "Notifica toast",
                    "pt": "Notificação toast",
                    "nl": "Toast-melding",
                    "da": "Toast-meddelelse",
                    "sv": "Toast-avisering",
                    "nb": "Toast-varsel",
                    "fi": "Toast-ilmoitus",
                    "is": "Toast tilkynning",
                    "el": "Ειδοποίηση toast",
                    "tr": "Toast bildirimi",
                    "hu": "Toast értesítés",
                    "hr": "Toast obavijest",
                    "pl": "Powiadomienie toast",
                    "sk": "Toast oznámenie",
                    "cs": "Toast oznámení",
                    "lb": "Toast-Notifikatioun",
                ]
            ),
            CopyToClipboardData(
                value: "https://example.com/articles/product-thinking",
                responseType: .toast
            )
        ),
        #previewVariant(
            tr(
                "Share Button (Custom Icon & Toast)",
                [
                    "de": "Teilen-Schaltfläche (Eigenes Icon & Toast)",
                    "fr": "Bouton de partage (Icône personnalisée & Toast)",
                    "es": "Botón de compartir (Icono personalizado y Toast)",
                    "it": "Pulsante di condivisione (Icona personalizzata e Toast)",
                    "pt": "Botão de partilha (Ícone personalizado e Toast)",
                    "nl": "Deelknop (Aangepast pictogram en Toast)",
                    "da": "Deleknap (Tilpasset ikon og Toast)",
                    "sv": "Delningsknapp (Anpassad ikon och Toast)",
                    "nb": "Deleknapp (Tilpasset ikon og Toast)",
                    "fi": "Jaa-painike (Mukautettu kuvake ja Toast)",
                    "is": "Deilihnappur (Sérsniðið tákn og Toast)",
                    "el": "Κουμπí κοινοποίησης (Προσαρμοσμένο εικονίδιο & Toast)",
                    "tr": "Paylaş butonu (Özel simge ve Toast)",
                    "hu": "Megosztás gomb (Egyéni ikon és Toast)",
                    "hr": "Gumb za dijeljenje (Prilagođena ikona i Toast)",
                    "pl": "Przycisk udostępniania (Niestandardowa ikona i Toast)",
                    "sk": "Tlačidlo zdieľania (Vlastná ikona a Toast)",
                    "cs": "Tlačítko sdílení (Vlastní ikona a Toast)",
                    "lb": "Deelen-Knäppchen (Eeget Icon & Toast)",
                ]
            ),
            CopyToClipboardData(
                ariaLabel: "Share link",
                tooltip: "Click to share link",
                value: "https://example.com/bookmarks/card-123",
                icon: .share,
                responseType: .toast
            )
        ),
    ]

    func makeHtml(ctx: CopyToClipboardData) -> String {
        let html = renderFragments(CopyToClipboard(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("CopyToClipboard")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { CopyToClipboard(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
