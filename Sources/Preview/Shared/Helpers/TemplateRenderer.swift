import Raccoon
import SGML
import Vapor

/// Path of the request that is currently being rendered. The preview layout
/// (`Basic`) reads it to highlight the active sidebar entry and to build the page title.
enum PreviewRequest {
    @TaskLocal static var path: String = "/"
}

struct TemplateRenderer {

    let request: Request

    init(_ request: Request) {
        self.request = request
    }

    func renderHtml(
        _ template: TemplateRepresentable,
        minify: Bool = true,
        indent: UInt8 = 4
    ) -> Response {
        respond(
            render(template, type: .html, minify: minify, indent: indent),
            contentType: "text/html"
        )
    }

    private func render(
        _ template: TemplateRepresentable,
        type: DocType,
        minify: Bool,
        indent: UInt8
    ) -> String? {
        PreviewRequest.$path.withValue(request.url.path) {
            template.renderString(type: type, minify: minify, indent: indent)
        }
    }

    private func respond(_ body: String?, contentType: String) -> Response {
        guard let body else {
            return Response(status: .internalServerError)
        }
        return Response(
            status: .ok,
            headers: ["content-type": contentType],
            body: .init(string: body)
        )
    }
}

extension Request {
    var templates: TemplateRenderer { .init(self) }
}
