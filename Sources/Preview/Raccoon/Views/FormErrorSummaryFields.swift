import Raccoon

enum FormErrorSummaryOptions {
    static let countries: [OptionValue] = [
        OptionValue(title: "Please select", value: ""),
        OptionValue(title: "Austria", value: "at"),
        OptionValue(title: "Germany", value: "de"),
        OptionValue(title: "Switzerland", value: "ch"),
        OptionValue(title: "Atlantis (not allowed)", value: "xx"),
    ]

    static let tags: [OptionValue] = [
        OptionValue(title: "Discovery", value: "discovery"),
        OptionValue(title: "Delivery", value: "delivery"),
        OptionValue(title: "Research", value: "research"),
    ]

    static let languages: [OptionValue] = [
        OptionValue(title: "English", value: "en"),
        OptionValue(title: "German", value: "de"),
        OptionValue(title: "French", value: "fr"),
    ]
}

/// Fields of the simulated article form. Mirrors `formFieldsArticle` of the cms: a
/// function from the values and the errors to `[FormField]`.
///
/// Live (client) validation: `title`, `friendly_url`, `excerpt`.
/// Server-only errors: `country`, `date`, `tags` (no live error state yet).
func formFieldsErrorSummary(
    values: FormErrorSummaryValues,
    errors: PreviewFormErrors?,
    validationMethod: FormValidationMethod = .errorSummary
) -> [FormField] {
    let fields: [FormField] = [
        .group(
            FormGroupData(
                legend: "Metadata",
                fields: [
                    .dropdown(
                        DropdownData(
                            id: "country",
                            label: LabelData(id: "country", title: "Country"),
                            value: values.country,
                            options: FormErrorSummaryOptions.countries.map {
                                var option = $0
                                option.selected = $0.value == values.country
                                return option
                            },
                            errorMessages: errors?.errorData(for: "country"),
                            helperText: HelperTextData(
                                id: "country",
                                text: "Server-only check. Pick Atlantis to see it fail."
                            ),
                            state: .enabled
                        )
                    ),
                    .datePicker(
                        DatePickerData(
                            id: "date",
                            label: LabelData(
                                id: "date",
                                title: "Publishing date",
                                position: .left
                            ),
                            value: values.date,
                            state: .enabled,
                            errorMessages: errors?.errorData(for: "date")
                        )
                    ),
                    .multiSelect(
                        MultiSelectData(
                            id: "tag",
                            name: "tags[]",
                            label: LabelData(id: "tag", title: "Tag(s)"),
                            values: values.tags,
                            options: FormErrorSummaryOptions.tags,
                            state: .enabled,
                            errorMessages: errors?.errorData(for: "tag")
                        )
                    ),
                ],
                isLegendVisible: true
            )
        ),
        .group(
            FormGroupData(
                legend: "Content",
                fields: [
                    .input(
                        InputFieldData(
                            id: "title",
                            label: LabelData(id: "title", title: "Title"),
                            value: values.title,
                            errorMessages: errors?.errorData(for: "title"),
                            helperText: HelperTextData(
                                id: "title",
                                text:
                                    "5 to 255 characters. The title \"formerror\" simulates a form-level server error."
                            )
                        )
                    ),
                    .input(
                        InputFieldData(
                            id: "friendly_url",
                            label: LabelData(
                                id: "friendly_url",
                                title: "Friendly URL"
                            ),
                            value: values.friendlyUrl,
                            errorMessages: errors?.errorData(
                                for: "friendly_url"
                            ),
                            helperText: HelperTextData(
                                id: "friendly_url",
                                text:
                                    "Allowed characters: a-z, hyphen. The URL \"taken-url\" is already in use."
                            ),
                            validation: .friendlyUrl
                        )
                    ),
                    .textArea(
                        TextAreaFieldData(
                            id: "excerpt",
                            label: LabelData(id: "excerpt", title: "Excerpt"),
                            rows: 6,
                            value: values.excerpt,
                            validation: .custom(
                                pattern: #"^[\s\S]{5,}$"#,
                                message: "Minimum of 5 characters required"
                            ),
                            errorMessages: errors?.errorData(for: "excerpt")
                        )
                    ),
                ],
                isLegendVisible: true
            )
        ),
        .group(
            FormGroupData(
                legend: "Account",
                fields: [
                    .password(
                        PasswordInputData(
                            passwordErrorMessages: errors?.errorData(
                                for: "password"
                            ),
                            confirmErrorMessages: errors?.errorData(
                                for: "confirmPassword"
                            )
                        )
                    ),
                    .inputList(
                        InputListData(
                            id: "keywords",
                            label: LabelData(
                                id: "keywords",
                                title: "Keywords"
                            ),
                            values: values.keywords,
                            validationType: .custom(
                                pattern: #"^[a-z-]+$"#,
                                message: "Use only a-z and hyphen."
                            ),
                            errorMessages: errors?.errorData(for: "keywords")
                        )
                    ),
                ],
                isLegendVisible: true
            )
        ),
        .group(
            FormGroupData(
                id: "more-fields",
                legend: "More fields",
                fields: [
                    .check(
                        CheckData(
                            id: "terms",
                            label: "I accept the terms",
                            isSelected: values.terms,
                            errorMessages: errors?.errorData(for: "terms")
                        )
                    ),
                    .radioGroup(
                        RadioGroupData(
                            id: "visibility",
                            name: "visibility",
                            label: LabelData(
                                id: "visibility",
                                title: "Visibility",
                                isRequired: true
                            ),
                            selectedValue: values.visibility,
                            options: [
                                RadioData(
                                    id: "visibility-public",
                                    label: "Public",
                                    value: "public"
                                ),
                                RadioData(
                                    id: "visibility-private",
                                    label: "Private",
                                    value: "private"
                                ),
                            ],
                            errorMessages: errors?.errorData(for: "visibility")
                        )
                    ),
                    .singleSelect(
                        SingleSelectData(
                            id: "language",
                            label: LabelData(
                                id: "language",
                                title: "Language",
                                isRequired: true
                            ),
                            value: values.language,
                            options: FormErrorSummaryOptions.languages,
                            errorMessages: errors?.errorData(for: "language"),
                            state: .enabled
                        )
                    ),
                    .checkboxSelect(
                        CheckboxSelectData(
                            id: "topics",
                            label: LabelData(
                                id: "topics",
                                title: "Topics",
                                isRequired: true
                            ),
                            values: FormErrorSummaryOptions.tags.map {
                                var option = $0
                                option.selected = values.topics.contains(
                                    $0.value ?? ""
                                )
                                return option
                            },
                            errorMessages: errors?.errorData(for: "topics")
                        )
                    ),
                    .singleFileUpload(
                        SingleFileUploadData(
                            id: "cover",
                            label: LabelData(
                                id: "cover",
                                title: "Cover image",
                                isRequired: true
                            ),
                            errorMessages: errors?.errorData(for: "cover")
                        )
                    ),
                    .multipleFileUpload(
                        MultipleFileUploadData(
                            id: "attachments",
                            label: LabelData(
                                id: "attachments",
                                title: "Attachments",
                                isRequired: true
                            ),
                            errorMessages: errors?.errorData(
                                for: "attachments"
                            )
                        )
                    ),
                ],
                isLegendVisible: true
            )
        ),
    ]

    guard validationMethod == .submit else { return fields }

    // Submit validation only reacts to client-side errors: the fields that have none are left out
    return fields.map { field in
        guard case .group(let group) = field, group.id == "more-fields" else {
            return field
        }
        return .group(
            FormGroupData(
                id: group.id,
                legend: group.legend,
                fields: group.fields.filter { field in
                    switch field {
                    case .check, .radioGroup, .singleFileUpload,
                        .multipleFileUpload:
                        return false
                    default:
                        return true
                    }
                },
                isLegendVisible: group.isLegendVisible
            )
        )
    }
}
