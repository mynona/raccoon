import HTML
import SGML
import SVG
import WebBuilders

public struct Notification: TemplateRepresentable {
    let data: NotificationData
    typealias styles = NotificationStyles

    public init(
        _ data: NotificationData
    ) {
        self.data = data
    }

    func makeIcon() -> SvgIcon {
        switch data.type {
        case .error:
            return .exclamation_circle
        case .success:
            return .check_circle
        case .info:
            return .info_circle
        case .warning:
            return .exclamation_triangle
        }
    }

    private var textColor: String {
        switch data.type {
        case .error:
            return styles.textError
        case .warning:
            return styles.textWarning
        case .info:
            return styles.textInfo
        case .success:
            return styles.textSuccess
        }
    }

    private var containerClasses: String {
        switch data.type {
        case .error:
            return "\(styles.borderError) \(styles.backgroundColorError)"
        case .warning:
            return "\(styles.borderWarning) \(styles.backgroundColorWarning)"
        case .info:
            return "\(styles.borderInfo) \(styles.backgroundColorInfo)"
        case .success:
            return "\(styles.borderSuccess) \(styles.backgroundColorSuccess)"
        }
    }

    @Builder<Element>
    func showIcon() -> [Element] {
        Span {
            Svg.icon(makeIcon(), width: 20, height: 20)
        }
        .class("flex-initial")
        .addClass(textColor)
    }

    @Builder<Element>
    func showMessage() -> [Element] {
        Div {
            P(data.title)
                .class(styles.titleFont)

            if let text = data.text {
                Div { InlineText(renderMarkdownAsHTML(text), isRaw: true) }
                    .class("pt-2")
            }
        }
        .class("flex-initial")
        .addClass(styles.messageFont)
        .addClass(textColor)
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Notification")
        let isAlert = (data.type == .error || data.type == .warning)
        Div {
            showIcon()
            showMessage()
        }
        .role(isAlert ? "alert" : "status")
        .ariaLive(isAlert ? .assertive : .polite)
        .setAttribute(name: "aria-atomic", value: "true")
        .class("flex flex-row space-x-4 p-4")
        .addClass(containerClasses)

    }
}
