func prettySwift<T>(_ value: T) -> String {

    func escapeHTML(_ s: String) -> String {
        s.replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "\"", with: "&quot;")
    }

    let mirror = Mirror(reflecting: value)
    var lines: [String] = []

    for child in mirror.children {
        guard let label = child.label else { continue }
        let v = child.value

        switch v {
        case let s as String:
            lines.append("    \(label): \"\(escapeHTML(s))\"")

        case let opt as String?:
            if let s = opt {
                lines.append("    \(label): \"\(escapeHTML(s))\"")
            }
            else {
                lines.append("    \(label): nil")
            }

        case let e as any RawRepresentable:
            // Enum detected — add leading dot
            lines.append("    \(label): .\(e.rawValue)")

        default:
            lines.append("    \(label): \(v)")
        }
    }

    return "\(mirror.subjectType)(" + "\n" + lines.joined(separator: ",\n")
        + "\n)"
}
