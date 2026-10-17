import SGML

extension TemplateRepresentable {

    /// Renders to a complete document string, or `nil` if the template produces no root element.
    public func renderString(
        type: DocType = .html,
        minify: Bool = true,
        indent: UInt8 = 4
    ) -> String? {
        guard let root = render().first else { return nil }
        return Document(type: type, root: root)
            .render(indent: minify ? 0 : indent)
    }

}
