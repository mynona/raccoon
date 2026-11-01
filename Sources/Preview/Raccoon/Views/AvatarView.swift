import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct AvatarView: TemplateRepresentable {

    let variants: [PreviewVariant<AvatarData>] = [
        #previewVariant(
            """
            //
            """,
            AvatarData(
                firstName: "Andreas",
                lastName: "Soller",
                size: .sm
            )
        ),
        #previewVariant(
            """
            //
            """,
            AvatarData(
                firstName: "Andreas",
                lastName: "Soller",
                size: .base
            )
        ),
        #previewVariant(
            """
            //
            """,
            AvatarData(
                firstName: "Andreas",
                lastName: "Soller",
                size: .xl
            )
        ),
        #previewVariant(
            """
            //
            """,
            AvatarData(
                firstName: "Andreas"
            )
        ),
        #previewVariant(
            """
            // No name
            """,
            AvatarData()
        ),
        #previewVariant(
            """
            //
            """,
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
