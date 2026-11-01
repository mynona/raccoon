import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct DropdownView: TemplateRepresentable {

    static let sampleOptions = [
        OptionValue(
            title: tr(
                "Architecture & Systems",
                de: "Architektur & Systeme",
                fr: "Architecture et systèmes",
                es: "Arquitectura y sistemas",
                it: "Architettura e sistemi"
            ),
            value: "arch"
        ),
        OptionValue(
            title: tr(
                "Product Thinking",
                de: "Produktdenken",
                fr: "Réflexion produit",
                es: "Pensamiento de producto",
                it: "Pensiero di prodotto"
            ),
            value: "product"
        ),
        OptionValue(
            title: tr(
                "Design Systems",
                de: "Designsysteme",
                fr: "Systèmes de design",
                es: "Sistemas de diseño",
                it: "Design system"
            ),
            value: "design"
        ),
        OptionValue(
            title: tr(
                "Engineering Culture",
                de: "Engineering-Kultur",
                fr: "Culture d'ingénierie",
                es: "Cultura de ingeniería",
                it: "Cultura ingegneristica"
            ),
            value: "culture"
        ),
    ]

    let variants: [PreviewVariant<DropdownData>] = [
        #previewVariant(
            """
            // Standard Enabled Dropdown with Pre-selected Value
            """,
            DropdownData(
                id: "topic_select",
                label: LabelData(
                    id: "topic_select",
                    title: tr(
                        "Topic",
                        de: "Thema",
                        fr: "Sujet",
                        es: "Tema",
                        it: "Argomento"
                    )
                ),
                value: "product",
                options: sampleOptions,
                helperText: HelperTextData(
                    id: "topic_helper",
                    text: tr(
                        "Choose the primary category for this publication.",
                        de:
                            "Wähle die Hauptkategorie für diese Veröffentlichung.",
                        fr:
                            "Choisissez la catégorie principale de cette publication.",
                        es: "Elige la categoría principal de esta publicación.",
                        it:
                            "Scegli la categoria principale per questa pubblicazione."
                    )
                )
            )
        ),
        #previewVariant(
            """
            // Dropdown with Validation Error
            """,
            DropdownData(
                id: "required_topic",
                label: LabelData(
                    id: "required_topic",
                    title: tr(
                        "Required Category",
                        de: "Erforderliche Kategorie",
                        fr: "Catégorie obligatoire",
                        es: "Categoría obligatoria",
                        it: "Categoria obbligatoria"
                    ),
                    isRequired: true
                ),
                placeholderText: tr(
                    "Please choose a category...",
                    de: "Bitte wähle eine Kategorie …",
                    fr: "Veuillez choisir une catégorie…",
                    es: "Elige una categoría…",
                    it: "Scegli una categoria…"
                ),
                options: sampleOptions,
                errorMessages: ErrorMessageData(
                    id: "required_topic",
                    errorMessages: [
                        tr(
                            "Please select a valid category before publishing.",
                            de:
                                "Bitte wähle vor der Veröffentlichung eine gültige Kategorie.",
                            fr:
                                "Veuillez sélectionner une catégorie valide avant de publier.",
                            es:
                                "Selecciona una categoría válida antes de publicar.",
                            it:
                                "Seleziona una categoria valida prima di pubblicare."
                        )
                    ]
                )
            )
        ),
        #previewVariant(
            """
            // Initialized Directly from SingleSelectData (Drop-in Interchangeable)
            """,
            DropdownData(
                SingleSelectData(
                    id: "author_single_select",
                    label: LabelData(
                        id: "author_single_select",
                        title: tr(
                            "Author (from SingleSelectData)",
                            de: "Autor (aus SingleSelectData)",
                            fr: "Auteur (depuis SingleSelectData)",
                            es: "Autor (desde SingleSelectData)",
                            it: "Autore (da SingleSelectData)"
                        )
                    ),
                    value: "arch",
                    options: sampleOptions,
                    state: .enabled
                )
            )
        ),
        #previewVariant(
            """
            // Disabled State
            """,
            DropdownData(
                id: "disabled_dropdown",
                label: LabelData(
                    id: "disabled_dropdown",
                    title: tr(
                        "Locked Field",
                        de: "Gesperrtes Feld",
                        fr: "Champ verrouillé",
                        es: "Campo bloqueado",
                        it: "Campo bloccato"
                    )
                ),
                value: "design",
                options: sampleOptions,
                state: .disabled
            )
        ),
        #previewVariant(
            """
            // Info State (Read-only Summary)
            """,
            DropdownData(
                id: "info_dropdown",
                label: LabelData(
                    id: "info_dropdown",
                    title: tr(
                        "Published Category",
                        de: "Veröffentlichte Kategorie",
                        fr: "Catégorie publiée",
                        es: "Categoría publicada",
                        it: "Categoria pubblicata"
                    )
                ),
                value: "culture",
                options: sampleOptions,
                state: .info
            )
        ),
    ]

    func makeHtml(ctx: DropdownData) -> String {
        let html = renderFragments(Dropdown(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {
        Basic(title: "Dropdown") {
            Div {
                showComponentTitle("Dropdown")

                for variant in variants {
                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div {
                            Dropdown(variant.data).render()
                        }
                        .class("mb-32 mt-4 max-w-md")
                    }
                }
            }
            .class("mt-4 space-y-6")
        }
        .render()
    }
}
