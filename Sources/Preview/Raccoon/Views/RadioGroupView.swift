import HTML
import Raccoon
import SGML
import WebBuilders

struct RadioGroupView: TemplateRepresentable {

    /// Option ids must be unique on the page, so every group gets its own prefix.
    private static func plans(_ prefix: String) -> [RadioData] {
        [
            RadioData(id: "\(prefix)-free", label: "Free", value: "free"),
            RadioData(id: "\(prefix)-pro", label: "Pro", value: "pro"),
            RadioData(id: "\(prefix)-team", label: "Team", value: "team"),
        ]
    }

    let variants: [(String, RadioGroupData)] = [
        (
            """
            // No selection
            """,
            RadioGroupData(
                id: "group-1",
                name: "plan-1",
                label: LabelData(id: "group-1", title: "Plan", isRequired: false),
                options: plans("g1")
            )
        ),
        (
            """
            // Preselected, required legend
            """,
            RadioGroupData(
                id: "group-2",
                name: "plan-2",
                label: LabelData(id: "group-2", title: "Plan"),
                selectedValue: "pro",
                options: plans("g2")
            )
        ),
        (
            """
            // Helper text
            """,
            RadioGroupData(
                id: "group-3",
                name: "plan-3",
                label: LabelData(id: "group-3", title: "Plan", isRequired: false),
                selectedValue: "free",
                options: plans("g3"),
                helperText: HelperTextData(
                    id: "group-3",
                    text: "You can change your plan at any time."
                )
            )
        ),
        (
            """
            // Group error
            """,
            RadioGroupData(
                id: "group-4",
                name: "plan-4",
                label: LabelData(id: "group-4", title: "Plan"),
                options: plans("g4"),
                errorMessages: ErrorMessageData(
                    id: "group-4",
                    errorMessages: ["Select a plan."],
                    hasIcon: true
                ),
                helperText: HelperTextData(
                    id: "group-4",
                    text: "You can change your plan at any time."
                )
            )
        ),
        (
            """
            // One option disabled, option helper text
            """,
            RadioGroupData(
                id: "group-5",
                name: "plan-5",
                label: LabelData(id: "group-5", title: "Plan", isRequired: false),
                selectedValue: "free",
                options: [
                    RadioData(id: "plan-5-free", label: "Free", value: "free"),
                    RadioData(
                        id: "plan-5-pro",
                        label: "Pro",
                        value: "pro",
                        helperText: HelperTextData(id: "plan-5-pro", text: "Includes support."),
                        state: .disabled
                    ),
                    RadioData(id: "plan-5-team", label: "Team", value: "team"),
                ]
            )
        ),
        (
            """
            // Whole group disabled
            """,
            RadioGroupData(
                id: "group-6",
                name: "plan-6",
                label: LabelData(id: "group-6", title: "Plan", isRequired: false),
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

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { RadioGroup(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
