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
    case custom(pattern: String, message: String)

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

    public func errorMessage(labelTitle: String?) -> String {
        let labelPrefix =
            (labelTitle?.isEmpty == false)
            ? "\(labelTitle ?? "Field") " : ""
        switch self {
        case .firstLastName:
            return
                "\(labelPrefix)has less than 2 valid characters (no spaces at the start or end)."
        case .email:
            return "\(labelPrefix)is not a valid email address."
        case .url:
            return
                "\(labelPrefix)is not a valid URL starting with http:// or https://."
        case .integer:
            return "\(labelPrefix)is not a valid integer number."
        case .amount:
            return "\(labelPrefix)is not a valid amount with 2 decimal numbers."
        case .phoneNumber:
            return "\(labelPrefix)is not a valid phone number (E.164 standard)."
        case .ip4vAddress:
            return "\(labelPrefix)is not a valid IPv4 address."
        case .friendlyUrl:
            return "\(labelPrefix)can only have lowercase letters and hyphens."
        case .custom(let pattern, let message):
            return Self.isValidRegex(pattern) ? message : ""
        }
    }
}
