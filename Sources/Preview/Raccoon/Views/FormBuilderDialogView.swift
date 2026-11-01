import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

/// Shows `FormBuilder` inside a dialog.
/// The dialog shell is local to this preview until Raccoon has its own `Dialog` component.
struct FormBuilderDialogView: TemplateRepresentable {

    private static let closeDialog = "open = false, $store.modal = false"

    private static func closeAction(piece: String) -> FormAction {
        .button(
            ActionButtonData(
                clickAction: closeDialog,
                label: tr(
                    "Cancel",
                    de: "Abbrechen",
                    fr: "Annuler",
                    es: "Cancelar",
                    it: "Annulla"
                ),
                htmlType: .button,
                buttonType: .secondary,
                contentTracker: MatomoContentTracker(
                    name: "preview-dialog-form",
                    piece: piece,
                    target: ""
                )
            )
        )
    }

    private static func submitAction(label: LocalizedText, piece: String)
        -> FormAction
    {
        .button(
            ActionButtonData(
                label: label,
                buttonType: .primary,
                contentTracker: MatomoContentTracker(
                    name: "preview-dialog-form",
                    piece: piece,
                    target: ""
                )
            )
        )
    }

    let variants: [PreviewVariant<FormBuilderData>] = [
        #previewVariant(
            tr(
                "Dialog Form with Trailing Actions",
                [
                    "de": "Dialogformular mit abschließenden Aktionen",
                    "fr": "Formulaire de dialogue avec actions alignées en fin",
                    "es": "Formulario de diálogo con acciones finales",
                    "it": "Modulo di dialogo con azioni finali",
                    "pt": "Formulário de diálogo com ações finais",
                    "nl": "Dialoogformulier met afsluitende acties",
                    "da": "Dialogformular med efterfølgende handlinger",
                    "sv": "Dialogformulär med avslutande åtgärder",
                    "nb": "Dialogskjema med avsluttende handlinger",
                    "fi": "Valintaikkunalomake loppuun sijoitetuilla toiminnoilla",
                    "is": "Svargluggareyðublað með lokaaðgerðum",
                    "el": "Φόρμα διαλόγου με τελικές ενέργειες",
                    "tr": "Sonda eylemli iletişim kutusu formu",
                    "hu": "Párbeszédpanel-űrlap záró műveletekkel",
                    "hr": "Dijaloški obrazac sa završnim radnjama",
                    "pl": "Formularz dialogowy z końcowymi akcjami",
                    "sk": "Formulár dialógu so záverečnými akciami",
                    "cs": "Formulář dialogu se závěrečnými akcemi",
                    "lb": "Dialogsformular mat ofschléissenden Aktiounen",
                ]
            ),
            FormBuilderData(
                id: "preview.dialog.rename",
                action: "/preview/form-builder-dialog",
                ariaLabel: tr(
                    "Rename item",
                    de: "Element umbenennen",
                    fr: "Renommer l'élément",
                    es: "Renombrar elemento",
                    it: "Rinomina elemento"
                ),
                csrfToken: "tok_abc123",
                fields: [
                    .input(
                        InputFieldData(
                            id: "rename_title",
                            label: LabelData(
                                id: "rename_title",
                                title: tr(
                                    "Title",
                                    de: "Titel",
                                    fr: "Titre",
                                    es: "Título",
                                    it: "Titolo"
                                )
                            ),
                            value: "My item"
                        )
                    ),
                    .check(
                        CheckData(
                            id: "rename_notify",
                            label: tr(
                                "Notify the followers",
                                de: "Follower benachrichtigen",
                                fr: "Informer les abonnés",
                                es: "Notificar a los seguidores",
                                it: "Avvisa i follower"
                            ),
                            name: "rename_notify"
                        )
                    ),
                ],
                actions: [
                    FormBuilderDialogView.closeAction(piece: "button.cancel"),
                    FormBuilderDialogView.submitAction(
                        label: tr(
                            "Save",
                            de: "Speichern",
                            fr: "Enregistrer",
                            es: "Guardar",
                            it: "Salva"
                        ),
                        piece: "button.save"
                    ),
                ],
                layout: .dialog
            )
        ),
    ]

    func makeHtml(ctx: FormBuilderData) -> String {
        let html = renderFragments(FormBuilder(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func openButton(id: String, label: LocalizedText) -> [Element] {
        ActionButton(
            ActionButtonData(
                id: id,
                clickAction: "open = true, $store.modal = true",
                label: label,
                htmlType: .button,
                buttonType: .primary,
                contentTracker: MatomoContentTracker(
                    name: "preview-dialog-form",
                    piece: "button.open",
                    target: ""
                )
            )
        )
        .render()
    }

    @Builder<Element>
    func closeButton() -> [Element] {
        Div {
            ActionButton(
                ActionButtonData(
                    clickAction: Self.closeDialog,
                    ariaLabel: tr(
                        "Close dialog",
                        de: "Dialog schließen",
                        fr: "Fermer la boîte de dialogue",
                        es: "Cerrar el cuadro de diálogo",
                        it: "Chiudi la finestra di dialogo"
                    ),
                    htmlType: .button,
                    buttonType: .icon,
                    size: .xl,
                    icon: .x_lg,
                    contentTracker: MatomoContentTracker(
                        name: "preview-dialog-form",
                        piece: "button.close",
                        target: ""
                    )
                )
            )
            .render()
        }
        .class(DialogStyles.closeButtonAbsolutePosition)
    }

    @Builder<Element>
    func dialog(
        title: LocalizedText,
        @Builder<Element> content: () -> [Element]
    ) -> [Element] {
        Div {
            Div {}
                .setAttribute(name: "x-show", value: "open")
                .flagAttribute("x-transition.opacity")
                .class(DeleteModalStyles.backdrop)

            Div {
                Div {
                    closeButton()

                    // `DialogStyles.title` ends with 1rem; 1rem more matches the 2rem above the actions
                    H2(title.resolved)
                        .localized(title)
                        .setAttribute(name: ":id", value: "$id('modal-title')")
                        .class(DialogStyles.title)
                        .addClass("mb-4")

                    content()
                }
                .flagAttribute("x-on:click.stop")
                .setAttribute(name: "x-trap.noscroll.inert", value: "open")
                .class(
                    "relative z-100 inset-x-0 mx-auto w-full max-w-2xl overflow-y-auto"
                )
                .addClass(DialogStyles.backgroundColorDefault)
                .addClass(DialogStyles.backgroundBorderDefault)
                .addClass(DialogStyles.backgroundShadow)
                .addClass(DialogStyles.backgroundRadius)
                .addClass(DialogStyles.backgroundMargin)
                .addClass(DialogStyles.backgroundPadding)
                .addClass(DialogStyles.textFont)
                .addClass(DialogStyles.textColor)
            }
            .setAttribute(name: "x-show", value: "open")
            .flagAttribute("x-transition")
            .setAttribute(name: "x-on:click", value: Self.closeDialog)
            .class(
                "z-10 fixed flex min-h-screen items-center container mx-auto w-full p-4"
            )
        }
        .setAttribute(name: "x-show", value: "open")
        .setAttribute(
            name: "x-on:keydown.escape.prevent.stop",
            value: Self.closeDialog
        )
        .setAttribute(name: "role", value: "dialog")
        .setAttribute(name: "aria-modal", value: "true")
        .setAttribute(name: "x-id", value: "['modal-title']")
        .setAttribute(name: ":aria-labelledby", value: "$id('modal-title')")
        .flagAttribute("x-cloak")
        .class("absolute inset-0 overflow-y-auto")
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("FormBuilder (dialog)")

                Script()
                    .src("/js/modal.js")
                    .setAttribute(name: "type", value: "text/javascript")

                for (index, variant) in variants.enumerated() {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div {
                            openButton(
                                id: "open-form-dialog-\(index)",
                                label: variant.data.ariaLabel ?? "Open dialog"
                            )
                            dialog(
                                title: variant.data.ariaLabel ?? "Dialog"
                            ) {
                                FormBuilder(variant.data).render()
                            }
                        }
                        .setAttribute(name: "x-data", value: "{ open: false }")
                        .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
