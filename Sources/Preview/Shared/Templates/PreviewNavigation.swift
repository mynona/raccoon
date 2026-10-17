import Foundation

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
    public let title: String?
    public let items: [PreviewNavItem]

    public init(title: String? = nil, items: [PreviewNavItem]) {
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
                    title: "Components",
                    items: [
                        PreviewNavItem(
                            title: "Accordion",
                            url: "/preview/accordion"
                        ),
                        PreviewNavItem(
                            title: "ActionButton",
                            url: "/preview/actionbutton"
                        ),
                        PreviewNavItem(
                            title: "AudioPlayer",
                            url: "/preview/audio-player"
                        ),
                        PreviewNavItem(title: "Avatar", url: "/preview/avatar"),
                        PreviewNavItem(title: "Badge", url: "/preview/badge"),
                        PreviewNavItem(
                            title: "Breadcrumb",
                            url: "/preview/breadcrumb"
                        ),
                        PreviewNavItem(
                            title: "ByMeACoffee",
                            url: "/preview/by-me-a-coffee"
                        ),
                        PreviewNavItem(
                            title: "Carousel",
                            url: "/preview/carousel"
                        ),
                        PreviewNavItem(title: "Check", url: "/preview/check"),
                        PreviewNavItem(
                            title: "CheckboxSelect",
                            url: "/preview/checkbox-select"
                        ),
                        PreviewNavItem(
                            title: "CodeBlock",
                            url: "/preview/code-block"
                        ),
                        PreviewNavItem(
                            title: "CookieBanner",
                            url: "/preview/cookie-banner"
                        ),
                        PreviewNavItem(
                            title: "CopyToClipboard",
                            url: "/preview/copy-to-clipboard"
                        ),
                        PreviewNavItem(
                            title: "DarkLightModeToggle",
                            url: "/preview/dark-light-mode-toggle"
                        ),
                        PreviewNavItem(
                            title: "DatePicker",
                            url: "/preview/date-picker"
                        ),
                        PreviewNavItem(
                            title: "Dropdown",
                            url: "/preview/dropdown"
                        ),
                        PreviewNavItem(
                            title: "Definition",
                            url: "/preview/definition"
                        ),
                        PreviewNavItem(
                            title: "DeleteModal",
                            url: "/preview/modal-delete"
                        ),
                        PreviewNavItem(
                            title: "ErrorMessage",
                            url: "/preview/error-message"
                        ),
                        PreviewNavItem(
                            title: "FileUpload",
                            url: "/preview/file-upload"
                        ),
                        PreviewNavItem(
                            title: "Glossary",
                            url: "/preview/glossary"
                        ),
                        PreviewNavItem(
                            title: "GlossaryEntry",
                            url: "/preview/glossary-entry"
                        ),
                        PreviewNavItem(
                            title: "HelperText",
                            url: "/preview/helper-text"
                        ),
                        PreviewNavItem(
                            title: "HiddenField",
                            url: "/preview/hidden-field"
                        ),
                        PreviewNavItem(
                            title: "HyperLink",
                            url: "/preview/hyperlink"
                        ),
                        PreviewNavItem(title: "Icons", url: "/preview/icons"),
                        PreviewNavItem(
                            title: "InputField",
                            url: "/preview/input-field"
                        ),
                        PreviewNavItem(
                            title: "InputList",
                            url: "/preview/input-list"
                        ),
                        PreviewNavItem(
                            title: "KeyboardKey",
                            url: "/preview/keyboard-key"
                        ),
                        PreviewNavItem(
                            title: "KeyTakeaways",
                            url: "/preview/key-takeaway"
                        ),
                        PreviewNavItem(title: "Label", url: "/preview/label"),
                        PreviewNavItem(
                            title: "LinkButton",
                            url: "/preview/link-button"
                        ),
                        PreviewNavItem(
                            title: "LinkList",
                            url: "/preview/link-list"
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
                        PreviewNavItem(
                            title: "MultiSelect",
                            url: "/preview/multi-select"
                        ),
                        PreviewNavItem(
                            title: "MultipleFileUpload",
                            url: "/preview/multiple-file-upload"
                        ),
                        PreviewNavItem(
                            title: "Notification",
                            url: "/preview/notification"
                        ),
                        PreviewNavItem(
                            title: "Pagination",
                            url: "/preview/pagination"
                        ),
                        PreviewNavItem(
                            title: "PasswordInput",
                            url: "/preview/password-input"
                        ),
                        PreviewNavItem(
                            title: "Pill",
                            url: "/preview/pill"
                        ),
                        PreviewNavItem(title: "Quote", url: "/preview/quote"),
                        PreviewNavItem(title: "Rating", url: "/preview/rating"),
                        PreviewNavItem(
                            title: "RatingFloating",
                            url: "/preview/rating-floating"
                        ),
                        PreviewNavItem(
                            title: "References",
                            url: "/preview/references"
                        ),
                        PreviewNavItem(
                            title: "SearchField",
                            url: "/preview/search-field"
                        ),
                        PreviewNavItem(
                            title: "SimpleTable",
                            url: "/preview/simple-table"
                        ),
                        PreviewNavItem(
                            title: "SimpleMenu",
                            url: "/preview/simple-menu"
                        ),
                        PreviewNavItem(
                            title: "SingleSelect",
                            url: "/preview/single-select"
                        ),
                        PreviewNavItem(
                            title: "SkipLink",
                            url: "/preview/skip-link"
                        ),
                        PreviewNavItem(title: "Spacer", url: "/preview/spacer"),
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
                        PreviewNavItem(
                            title: "TextAreaField",
                            url: "/preview/textarea-field"
                        ),
                        PreviewNavItem(
                            title: "ThemeSwitcher",
                            url: "/preview/theme-switcher"
                        ),
                        PreviewNavItem(
                            title: "ToggleSwitch",
                            url: "/preview/toggle-switch"
                        ),
                        PreviewNavItem(
                            title: "Tooltip",
                            url: "/preview/tooltip"
                        ),
                        PreviewNavItem(
                            title: "ViewMaskedSecret",
                            url: "/preview/view-masked-secret"
                        ),
                    ]
                )
            ]
        )
    ]
}
