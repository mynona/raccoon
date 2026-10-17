public struct PaginationItem: Sendable {

   public let title: String
   public let order: Int
   public let friendly_url: String
   public let selected: Bool

   public init(
      title: String,
      order: Int,
      friendly_url: String,
      selected: Bool = false
   ) {
      self.friendly_url = friendly_url
      self.order = order
      self.title = title
      self.selected = selected
   }
}
