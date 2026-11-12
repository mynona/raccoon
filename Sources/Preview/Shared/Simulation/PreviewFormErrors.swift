import Raccoon
import Vapor

/// Server-side validation errors of a simulated form post, keyed by field id.
///
/// Same role as `ErrorMessages` in the cms: collected while validating, then handed to the
/// form fields via `errorData(for:)`.
struct PreviewFormErrors: Sendable {
    private(set) var errors: [String: [String]] = [:]

    var exist: Bool { !errors.isEmpty }

    mutating func addError(forKey key: String, message: String) {
        errors[key, default: []].append(message)
    }

    mutating func merge(_ validationsError: ValidationsError) {
        for failure in validationsError.failures {
            let key = failure.key.stringValue
            let description = failure.failureDescription ?? "is invalid"
            // The summary link already names the field: "Title: Value is …", not "Title: title is …"
            let message =
                description.hasPrefix("\(key) ")
                ? "Value " + description.dropFirst(key.count + 1)
                : description
            addError(forKey: key, message: message)
        }
    }

    /// Errors of one field, ready for a `*Data` type. `nil` when the field has no problem.
    func errorData(for key: String) -> ErrorMessageData? {
        guard let messages = errors[key] else { return nil }
        return ErrorMessageData(
            id: key,
            errorMessages: messages.map { LocalizedText(verbatim: $0) }
        )
    }
}
