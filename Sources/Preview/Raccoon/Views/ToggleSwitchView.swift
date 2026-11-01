import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ToggleSwitchView: TemplateRepresentable {

    let variants: [PreviewVariant<ToggleSwitchData>] = [
        #previewVariant(
            """
            // off (value = false)
            """,
            ToggleSwitchData(
                id: "ts-1",
                label: LabelData(
                    id: "ts-1",
                    title: "label"
                ),
                isSelected: false,
                size: .base,
                state: .enabled,
                apiURL: nil
            )
        ),
        #previewVariant(
            """
            // on (value = true) + disabled
            """,
            ToggleSwitchData(
                id: "ts-2",
                label: nil,
                isSelected: true,
                size: .base,
                state: .disabled,
                apiURL: nil
            )
        ),
        #previewVariant(
            """
            // on (value = true) + size:sm
            """,
            ToggleSwitchData(
                id: "ts-3",
                label: LabelData(
                    id: "ts-3",
                    title: "label",
                    position: .left
                ),
                isSelected: true,
                size: .sm,
                state: .enabled,
                apiURL: "some-api-url"
            )
        ),
        #previewVariant(
            """
            // on (value = true) + size:xl
            """,
            ToggleSwitchData(
                id: "ts-5",
                label: LabelData(
                    id: "ts-5",
                    title: "label",
                    position: .right
                ),
                isSelected: true,
                size: .xl,
                state: .enabled,
                apiURL: "some-api-url"
            )
        ),
    ]

    func makeHtml(ctx: ToggleSwitchData) -> String {
        let html = renderFragments(ToggleSwitch(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("ToggleSwitch")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { ToggleSwitch(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
