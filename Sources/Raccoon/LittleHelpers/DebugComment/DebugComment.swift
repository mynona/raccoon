import HTML
import SGML
import WebBuilders

/// Renders an HTML comment node during debug builds only.
///
/// In release builds (`#if !DEBUG`), this function compiles away to an empty
/// array of elements with zero allocations, zero DOM nodes, and zero serialized bytes.
@inline(__always)
@Builder<Element>
public func DebugComment(_ text: String) -> [Element] {
    #if DEBUG
    Comment(text)
    #endif
}
