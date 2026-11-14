import Vapor

/// Dev policy for the preview app. It allows no inline script at all: a violation in the browser console
/// means a Raccoon component (or a preview page) renders an inline script. `'unsafe-eval'` is for Alpine,
/// unpkg.com for Mermaid.
struct SecurityHeadersMiddleware: AsyncMiddleware {
    func respond(to request: Request, chainingTo next: AsyncResponder)
        async throws -> Response
    {
        let response = try await next.respond(to: request)
        let policy =
            "default-src 'self';"
            + "script-src 'self' 'unsafe-eval' https://unpkg.com;"
            + "style-src 'self' 'unsafe-inline';"
            + "img-src 'self' data: blob: https:;"
            + "media-src 'self' https:;"
            + "font-src 'self';"
            + "object-src 'none';"
            + "base-uri 'self';"
            + "frame-ancestors 'none';"
            + "connect-src 'self' https://unpkg.com;"
        response.headers.replaceOrAdd(
            name: "Content-Security-Policy",
            value: policy
        )
        return response
    }
}
