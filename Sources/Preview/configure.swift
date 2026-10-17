import HTML
import Raccoon
import SGML
import Vapor

func configure(_ app: Application) async throws {
    app.http.server.configuration.hostname = Environment.get("HOST") ?? "0.0.0.0"
    if let portString = Environment.get("PORT"), let port = Int(portString) {
        app.http.server.configuration.port = port
    } else {
        app.http.server.configuration.port = 8090
    }
    app.middleware.use(
        FileMiddleware(publicDirectory: app.directory.publicDirectory)
    )
    try routes(app)
}
