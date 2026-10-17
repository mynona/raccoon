import HTML
import SGML
import WebBuilders

public protocol TemplateRepresentable {
    @Builder<Element>
    func render() -> [Element]
}
