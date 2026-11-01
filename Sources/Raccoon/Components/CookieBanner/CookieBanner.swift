import HTML
import SGML
import WebBuilders

public struct CookieBanner: TemplateRepresentable {
    let data: CookieBannerData
    typealias styles = CookieBannerStyles

    private static let title = LocalizedText(
        "cookiebanner.title",
        "You decide"
    )
    private static let statistics = LocalizedText(
        "cookiebanner.statistics",
        "Statistics cookies"
    )
    private static let statisticsText = LocalizedText(
        "cookiebanner.statisticsText",
        " help me to improve this service. No data is shared with third parties."
    )
    private static let necessary = LocalizedText(
        "cookiebanner.necessary",
        "Necessary cookies"
    )
    private static let necessaryText = LocalizedText(
        "cookiebanner.necessaryText",
        " keep this website reliable and secure."
    )
    private static let privacyBefore = LocalizedText(
        "cookiebanner.privacyBefore",
        "You can change your cookie preferences anytime in the "
    )
    private static let privacyLink = LocalizedText(
        "cookiebanner.privacyLink",
        "Privacy Policy"
    )
    private static let privacyAfter = LocalizedText(
        "cookiebanner.privacyAfter",
        "."
    )
    private static let acceptAll = LocalizedText(
        "cookiebanner.acceptAll",
        "Accept all"
    )
    private static let decline = LocalizedText(
        "cookiebanner.decline",
        "Decline statistics"
    )
    private static let consent = LocalizedText(
        "cookiebanner.consent",
        "Cookie consent"
    )

    public init(
        _ data: CookieBannerData
    ) {
        self.data = data
    }

    @Builder<Element>
    func showDialogBodyText() -> [Element] {
        P(Self.title.resolved)
            .localized(Self.title)
            .class(styles.bodyTitle)

        Div {
            Ul {
                Li {
                    Span(Self.statistics.resolved)
                        .localized(Self.statistics)
                        .class("italic")
                    Span(Self.statisticsText.resolved)
                        .localized(Self.statisticsText)

                }
                Li {
                    Span(Self.necessary.resolved)
                        .localized(Self.necessary)
                        .class("italic")
                    Span(Self.necessaryText.resolved)
                        .localized(Self.necessaryText)
                }
            }
            .class("list-disc list-outside")
        }
        .class("pl-4 py-2")

        P {
            // The sentence is split around the link; each part is its own key so that
            // the word order of every language works
            Span(Self.privacyBefore.resolved)
                .localized(Self.privacyBefore)
            A(Self.privacyLink.resolved)
                .localized(Self.privacyLink)
                .href("/privacy-policy/")
                .class(
                    "p-1 \(HyperLinkStyles.underlined) \(HyperLinkStyles.link) \(HyperLinkStyles.focus)"
                )
            Span(Self.privacyAfter.resolved)
                .localized(Self.privacyAfter)
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
                        label: Self.acceptAll,
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
                        label: Self.decline,
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
                .localized(.ariaLabel, Self.consent)
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
