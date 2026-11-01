import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ButtonView: TemplateRepresentable {

    let variants: [PreviewVariant<ActionButtonData>] = [
        #previewVariant(
            """
            // With translations (en, de, fr) and an icon-only button with the built-in fallback label
            """,
            ActionButtonData(
                id: "btn-i18n",
                label: tr(
                    "Save",
                    de: "Speichern",
                    fr: "Enregistrer",
                    es: "Guardar",
                    it: "Salva"
                ),
                tooltip: tr(
                    "Save your changes",
                    de: "Änderungen speichern",
                    fr: "Enregistrer vos modifications",
                    es: "Guardar los cambios",
                    it: "Salva le modifiche"
                ),
                tooltipPosition: .bottom,
                htmlType: .button,
                buttonType: .primary,
                icon: .airplane,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // Icon only, no texts: the aria-label "Action" is built in and translated
            """,
            ActionButtonData(
                id: "btn-i18n-fallback",
                htmlType: .button,
                buttonType: .icon,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // Primary Button
            """,
            ActionButtonData(
                id: "btn-1",
                clickAction: "alert('ClickAction fired');",
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "Aria-Label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                tooltip: tr(
                    "Tooltip",
                    de: "Tooltip",
                    fr: "Infobulle",
                    es: "Información",
                    it: "Tooltip"
                ),
                tooltipPosition: .bottom,
                htmlType: .submit,
                buttonType: .primary,
                state: .enabled,
                size: .base,
                hasFullWidth: true,
                icon: .airplane,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // with Matomo
            """,
            ActionButtonData(
                id: "btn-2",
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "Aria-Label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                tooltip: tr(
                    "Tooltip",
                    de: "Tooltip",
                    fr: "Infobulle",
                    es: "Información",
                    it: "Tooltip"
                ),
                tooltipPosition: .right,
                htmlType: .submit,
                buttonType: .primary,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: nil,
                iconPosition: .left,
                matomoStatus: .ACCEPTED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            //
            """,
            ActionButtonData(
                id: "btn-3",
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "Aria-Label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                tooltip: tr(
                    "Tooltip",
                    de: "Tooltip",
                    fr: "Infobulle",
                    es: "Información",
                    it: "Tooltip"
                ),
                tooltipPosition: .right,
                htmlType: .submit,
                buttonType: .secondary,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: nil,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            //
            """,
            ActionButtonData(
                id: "btn-8",
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "Aria-Label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                tooltip: tr(
                    "Tooltip",
                    de: "Tooltip",
                    fr: "Infobulle",
                    es: "Información",
                    it: "Tooltip"
                ),
                tooltipPosition: .right,
                htmlType: .submit,
                buttonType: .tertiary,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: nil,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            //
            """,
            ActionButtonData(
                id: "btn-12",
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "Aria-Label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                tooltip: tr(
                    "Tooltip",
                    de: "Tooltip",
                    fr: "Infobulle",
                    es: "Información",
                    it: "Tooltip"
                ),
                tooltipPosition: .right,
                htmlType: .submit,
                buttonType: .warning,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: nil,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // .icon
            """,
            ActionButtonData(
                id: "btn-22",
                label: nil,
                ariaLabel: tr(
                    "Aria-Label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                tooltip: tr(
                    "Tooltip",
                    de: "Tooltip",
                    fr: "Infobulle",
                    es: "Información",
                    it: "Tooltip"
                ),
                tooltipPosition: .bottom,
                htmlType: .submit,
                buttonType: .icon,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: .cake,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            /// action + method:
            /// Sets the button's formaction and formmethod (native form submission).
            /// Clicking this button will submit the form to the server endpoint /preview-save using POST.
            """,
            ActionButtonData(
                id: "btn-action",
                action: "/preview-save",  // -> becomes formaction="/preview-save"
                method: .post,  // -> becomes formmethod="post"
                label: tr(
                    "Submit to /preview-save",
                    de: "An /preview-save senden",
                    fr: "Envoyer à /preview-save",
                    es: "Enviar a /preview-save",
                    it: "Invia a /preview-save"
                ),
                ariaLabel: tr(
                    "SubmitAction",
                    de: "Aktion absenden",
                    fr: "Action d'envoi",
                    es: "Acción de envío",
                    it: "Azione di invio"
                ),
                tooltip: tr(
                    "Submits form to server",
                    de: "Sendet das Formular an den Server",
                    fr: "Envoie le formulaire au serveur",
                    es: "Envía el formulario al servidor",
                    it: "Invia il modulo al server"
                ),
                tooltipPosition: .top,
                htmlType: .submit,
                buttonType: .secondary,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: nil,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            /// bindAction:
            /// Sets x-bind:formaction to a JS expression so the button's target can change at runtime.
            /// Requires a parent Alpine scope that defines the bound variable (e.g., dynamicUrl).
            """,
            ActionButtonData(
                id: "btn-bindAction",
                bindAction: "dynamicUrl",  // -> becomes x-bind:formaction="dynamicUrl"
                method: .post,
                label: tr(
                    "Submit to dynamic URL",
                    de: "An dynamische URL senden",
                    fr: "Envoyer à l'URL dynamique",
                    es: "Enviar a URL dinámica",
                    it: "Invia a URL dinamico"
                ),
                ariaLabel: tr(
                    "BindAction",
                    de: "Bindungsaktion",
                    fr: "Action liée",
                    es: "Acción vinculada",
                    it: "Azione associata"
                ),
                tooltip: tr(
                    "Reactive formaction via x-bind:formaction",
                    de: "Reaktive formaction über x-bind:formaction",
                    fr: "Formaction réactive via x-bind:formaction",
                    es: "Formaction reactiva mediante x-bind:formaction",
                    it: "Formaction reattiva tramite x-bind:formaction"
                ),
                tooltipPosition: .right,
                htmlType: .submit,
                buttonType: .tertiary,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: nil,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // state: .disabled — primary
            """,
            ActionButtonData(
                id: "btn-disabled-primary",
                clickAction: "alert('This must never fire');",
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "Disabled primary button",
                    de: "Deaktivierte primäre Schaltfläche",
                    fr: "Bouton principal désactivé",
                    es: "Botón principal deshabilitado",
                    it: "Pulsante primario disabilitato"
                ),
                tooltip: tr(
                    "Tooltip",
                    de: "Tooltip",
                    fr: "Infobulle",
                    es: "Información",
                    it: "Tooltip"
                ),
                tooltipPosition: .right,
                htmlType: .submit,
                buttonType: .primary,
                state: .disabled,
                size: .base,
                hasFullWidth: false,
                icon: .airplane,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // state: .disabled — secondary
            """,
            ActionButtonData(
                id: "btn-disabled-secondary",
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "Disabled secondary button",
                    de: "Deaktivierte sekundäre Schaltfläche",
                    fr: "Bouton secondaire désactivé",
                    es: "Botón secundario deshabilitado",
                    it: "Pulsante secondario disabilitato"
                ),
                buttonType: .secondary,
                state: .disabled,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // state: .disabled — tertiary
            """,
            ActionButtonData(
                id: "btn-disabled-tertiary",
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "Disabled tertiary button",
                    de: "Deaktivierte tertiäre Schaltfläche",
                    fr: "Bouton tertiaire désactivé",
                    es: "Botón terciario deshabilitado",
                    it: "Pulsante terziario disabilitato"
                ),
                buttonType: .tertiary,
                state: .disabled,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // state: .disabled — warning
            """,
            ActionButtonData(
                id: "btn-disabled-warning",
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "Disabled warning button",
                    de: "Deaktivierte Warn-Schaltfläche",
                    fr: "Bouton d'avertissement désactivé",
                    es: "Botón de advertencia deshabilitado",
                    it: "Pulsante di avviso disabilitato"
                ),
                buttonType: .warning,
                state: .disabled,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // state: .disabled — icon only
            """,
            ActionButtonData(
                id: "btn-disabled-icon",
                ariaLabel: tr(
                    "Disabled icon button",
                    de: "Deaktivierte Icon-Schaltfläche",
                    fr: "Bouton icône désactivé",
                    es: "Botón de icono deshabilitado",
                    it: "Pulsante con icona disabilitato"
                ),
                tooltip: tr(
                    "Tooltip",
                    de: "Tooltip",
                    fr: "Infobulle",
                    es: "Información",
                    it: "Tooltip"
                ),
                tooltipPosition: .bottom,
                buttonType: .icon,
                state: .disabled,
                icon: .cake,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // No explicit id and no tooltipId — identical to the two below.
            // Hovering one icon button must show exactly one tooltip.
            """,
            ActionButtonData(
                ariaLabel: tr(
                    "Icon button without id, first",
                    de: "Icon-Schaltfläche ohne ID, erste",
                    fr: "Bouton icône sans id, premier",
                    es: "Botón de icono sin id, primero",
                    it: "Pulsante con icona senza id, primo"
                ),
                tooltip: tr(
                    "Same tooltip text on all three",
                    de: "Gleicher Tooltip-Text bei allen dreien",
                    fr: "Même texte d'infobulle pour les trois",
                    es: "Mismo texto de información en los tres",
                    it: "Stesso testo del tooltip per tutti e tre"
                ),
                tooltipPosition: .top,
                buttonType: .tertiary,
                icon: .airplane,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // No explicit id, second of three
            """,
            ActionButtonData(
                ariaLabel: tr(
                    "Icon button without id, second",
                    de: "Icon-Schaltfläche ohne ID, zweite",
                    fr: "Bouton icône sans id, deuxième",
                    es: "Botón de icono sin id, segundo",
                    it: "Pulsante con icona senza id, secondo"
                ),
                tooltip: tr(
                    "Same tooltip text on all three",
                    de: "Gleicher Tooltip-Text bei allen dreien",
                    fr: "Même texte d'infobulle pour les trois",
                    es: "Mismo texto de información en los tres",
                    it: "Stesso testo del tooltip per tutti e tre"
                ),
                tooltipPosition: .top,
                buttonType: .tertiary,
                icon: .airplane,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            """
            // Multiline wrapping with icon
            """,
            ActionButtonData(
                id: "btn-multiline",
                label:
                    tr(
                        "This is a very long button label that exceeds typical button widths and wraps across several lines with vertical centering",
                        de:
                            "Dies ist eine sehr lange Beschriftung, die übliche Schaltflächenbreiten überschreitet und über mehrere Zeilen umbricht, vertikal zentriert",
                        fr:
                            "Ceci est un libellé de bouton très long qui dépasse les largeurs habituelles et s'étend sur plusieurs lignes avec centrage vertical",
                        es:
                            "Esta es una etiqueta de botón muy larga que supera los anchos habituales y se distribuye en varias líneas con centrado vertical",
                        it:
                            "Questa è un'etichetta molto lunga che supera le larghezze abituali e va a capo su più righe con centratura verticale"
                    ),
                buttonType: .primary,
                size: .base,
                hasFullWidth: false,
                icon: .airplane,
                iconPosition: .left,
                contentTracker: tracker
            )
        ),
    ]

    func makeHtml(ctx: ActionButtonData) -> String {
        let html = renderFragments(ActionButton(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Button")

                for (index, variant) in variants.enumerated() {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        id: "btn-\(index)",
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Form {
                            Div { ActionButton(variant.data).render() }
                                .class("flex")
                        }
                        .setAttribute(
                            name: "x-data",
                            value: "{ dynamicUrl: 'something' }"
                        )
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
