import HTML
import Raccoon
import SGML
import WebBuilders

struct RadioGroupView: TemplateRepresentable {

    /// Option ids must be unique on the page, so every group gets its own prefix.
    private static func plans(_ prefix: String) -> [RadioData] {
        [
            RadioData(
                id: "\(prefix)-free",
                label: tr(
                    "Free",
                    de: "Kostenlos",
                    fr: "Gratuit",
                    es: "Gratis",
                    it: "Gratuito"
                ),
                value: "free"
            ),
            RadioData(
                id: "\(prefix)-pro",
                label: tr("Pro", de: "Pro", fr: "Pro", es: "Pro", it: "Pro"),
                value: "pro"
            ),
            RadioData(
                id: "\(prefix)-team",
                label: tr(
                    "Team",
                    de: "Team",
                    fr: "Équipe",
                    es: "Equipo",
                    it: "Team"
                ),
                value: "team"
            ),
        ]
    }

    let variants: [PreviewVariant<RadioGroupData>] = [
        #previewVariant(
            "Unselected Optional Group",
            RadioGroupData(
                id: "group-1",
                name: "plan-1",
                label: LabelData(
                    id: "group-1",
                    title: tr(
                        "Plan",
                        de: "Tarif",
                        fr: "Forfait",
                        es: "Plan",
                        it: "Piano"
                    ),
                    isRequired: false
                ),
                options: plans("g1")
            )
        ),
        #previewVariant(
            "Preselected Required Group",
            RadioGroupData(
                id: "group-2",
                name: "plan-2",
                label: LabelData(
                    id: "group-2",
                    title: tr(
                        "Plan",
                        de: "Tarif",
                        fr: "Forfait",
                        es: "Plan",
                        it: "Piano"
                    )
                ),
                selectedValue: "pro",
                options: plans("g2")
            )
        ),
        #previewVariant(
            "Group with Helper Text",
            RadioGroupData(
                id: "group-3",
                name: "plan-3",
                label: LabelData(
                    id: "group-3",
                    title: tr(
                        "Plan",
                        de: "Tarif",
                        fr: "Forfait",
                        es: "Plan",
                        it: "Piano"
                    ),
                    isRequired: false
                ),
                selectedValue: "free",
                options: plans("g3"),
                helperText: HelperTextData(
                    id: "group-3",
                    text: tr(
                        "You can change your plan at any time.",
                        de: "Du kannst deinen Tarif jederzeit ändern.",
                        fr: "Vous pouvez changer de forfait à tout moment.",
                        es: "Puedes cambiar de plan en cualquier momento.",
                        it: "Puoi cambiare piano in qualsiasi momento."
                    )
                )
            )
        ),
        #previewVariant(
            "Group Validation Error",
            RadioGroupData(
                id: "group-4",
                name: "plan-4",
                label: LabelData(
                    id: "group-4",
                    title: tr(
                        "Plan",
                        de: "Tarif",
                        fr: "Forfait",
                        es: "Plan",
                        it: "Piano"
                    )
                ),
                options: plans("g4"),
                errorMessages: ErrorMessageData(
                    id: "group-4",
                    errorMessages: [
                        tr(
                            "Select a plan.",
                            de: "Wähle einen Tarif.",
                            fr: "Sélectionnez un forfait.",
                            es: "Selecciona un plan.",
                            it: "Seleziona un piano."
                        )
                    ],
                    hasIcon: true
                ),
                helperText: HelperTextData(
                    id: "group-4",
                    text: tr(
                        "You can change your plan at any time.",
                        de: "Du kannst deinen Tarif jederzeit ändern.",
                        fr: "Vous pouvez changer de forfait à tout moment.",
                        es: "Puedes cambiar de plan en cualquier momento.",
                        it: "Puoi cambiare piano in qualsiasi momento."
                    )
                )
            )
        ),
        #previewVariant(
            "Individual Option Disabled with Helper Text",
            RadioGroupData(
                id: "group-5",
                name: "plan-5",
                label: LabelData(
                    id: "group-5",
                    title: tr(
                        "Plan",
                        de: "Tarif",
                        fr: "Forfait",
                        es: "Plan",
                        it: "Piano"
                    ),
                    isRequired: false
                ),
                selectedValue: "free",
                options: [
                    RadioData(
                        id: "plan-5-free",
                        label: tr(
                            "Free",
                            de: "Kostenlos",
                            fr: "Gratuit",
                            es: "Gratis",
                            it: "Gratuito"
                        ),
                        value: "free"
                    ),
                    RadioData(
                        id: "plan-5-pro",
                        label: tr(
                            "Pro",
                            de: "Pro",
                            fr: "Pro",
                            es: "Pro",
                            it: "Pro"
                        ),
                        value: "pro",
                        helperText: HelperTextData(
                            id: "plan-5-pro",
                            text: tr(
                                "Includes support.",
                                de: "Inklusive Support.",
                                fr: "Support inclus.",
                                es: "Incluye soporte.",
                                it: "Supporto incluso."
                            )
                        ),
                        state: .disabled
                    ),
                    RadioData(
                        id: "plan-5-team",
                        label: tr(
                            "Team",
                            de: "Team",
                            fr: "Équipe",
                            es: "Equipo",
                            it: "Team"
                        ),
                        value: "team"
                    ),
                ]
            )
        ),
        #previewVariant(
            "Entire Group Disabled",
            RadioGroupData(
                id: "group-6",
                name: "plan-6",
                label: LabelData(
                    id: "group-6",
                    title: tr(
                        "Plan",
                        de: "Tarif",
                        fr: "Forfait",
                        es: "Plan",
                        it: "Piano"
                    ),
                    isRequired: false
                ),
                selectedValue: "pro",
                options: plans("g6"),
                state: .disabled
            )
        ),
    ]

    func makeHtml(ctx: RadioGroupData) -> String {
        let html = renderFragments(RadioGroup(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("RadioGroup")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { RadioGroup(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
