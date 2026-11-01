import HTML
import SGML
import SVG
import WebBuilders

public struct DeleteModal: TemplateRepresentable {
    let data: DeleteModalData
    typealias styles = DeleteModalStyles

    private static let close = LocalizedText(
        "deletemodal.close",
        "Close delete dialog"
    )
    private static let title = LocalizedText("deletemodal.title", "Delete")
    private static let confirm = LocalizedText(
        "deletemodal.confirm",
        "Are you sure you want to delete this item?"
    )
    private static let warning = LocalizedText(
        "deletemodal.warning",
        "This action cannot be undone and all data will be irrevocably deleted."
    )
    private static let yes = LocalizedText(
        "deletemodal.yes",
        "Yes, delete"
    )
    private static let cancel = LocalizedText(
        "deletemodal.cancel",
        "Cancel"
    )

    public init(
        _ data: DeleteModalData
    ) {
        self.data = data
    }

    @Builder<Element>
    func showCloseButton() -> [Element] {
        Div {

            ActionButton(
                ActionButtonData(
                    action: nil,
                    bindAction: nil,
                    clickAction: "open = false, $store.modal = false",
                    method: nil,
                    label: nil,
                    ariaLabel: Self.close,
                    tooltip: nil,
                    tooltipPosition: nil,
                    htmlType: .button,
                    buttonType: .icon,
                    state: .enabled,
                    size: .xl,
                    hasFullWidth: false,
                    icon: .x_lg,
                    iconPosition: .left,
                    contentTracker: MatomoContentTracker(
                        name: "delete-modal",
                        piece: "close-button",
                        target: ""
                    )
                )
            )
            .render()
        }
        .class(DialogStyles.closeButtonAbsolutePosition)
    }

    @Builder<Element>
    func showDialogTitle() -> [Element] {
        Div {
            Span { Svg.icon(.exclamation_triangle, width: 24, height: 24) }
                .class("flex-initial")

            H2(Self.title.resolved)
                .localized(Self.title)
                .setAttribute(
                    name: ":id",
                    value: "$id('modal-title')"
                )
                .class("flex-initial")

        }
        .class("flex items-center space-x-4")
        .addClass(DialogStyles.title)

    }

    @Builder<Element>
    func showDialogBody() -> [Element] {
        Div {
            P(Self.confirm.resolved)
                .localized(Self.confirm)
                .addClass(styles.textColor)
            // One key for the whole sentence: the word order differs between languages
            P(Self.warning.resolved)
                .localized(Self.warning)
                .class("pt-4")
                .addClass(styles.textColor)
        }
        .class("mt-4 pr-4")

    }

    @Builder<Element>
    func showActionBar() -> [Element] {
        Div {

            Div {
                ActionButton(
                    ActionButtonData(
                        action: data.deletionRedirect,
                        method: .post,
                        label: Self.yes,
                        htmlType: .submit,
                        buttonType: .warning,
                        contentTracker: MatomoContentTracker(
                            name: "delete-modal",
                            piece: "button.delete",
                            target: ""
                        )
                    )
                )
                .render()
            }
            .class("flex-initial")

            Div {
                ActionButton(
                    ActionButtonData(
                        action: "",
                        method: .get,
                        label: Self.cancel,
                        htmlType: .button,
                        buttonType: .secondary,
                        contentTracker: MatomoContentTracker(
                            name: "delete-modal",
                            piece: "button.cancel",
                            target: ""
                        )
                    )
                )
                .render()
            }
            .class("flex-initial")

        }
        .class("flex space-x-4 pt-8")
        .setAttribute(
            name: "x-on:click",
            value: "open = false, $store.modal = false"
        )
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Delete modal")
        Script()
            .src("/js/modal.js")
            .setAttribute(
                name: "type",
                value: "text/javascript"
            )
        Div {
            // Overlay
            Div {}
                .setAttribute(
                    name: "x-show",
                    value: "open"
                )
                .flagAttribute("x-transition.opacity")
                .class(styles.backdrop)

            // Dialog
            Div {
                Div {
                    showCloseButton()
                    showDialogTitle()
                    showDialogBody()

                    Form {

                        // MARK: csrf
                        HiddenField(
                            HiddenFieldData(
                                id: "X-CSRF-Token",
                                value: data.csrfToken,
                                state: .enabled
                            )
                        )
                        .render()

                        showActionBar()

                    }
                    .action(data.deletionRedirect)
                    .method(.post)
                    .flagAttribute("novalidate")

                }
                .flagAttribute("x-on:click.stop")
                .setAttribute(
                    name: "x-trap.noscroll.inert",
                    value: "open"
                )
                .class(
                    """
                    relative z-100 inset-x-0 mx-auto w-full max-w-2xl overflow-y-auto
                    """
                )
                .addClass(DialogStyles.backgroundColorWarning)
                .addClass(DialogStyles.backgroundBorderWarning)
                .addClass(DialogStyles.backgroundShadow)
                .addClass(DialogStyles.backgroundRadius)
                .addClass(DialogStyles.backgroundMargin)
                .addClass(DialogStyles.backgroundPadding)
                .addClass(DialogStyles.textFont)
                .addClass(styles.textColor)

            }
            .setAttribute(
                name: "x-show",
                value: "open"
            )
            .flagAttribute("x-transition")
            .setAttribute(
                name: "x-on:click",
                value: "open = false, $store.modal = false"
            )
            .class(
                "z-10 fixed flex min-h-screen items-center container mx-auto w-full p-4"
            )

        }
        .setAttribute(
            name: "x-show",
            value: "open"
        )
        .setAttribute(
            name: "x-on:keydown.escape.prevent.stop",
            value: "open = false"
        )
        .setAttribute(
            name: "role",
            value: "dialog"
        )
        .setAttribute(
            name: "aria-modal",
            value: "true"
        )
        .setAttribute(
            name: "x-id",
            value: "['modal-title']"
        )
        .setAttribute(
            name: ":aria-labelledby",
            value: "$id('modal-title')"
        )
        .flagAttribute("x-cloak")
        .class("absolute inset-0 overflow-y-auto")
    }
}
