/// Context in which a `FormBuilder` is shown. Controls the alignment of the actions.
public enum FormLayout: String, Sendable {
    /// Form as part of a page: actions start at the leading edge.
    case page
    /// Form inside a dialog: actions aligned to the trailing edge.
    case dialog
    /// Form inside a banner: actions stacked on mobile, inline row on tablet/desktop.
    case banner
}
