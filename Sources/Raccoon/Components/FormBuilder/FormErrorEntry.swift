/// One problem shown in the error summary of a `FormBuilder`: the control to link to,
/// the visible label of the field and the messages that explain the problem.
public struct FormErrorEntry: Sendable {

    // MARK: - 1. Identity & Alpine Bindings
    public let fieldId: String

    // MARK: - 2. Content & Accessibility
    public let label: LocalizedText

    // MARK: - 4. Feedback & Validation
    public let messages: [LocalizedText]

    /// Creates a new problem entry for the error summary.
    ///
    /// - Parameters:
    ///   - fieldId: DOM identifier of the control the summary link points to (`#fieldId`).
    ///   - label: Visible label of the field. It is the "field" part of the link text.
    ///   - messages: Error texts of the field. They are the "problem" part of the link text.
    public init(
        // 1. Identity & Alpine Bindings
        fieldId: String,

        // 2. Content & Accessibility
        label: LocalizedText,

        // 4. Feedback & Validation
        messages: [LocalizedText]
    ) {
        // 1. Identity & Alpine Bindings
        self.fieldId = fieldId

        // 2. Content & Accessibility
        self.label = label

        // 4. Feedback & Validation
        self.messages = messages
    }
}

extension FormField {

    /// The problems of this field, or of the fields nested in a group or row, one entry per field.
    ///
    /// Hidden fields and custom templates are never listed: they have no label and no focus target.
    var errorEntries: [FormErrorEntry] {
        switch self {
        case .group(let group):
            return group.fields.flatMap(\.errorEntries)
        case .row(let fields):
            return fields.flatMap(\.errorEntries)
        case .check(let data):
            return Self.entry(data.id, data.label, data.errorMessages)
        case .checkboxSelect(let data):
            return Self.entry(data.id, data.label?.title, data.errorMessages)
        case .input(let data):
            return Self.entry(data.id, data.label?.title, data.errorMessages)
        case .textArea(let data):
            return Self.entry(data.id, data.label?.title, data.errorMessages)
        case .password(let data):
            return Self.entry(
                data.passwordId,
                data.passwordLabel.title,
                data.passwordErrorMessages
            )
                + Self.entry(
                    data.confirmId ?? "",
                    data.confirmLabel?.title,
                    data.confirmErrorMessages
                )
        case .singleFileUpload(let data):
            return Self.entry(data.id, data.label?.title, data.errorMessages)
        case .multipleFileUpload(let data):
            return Self.entry(data.id, data.label?.title, data.errorMessages)
        case .dropdown(let data):
            return Self.entry(data.id, data.label?.title, data.errorMessages)
        case .singleSelect(let data):
            return Self.entry(data.id, data.label?.title, data.errorMessages)
        case .multiSelect(let data):
            return Self.entry(data.id, data.label?.title, data.errorMessages)
        case .datePicker(let data):
            // The first segment of the picker carries the label id
            return Self.entry(
                data.label?.id ?? data.id,
                data.label?.title,
                data.errorMessages
            )
        case .inputList(let data):
            return Self.entry(data.id, data.label?.title, data.errorMessages)
        case .radioGroup(let data):
            return Self.entry(data.id, data.label?.title, data.errorMessages)
        case .hidden, .custom:
            return []
        }
    }

    /// The control a form-level problem links to: the first field that can take focus.
    /// The `<form>` itself is not focusable.
    var firstControlId: String? {
        switch self {
        case .group(let group):
            return group.fields.lazy.compactMap(\.firstControlId).first
        case .row(let fields):
            return fields.lazy.compactMap(\.firstControlId).first
        case .check(let data): return data.id
        case .checkboxSelect(let data): return data.id
        case .input(let data): return data.id
        case .textArea(let data): return data.id
        case .password(let data): return data.passwordId
        case .singleFileUpload(let data): return data.id
        case .multipleFileUpload(let data): return data.id
        case .dropdown(let data): return data.id
        case .singleSelect(let data): return data.id
        case .multiSelect(let data): return data.id
        case .datePicker(let data): return data.label?.id ?? data.id
        case .inputList(let data): return data.id
        case .radioGroup(let data): return data.id
        case .hidden, .custom: return nil
        }
    }

    private static func entry(
        _ id: String,
        _ label: LocalizedText?,
        _ errors: ErrorMessageData?
    ) -> [FormErrorEntry] {
        guard !id.isEmpty, let messages = errors?.errorMessages,
            !messages.isEmpty
        else { return [] }
        return [
            FormErrorEntry(
                fieldId: id,
                label: label ?? LocalizedText(verbatim: id),
                messages: messages
            )
        ]
    }
}
