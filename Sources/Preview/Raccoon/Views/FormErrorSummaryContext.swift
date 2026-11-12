import Foundation
import Raccoon

/// Values of the simulated article form. They are kept as the user sent them, so a failed
/// post shows the same input again.
struct FormErrorSummaryValues: Sendable {
    var title: String = ""
    var friendlyUrl: String = ""
    var excerpt: String = ""
    var country: String = ""
    var tags: [String] = []
    var date: Date = Date()
    var keywords: [String] = []
    var terms: Bool = false
    var visibility: String?
    var language: String?
    var topics: [String] = []
}

struct FormErrorSummaryContext: Sendable {
    let values: FormErrorSummaryValues
    let errors: PreviewFormErrors?
    /// Form-level problem that belongs to no field, for example a failed backend call.
    let formError: String?
    let isSaved: Bool
    let validationMethod: FormValidationMethod
    let csrfToken: String

    init(
        values: FormErrorSummaryValues = .init(),
        errors: PreviewFormErrors? = nil,
        formError: String? = nil,
        isSaved: Bool = false,
        validationMethod: FormValidationMethod = .errorSummary,
        csrfToken: String
    ) {
        self.values = values
        self.errors = errors
        self.formError = formError
        self.isSaved = isSaved
        self.validationMethod = validationMethod
        self.csrfToken = csrfToken
    }
}
