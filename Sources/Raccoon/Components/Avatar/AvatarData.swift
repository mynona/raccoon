/// Configuration data for the `Avatar` component.
public struct AvatarData: Sendable {

    public let firstName: String?
    public let lastName: String?
    public let picture: String?
    public let size: ComponentSize

    /// Creates a new configuration instance for `Avatar`.
    ///
    /// - Parameters:
    ///   - firstName: Optional first name used for initials fallback.
    ///   - lastName: Optional last name used for initials fallback.
    ///   - picture: Optional image URL for the avatar picture.
    ///   - size: Display size of the avatar (`ComponentSize`).
    public init(
        firstName: String? = nil,
        lastName: String? = nil,
        picture: String? = nil,
        size: ComponentSize = .base
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.picture = picture
        self.size = size
    }

}
