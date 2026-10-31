public struct OptionValue: Sendable, Encodable {
   public var title: String?
   public var value: String?
   public var selected: Bool
   public var friendly_url: String?
   /// Optional language of the title (BCP 47 code), rendered as `lang` attribute so screen readers pronounce it correctly.
   public var lang: String?

   public init(
      title: String? = nil,
      value: String? = nil,
      selected: Bool = false,
      friendly_url: String? = nil,
      lang: String? = nil
   ) {
      self.title = title
      self.value = value
      self.selected = selected
      self.friendly_url = friendly_url
      self.lang = lang
   }
}
