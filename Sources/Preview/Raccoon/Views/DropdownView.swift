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

    let variants: [(String, DropdownData)] = [
        (
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
        (
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
        (
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
        (
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
        (
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

                for (label, ctx) in variants {
                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div {
                            Dropdown(ctx).render()
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
