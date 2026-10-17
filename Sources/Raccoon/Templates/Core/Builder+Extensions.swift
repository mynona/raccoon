import HTML
import SGML
import SVG
import WebBuilders


// Allows [Element] arrays inside @Builder<FlowContent> closures (Li, P, Td, Section, etc.)
// Filed as issue: swift-web-standards provides no bridge between Element and FlowContent.
extension Builder where Element == any FlowContent {
    public static func buildExpression(
        _ expression: [SGML.Element]
    ) -> [any FlowContent] {
        expression.compactMap { $0 as? any FlowContent }
    }
}

// Allows [Element] arrays inside @Builder<MetadataContent> closures (Head {}).
// Note: elements outside the metadata category are dropped, not rendered.
extension Builder where Element == any MetadataContent {
    public static func buildExpression(
        _ expression: [SGML.Element]
    ) -> [any MetadataContent] {
        expression.compactMap { $0 as? any MetadataContent }
    }
}


