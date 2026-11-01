import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ModalDeleteView: TemplateRepresentable {

    let variants: [PreviewVariant<DeleteModalData>] = [
        #previewVariant(
            "Standard Confirmation Dialog",
            DeleteModalData(
                deletionRedirect: "/items",
                csrfToken: "tok_abc123"
            )
        ),
        #previewVariant(
            "Second Independent Modal Instance",
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
                            label: tr(
                                "Delete",
                                de: "Löschen",
                                fr: "Supprimer",
                                es: "Eliminar",
                                it: "Elimina"
                            ),
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

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { DeleteModal(variant.data).render() }
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
