/// A Matomo event reported by the tracker script together with the page view.
public struct MatomoEvent: Sendable, Equatable {

    public let category: String
    public let action: String
    public let name: String?

    public init(category: String, action: String, name: String? = nil) {
        self.category = category
        self.action = action
        self.name = name
    }
}
