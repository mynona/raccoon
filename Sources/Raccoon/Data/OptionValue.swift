public struct OptionValue: Sendable, Encodable {
   public var title: String?
   public var value: String?
   public var selected: Bool
   public var friendly_url: String?

   public init(
      title: String? = nil,
      value: String? = nil,
      selected: Bool = false,
      friendly_url: String? = nil
   ) {
      self.title = title
      self.value = value
      self.selected = selected
      self.friendly_url = friendly_url
   }
}
