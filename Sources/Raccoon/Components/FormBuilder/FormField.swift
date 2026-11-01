/// A field, or a structural element, inside a `FormBuilder`.
///
/// Fields are rendered in the order in which they are given.
public enum FormField: Sendable {
    case check(CheckData)
    case checkboxSelect(CheckboxSelectData)
    case input(InputFieldData)
    case textArea(TextAreaFieldData)
    case password(PasswordInputData)
    case singleFileUpload(SingleFileUploadData)
    case multipleFileUpload(MultipleFileUploadData)
    case dropdown(DropdownData)
    case singleSelect(SingleSelectData)
    case multiSelect(MultiSelectData)
    case datePicker(DatePickerData)
    case inputList(InputListData)
    case radioGroup(RadioGroupData)
    case hidden(HiddenFieldData)

    /// Fields wrapped in a `<fieldset>` with a `<legend>`.
    case group(FormGroupData)
    /// Fields placed side by side (stacked on small screens).
    case row([FormField])
    /// Any other template, for example a component that is not a form field type of its own.
    case custom(any TemplateRepresentable & Sendable)

    /// Whether this field, or a field nested in a group or row, uploads files.
    var hasFileUpload: Bool {
        switch self {
        case .singleFileUpload, .multipleFileUpload:
            return true
        case .group(let group):
            return group.fields.contains { $0.hasFileUpload }
        case .row(let fields):
            return fields.contains { $0.hasFileUpload }
        default:
            return false
        }
    }
}
