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

    /// The spoken name of a key. Characters and other text keys have none.
    static func ariaLabel(for key: KeyboardKeyData.KbdKey) -> LocalizedText? {
        switch key {
        case .shift: LocalizedText("keyboardkey.shift", "Shift key")
        case .command: LocalizedText("keyboardkey.command", "Command key")
        case .ctrl: LocalizedText("keyboardkey.ctrl", "Control key")
        case .option: LocalizedText("keyboardkey.option", "Option key")
        case .cursorUp: LocalizedText("keyboardkey.cursorUp", "Cursor Up key")
        case .cursorDown:
            LocalizedText("keyboardkey.cursorDown", "Cursor Down key")
        case .cursorLeft:
            LocalizedText("keyboardkey.cursorLeft", "Cursor Left key")
        case .cursorRight:
            LocalizedText("keyboardkey.cursorRight", "Cursor Right key")
        case .backspace: LocalizedText("keyboardkey.backspace", "Backspace key")
        case .capslock: LocalizedText("keyboardkey.capslock", "Caps Lock key")
        case .indent: LocalizedText("keyboardkey.indent", "Tabulator key")
        case .text: nil
        }
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
        .if(Self.ariaLabel(for: data.key) != nil) {
            $0.localized(.ariaLabel, Self.ariaLabel(for: data.key)!)
        }

    }
}
