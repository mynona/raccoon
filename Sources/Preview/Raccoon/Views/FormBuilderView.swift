import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct FormBuilderView: TemplateRepresentable {

    let variants: [PreviewVariant<FormBuilderData>] = [
        #previewVariant(
            """
            // Page form: group, fields, link action (sign up)
            """,
            FormBuilderData(
                id: "preview.registration",
                action: "/preview/form-builder",
                csrfToken: "tok_abc123",
                fields: [
                    .group(
                        FormGroupData(
                            legend: tr(
                                "Your contact details",
                                de: "Ihre Kontaktdaten",
                                fr: "Vos coordonnées",
                                es: "Tus datos de contacto",
                                it: "I tuoi dati di contatto"
                            ),
                            fields: [
                                .row([
                                    .input(
                                        InputFieldData(
                                            id: "first_name",
                                            label: LabelData(
                                                id: "first_name",
                                                title: tr(
                                                    "First name",
                                                    de: "Vorname",
                                                    fr: "Prénom",
                                                    es: "Nombre",
                                                    it: "Nome"
                                                )
                                            ),
                                            placeholder: "John",
                                            autocomplete: "given-name"
                                        )
                                    ),
                                    .input(
                                        InputFieldData(
                                            id: "last_name",
                                            label: LabelData(
                                                id: "last_name",
                                                title: tr(
                                                    "Last name",
                                                    de: "Nachname",
                                                    fr: "Nom de famille",
                                                    es: "Apellidos",
                                                    it: "Cognome"
                                                )
                                            ),
                                            placeholder: "Doe",
                                            autocomplete: "family-name"
                                        )
                                    ),
                                ]),
                                .input(
                                    InputFieldData(
                                        id: "email",
                                        label: LabelData(
                                            id: "email",
                                            title: tr(
                                                "Email",
                                                de: "E-Mail",
                                                fr: "E-mail",
                                                es: "Correo electrónico",
                                                it: "E-mail"
                                            )
                                        ),
                                        placeholder: "john.doe@example.com",
                                        helperText: HelperTextData(
                                            id: "email",
                                            text: tr(
                                                "You will need the email to sign in.",
                                                de: "Sie benötigen die E-Mail-Adresse zum Anmelden.",
                                                fr: "Vous aurez besoin de l'e-mail pour vous connecter.",
                                                es: "Necesitarás el correo electrónico para iniciar sesión.",
                                                it: "Ti servirà l'e-mail per accedere."
                                            )
                                        ),
                                        validation: .email,
                                        autocomplete: "email"
                                    )
                                ),
                                .check(
                                    CheckData(
                                        id: "newsletter",
                                        label: tr(
                                            "I would like to receive email updates every two months.",
                                            de: "Ich möchte alle zwei Monate E-Mail-Neuigkeiten erhalten.",
                                            fr: "Je souhaite recevoir des nouvelles par e-mail tous les deux mois.",
                                            es: "Quiero recibir novedades por correo electrónico cada dos meses.",
                                            it: "Desidero ricevere aggiornamenti via e-mail ogni due mesi."
                                        ),
                                        name: "newsletter"
                                    )
                                ),
                            ]
                        )
                    )
                ],
                actions: [
                    .button(
                        ActionButtonData(
                            id: "preview-proceed",
                            label: tr(
                                "Proceed",
                                de: "Weiter",
                                fr: "Continuer",
                                es: "Continuar",
                                it: "Continua"
                            ),
                            buttonType: .primary,
                            contentTracker: MatomoContentTracker(
                                name: "preview-form",
                                piece: "button.proceed",
                                target: ""
                            )
                        )
                    ),
                    .link(
                        LinkButtonData(
                            label: tr(
                                "Already registered?",
                                de: "Bereits registriert?",
                                fr: "Déjà inscrit ?",
                                es: "¿Ya estás registrado?",
                                it: "Già registrato?"
                            ),
                            href: "/preview/form-builder",
                            buttonType: .tertiary,
                            contentTracker: MatomoContentTracker(
                                name: "preview-form",
                                piece: "link.login",
                                target: "/preview/form-builder"
                            )
                        )
                    ),
                ]
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
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("FormBuilder (page)")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { FormBuilder(variant.data).render() }
                            .class("mb-4 mt-12 max-w-2xl")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
