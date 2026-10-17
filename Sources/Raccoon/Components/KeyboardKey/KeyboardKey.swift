import HTML
import SGML
import SVG
import WebBuilders

public struct KeyboardKey: TemplateRepresentable {
    let data: KeyboardKeyData
    typealias styles = KeyboardKeyStyles

    public init(
        _ data: KeyboardKeyData
    ) {
        self.data = data
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Keyboard shortcut")
        Kbd {
            let iconSize = 14
            switch data.key {
            case .command:
                Svg.icon(.command, width: iconSize, height: iconSize)

            case .ctrl:
                Svg.icon(.chevron_up, width: iconSize, height: iconSize)

            case .cursorDown:
                Svg.icon(.caret_down_fill, width: iconSize, height: iconSize)

            case .cursorLeft:
                Svg.icon(.caret_left_fill, width: iconSize, height: iconSize)

            case .cursorRight:
                Svg.icon(.caret_right_fill, width: iconSize, height: iconSize)

            case .cursorUp:
                Svg.icon(.caret_up_fill, width: iconSize, height: iconSize)

            case .option:
                Svg.icon(.option, width: iconSize, height: iconSize)

            case .shift:
                Svg.icon(.shift, width: iconSize, height: iconSize)

            case .backspace:
                Svg.icon(.backspace, width: iconSize, height: iconSize)

            case .capslock:
                Svg.icon(.capslock, width: iconSize, height: iconSize)

            case .indent:
                Svg.icon(.indent, width: iconSize, height: iconSize)

            case .text(let value):
                // Inline Style intentionally set
                Span(value)
                    .style(
                        "min-width:\(iconSize)px; display:inline-block; text-align:center;"
                    )
            }
        }
        .class(
            "not-prose inline-flex size-min whitespace-nowrap items-center"
        )
        .addClass(styles.background)
        .addClass(styles.font)
        .addClass(styles.text)
        .if(data.hasBorder) {
            $0
                .addClass("p-1 h-full")
                .addClass(styles.border)
        }
        .if(data.key == .shift) {
            $0.ariaLabel("Shift key")
        }
        .if(data.key == .command) {
            $0.ariaLabel("Command key")
        }
        .if(data.key == .ctrl) {
            $0.ariaLabel("Control key")
        }
        .if(data.key == .command) {
            $0.ariaLabel("Command key")
        }
        .if(data.key == .option) {
            $0.ariaLabel("Option key")
        }
        .if(data.key == .cursorUp) {
            $0.ariaLabel("Cursor Up key")
        }
        .if(data.key == .cursorDown) {
            $0.ariaLabel("Cursor Down key")
        }
        .if(data.key == .cursorLeft) {
            $0.ariaLabel("Cursor Left key")
        }
        .if(data.key == .cursorRight) {
            $0.ariaLabel("Cursor Right key")
        }
        .if(data.key == .backspace) {
            $0.ariaLabel("Backspace key")
        }
        .if(data.key == .capslock) {
            $0.ariaLabel("Caps Lock key")
        }
        .if(data.key == .indent) {
            $0.ariaLabel("Tabulator key")
        }

    }
}
