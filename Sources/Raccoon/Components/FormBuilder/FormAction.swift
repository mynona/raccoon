/// An action shown below the fields of a `FormBuilder`.
public enum FormAction: Sendable {
    /// A button. Use `htmlType: .submit` (the `ActionButtonData` default) to submit the form,
    /// or `.button` together with `clickAction` for actions such as closing a dialog.
    case button(ActionButtonData)
    /// A link, for example "Cancel" on a page or "Already registered?".
    case link(LinkButtonData)
}
