import HTML
import Raccoon
import SGML
import Vapor

public struct SearchFieldController: RouteCollection, Sendable {

    public init() {}

    public func boot(routes: RoutesBuilder) throws {
        let preview = routes.grouped("preview")
        preview.get("search-field", use: getSearchField)
    }

    @Sendable
    func getSearchField(_ request: Request) async throws -> Response {
        request.templates.renderHtml(SearchFieldView())
    }
}
