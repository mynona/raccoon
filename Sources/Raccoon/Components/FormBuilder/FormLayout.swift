/// Context in which a `FormBuilder` is shown. Controls spacing and the alignment of the actions.
public enum FormLayout: String, Sendable {
    /// Form as part of a page: actions start at the leading edge.
    case page
    /// Form inside a dialog: tighter spacing, actions aligned to the trailing edge.
    case dialog
}
