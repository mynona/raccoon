import HTML
import SGML
import SVG
import WebBuilders

/// An accessible stepper component for tracking progress through multi-step workflows.
///
/// Supports both horizontal (compact circle indicators) and vertical (detailed titles & descriptions)
/// layouts, with interactive link navigation or static step indicators.
public struct Stepper: TemplateRepresentable {
    let data: StepperData
    typealias styles = StepperStyles

    /// Creates a new `Stepper` component instance.
    ///
    /// - Parameter data: Configuration data defining the steps, orientation, and layout options.
    public init(_ data: StepperData) {
        self.data = data
    }

    private func shouldTrackMatomo(for step: StepperStepData) -> Bool {
        guard step.href != nil, step.state == .enabled else { return false }
        return step.matomoStatus == .ACCEPTED
            || step.matomoStatus == .BANNER
            || data.matomoStatus == .ACCEPTED
            || data.matomoStatus == .BANNER
    }

    // MARK: - Tooltips

    private func tooltipReference(for step: StepperStepData, index: Int)
        -> String
    {
        if let explicit = step.tooltipId {
            return explicit
        }
        if let stepperId = data.id {
            return "tooltip-\(stepperId)-\(index + 1)"
        }
        let seed = step.tooltip ?? step.title
        return "tooltip-\(StableIdentifier.hash(seed))-\(index + 1)"
    }

    private func tooltipText(for step: StepperStepData) -> String {
        step.tooltip ?? step.title
    }

    private func tooltipPosition(for step: StepperStepData) -> ComponentPosition
    {
        step.tooltipPosition ?? .top
    }

    @Builder<Element>
    func showTooltip(
        for step: StepperStepData,
        referenceId: String
    ) -> [Element] {
        let text = tooltipText(for: step)
        if data.hasTooltip && step.hasTooltip && !text.isEmpty {
            Tooltip(
                TooltipData(
                    id: referenceId,
                    text: text,
                    position: tooltipPosition(for: step),
                    hasArrow: true
                )
            )
            .render()
        }
    }

    // MARK: - Circle Indicator

    @Builder<Element>
    func renderCircleIndicator(
        for step: StepperStepData,
        index: Int
    ) -> [Element] {
        switch step.status {
        case .complete:
            // Once a step is completed it always shows the tick
            Svg.icon(
                .check_lg,
                width: 20,
                height: 20,
                role: .presentation
            )
        case .current:
            if let icon = step.icon {
                Svg.icon(
                    icon,
                    width: 20,
                    height: 20,
                    role: .presentation
                )
                .class(styles.iconCurrent)
            }
            else if let number = step.stepNumber
                ?? (data.hasStepNumbers ? index + 1 : nil)
            {
                Span(String(number))
                    .setAttribute(name: "aria-hidden", value: "true")
                    .class(styles.circleTextCurrent)
            }
            else {
                Span {}
                    .setAttribute(name: "aria-hidden", value: "true")
                    .class(styles.dotCurrent)
            }
        case .upcoming:
            if let icon = step.icon {
                Svg.icon(
                    icon,
                    width: 20,
                    height: 20,
                    role: .presentation
                )
                .class(styles.iconUpcoming)
            }
            else if let number = step.stepNumber
                ?? (data.hasStepNumbers ? index + 1 : nil)
            {
                Span(String(number))
                    .setAttribute(name: "aria-hidden", value: "true")
                    .class(styles.circleTextUpcoming)
            }
            else {
                Span {}
                    .setAttribute(name: "aria-hidden", value: "true")
                    .class(styles.dotUpcoming)
            }
        }
    }

    // MARK: - Horizontal Rendering

    @Builder<Element>
    func renderHorizontalStepInner(
        _ step: StepperStepData,
        index: Int,
        accessibleLabel: String
    ) -> [Element] {
        renderCircleIndicator(for: step, index: index)
        Span(accessibleLabel)
            .class(styles.srOnly)
    }

    @Builder<Element>
    func renderHorizontalStepElement(
        _ step: StepperStepData,
        index: Int,
        tooltipId: String?
    ) -> [Element] {
        let circleClass: String = {
            switch step.status {
            case .complete: return styles.circleComplete
            case .current: return styles.circleCurrent
            case .upcoming: return styles.circleUpcoming
            }
        }()

        let accessibleLabel = step.ariaLabel ?? step.title

        if let href = step.href, step.state == .enabled {
            A {
                renderHorizontalStepInner(
                    step,
                    index: index,
                    accessibleLabel: accessibleLabel
                )
            }
            .href(href)
            .if(step.hreflang != nil) { $0.hrefLang(step.hreflang!) }
            .if(step.target != nil) {
                $0.setAttribute(name: "target", value: step.target!)
            }
            .if(step.rel != nil) {
                $0.setAttribute(name: "rel", value: step.rel!)
            }
            .if(step.status == .current) {
                $0.setAttribute(name: "aria-current", value: "step")
            }
            .if(step.id != nil) { $0.id(step.id!) }
            .if(step.bindId != nil) {
                $0.setAttribute(name: "x-bind:id", value: step.bindId!)
            }
            .if(tooltipId != nil) {
                $0
                    .setAttribute(name: "x-ref", value: tooltipId!)
                    .setAttribute(name: "aria-describedby", value: tooltipId!)
                    .setAttribute(
                        name: "x-on:mouseenter",
                        value:
                            "window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: '\(tooltipId!)' } }))"
                    )
                    .setAttribute(
                        name: "x-on:mouseleave",
                        value:
                            "window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: '\(tooltipId!)' } }))"
                    )
                    .setAttribute(
                        name: "x-on:focus",
                        value:
                            "window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: '\(tooltipId!)' } }))"
                    )
                    .setAttribute(
                        name: "x-on:blur",
                        value:
                            "window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: '\(tooltipId!)' } }))"
                    )
            }
            .class(circleClass)
            .addClass(styles.interactiveFocus)
            .if(shouldTrackMatomo(for: step)) {
                guard let tracker = step.contentTracker ?? data.contentTracker
                else {
                    let piece = step.id ?? "step-\(index + 1)"
                    let target = step.href ?? step.title
                    return
                        $0
                        .flagAttribute("data-track-content")
                        .setAttribute(
                            name: "data-content-name",
                            value: "stepper"
                        )
                        .setAttribute(name: "data-content-piece", value: piece)
                        .setAttribute(
                            name: "data-content-target",
                            value: target
                        )
                }
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
        else {
            Div {
                renderHorizontalStepInner(
                    step,
                    index: index,
                    accessibleLabel: accessibleLabel
                )
            }
            .if(step.status == .current) {
                $0.setAttribute(name: "aria-current", value: "step")
            }
            .if(step.state == .disabled) {
                $0.setAttribute(name: "aria-disabled", value: "true")
                    .addClass(styles.stepDisabled)
            }
            .if(step.id != nil) { $0.id(step.id!) }
            .if(step.bindId != nil) {
                $0.setAttribute(name: "x-bind:id", value: step.bindId!)
            }
            .if(tooltipId != nil && step.state != .disabled) {
                $0
                    .setAttribute(name: "x-ref", value: tooltipId!)
                    .setAttribute(name: "aria-describedby", value: tooltipId!)
                    .setAttribute(
                        name: "x-on:mouseenter",
                        value:
                            "window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: '\(tooltipId!)' } }))"
                    )
                    .setAttribute(
                        name: "x-on:mouseleave",
                        value:
                            "window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: '\(tooltipId!)' } }))"
                    )
                    .setAttribute(
                        name: "x-on:focus",
                        value:
                            "window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: '\(tooltipId!)' } }))"
                    )
                    .setAttribute(
                        name: "x-on:blur",
                        value:
                            "window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: '\(tooltipId!)' } }))"
                    )
            }
            .class(circleClass)
        }
    }

    @Builder<Element>
    func renderHorizontalStep(
        _ step: StepperStepData,
        index: Int,
        isLast: Bool
    ) -> [Element] {
        let itemClass =
            isLast
            ? styles.itemHorizontalLast
            : (data.hasFullWidth
                ? styles.itemHorizontalFullWidth : styles.itemHorizontal)
        let tooltipId = tooltipReference(for: step, index: index)
        let hasTooltip =
            data.hasTooltip && step.hasTooltip
            && !tooltipText(for: step).isEmpty

        Li {
            if !isLast {
                Div {
                    Div {}
                        .class(
                            step.status == .complete
                                ? styles.lineHorizontalComplete
                                : styles.lineHorizontalUpcoming
                        )
                }
                .setAttribute(name: "aria-hidden", value: "true")
                .class(styles.lineHorizontalContainer)
            }

            Div {
                renderHorizontalStepElement(
                    step,
                    index: index,
                    tooltipId: hasTooltip ? tooltipId : nil
                )
                if hasTooltip {
                    showTooltip(for: step, referenceId: tooltipId)
                }
            }
            .class(styles.iconWrapper)
        }
        .class(itemClass)
    }

    // MARK: - Vertical Rendering

    @Builder<Element>
    func renderVerticalCircle(_ step: StepperStepData, index: Int) -> [Element]
    {
        let circleClass: String = {
            switch step.status {
            case .complete: return styles.circleComplete
            case .current: return styles.circleCurrent
            case .upcoming: return styles.circleUpcoming
            }
        }()

        Span {
            Span {
                renderCircleIndicator(for: step, index: index)
            }
            .class(circleClass)
        }
        .setAttribute(name: "aria-hidden", value: "true")
        .class(styles.circleWrapperVertical)
    }

    @Builder<Element>
    func renderVerticalLabels(_ step: StepperStepData) -> [Element] {
        Span {
            let titleClass: String = {
                switch step.status {
                case .complete: return styles.titleComplete
                case .current: return styles.titleCurrent
                case .upcoming: return styles.titleUpcoming
                }
            }()
            Span(step.title)
                .class(titleClass)

            if let description = step.description, !description.isEmpty {
                let descClass: String = {
                    switch step.status {
                    case .complete: return styles.descriptionComplete
                    case .current: return styles.descriptionCurrent
                    case .upcoming: return styles.descriptionUpcoming
                    }
                }()
                Span(description)
                    .class(descClass)
            }
        }
        .class(styles.textContainerVertical)
    }

    @Builder<Element>
    func renderVerticalStepElement(
        _ step: StepperStepData,
        index: Int,
        tooltipId: String?
    ) -> [Element] {
        let circleClass: String = {
            switch step.status {
            case .complete: return styles.circleComplete
            case .current: return styles.circleCurrent
            case .upcoming: return styles.circleUpcoming
            }
        }()

        let accessibleLabel = step.ariaLabel ?? step.title

        if let href = step.href, step.state == .enabled {
            Div {
                Div {
                    Span {
                        A {
                            renderCircleIndicator(for: step, index: index)
                            Span(accessibleLabel)
                                .class(styles.srOnly)
                        }
                        .href(href)
                        .if(step.hreflang != nil) { $0.hrefLang(step.hreflang!) }
                        .if(step.target != nil) {
                            $0.setAttribute(name: "target", value: step.target!)
                        }
                        .if(step.rel != nil) {
                            $0.setAttribute(name: "rel", value: step.rel!)
                        }
                        .if(step.status == .current) {
                            $0.setAttribute(name: "aria-current", value: "step")
                        }
                        .if(step.id != nil) { $0.id(step.id!) }
                        .if(step.bindId != nil) {
                            $0.setAttribute(name: "x-bind:id", value: step.bindId!)
                        }
                        .if(tooltipId != nil) {
                            $0
                                .setAttribute(name: "x-ref", value: tooltipId!)
                                .setAttribute(name: "aria-describedby", value: tooltipId!)
                                .setAttribute(
                                    name: "x-on:mouseenter",
                                    value:
                                        "window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: '\(tooltipId!)' } }))"
                                )
                                .setAttribute(
                                    name: "x-on:mouseleave",
                                    value:
                                        "window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: '\(tooltipId!)' } }))"
                                )
                                .setAttribute(
                                    name: "x-on:focus",
                                    value:
                                        "window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: '\(tooltipId!)' } }))"
                                )
                                .setAttribute(
                                    name: "x-on:blur",
                                    value:
                                        "window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: '\(tooltipId!)' } }))"
                                )
                        }
                        .class(circleClass)
                        .addClass(styles.interactiveFocus)
                        .if(shouldTrackMatomo(for: step)) {
                            guard let tracker = step.contentTracker ?? data.contentTracker
                            else {
                                let piece = step.id ?? "step-\(index + 1)"
                                let target = step.href ?? step.title
                                return
                                    $0
                                    .flagAttribute("data-track-content")
                                    .setAttribute(
                                        name: "data-content-name",
                                        value: "stepper"
                                    )
                                    .setAttribute(name: "data-content-piece", value: piece)
                                    .setAttribute(
                                        name: "data-content-target",
                                        value: target
                                    )
                            }
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
                    .class(styles.circleWrapperVertical)

                    if let tooltipId {
                        showTooltip(
                            for: step,
                            referenceId: tooltipId
                        )
                    }
                }
                .class(styles.iconWrapper)

                renderVerticalLabels(step)
            }
            .class(styles.stepTriggerVertical)
        }
        else {
            Div {
                Div {
                    renderVerticalCircle(step, index: index)
                    if let tooltipId {
                        showTooltip(
                            for: step,
                            referenceId: tooltipId
                        )
                    }
                }
                .class(styles.iconWrapper)
                .if(tooltipId != nil && step.state != .disabled) {
                    $0
                        .setAttribute(name: "x-ref", value: tooltipId!)
                        .setAttribute(
                            name: "aria-describedby",
                            value: tooltipId!
                        )
                        .setAttribute(
                            name: "x-on:mouseenter",
                            value:
                                "window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: '\(tooltipId!)' } }))"
                        )
                        .setAttribute(
                            name: "x-on:mouseleave",
                            value:
                                "window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: '\(tooltipId!)' } }))"
                        )
                        .setAttribute(
                            name: "x-on:focus",
                            value:
                                "window.dispatchEvent(new CustomEvent('show-tooltip', { detail: { id: '\(tooltipId!)' } }))"
                        )
                        .setAttribute(
                            name: "x-on:blur",
                            value:
                                "window.dispatchEvent(new CustomEvent('hide-tooltip', { detail: { id: '\(tooltipId!)' } }))"
                        )
                }

                renderVerticalLabels(step)
            }
            .if(step.status == .current) {
                $0.setAttribute(name: "aria-current", value: "step")
            }
            .if(step.state == .disabled) {
                $0.setAttribute(name: "aria-disabled", value: "true")
                    .addClass(styles.stepDisabled)
            }
            .if(step.id != nil) { $0.id(step.id!) }
            .if(step.bindId != nil) {
                $0.setAttribute(name: "x-bind:id", value: step.bindId!)
            }
            .class(styles.stepStaticVertical)
        }
    }

    @Builder<Element>
    func renderVerticalStep(
        _ step: StepperStepData,
        index: Int,
        isLast: Bool
    ) -> [Element] {
        let itemClass = isLast ? styles.itemVerticalLast : styles.itemVertical
        let tooltipId = tooltipReference(for: step, index: index)
        let hasTooltip =
            data.hasTooltip && step.hasTooltip
            && !tooltipText(for: step).isEmpty

        Li {
            if !isLast {
                Div {}
                    .setAttribute(name: "aria-hidden", value: "true")
                    .class(
                        step.status == .complete
                            ? styles.lineVerticalComplete
                            : styles.lineVerticalUpcoming
                    )
            }

            renderVerticalStepElement(
                step,
                index: index,
                tooltipId: hasTooltip ? tooltipId : nil
            )
        }
        .class(itemClass)
    }

    // MARK: - Main Render

    @Builder<Element>
    public func render() -> [Element] {
        if !data.steps.isEmpty {
            Nav {
                Ol {
                    for (index, step) in data.steps.enumerated() {
                        let isLast = index == data.steps.count - 1
                        switch data.orientation {
                        case .horizontal:
                            renderHorizontalStep(
                                step,
                                index: index,
                                isLast: isLast
                            )
                        case .vertical:
                            renderVerticalStep(
                                step,
                                index: index,
                                isLast: isLast
                            )
                        }
                    }
                }
                .setAttribute(name: "role", value: "list")
                .if(data.orientation == .horizontal) {
                    $0.class(styles.listHorizontal)
                }
                .if(data.orientation == .vertical && !styles.listVertical.isEmpty) {
                    $0.class(styles.listVertical)
                }
            }
            .setAttribute(name: "aria-label", value: data.ariaLabel)
            .if(data.id != nil) { $0.id(data.id!) }
            .if(data.bindId != nil) {
                $0.setAttribute(name: "x-bind:id", value: data.bindId!)
            }
            .class(styles.nav)
        }
    }
}
