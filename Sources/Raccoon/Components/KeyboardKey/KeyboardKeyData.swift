import SVG

public struct KeyboardKeyData: Sendable {

    public enum KbdKey: Codable, Equatable, Sendable {
        case shift
        case ctrl
        case command
        case option
        case cursorUp
        case cursorDown
        case cursorLeft
        case cursorRight
        case backspace
        case capslock
        case indent
        case text(String)

        var rawValue: String {
            switch self {
            case .shift: return "shift"
            case .ctrl: return "ctrl"
            case .command: return "command"
            case .option: return "option"
            case .cursorUp: return "cursorUp"
            case .cursorDown: return "cursorDown"
            case .cursorLeft: return "cursorLeft"
            case .cursorRight: return "cursorRight"
            case .backspace: return "backspace"
            case .capslock: return "capslock"
            case .indent: return "indent"  // tabulator key
            case .text(let value): return value
            }
        }

        init?(rawValue: String) {
            switch rawValue {
            case "shift": self = .shift
            case "ctrl": self = .ctrl
            case "command": self = .command
            case "option": self = .option
            case "cursorUp": self = .cursorUp
            case "cursorDown": self = .cursorDown
            case "cursorLeft": self = .cursorLeft
            case "cursorRight": self = .cursorRight
            case "backspace": self = .backspace
            case "capslock": self = .capslock
            case "indent": self = .indent  // tabulator key
            default: self = .text(rawValue)
            }
        }
    }

    public let key: KbdKey
    public let hasBorder: Bool

    /// Creates a new configuration instance for `KeyboardKey`.
    ///
    /// - Parameters:
    ///   - key: The keyboard key type or text representation to display.
    ///   - hasBorder: Whether to render an outlined border around the key.
    public init(
        key: KbdKey,
        hasBorder: Bool = true
    ) {
        self.key = key
        self.hasBorder = hasBorder
    }

}
