import Raccoon
import SGML
import Vapor

/// Path of the request that is currently being rendered. The preview layout
/// (`Basic`) reads it to highlight the active sidebar entry and to build the page title.
enum PreviewRequest {
    @TaskLocal static var path: String = "/"
    @TaskLocal static var lang: String = "en"

    /// Language codes with the name of each language written in that language.
    static let languages: [(code: String, name: String)] = [
        ("en", "English"), ("de", "Deutsch"), ("fr", "Français"),
        ("es", "Español"), ("it", "Italiano"), ("pt", "Português"),
        ("nl", "Nederlands"), ("lb", "Lëtzebuergesch"), ("da", "Dansk"),
        ("sv", "Svenska"), ("nb", "Norsk bokmål"), ("fi", "Suomi"),
        ("is", "Íslenska"), ("el", "Ελληνικά"), ("tr", "Türkçe"),
        ("hu", "Magyar"), ("hr", "Hrvatski"), ("pl", "Polski"),
        ("sk", "Slovenčina"), ("cs", "Čeština"),
    ]

    static let supportedLanguages = languages.map(\.code)
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
        let response = respond(
            render(template, type: .html, minify: minify, indent: indent),
            contentType: "text/html"
        )
        // `?lang=de` is remembered for the following pages.
        if let lang = requestedLanguage() {
            response.cookies["preview-lang"] = .init(string: lang, path: "/")
        }
        return response
    }

    private func requestedLanguage() -> String? {
        guard let lang = request.query[String.self, at: "lang"],
            PreviewRequest.supportedLanguages.contains(lang)
        else { return nil }
        return lang
    }

    private func resolvedLanguage() -> String {
        if let lang = requestedLanguage() { return lang }
        if let saved = request.cookies["preview-lang"]?.string,
            PreviewRequest.supportedLanguages.contains(saved)
        {
            return saved
        }
        return "en"
    }

    private func render(
        _ template: TemplateRepresentable,
        type: DocType,
        minify: Bool,
        indent: UInt8
    ) -> String? {
        let language = resolvedLanguage()
        return PreviewRequest.$lang.withValue(language) {
            I18n.render(language: language, collectsUsedKeys: true) {
                PreviewRequest.$path.withValue(request.url.path) {
                    template.renderString(
                        type: type,
                        minify: minify,
                        indent: indent
                    )
                }
            }
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
