import HTML
import SGML
import SVG
import WebBuilders

/// Standardized dropdown form input component without search functionality.
///
/// Shares the exact same data model as `SingleSelect` (`DropdownData` / `SingleSelectData`),
/// allowing drop-in interchangeability, while styling its floating panel exactly like `SimpleMenu`.
public struct Dropdown: TemplateRepresentable {

    let data: DropdownData
    typealias styles = DropdownStyles

    /// Creates a new `Dropdown` instance from `DropdownData`.
    ///
    /// - Parameter data: Configuration data model for the dropdown.
    public init(_ data: DropdownData) {
        self.data = data
    }

    /// Creates a new `Dropdown` instance directly from `SingleSelectData` for seamless switching.
    ///
    /// - Parameter data: Source `SingleSelectData` instance.
    public init(_ data: SingleSelectData) {
        self.data = DropdownData(data)
    }

    private func getTitle(forValue id: String) -> String {
        guard let elements = data.options else { return "" }
        for element in elements where id == element.value {
            return element.title ?? ""
        }
        return ""
    }

    private var initialTitle: String {
        let title = getTitle(forValue: data.value ?? "")
        if !title.isEmpty {
            return title
        }
        return data.placeholder ?? data.placeholderText ?? "Select an option"
    }

    @Builder<Element>
    private func showTriggerText(bound: Bool) -> [Element] {
        let text =
            bound
            ? Span("").setAttribute(name: "x-text", value: "selectedTitle")
            : Span(initialTitle)
        if let icon = data.icon {
            Div {
                Svg.icon(icon, width: 16, height: 16)
                    .class(styles.triggerIcon)
                text
            }
            .class(styles.triggerContent)
        }
        else {
            text
        }
    }

    @Builder<Element>
    private func showInfo() -> [Element] {
        Div {
            if let label = data.label {
                Label(label).render()
                Input()
                    .type(.hidden)
                    .id(data.id)
                    .name(data.name ?? data.id)
                    .value(data.value ?? "")
            }
            P(initialTitle)
        }
        .class("pb-1.5 pt-2.5")
        .addClass(styles.infoBorder)
        .addClass(styles.infoTextColor)
    }

    @Builder<Element>
    private func showDisabled() -> [Element] {
        Div {
            if let label = data.label {
                Label(
                    LabelData(
                        id: label.id,
                        title: label.title,
                        position: label.position ?? .left,
                        size: label.size,
                        isRequired: label.isRequired,
                        isDisabled: true,
                        xhtml: label.xhtml
                    )
                )
                .render()
            }

            Input()
                .type(.hidden)
                .id(data.id)
                .name(data.name ?? data.id)
                .value(data.value ?? "")

            Button {
                showTriggerText(bound: false)
                Svg.icon(.chevron_down, width: 14, height: 14)
            }
            .type(.button)
            .disabled()
            .class(styles.triggerButtonDisabled)
            .if(data.icon != nil) { $0.addClass(styles.triggerGap) }

            if let helper = data.helperText {
                HelperText(helper).render()
            }
        }
        .class("space-y-1")
    }

    @Builder<Element>
    private func showHidden() -> [Element] {
        Input()
            .type(.hidden)
            .id(data.id)
            .name(data.name ?? data.id)
            .value(data.value ?? "")
    }

    @Builder<Element>
    private func showOptionItem(_ option: OptionValue) -> [Element] {
        let optVal = option.value ?? ""
        let optTitle = option.title ?? ""
        Button {
            Span(optTitle)
            Svg.icon(.check_lg, width: 16, height: 16)
                .setAttribute(
                    name: "x-show",
                    value: "selectedValue === '\(optVal)'"
                )
                .flagAttribute("x-cloak")
                .class(styles.activeIcon)
        }
        .type(.button)
        .setAttribute(name: "role", value: "option")
        .setAttribute(
            name: ":aria-selected",
            value: "selectedValue === '\(optVal)'"
        )
        .setAttribute(
            name: "@click",
            value: "select('\(optVal)', '\(optTitle)')"
        )
        .if(option.lang != nil) {
            guard let lang = option.lang else { return $0 }
            return $0.setAttribute(name: "lang", value: lang)
        }
        .class(styles.menuItem)
    }

    @Builder<Element>
    private func showEnabled() -> [Element] {
        Script()
            .src("/js/dropdown.js")
            .setAttribute(name: "type", value: "text/javascript")

        let hasError =
            data.errorMessages?.errorMessages != nil
            && !(data.errorMessages?.errorMessages?.isEmpty ?? true)
        let initialVal = data.value ?? ""
        let escapedTitle = JavaScriptEscaper.escapeSingleQuotedString(
            initialTitle
        )
        let escapedVal = JavaScriptEscaper.escapeSingleQuotedString(initialVal)

        let alpineData =
            "dropdown({ selectedValue: '\(escapedVal)', selectedTitle: '\(escapedTitle)', hasServerError: \(hasError ? "true" : "false") })"

        Div {
            // Label
            if let label = data.label {
                Label(label).render()
            }

            // Hidden input for standard HTML form submission
            Input()
                .type(.hidden)
                .id(data.id)
                .name(data.name ?? data.id)
                .setAttribute(name: ":value", value: "selectedValue")

            // Relative container for trigger + floating panel
            Div {
                // Trigger Button
                Button {
                    showTriggerText(bound: true)
                    Svg.icon(.chevron_down, width: 14, height: 14)
                        .setAttribute(
                            name: ":class",
                            value: "{ 'rotate-180': open }"
                        )
                        .class("transition-transform duration-150")
                }
                .type(.button)
                .id("\(data.id)-trigger")
                .ariaLabel(
                    data.placeholderAriaLabelText ?? data.placeholderText
                        ?? "Select"
                )
                .setAttribute(name: "x-ref", value: "button")
                .setAttribute(name: "@click", value: "open = !open")
                .setAttribute(
                    name: "@keydown.down.prevent.stop",
                    value: "openMenu()"
                )
                .setAttribute(
                    name: "@keydown.up.prevent.stop",
                    value: "openMenu()"
                )
                .setAttribute(name: ":aria-expanded", value: "open")
                .setAttribute(
                    name: ":aria-controls",
                    value: "$id('dropdown-panel')"
                )
                .class(styles.triggerButton)
                .if(data.icon != nil) { $0.addClass(styles.triggerGap) }

                // Floating Panel
                Div {
                    Ul {
                        if let options = data.options {
                            for option in options {
                                Li {
                                    showOptionItem(option)
                                }
                                .setAttribute(name: "role", value: "none")
                                .class("py-1")
                            }
                        }
                    }
                    .setAttribute(name: "role", value: "listbox")
                    .class(styles.menuList)
                }
                .setAttribute(name: "x-ref", value: "panel")
                .setAttribute(name: "x-show", value: "open")
                .flagAttribute("x-transition.origin.top.left")
                .setAttribute(name: "@click.outside", value: "open = false")
                .setAttribute(
                    name: ":id",
                    value: "$id('dropdown-panel')"
                )
                .style("display: none;")
                .flagAttribute("x-cloak")
                .class(styles.dropdownPanel)
            }
            .setAttribute(name: "x-data", value: alpineData)
            .setAttribute(name: "x-id", value: "['dropdown-panel']")
            .setAttribute(
                name: "@keydown.down.prevent.stop",
                value: "open ? nextItem() : openMenu()"
            )
            .setAttribute(
                name: "@keydown.up.prevent.stop",
                value: "open ? prevItem() : openMenu()"
            )
            .setAttribute(
                name: "@keydown.home.prevent.stop",
                value: "open && firstItem()"
            )
            .setAttribute(
                name: "@keydown.end.prevent.stop",
                value: "open && lastItem()"
            )
            .setAttribute(
                name: "@keydown.escape.window",
                value: "close($refs.button)"
            )
            .setAttribute(name: "@keydown.tab", value: "open && close()")
            .setAttribute(
                name: "x-on:focusin.window",
                value:
                    "! $refs.panel.contains($event.target) && ! $refs.button.contains($event.target) && (open = false)"
            )
            .class(styles.container)

            // Validation & Helper text
            if let errors = data.errorMessages {
                ErrorMessage(errors).render()
            }
            if let helper = data.helperText {
                HelperText(helper).render()
            }
        }
        .class("space-y-1 w-full")
    }

    @Builder<Element>
    public func render() -> [Element] {
        switch data.state {
        case .enabled:
            showEnabled()
        case .disabled:
            showDisabled()
        case .hidden:
            showHidden()
        case .info:
            showInfo()
        }
    }
}
