import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct DropdownView: TemplateRepresentable {

    static let sampleOptions = [
        OptionValue(title: "Architecture & Systems", value: "arch"),
        OptionValue(title: "Product Thinking", value: "product"),
        OptionValue(title: "Design Systems", value: "design"),
        OptionValue(title: "Engineering Culture", value: "culture"),
    ]

    let variants: [PreviewVariant<DropdownData>] = [
        #previewVariant(
            """
            // Standard Enabled Dropdown with Pre-selected Value
            """,
            DropdownData(
                id: "topic_select",
                label: LabelData(id: "topic_select", title: "Topic"),
                value: "product",
                options: sampleOptions,
                helperText: HelperTextData(
                    id: "topic_helper",
                    text: "Choose the primary category for this publication."
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
                    title: "Required Category",
                    isRequired: true
                ),
                placeholderText: "Please choose a category...",
                options: sampleOptions,
                errorMessages: ErrorMessageData(
                    id: "required_topic",
                    errorMessages: [
                        "Please select a valid category before publishing."
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
                        title: "Author (from SingleSelectData)"
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
                    title: "Locked Field"
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
                    title: "Published Category"
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
