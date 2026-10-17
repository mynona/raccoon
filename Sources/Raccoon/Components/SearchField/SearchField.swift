import HTML
import SGML
import SVG
import WebBuilders

/// Standardized search field component used across Raccoon.
///
/// Combines a leading search icon, an input element with Alpine.js bindings,
/// and an accessible clear button with focus restoration.
public struct SearchField: TemplateRepresentable {
    let data: SearchFieldData
    typealias styles = SearchFieldStyles
    typealias inputStyles = InputFieldStyles

    private var iconDimension: Int {
        data.size == .sm ? 16 : 20
    }

    /// Creates a new `SearchField` component instance.
    ///
    /// - Parameter data: Configuration data model for the search field.
    public init(_ data: SearchFieldData = SearchFieldData()) {
        self.data = data
    }

    @Builder<Element>
    private func showLeadingIcon() -> [Element] {
        Div {
            if let loadingBind = data.loadingBind {
                Svg.icon(
                    .search,
                    title: data.iconTitle,
                    width: iconDimension,
                    height: iconDimension
                )
                .setAttribute(name: "x-show", value: "!\(loadingBind)")

                Svg.icon(
                    .search_heart,
                    title: data.iconTitle,
                    width: iconDimension,
                    height: iconDimension
                )
                .setAttribute(name: "x-show", value: "\(loadingBind)")
            }
            else {
                Svg.icon(
                    .search,
                    title: data.iconTitle,
                    width: iconDimension,
                    height: iconDimension
                )
            }
        }
        .class(data.size == .sm ? "pl-2 pr-1" : "pl-4")
        .addClass(styles.textColorIcon)
    }

    @Builder<Element>
    private func showInput() -> [Element] {
        Input()
            .if(data.name != nil) {
                if let name = data.name {
                    return $0.name(name)
                }
                return $0
            }
            .if(data.id != nil) {
                if let id = data.id {
                    return $0.id(id)
                }
                return $0
            }
            .if(data.value != nil) {
                if let value = data.value {
                    return $0.value(value)
                }
                return $0
            }
            .placeholder(data.placeholder)
            .ariaLabel(data.ariaLabel)
            .if(data.ariaControls != nil) {
                if let ariaControls = data.ariaControls {
                    return $0.ariaControls(ariaControls)
                }
                return $0
            }
            .if(data.tabindex != nil) {
                if let tabindex = data.tabindex {
                    return $0.setAttribute(name: "tabindex", value: tabindex)
                }
                return $0
            }
            .setAttribute(name: "x-model", value: data.bindModel)
            .setAttribute(name: "x-ref", value: data.bindRef)
            .if(data.bindKeyup != nil) {
                if let bindKeyup = data.bindKeyup {
                    return $0.setAttribute(
                        name: "@keyup.debounce",
                        value: bindKeyup
                    )
                }
                return $0
            }
            .setAttribute(name: "autocomplete", value: "false")
            .setAttribute(name: "autocapitalize", value: "off")
            .setAttribute(name: "autocorrect", value: "off")
            .if(data.state == .disabled) {
                $0.disabled()
            }
            .class(data.size == .sm ? "w-full px-2 py-1 text-sm" : "w-full")
            .addClass(inputStyles.inputReset)
            .addClass(styles.textColorInput)
    }

    @Builder<Element>
    private func showClearButton() -> [Element] {
        if data.hasClearButton {
            let clearExpression =
                data.bindClearAction
                ?? "\(data.bindModel) = ''; $nextTick(() => { $refs.\(data.bindRef)?.focus(); })"
            let showExpression =
                data.bindClearShow ?? "\(data.bindModel).length > 0"

            Button {
                Svg.icon(.x_circle, width: iconDimension, height: iconDimension)
            }
            .type(.button)
            .ariaLabel(data.clearAriaLabel)
            .setAttribute(name: "@click", value: clearExpression)
            .setAttribute(name: "x-show", value: showExpression)
            .class(data.size == .sm ? "p-1 mr-2" : "p-2 min-h-full h-full mr-4")
            .addClass(styles.actionButton)
            .if(
                data.contentTracker != nil
                    && (data.matomoStatus == .ACCEPTED
                        || data.matomoStatus == .BANNER)
            ) {
                guard let tracker = data.contentTracker else { return $0 }
                return
                    $0
                    .flagAttribute("data-track-content")
                    .setAttribute(
                        name: "data-content-name",
                        value: tracker.name
                    )
                    .setAttribute(
                        name: "data-content-piece",
                        value: tracker.piece
                    )
                    .setAttribute(
                        name: "data-content-target",
                        value: tracker.target
                    )
            }
        }
    }

    @Builder<Element>
    public func render() -> [Element] {
        Div {
            showLeadingIcon()
            showInput()
            showClearButton()
        }
        .class(
            styles.container(
                hasTransparentBackground: data.hasTransparentBackground
            )
        )
    }
}
