import Foundation

public enum FieldValidationType: Sendable {
    case firstLastName
    /// RFC 5322
    case email
    case url
    case integer
    /// must have 2 decimal numbers
    case amount
    /// leading plus sign, followed by 7 to 15 digits, allowing optional spaces, hyphens, or parentheses.
    case phoneNumber
    case ip4vAddress
    case friendlyUrl
    case custom(pattern: String, message: LocalizedText)

    private static func isValidRegex(_ pattern: String) -> Bool {
        do {
            _ = try NSRegularExpression(pattern: pattern)
            return true
        }
        catch {
            return false
        }
    }

    public var regex: String {
        switch self {
        case .firstLastName:
            return
                #"^(?=.{2,}$)[A-Za-zÀ-ÖØ-öø-ÿ]+(?:[ '-][A-Za-zÀ-ÖØ-öø-ÿ]+)*$"#
        case .email:
            return #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,63}$"#
        case .url:
            return
                #"^(?=.{1,253}$)https?:\/\/([A-Za-z0-9-]{1,63}\.)+[A-Za-z]{2,63}(\/\S*)?$"#
        case .integer:
            return #"^\d+$"#
        case .amount:
            return #"^\d+\.\d{2,}$"#
        case .phoneNumber:
            return #"^\+[1-9]\d{7,14}$"#
        case .ip4vAddress:
            return
                #"^((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$"#
        case .friendlyUrl:
            return #"^(?=.{3,}$)[a-z]+(-[a-z]+)*$"#
        case .custom(let pattern, _):
            if !Self.isValidRegex(pattern) || pattern.isEmpty { return "" }
            return pattern
        }
    }

    /// The message for an invalid value, as a built-in text in the page language. With a label title the
    /// message starts with it ("Email is not a valid email address."), without one it starts with "This".
    public func errorMessage(labelTitle: LocalizedText?) -> LocalizedText {
        let label = labelTitle?.resolved
        let hasLabel = label?.isEmpty == false
        switch self {
        case .firstLastName:
            return hasLabel
                ? LocalizedText(
                    "fieldvalidation.firstLastNameWithLabel",
                    "{{label}} has less than 2 valid characters (no spaces at the start or end).",
                    variables: ["label": label ?? ""]
                )
                : LocalizedText(
                    "fieldvalidation.firstLastName",
                    "Must have at least 2 valid characters (no spaces at the start or end)."
                )
        case .email:
            return hasLabel
                ? LocalizedText(
                    "fieldvalidation.emailWithLabel",
                    "{{label}} is not a valid email address.",
                    variables: ["label": label ?? ""]
                )
                : LocalizedText(
                    "fieldvalidation.email",
                    "This is not a valid email address."
                )
        case .url:
            return hasLabel
                ? LocalizedText(
                    "fieldvalidation.urlWithLabel",
                    "{{label}} is not a valid URL starting with http:// or https://.",
                    variables: ["label": label ?? ""]
                )
                : LocalizedText(
                    "fieldvalidation.url",
                    "This is not a valid URL starting with http:// or https://."
                )
        case .integer:
            return hasLabel
                ? LocalizedText(
                    "fieldvalidation.integerWithLabel",
                    "{{label}} is not a valid integer number.",
                    variables: ["label": label ?? ""]
                )
                : LocalizedText(
                    "fieldvalidation.integer",
                    "This is not a valid integer number."
                )
        case .amount:
            return hasLabel
                ? LocalizedText(
                    "fieldvalidation.amountWithLabel",
                    "{{label}} is not a valid amount with 2 decimal numbers.",
                    variables: ["label": label ?? ""]
                )
                : LocalizedText(
                    "fieldvalidation.amount",
                    "This is not a valid amount with 2 decimal numbers."
                )
        case .phoneNumber:
            return hasLabel
                ? LocalizedText(
                    "fieldvalidation.phoneNumberWithLabel",
                    "{{label}} is not a valid phone number (E.164 standard).",
                    variables: ["label": label ?? ""]
                )
                : LocalizedText(
                    "fieldvalidation.phoneNumber",
                    "This is not a valid phone number (E.164 standard)."
                )
        case .ip4vAddress:
            return hasLabel
                ? LocalizedText(
                    "fieldvalidation.ip4vAddressWithLabel",
                    "{{label}} is not a valid IPv4 address.",
                    variables: ["label": label ?? ""]
                )
                : LocalizedText(
                    "fieldvalidation.ip4vAddress",
                    "This is not a valid IPv4 address."
                )
        case .friendlyUrl:
            return hasLabel
                ? LocalizedText(
                    "fieldvalidation.friendlyUrlWithLabel",
                    "{{label}} can only have lowercase letters and hyphens.",
                    variables: ["label": label ?? ""]
                )
                : LocalizedText(
                    "fieldvalidation.friendlyUrl",
                    "This can only have lowercase letters and hyphens."
                )
        case .custom(let pattern, let message):
            return Self.isValidRegex(pattern)
                ? message : LocalizedText(verbatim: "")
        }
    }
}
