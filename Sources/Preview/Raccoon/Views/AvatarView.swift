import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct AvatarView: TemplateRepresentable {

    let variants: [PreviewVariant<AvatarData>] = [
        #previewVariant(
            "Initials Small",
            AvatarData(
                firstName: "Andreas",
                lastName: "Soller",
                size: .sm
            )
        ),
        #previewVariant(
            "Initials Medium",
            AvatarData(
                firstName: "Andreas",
                lastName: "Soller",
                size: .base
            )
        ),
        #previewVariant(
            "Initials Extra Large",
            AvatarData(
                firstName: "Andreas",
                lastName: "Soller",
                size: .xl
            )
        ),
        #previewVariant(
            "Single Initial",
            AvatarData(
                firstName: "Andreas"
            )
        ),
        #previewVariant(
            "Placeholder Fallback",
            AvatarData()
        ),
        #previewVariant(
            "Image Picture",
            AvatarData(
                picture:
                    "https://avatars.githubusercontent.com/u/12345678?v=4"
            )
        ),
    ]

    func makeHtml(ctx: AvatarData) -> String {
        let html = renderFragments(Avatar(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Avatar")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Avatar(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
