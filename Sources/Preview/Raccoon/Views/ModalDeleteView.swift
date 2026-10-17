import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ModalDeleteView: TemplateRepresentable {

    let variants: [(String, DeleteModalData)] = [
        (
            """
            // Default
            """,
            DeleteModalData(
                deletionRedirect: "/items",
                csrfToken: "tok_abc123"
            )
        ),
        (
            """
            // Second instance on the same page — must not share ids with the first
            """,
            DeleteModalData(
                deletionRedirect: "/records",
                csrfToken: "tok_def456"
            )
        ),
    ]

    func makeHtml(ctx: DeleteModalData) -> String {
        let html = renderFragments(DeleteModal(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("DeleteModal")

                Span {
                    ActionButton(
                        ActionButtonData(
                            id: "buttonOpenDeleteModal",
                            action: "/system/client-delete/uuid",
                            method: .post,
                            label: "Delete",
                            htmlType: .button,
                            buttonType: .warning,
                            contentTracker: MatomoContentTracker(
                                name: "client",
                                piece: "button.delete",
                                target: "/system/client-delete/uui"
                            )
                        )
                    )
                    .render()
                }
                .setAttribute(
                    name: "x-on:click",
                    value: "open = true"
                )
                .setAttribute(
                    name: "@click",
                    value: "$store.modal = true"
                )

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { DeleteModal(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")
            .setAttribute(
                name: "x-data",
                value: "{ open: false }"
            )

        }
        .render()

    }
}
