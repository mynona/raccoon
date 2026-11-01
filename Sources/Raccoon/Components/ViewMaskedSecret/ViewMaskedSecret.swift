import DOM
import HTML
import SGML
import SVG
import WebBuilders

/// A reusable UI component that displays a secret string in masked form,
/// with the ability to temporarily reveal it. Copying is delegated to
/// the `CopyToClipboard` component.
/// > Important: This component provides **visual obfuscation** (e.g., protection
/// > against shoulder-surfing or accidental screen-share exposure). The secret
/// > is encoded in the client-side DOM payload and can be inspected via browser
/// > developer tools. Do not use this component to protect secrets from users who
/// > should not have access to the raw value. For zero-trust secrets, use
/// > an authenticated on-demand API fetch pattern.
public struct ViewMaskedSecret: TemplateRepresentable {
    let data: ViewMaskedSecretData
    typealias styles = ViewMaskedSecretStyles
    typealias buttonStyles = ActionButtonStyles

    public init(
        _ data: ViewMaskedSecretData
    ) {
        self.data = data
    }

    private static let hide = LocalizedText(
        "viewmaskedsecret.hide",
        "Hide secret"
    )
    private static let show = LocalizedText(
        "viewmaskedsecret.show",
        "Show secret"
    )
    private static let toggle = LocalizedText(
        "viewmaskedsecret.toggle",
        "Show/Hide secret"
    )

    @Builder<Element>
    func showRevealHideButton() -> [Element] {
        // MARK: reveal button (eye / eye-slash)
        Button {
            Span { Svg.icon(.eye_slash) }
                .setAttribute(
                    name: "x-show",
                    value: "!visible"
                )
                .setAttribute(
                    name: "class",
                    value: "w-5 h-5"
                )

            Span { Svg.icon(.eye) }
                .setAttribute(
                    name: "x-show",
                    value: "visible"
                )
                .setAttribute(
                    name: "class",
                    value: "w-5 h-5"
                )
        }
        .class("p-1")
        .addClass(buttonStyles.iconButton)
        .setAttribute(
            name: "@click",
            value: "toggleReveal()"
        )
        .setAttribute(
            name: ":aria-label",
            value:
                "visible ? \(Self.hide.alpineExpression) : \(Self.show.alpineExpression)"
        )
        .setAttribute(
            name: ":aria-pressed",
            value: "visible"
        )
        .localized(.title, Self.toggle)
    }

    @Builder<Element>
    func showCopyToClipboardButton() -> [Element] {
        // MARK: Copy button (delegated)
        if data.hasCopyToClipboard {
            // CopyToClipboard HTML-escapes its own attribute values, so pass the raw secret.
            CopyToClipboard(
                CopyToClipboardData(
                    value: data.secret,
                    orientation: .horizontal
                )
            )
            .render()
        }
    }

    @Builder<Element>
    func showSecret() -> [Element] {
        Span {}
            .class(styles.fontMono)
            .addClass(styles.textColorInput)
            .setAttribute(
                name: "x-text",
                value: "visible ? secret : maskedSecret"
            )
    }

    @Builder<Element>
    public func render() -> [Element] {

        let valueBase64 = (data.secret)
            .data(using: .utf8)!
            .base64EncodedString()

        DebugComment("Masked value")
        Div {
            Div {
                showSecret()
                showRevealHideButton()
                showCopyToClipboardButton()
            }
            .class("flex items-center space-x-4 mt-2")
        }
        .setAttribute(
            name: "x-data",
            value:
                "maskedSecret('\(valueBase64)', \(data.revealCount), \(data.revealDuration))"
        )
        .setAttribute(
            name: "x-init",
            value: "init()"
        )
        Script()
            .src("/js/view-masked.js")
            .setAttribute(name: "type", value: "text/javascript")
    }
}
