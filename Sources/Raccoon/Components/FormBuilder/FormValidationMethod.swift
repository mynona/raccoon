/// How a `FormBuilder` reports problems with the fields to the user.
public enum FormValidationMethod: String, Sendable {
    /// No extra feedback. Form-level errors show in a separate error block above the fields.
    case none
    /// A summary above the first field lists every problem with a link to its field. After a failed
    /// submit, focus moves to the summary. The submit button stays active.
    case errorSummary
    /// No summary. The submit button is `aria-disabled` while a field has a client-side error, and
    /// activating it (click or Enter) does not post. Form-level errors show in a separate error block.
    case submit
}
