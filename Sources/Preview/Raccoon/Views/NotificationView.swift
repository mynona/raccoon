import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct NotificationView: TemplateRepresentable {

    let variants: [(String, NotificationData)] = [
        (
            """
            // Info (no text)
            """,
            NotificationData(
                title: "Info title",
                text: nil,
                type: .info
            )
        ),
        (
            """
            // Info (with text)
            """,
            NotificationData(
                title: "Info title",
                text: "Some **detail** here.",
                type: .info
            )
        ),
        (
            """
            // Success
            """,
            NotificationData(
                title: "All done!",
                text: "Your changes were saved.",
                type: .success
            )
        ),
        (
            """
            // Warning
            """,
            NotificationData(
                title: "Watch out",
                text: "This action cannot be undone.",
                type: .warning
            )
        ),
        (
            """
            // Error
            """,
            NotificationData(
                title: "Something went wrong",
                text: "Please try again later.",
                type: .error
            )
        ),
    ]

    func makeHtml(ctx: NotificationData) -> String {
        let html = renderFragments(Notification(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Notification")

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { Notification(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
