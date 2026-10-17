---
name: skill-component-data
description: Defines the public API contract standards for Raccoon component data models (*Data.swift). Always use this skill when creating, reviewing, refactoring, or adding properties to any *Data.swift struct in Sources/Raccoon/Components or Sources/Raccoon/Article.
---

# Component Data API Contract (*Data.swift)

Every Raccoon component (in `Sources/Raccoon/Components` and `Sources/Raccoon/Article`) exposes its configuration and parameters through a dedicated data struct named `<ComponentName>Data.swift`. This struct is the component's public API contract.

## Core Contract Rules

1. **Type & Concurrency**: Always declare as `public struct <ComponentName>Data: Sendable`.
2. **Immutability**: All stored properties must be `public let`.
3. **Boolean Flag Naming**: Booleans must always use the `is*` or `has*` prefix (e.g. `hasFullWidth`, `isSelected`, `hasBorder`, `isMaskedInMatomo`).
4. **Three-Way Consistency**: The attribute order must be identical across:
   - Stored property declarations (`public let ...`)
   - Initializer parameter list (`public init(...)`)
   - Initializer assignments (`self.<prop> = <prop>`)
5. **Documentation**: Every public property and every `init(...)` initializer must be documented with triple-slash (`///`) DocC comments, including `- Parameter <param>:` descriptions for each parameter.
6. **Optionality & Defaults**: Omit or provide sensible defaults (e.g. `nil`, `.enabled`, `.base`, `false`, `.DECLINED`) where appropriate to keep call sites ergonomic.

---

## The 6-Slot Attribute Ordering Sequence

Properties and initializer parameters must strictly follow this 6-slot order from top to bottom:

### 1. Identity & Alpine Bindings
Attributes that identify the component in the DOM or bind to Alpine / form actions:
- Identifiers: `id`, `bindId`, `name`
- Action bindings: `action`, `bindAction`, `clickAction`, `method`
- State bindings: `bindAriaExpanded`, `bindAriaPressed`

### 2. Content & Accessibility
Human-readable text, accessible descriptions, navigation targets, and tooltips:
- Labels & text: `label`, `ariaLabel`, `title`, `text`, `caption`, `placeholder`
- Tooltips: `tooltip`, `tooltipId`, `bindTooltipId`, `tooltipPosition`
- Hyperlinks: `href`, `hreflang`, `target`, `rel`

### 3. Value & Options (Data Payload)
Data values, selections, or collections managed or displayed by the component:
- Single value: `value`
- Collections / options: `values`, `options`, `items`, `entries`, `content`

### 4. Feedback & Validation
Form validation and contextual guidance:
- `errorMessages` (`ErrorMessageData?`)
- `helperText` (`HelperTextData?`)
- `validation` (`FieldValidationType?`)

### 5. Presentation & State
Visual appearance, sizing, icons, and interactive states:
- States: `state` (`ComponentState`, `ActionButtonState`), `isSelected`, `isFocusable`
- Sizing & layout: `size` (`ComponentSize`), `hasFullWidth`, `align`
- Icons: `icon`, `iconPosition`, `iconSize`
- Visual styling & types: `htmlType`, `buttonType`, `hasBorder`, `backgroundColor`

### 6. Analytics & Tracking
Matomo tracking and privacy options:
- `matomoStatus` (`MatomoStatus`, typically defaulting to `.DECLINED` or `.DEACTIVATED`)
- `contentTracker` (`MatomoContentTracker?`)
- `isMaskedInMatomo` (`Bool`)

---

## Canonical Implementation Blueprint

```swift
import HTML
import SVG
import Vapor

/// Configuration data for `<ComponentName>`. Serves as the public API contract.
public struct <ComponentName>Data: Sendable {

    // MARK: - 1. Identity & Alpine Bindings
    public let id: String?
    public let bindId: String?

    // MARK: - 2. Content & Accessibility
    public let label: String?
    public let ariaLabel: String?
    public let tooltip: String?
    public let tooltipPosition: ComponentPosition?

    // MARK: - 3. Value & Options
    public let value: String?

    // MARK: - 4. Feedback & Validation
    public let errorMessages: ErrorMessageData?
    public let helperText: HelperTextData?

    // MARK: - 5. Presentation & State
    public let state: ComponentState
    public let size: ComponentSize
    public let hasFullWidth: Bool
    public let icon: SvgIcon?

    // MARK: - 6. Analytics & Tracking
    public let matomoStatus: MatomoStatus
    public let contentTracker: MatomoContentTracker?

    /// Creates a new configuration instance for `<ComponentName>`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier.
    ///   - bindId: Dynamic Alpine `:id` expression.
    ///   - label: Visible label text.
    ///   - ariaLabel: Accessible name override for screen readers.
    ///   - tooltip: Text to display in the tooltip.
    ///   - tooltipPosition: Position of the tooltip relative to the element.
    ///   - value: Current input value or data payload.
    ///   - errorMessages: Error message configuration displayed below the component.
    ///   - helperText: Guidance or helper text displayed below the component.
    ///   - state: Current interaction state of the component.
    ///   - size: Visual size of the component.
    ///   - hasFullWidth: Whether the component should stretch to full parent width.
    ///   - icon: Optional SVG icon to display.
    ///   - matomoStatus: Tracking consent status for Matomo analytics.
    ///   - contentTracker: Matomo content tracking configuration.
    public init(
        // 1. Identity & Alpine Bindings
        id: String? = nil,
        bindId: String? = nil,

        // 2. Content & Accessibility
        label: String? = nil,
        ariaLabel: String? = nil,
        tooltip: String? = nil,
        tooltipPosition: ComponentPosition? = nil,

        // 3. Value & Options
        value: String? = nil,

        // 4. Feedback & Validation
        errorMessages: ErrorMessageData? = nil,
        helperText: HelperTextData? = nil,

        // 5. Presentation & State
        state: ComponentState = .enabled,
        size: ComponentSize = .base,
        hasFullWidth: Bool = false,
        icon: SvgIcon? = nil,

        // 6. Analytics & Tracking
        matomoStatus: MatomoStatus = .DECLINED,
        contentTracker: MatomoContentTracker? = nil
    ) {
        // 1. Identity & Alpine Bindings
        self.id = id
        self.bindId = bindId

        // 2. Content & Accessibility
        self.label = label
        self.ariaLabel = ariaLabel
        self.tooltip = tooltip
        self.tooltipPosition = tooltipPosition

        // 3. Value & Options
        self.value = value

        // 4. Feedback & Validation
        self.errorMessages = errorMessages
        self.helperText = helperText

        // 5. Presentation & State
        self.state = state
        self.size = size
        self.hasFullWidth = hasFullWidth
        self.icon = icon

        // 6. Analytics & Tracking
        self.matomoStatus = matomoStatus
        self.contentTracker = contentTracker
    }
}
```

---

## Refactoring / Extension Checklist

When modifying an existing `*Data.swift` or authoring a new one:

1. [ ] Struct conforms to `Sendable`.
2. [ ] All stored properties are `public let`.
3. [ ] Every `Bool` property uses `is*` or `has*`.
4. [ ] Slot placement confirmed (1. Identity $\rightarrow$ 2. Content $\rightarrow$ 3. Value $\rightarrow$ 4. Feedback $\rightarrow$ 5. Presentation $\rightarrow$ 6. Analytics).
5. [ ] Exact same order in property declarations, `init()` parameters, and `self.* = *` body.
6. [ ] Triple-slash (`///`) DocC comments present and if applicable updated on all stored properties and every `init(...)` function (with full `- Parameter` descriptions).


