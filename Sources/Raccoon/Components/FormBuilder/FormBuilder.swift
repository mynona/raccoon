import HTML
import SGML
import WebBuilders

/// Renders a complete `<form>` from an ordered list of fields and actions.
///
/// The builder only renders the form itself. Headings, steppers and page templates stay outside.
public struct FormBuilder: TemplateRepresentable {
    let data: FormBuilderData
    typealias styles = FormBuilderStyles

    public init(
        _ data: FormBuilderData
    ) {
        self.data = data
    }

    var hasFileUpload: Bool {
        data.fields.contains { $0.hasFileUpload }
    }

    @Builder<Element>
    func showField(_ field: FormField) -> [Element] {
        switch field {
        case .check(let data): Check(data).render()
        case .checkboxSelect(let data): CheckboxSelect(data).render()
        case .input(let data): InputField(data).render()
        case .textArea(let data): TextAreaField(data).render()
        case .password(let data): PasswordInput(data).render()
        case .singleFileUpload(let data): SingleFileUpload(data).render()
        case .multipleFileUpload(let data): MultipleFileUpload(data).render()
        case .dropdown(let data): Dropdown(data).render()
        case .singleSelect(let data): SingleSelect(data).render()
        case .multiSelect(let data): MultiSelect(data).render()
        case .datePicker(let data): DatePicker(data).render()
        case .inputList(let data): InputList(data).render()
        case .radioGroup(let data): RadioGroup(data).render()
        case .hidden(let data): HiddenField(data).render()
        case .group(let group): showGroup(group)
        case .row(let fields): showRow(fields)
        case .custom(let template): template.render()
        }
    }

    @Builder<Element>
    func showFields(_ fields: [FormField]) -> [Element] {
        for field in fields {
            showField(field)
        }
    }

    @Builder<Element>
    func showGroup(_ group: FormGroupData) -> [Element] {
        Fieldset {
            Legend(group.legend.resolved)
                .localized(group.legend)
                .class(
                    group.isLegendVisible
                        ? styles.legendVisible : styles.legendHidden
                )
            showFields(group.fields)
        }
        .class(styles.group)
        .if(group.id != nil) {
            if let id = group.id {
                return $0.id(id)
            }
            return $0
        }
    }

    @Builder<Element>
    func showRow(_ fields: [FormField]) -> [Element] {
        Div {
            showFields(fields)
        }
        .class(styles.row)
    }

    private var actionsClass: String {
        switch data.layout {
        case .page:
            return styles.actionsPage
        case .dialog:
            return styles.actionsDialog
        case .banner:
            return styles.actionsBanner
        }
    }

    @Builder<Element>
    func showActions() -> [Element] {
        if !data.actions.isEmpty {
            Div {
                for action in data.actions {
                    Div {
                        switch action {
                        case .button(let button):
                            ActionButton(button).render()
                        case .link(let link):
                            LinkButton(link).render()
                        }
                    }
                    .class(styles.action)
                }
            }
            .class(actionsClass)
        }
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Form builder")
        Form {

            if let token = data.csrfToken {
                HiddenField(
                    HiddenFieldData(id: "X-CSRF-Token", value: token)
                )
                .render()
            }

            if let errors = data.errorMessages {
                ErrorMessage(errors).render()
            }

            showFields(data.fields)
            showActions()

        }
        .id(data.id)
        .name(data.id)
        .method(data.method)
        .flagAttribute("novalidate")
        .class(styles.form)
        .if(data.action != nil) {
            if let action = data.action {
                return $0.action(action)
            }
            return $0
        }
        .if(hasFileUpload) {
            $0.setAttribute(name: "enctype", value: "multipart/form-data")
        }
        .if(data.ariaLabel != nil) {
            if let label = data.ariaLabel {
                return $0.localized(.ariaLabel, label)
            }
            return $0
        }
        .if(data.isTracked) {
            $0.setAttribute(name: "data-matomo-name", value: data.id)
        }
    }
}
