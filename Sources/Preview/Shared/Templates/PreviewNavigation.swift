import Foundation
import Raccoon

public struct PreviewNavItem: Sendable {
    public let title: String
    public let url: String
    public let isOpenInNewTab: Bool

    public init(title: String, url: String, isOpenInNewTab: Bool = false) {
        self.title = title
        self.url = url
        self.isOpenInNewTab = isOpenInNewTab
    }
}

public struct PreviewNavSection: Sendable {
    /// A generic heading, translated. Item titles are component names and stay fixed.
    public let title: LocalizedText?
    public let items: [PreviewNavItem]

    public init(title: LocalizedText? = nil, items: [PreviewNavItem]) {
        self.title = title
        self.items = items
    }
}

public struct PreviewNavGroup: Sendable {
    public let name: String
    public let sections: [PreviewNavSection]

    public init(name: String, sections: [PreviewNavSection]) {
        self.name = name
        self.sections = sections
    }
}

public enum PreviewNavigation {

    public static let groups: [PreviewNavGroup] = [
        PreviewNavGroup(
            name: "Raccoon",
            sections: [
                PreviewNavSection(
                    title: PreviewTexts.sectionInputElements,
                    items: [
                        PreviewNavItem(title: "Check", url: "/preview/check"),
                        PreviewNavItem(
                            title: "CheckboxSelect",
                            url: "/preview/checkbox-select"
                        ),
                        PreviewNavItem(
                            title: "DatePicker",
                            url: "/preview/date-picker"
                        ),
                        PreviewNavItem(
                            title: "FileUpload",
                            url: "/preview/file-upload"
                        ),
                        PreviewNavItem(
                            title: "HiddenField",
                            url: "/preview/hidden-field"
                        ),
                        PreviewNavItem(
                            title: "InputField",
                            url: "/preview/input-field"
                        ),
                        PreviewNavItem(
                            title: "InputList",
                            url: "/preview/input-list"
                        ),
                        PreviewNavItem(
                            title: "MultiSelect",
                            url: "/preview/multi-select"
                        ),
                        PreviewNavItem(
                            title: "MultipleFileUpload",
                            url: "/preview/multiple-file-upload"
                        ),
                        PreviewNavItem(
                            title: "PasswordInput",
                            url: "/preview/password-input"
                        ),
                        PreviewNavItem(title: "Radio", url: "/preview/radio"),
                        PreviewNavItem(
                            title: "RadioGroup",
                            url: "/preview/radio-group"
                        ),
                        PreviewNavItem(title: "Rating", url: "/preview/rating"),
                        PreviewNavItem(
                            title: "RatingFloating",
                            url: "/preview/rating-floating"
                        ),
                        PreviewNavItem(
                            title: "SearchField",
                            url: "/preview/search-field"
                        ),
                        PreviewNavItem(
                            title: "SingleSelect",
                            url: "/preview/single-select"
                        ),
                        PreviewNavItem(
                            title: "TextAreaField",
                            url: "/preview/textarea-field"
                        ),
                        PreviewNavItem(
                            title: "ToggleSwitch",
                            url: "/preview/toggle-switch"
                        ),
                        PreviewNavItem(
                            title: "ViewMaskedSecret",
                            url: "/preview/view-masked-secret"
                        ),
                    ]
                ),
                PreviewNavSection(
                    title: PreviewTexts.sectionForms,
                    items: [
                        PreviewNavItem(
                            title: "ErrorMessage",
                            url: "/preview/error-message"
                        ),
                        PreviewNavItem(
                            title: "FormBuilder (dialog)",
                            url: "/preview/form-builder-dialog"
                        ),
                        PreviewNavItem(
                            title: "FormBuilder (error summary)",
                            url: "/preview/form-error-summary"
                        ),
                        PreviewNavItem(
                            title: "FormBuilder (page)",
                            url: "/preview/form-builder"
                        ),
                        PreviewNavItem(
                            title: "FormBuilder (submit validation)",
                            url: "/preview/form-submit-validation"
                        ),
                        PreviewNavItem(
                            title: "HelperText",
                            url: "/preview/helper-text"
                        ),
                        PreviewNavItem(title: "Label", url: "/preview/label"),
                    ]
                ),
                PreviewNavSection(
                    title: PreviewTexts.sectionActions,
                    items: [
                        PreviewNavItem(
                            title: "ActionButton",
                            url: "/preview/actionbutton"
                        ),
                        PreviewNavItem(
                            title: "ByMeACoffee",
                            url: "/preview/by-me-a-coffee"
                        ),
                        PreviewNavItem(
                            title: "CopyToClipboard",
                            url: "/preview/copy-to-clipboard"
                        ),
                        PreviewNavItem(
                            title: "LinkButton",
                            url: "/preview/link-button"
                        ),
                    ]
                ),
                PreviewNavSection(
                    title: PreviewTexts.sectionNavigation,
                    items: [
                        PreviewNavItem(
                            title: "Breadcrumb",
                            url: "/preview/breadcrumb"
                        ),
                        PreviewNavItem(
                            title: "Dropdown",
                            url: "/preview/dropdown"
                        ),
                        PreviewNavItem(
                            title: "HyperLink",
                            url: "/preview/hyperlink"
                        ),
                        PreviewNavItem(
                            title: "LinkList",
                            url: "/preview/link-list"
                        ),
                        PreviewNavItem(
                            title: "Pagination",
                            url: "/preview/pagination"
                        ),
                        PreviewNavItem(
                            title: "SimpleMenu",
                            url: "/preview/simple-menu"
                        ),
                        PreviewNavItem(
                            title: "SkipLink",
                            url: "/preview/skip-link"
                        ),
                        PreviewNavItem(
                            title: "Stepper",
                            url: "/preview/stepper"
                        ),
                        PreviewNavItem(
                            title: "TabGroup",
                            url: "/preview/tab-group"
                        ),
                        PreviewNavItem(
                            title: "TablePaginator",
                            url: "/preview/table-paginator"
                        ),
                    ]
                ),
                PreviewNavSection(
                    title: PreviewTexts.sectionFeedback,
                    items: [
                        PreviewNavItem(
                            title: "CookieBanner",
                            url: "/preview/cookie-banner"
                        ),
                        PreviewNavItem(
                            title: "DeleteModal",
                            url: "/preview/modal-delete"
                        ),
                        PreviewNavItem(
                            title: "Notification",
                            url: "/preview/notification"
                        ),
                        PreviewNavItem(
                            title: "Toast",
                            url: "/preview/toast"
                        ),
                        PreviewNavItem(
                            title: "Tooltip",
                            url: "/preview/tooltip"
                        ),
                    ]
                ),
                PreviewNavSection(
                    title: PreviewTexts.sectionDataDisplay,
                    items: [
                        PreviewNavItem(title: "Avatar", url: "/preview/avatar"),
                        PreviewNavItem(title: "Badge", url: "/preview/badge"),
                        PreviewNavItem(
                            title: "DataTable",
                            url: "/preview/data-table"
                        ),
                        PreviewNavItem(
                            title: "Definition",
                            url: "/preview/definition"
                        ),
                        PreviewNavItem(
                            title: "Pill",
                            url: "/preview/pill"
                        ),
                        PreviewNavItem(
                            title: "SimpleTable",
                            url: "/preview/simple-table"
                        ),
                    ]
                ),
                PreviewNavSection(
                    title: PreviewTexts.sectionContent,
                    items: [
                        PreviewNavItem(
                            title: "Accordion",
                            url: "/preview/accordion"
                        ),
                        PreviewNavItem(
                            title: "AudioPlayer",
                            url: "/preview/audio-player"
                        ),
                        PreviewNavItem(
                            title: "Carousel",
                            url: "/preview/carousel"
                        ),
                        PreviewNavItem(
                            title: "CodeBlock",
                            url: "/preview/code-block"
                        ),
                        PreviewNavItem(
                            title: "Glossary",
                            url: "/preview/glossary"
                        ),
                        PreviewNavItem(
                            title: "GlossaryEntry",
                            url: "/preview/glossary-entry"
                        ),
                        PreviewNavItem(title: "Icons", url: "/preview/icons"),
                        PreviewNavItem(
                            title: "KeyboardKey",
                            url: "/preview/keyboard-key"
                        ),
                        PreviewNavItem(
                            title: "KeyTakeaways",
                            url: "/preview/key-takeaway"
                        ),
                        PreviewNavItem(title: "Logo", url: "/preview/logo"),
                        PreviewNavItem(
                            title: "MarkdownBlock",
                            url: "/preview/markdown-block"
                        ),
                        PreviewNavItem(
                            title: "Mermaid",
                            url: "/preview/mermaid"
                        ),
                        PreviewNavItem(title: "Quote", url: "/preview/quote"),
                        PreviewNavItem(
                            title: "References",
                            url: "/preview/references"
                        ),
                    ]
                ),
                PreviewNavSection(
                    title: PreviewTexts.sectionSettings,
                    items: [
                        PreviewNavItem(
                            title: "DarkLightModeToggle",
                            url: "/preview/dark-light-mode-toggle"
                        ),
                        PreviewNavItem(
                            title: "LanguageSwitcher",
                            url: "/preview/language-switcher"
                        ),
                        PreviewNavItem(title: "Spacer", url: "/preview/spacer"),
                        PreviewNavItem(
                            title: "ThemeSwitcher",
                            url: "/preview/theme-switcher"
                        ),
                    ]
                ),
            ]
        )
    ]
}
