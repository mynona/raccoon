import Foundation
import Raccoon
import Vapor

/// Simulates the server side of a form, in the same shape as the cms `ControllerArticleEdit`:
/// `get` renders the form, `post` decodes and validates the content and either redirects (success)
/// or renders the form again with the values kept and the errors set.
public struct FormErrorSummaryController: RouteCollection, Sendable {

    let validationMethod: FormValidationMethod

    /// One controller per page: the error summary page and the submit validation page share the
    /// form and the server checks, but each has its own route.
    public init(validationMethod: FormValidationMethod = .errorSummary) {
        self.validationMethod = validationMethod
    }

    public func boot(routes: RoutesBuilder) throws {
        let preview = routes.grouped("preview")
        let slug = PathComponent(stringLiteral: FormErrorSummaryView.slug(for: validationMethod))
        preview.get(slug, use: get)
        preview.post(slug, use: post)
    }

    /// What the browser sends. Everything is optional: an untouched field is missing or empty.
    struct Dto: Content, Validatable {
        let title: String?
        let friendly_url: String?
        let excerpt: String?
        let country: String?
        let date: String?
        let tags: [String]?
        let password: String?
        let confirmPassword: String?
        let keywords: [String]?
        let terms: String?
        let visibility: String?
        let language: String?
        let topics: String?
        let cover: File?
        let attachments: [File]?
        static func validations(_ validations: inout Validations) {
            validations.add("title", as: String.self, is: .count(5...255))
            validations.add("excerpt", as: String.self, is: .count(5...))
            validations.add(
                "friendly_url",
                as: String.self,
                is: .count(5...150)
            )
        }
    }

    private static let csrfToken = "preview-csrf-token"

    @Sendable
    func get(_ request: Request) async throws -> Response {
        let isSaved = request.query[String.self, at: "saved"] == "1"

        // A date object cannot hold 31.11.2026, so the first view simulates the
        // state of an invalid date: the last real day of the month plus the server's rejection.
        var values = FormErrorSummaryValues()
        var errors: PreviewFormErrors?
        if !isSaved {
            var components = DateComponents()
            components.year = 2026
            components.month = 11
            components.day = 30
            values.date = Calendar(identifier: .gregorian).date(from: components) ?? Date()
            var initialErrors = PreviewFormErrors()
            initialErrors.addError(
                forKey: "date",
                message: "31.11.2026 is not a valid date."
            )
            errors = initialErrors
        }

        return request.templates.renderHtml(
            FormErrorSummaryView(
                FormErrorSummaryContext(
                    values: values,
                    errors: errors,
                    isSaved: isSaved,
                    validationMethod: validationMethod,
                    csrfToken: Self.csrfToken
                )
            )
        )
    }

    @Sendable
    func post(_ request: Request) async throws -> Response {
        let data = try request.content.decode(Dto.self)

        var errors = PreviewFormErrors()
        var formError: String?

        do {
            try Dto.validate(content: request)
        }
        catch let error as ValidationsError {
            errors.merge(error)
        }

        // Server-only checks: the browser cannot know these
        let friendlyUrl = data.friendly_url ?? ""
        if friendlyUrl == "taken-url" {
            errors.addError(
                forKey: "friendly_url",
                message: "This URL is already in use."
            )
        }
        else if !friendlyUrl.isEmpty,
            friendlyUrl.range(of: "^[a-z-]+$", options: .regularExpression)
                == nil
        {
            errors.addError(
                forKey: "friendly_url",
                message: "Use only the characters a-z and hyphen."
            )
        }

        switch data.country ?? "" {
        case "":
            errors.addError(forKey: "country", message: "Select a country.")
        case "xx":
            errors.addError(
                forKey: "country",
                message: "Atlantis is not available."
            )
        default:
            break
        }

        if (data.tags ?? []).isEmpty {
            errors.addError(
                forKey: "tag",
                message: "You must select at least one tag."
            )
        }

        if (data.password ?? "").count < 12 {
            errors.addError(
                forKey: "password",
                message: "Use at least 12 characters."
            )
        }
        if (data.confirmPassword ?? "") != (data.password ?? "") {
            errors.addError(
                forKey: "confirmPassword",
                message: "The passwords do not match."
            )
        }

        let keywords = (data.keywords ?? []).filter { !$0.isEmpty }
        if keywords.isEmpty {
            errors.addError(
                forKey: "keywords",
                message: "Add at least one keyword."
            )
        }

        // The submit validation page has no check, radio group or file upload
        let hasAllFields = validationMethod != .submit

        if hasAllFields && data.terms == nil {
            errors.addError(
                forKey: "terms",
                message: "You must accept the terms."
            )
        }
        if hasAllFields && (data.visibility ?? "").isEmpty {
            errors.addError(
                forKey: "visibility",
                message: "Choose who can see the article."
            )
        }
        if (data.language ?? "").isEmpty {
            errors.addError(
                forKey: "language",
                message: "Select a language."
            )
        }
        let topics = (data.topics ?? "").split(separator: ",").map(String.init)
        if topics.isEmpty {
            errors.addError(
                forKey: "topics",
                message: "Select at least one topic."
            )
        }
        if hasAllFields && (data.cover?.data.readableBytes ?? 0) == 0 {
            errors.addError(
                forKey: "cover",
                message: "Upload a cover image."
            )
        }
        if hasAllFields
            && (data.attachments ?? []).allSatisfy({ $0.data.readableBytes == 0 })
        {
            errors.addError(
                forKey: "attachments",
                message: "Upload at least one attachment."
            )
        }

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        // DatePicker returns this format
        dateFormatter.dateFormat = "EEE MMM dd yyyy"
        let date = data.date.flatMap { dateFormatter.date(from: $0) }
        if date == nil {
            errors.addError(forKey: "date", message: "Invalid date value.")
        }

        if data.title == "formerror" {
            formError = "The server could not save the article. Try again."
        }

        if errors.exist || formError != nil {
            return request.templates.renderHtml(
                FormErrorSummaryView(
                    FormErrorSummaryContext(
                        values: FormErrorSummaryValues(
                            title: data.title ?? "",
                            friendlyUrl: friendlyUrl,
                            excerpt: data.excerpt ?? "",
                            country: data.country ?? "",
                            tags: data.tags ?? [],
                            date: date ?? Date(),
                            keywords: keywords,
                            terms: data.terms != nil,
                            visibility: data.visibility,
                            language: data.language,
                            topics: topics
                        ),
                        errors: errors,
                        formError: formError,
                        validationMethod: validationMethod,
                        csrfToken: Self.csrfToken
                    )
                )
            )
        }

        return request.redirect(
            to: "\(FormErrorSummaryView.path(for: validationMethod))?saved=1"
        )
    }
}
