import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct AvatarView: TemplateRepresentable {

    let variants: [(String, AvatarData)] = [
        (
            """
            //
            """,
            AvatarData(
                firstName: "Andreas",
                lastName: "Soller",
                size: .sm
            )
        ),
        (
            """
            //
            """,
            AvatarData(
                firstName: "Andreas",
                lastName: "Soller",
                size: .base
            )
        ),
        (
            """
            //
            """,
            AvatarData(
                firstName: "Andreas",
                lastName: "Soller",
                size: .xl
            )
        ),
        (
            """
            //
            """,
            AvatarData(
                firstName: "Andreas"
            )
        ),
        (
            """
            // No name
            """,
            AvatarData()
        ),
        (
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

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { Avatar(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
