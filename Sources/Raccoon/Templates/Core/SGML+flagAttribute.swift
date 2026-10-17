import HTML
import SGML
import SVG

/// Replicates the old `flagAttribute` behavior from swift-html.
/// Renders `<tag name>` (boolean/flag attribute) when `name` is non-empty,
/// and does nothing when `name` is empty (attribute is absent).
extension SGML.Attributes where Self: SGML.Mutable {
    public func flagAttribute(_ name: String) -> Self {
        guard !name.isEmpty else { return self }
        return setAttribute(name: name, value: nil)
    }
}
