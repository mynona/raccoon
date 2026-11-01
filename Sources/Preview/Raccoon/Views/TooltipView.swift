import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct TooltipView: TemplateRepresentable {

    let variants: [PreviewVariant<TooltipData>] = [
        #previewVariant(
            tr(
                "Top Position with Arrow",
                [
                    "de": "Oben positioniert mit Pfeil",
                    "fr": "Position supérieure avec flèche",
                    "es": "Posición superior con flecha",
                    "it": "Posizione superiore con freccia",
                    "pt": "Posição superior com seta",
                    "nl": "Bovenste positie met pijl",
                    "da": "Øverste position med pil",
                    "sv": "Övre position med pil",
                    "nb": "Topposisjon med pil",
                    "fi": "Yläasento nuolella",
                    "is": "Efri staða með ör",
                    "el": "Πάνω θέση με βέλος",
                    "tr": "Oklu üst konum",
                    "hu": "Felső pozíció nyíllal",
                    "hr": "Gornji položaj sa strelicom",
                    "pl": "Górna pozycja ze strzałką",
                    "sk": "Horná pozícia so šípkou",
                    "cs": "Horní pozice se šipkou",
                    "lb": "Iewescht Positioun mat Feil",
                ]
            ),
            TooltipData(
                id: "tooltip-1",
                text: tr(
                    "This appears on top",
                    de: "Dies erscheint oben",
                    fr: "Ceci apparaît au-dessus",
                    es: "Esto aparece arriba",
                    it: "Questo appare sopra"
                ),
                position: .top,
                hasArrow: true
            )
        ),
        #previewVariant(
            tr(
                "Bottom Position with Arrow",
                [
                    "de": "Unten positioniert mit Pfeil",
                    "fr": "Position inférieure avec flèche",
                    "es": "Posición inferior con flecha",
                    "it": "Posizione inferiore con freccia",
                    "pt": "Posição inferior com seta",
                    "nl": "Onderste positie met pijl",
                    "da": "Nederste position med pil",
                    "sv": "Nedre position med pil",
                    "nb": "Bunnposisjon med pil",
                    "fi": "Ala-asento nuolella",
                    "is": "Neðri staða með ör",
                    "el": "Κάτω θέση με βέλος",
                    "tr": "Oklu alt konum",
                    "hu": "Alsó pozíció nyíllal",
                    "hr": "Donji položaj sa strelicom",
                    "pl": "Dolna pozycja ze strzałką",
                    "sk": "Dolná pozícia so šípkou",
                    "cs": "Dolní pozice se šipkou",
                    "lb": "Ënnescht Positioun mat Feil",
                ]
            ),
            TooltipData(
                id: "tooltip-2",
                text: tr(
                    "This appears on bottom",
                    de: "Dies erscheint unten",
                    fr: "Ceci apparaît en dessous",
                    es: "Esto aparece abajo",
                    it: "Questo appare sotto"
                ),
                position: .bottom,
                hasArrow: true
            )
        ),
        #previewVariant(
            tr(
                "Localized Text with Arrow",
                [
                    "de": "Lokalisierter Text mit Pfeil",
                    "fr": "Texte localisé avec flèche",
                    "es": "Texto localizado con flecha",
                    "it": "Testo localizzato con freccia",
                    "pt": "Texto localizado com seta",
                    "nl": "Gelokaliseerde tekst met pijl",
                    "da": "Lokaliseret tekst med pil",
                    "sv": "Lokaliserad text med pil",
                    "nb": "Lokalisert tekst med pil",
                    "fi": "Lokalisoitu teksti nuolella",
                    "is": "Staðfærður texti með ör",
                    "el": "Τοπικοποιημένο κείμενο με βέλος",
                    "tr": "Oklu yerelleştirilmiş metin",
                    "hu": "Honosított szöveg nyíllal",
                    "hr": "Lokalizirani tekst sa strelicom",
                    "pl": "Zlokalizowany tekst ze strzałką",
                    "sk": "Lokalizovaný text so šípkou",
                    "cs": "Lokalizovaný text se šipkou",
                    "lb": "Lokaliséierten Text mat Feil",
                ]
            ),
            TooltipData(
                id: "tooltip-3",
                text: tr(
                    "Save your changes",
                    de: "Änderungen speichern",
                    fr: "Enregistrer vos modifications",
                    es: "Guardar los cambios",
                    it: "Salva le modifiche"
                ),
                position: .top,
                hasArrow: true
            )
        ),
    ]

    func makeHtml(ctx: TooltipData) -> String {
        let html = renderFragments(Tooltip(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Tooltip")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    /// ## Tooltip Usage
                    ///
                    /// The `Tooltip` component renders an Alpine‑powered tooltip that attaches
                    /// to any element via a shared `id`. To use a tooltip correctly, three things
                    /// must be present:
                    ///
                    /// 1. **A wrapper with `x-data` and `position: relative`**
                    ///    This creates the Alpine scope and ensures the tooltip can position
                    ///    itself relative to the trigger element.
                    ///    ```html
                    ///    <div x-data class="relative inline-block">
                    ///    ```
                    ///
                    /// 2. **A trigger element with a matching `x-ref`**
                    ///    The trigger must define an `x-ref` whose value matches the tooltip’s
                    ///    `context.id`.
                    ///    ```html
                    ///    <button x-ref="tooltip-1">Hover me</button>
                    ///    ```
                    ///
                    /// 3. **Show/Hide events using the same ID**
                    ///    The trigger must dispatch `show-tooltip` and `hide-tooltip` events
                    ///    with the same ID used in `x-ref` and `TooltipData(id:)`.
                    ///    ```html
                    ///    x-on:mouseenter="window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: 'tooltip-1' } }))"
                    ///    x-on:mouseleave="window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: 'tooltip-1' } }))"
                    ///    ```
                    ///
                    /// 4. **Render the tooltip with the same ID**
                    ///    ```swift
                    ///    Tooltip(
                    ///        TooltipData(
                    ///            id: "tooltip-1",
                    ///            text: "Tooltip text",
                    ///            arrow: true,
                    ///            position: .top
                    ///        )
                    ///    )
                    ///    ```
                    ///
                    /// ### Minimal Working Example
                    ///
                    /// ```html
                    /// <div x-data class="relative inline-block">
                    ///     <button
                    ///         x-ref="tooltip-1"
                    ///         x-on:mouseenter="window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: 'tooltip-1' } }))"
                    ///         x-on:mouseleave="window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: 'tooltip-1' } }))"
                    ///         class="inline-block"
                    ///     >
                    ///

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div {

                            Button(variant.data.text.resolved)
                                .setAttribute(
                                    name: "x-ref",
                                    value: variant.data.id
                                )
                                .setAttribute(
                                    name: "x-on:mouseenter",
                                    value:
                                        "window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: '\(variant.data.id)' } }))"
                                )
                                .setAttribute(
                                    name: "x-on:mouseleave",
                                    value:
                                        "window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: '\(variant.data.id)' } }))"
                                )
                                .class("inline-block")

                            Tooltip(variant.data).render()

                        }
                        .class("relative inline-block mb-4 mt-12")
                        .setAttribute(name: "x-data", value: "{}")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
