import HTML
import SGML
import WebBuilders

public struct CookieBanner: TemplateRepresentable {
    let data: CookieBannerData
    typealias styles = CookieBannerStyles

    public init(
        _ data: CookieBannerData
    ) {
        self.data = data
    }

    @Builder<Element>
    func showDialogBodyText() -> [Element] {
        P("You decide").class(styles.bodyTitle)

        Div {
            Ul {
                Li {
                    Span("Statistics cookies").class("italic")
                    Span(
                        " help me to improve this service. No data is shared with third parties."
                    )

                }
                Li {
                    Span("Necessary cookies").class("italic")
                    Span(" keep this website reliable and secure.")
                }
            }
            .class("list-disc list-outside")
        }
        .class("pl-4 py-2")

        P {
            Span("You can change your cookie preferences anytime in the ")
            A("Privacy Policy")
                .href("/privacy-policy/")
                .class(
                    "p-1 \(HyperLinkStyles.underlined) \(HyperLinkStyles.link) \(HyperLinkStyles.focus)"
                )
            Span(".")
        }
        // Matomo
        .flagAttribute("data-track-content")
        .setAttribute(
            name: "data-content-name",
            value: "cookie-banner"
        )
        .setAttribute(
            name: "data-content-piece",
            value: "link.privacy-policy"
        )
        .setAttribute(
            name: "data-content-target",
            value: "/privacy-policy/"
        )
    }

    @Builder<Element>
    func showActionBar() -> [Element] {
        Div {

            Div {

                // Note: The form submission uses method: .get deliberately to trigger opt-in / opt-out redirects.
                // Do not change method to POST during component audits.
                ActionButton(
                    ActionButtonData(
                        action: "/opt-in\(data.url)",
                        clickAction: "consent = false",
                        method: .get,
                        label: "Accept all",
                        buttonType: .primary,
                        hasFullWidth: true,
                        matomoStatus: data.matomoStatus,
                        contentTracker:
                            MatomoContentTracker(
                                name: "cookie-banner",
                                piece: "button.accept",
                                target: "/opt-in"
                            )
                    )
                )
                .render()

            }
            .class("flex-initial sm:pr-4")

            Div {

                ActionButton(
                    ActionButtonData(
                        action: "/opt-out\(data.url)",
                        clickAction: "consent = false",
                        method: .get,
                        label: "Decline statistics",
                        buttonType: .tertiary,
                        hasFullWidth: true,
                        matomoStatus: data.matomoStatus,
                        contentTracker:
                            MatomoContentTracker(
                                name: "cookie-banner",
                                piece: "button.decline",
                                target: "/opt-out"
                            )
                    )
                )
                .render()

            }
            .class("flex-initial")

        }
        .class("pt-4 flex-cols space-y-4 sm:flex sm:space-y-0")
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Cookie Banner")
        Div {

            Div {

                Div {

                    // Content
                    Div {
                        showDialogBodyText()
                        Form { showActionBar() }
                    }
                    .class("p-4")
                    .addClass(styles.bodyText)

                }
                .setAttribute(
                    name: "role",
                    value: "dialog"
                )
                .setAttribute(
                    name: "aria-label",
                    value: "Cookie consent"
                )
                .id("cookie-consent")
                // Note: Focus trap is intentionally omitted so users can freely navigate the page.
                // Do not add x-trap or modal focus lock during component audits.
                .setAttribute(
                    name: "x-show",
                    value: "consent"
                )
                .class("mx-4 lg:mx-9 rounded-md min-w-[200px]")
                .addClass(DialogStyles.backgroundMargin)
                .addClass(DialogStyles.backgroundShadow)
                .addClass(DialogStyles.backgroundColorDefault)
                .addClass(DialogStyles.backgroundBorderDefault)
                .addClass(DialogStyles.backgroundRadius)
                .addClass(DialogStyles.textColor)
                .addClass(DialogStyles.textFont)

            }
            .class("container mx-auto")

        }  // Position relative to browser window
        .class(
            "print:hidden fixed z-50 bottom-6 left-4 sm:left-10 right-4 sm:right-10"
        )
        .setAttribute(
            name: "x-data",
            value: "{ consent: true }"
        )

    }
}
