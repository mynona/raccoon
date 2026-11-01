public struct OptionValue: Sendable, Encodable {
   public var title: LocalizedText?
   public var value: String?
   public var selected: Bool
   public var friendly_url: String?
   /// Optional language of the title (BCP 47 code), rendered as `lang` attribute so screen readers pronounce it correctly.
   public var lang: String?

   public init(
      title: LocalizedText? = nil,
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

   private enum CodingKeys: String, CodingKey {
      case title, value, selected, friendly_url, lang
   }

   /// The title is encoded in the language of the page that is rendered (the JSON goes into Alpine state).
   public func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)
      try container.encodeIfPresent(title?.resolved, forKey: .title)
      try container.encodeIfPresent(value, forKey: .value)
      try container.encode(selected, forKey: .selected)
      try container.encodeIfPresent(friendly_url, forKey: .friendly_url)
      try container.encodeIfPresent(lang, forKey: .lang)
   }
}
