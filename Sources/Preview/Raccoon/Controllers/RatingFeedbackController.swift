import Foundation
import Vapor

/// Simulates the server side of the rating widget, in the same shape as the blog's
/// `FeedbackViewController.sendFeedbackArticle`: `post` decodes `id` (UUID), `rating` and the optional
/// `feedback`, answers `400` when a required field is missing or invalid and otherwise keeps the
/// feedback. `get` lists what was collected, so a test can check what the widget has sent.
public struct RatingFeedbackController: RouteCollection, Sendable {

    public init() {}

    public func boot(routes: RoutesBuilder) throws {
        let feedback = routes.grouped("preview", "rating-feedback")
        feedback.post(use: post)
        feedback.get(use: list)
        feedback.delete(use: clear)
    }

    /// What the widget sends. `feedback` is optional on the server, the widget asks for 5 characters.
    struct Dto: Content {
        let id: UUID
        let rating: Int
        let feedback: String?
    }

    struct Entry: Content {
        let id: UUID
        let rating: Int
        let feedback: String
        let receivedAt: Date
    }

    actor Store {
        static let shared = Store()
        private var entries: [Entry] = []

        func add(_ entry: Entry) { entries.append(entry) }
        func all() -> [Entry] { entries }
        func clear() { entries.removeAll() }
    }

    @Sendable
    func post(_ request: Request) async throws -> Response {
        guard let data = try? request.content.decode(Dto.self) else {
            throw Abort(
                .badRequest,
                reason:
                    "Missing or invalid required feedback fields (id, rating)."
            )
        }
        let entry = Entry(
            id: data.id,
            rating: data.rating,
            feedback: data.feedback ?? "",
            receivedAt: Date()
        )
        await Store.shared.add(entry)
        request.logger.info("Feedback received: \(entry)")
        return try await entry.encodeResponse(for: request)
    }

    @Sendable
    func list(_ request: Request) async throws -> [Entry] {
        await Store.shared.all()
    }

    @Sendable
    func clear(_ request: Request) async throws -> HTTPStatus {
        await Store.shared.clear()
        return .noContent
    }
}
