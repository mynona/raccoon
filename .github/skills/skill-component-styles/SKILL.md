---
name: skill-component-styles
description: Standards and architecture for component and template styling (*Styles.swift, CommonStyles.swift). Always use this skill when creating, reviewing, refactoring, or updating styles in Sources/Raccoon/Components, Sources/Raccoon/Article, Sources/Raccoon/Templates, or Sources/Raccoon/Theme.
---

# Component and Template Styling Architecture (*Styles.swift)

In Raccoon, styling is decoupled from markup and component logic. All Tailwind utility classes and theme tokens are centralized and organized into dedicated style structs.

---

## 1. Core Architectural Laws

1. **Mandatory Dedicated Style File**:
   - Every component and template must have its own dedicated `*Styles.swift` file (e.g. `AccordionStyles.swift`, `TemplateFrontendStyles.swift`).
   - Sibling co-location: `<ComponentName>Styles.swift` lives right beside `<ComponentName>.swift` and `<ComponentName>Data.swift` in the same directory.
   - Even if a component borrows styles from another component (like `ActionButtonStyles` or `InputFieldStyles`), it **must have its own `*Styles.swift`** file defining or delegating its styles.

2. **Strict Indirection Rule (No Direct CommonStyles in Components)**:
   - **Never reference `CommonStyles` directly inside a component or template rendering file (`.swift`)**.
   - Components and templates access styles **only** via style structs (`styles.<property>`, `buttonStyles.<property>`, `inputFieldStyles.<property>`).
   - Only `*Styles.swift` files are permitted to import/reference `CommonStyles`.

3. **Typealias Binding in Components**:
   - Each component must alias its primary style struct at the top of the component type:
     ```swift
     public struct Accordion: TemplateRepresentable {
         let data: AccordionData
         typealias styles = AccordionStyles
         ...
     }
     ```
   - When a component also consumes shared button or input styles, use explicit secondary aliases:
     ```swift
     typealias buttonStyles = ActionButtonStyles
     typealias inputStyles = InputFieldStyles
     ```

4. **Common Reusable Style Providers**:
   - `ActionButtonStyles`: Reused by components with button triggers, icon buttons, clear buttons, pagination buttons, actions.
   - `InputFieldStyles`: Reused by text inputs, text areas, search inputs, select search inputs, form containers.
   - `SearchFieldStyles`: Reused by standalone search and composite components containing search bars.
   - Any component requiring button, input, or search styling delegates to or references these style structs in its own `*Styles.swift` or via secondary `typealias`.

---

## 2. CommonStyles vs ComponentStyles Responsibilities

### `CommonStyles.swift` (`Sources/Raccoon/Theme/Application/CommonStyles.swift`)
- The single global root for primitive design tokens and system utilities.
- Properties are defined **without** component prefixes:
  - Font families: `fontSans`, `fontMono`, `fontSerif`
  - Font weights: `fontWeightNormal`, `fontWeightMedium`, `fontWeightSemibold`, `fontWeightBold`
  - Text sizes: `textSizeTiny`, `textSizeSmall`, `textSizeBase`, `textSizeLarge`, `textSizeExtraLarge`
  - Text colors: `textColorDefault`, `textColorHighContrast`, `textColorInput`, `textColorPlaceholder`, `textColorError`, `textColorSuccess`, `textColorDisabled`
  - Borders & radii: `inputBorder`, `borderColorDefault`, `borderColorBrand`, `borderColorError`, `borderColorSuccess`, `borderColorDisabled`, `cornerRadiusTiny`, `cornerRadiusMedium`, `cornerRadiusLarge`
  - Backgrounds: `backgroundTransparent`, `backgroundLight`, `backgroundDark`, `backgroundBrand`, `backdropColor`
  - Resets: `focusReset`, `inputReset`, `proseReset`
  - Focus and hover rings: `focusDefault`, `focusInverted`, `focusError`, `focusDefaultCheckbox`, `hoverDefault`, `hoverInverted`, `hoverError`, `hoverDefaultCheckbox`
  - Base button primitives: `buttonTextColorPrimary`, `buttonBackgroundColorPrimary`, `buttonBorderPrimary`, `buttonPaddingPrimary`, etc.
- **Multi-mode requirement**: Every color token in `CommonStyles` declares light mode, dark mode (`dark:`), and print mode (`print:`) together so consumers never style modes in isolation.
- **Naming convention**: `<property><Variant/State>` (e.g. `textColorError`, `borderColorSuccess`, `hoverDefault`).

### Component `*Styles.swift`
- Exposes component-specific semantic styling properties.
- Map or delegate primitive tokens from `CommonStyles`, `ActionButtonStyles`, or `InputFieldStyles`.
- Defines compound/composed styles to avoid multiple `.addClass(...)` calls in markup.

---

## 3. Composed (Compound) Styles Pattern

To avoid spreading numerous styling calls across component views and templates, `*Styles.swift` aggregates related atomic utility classes into **composed variants**.

### Pattern Structure
- Declare an array of `String` tokens combining:
  1. Cursor / interactive base (`CommonStyles.cursorPointer`)
  2. Font family & weight (`font`, `CommonStyles.fontSans`, `CommonStyles.fontWeightMedium`)
  3. Sizing (`textSizeBase`, `CommonStyles.textSizeSmall`)
  4. Padding / spacing (`primaryPadding`, `paddingIcon`)
  5. Text color (`textColorPrimary`)
  6. Background color (`backgroundColorPrimary`)
  7. Border & radius (`borderPrimary`)
  8. Interaction states (`focusDefault`, `hoverDefault`)
- Join with `.joined(separator: " ")`.

### Canonical Example (`ActionButtonStyles.swift`)
```swift
public struct ActionButtonStyles {

    // MARK: font
    public static let font = [
        CommonStyles.fontSans,
        CommonStyles.fontWeightMedium,
        CommonStyles.textNoWrap,
    ]
    .joined(separator: " ")

    // MARK: text size
    public static let textSizeBase = CommonStyles.textSizeBase
    public static let textSizeSmall = CommonStyles.textSizeSmall

    // MARK: composed variants
    // One complete class set per variant, including font, size, padding and interaction state.
    public static let primaryButton: String = [
        CommonStyles.cursorPointer,
        font,
        textSizeBase,
        primaryPadding,
        textColorPrimary,
        backgroundColorPrimary,
        borderPrimary,
        focusDefault,
        hoverDefault,
    ]
    .joined(separator: " ")

    public static let iconButton: String = [
        CommonStyles.cursorPointer,
        font,
        textSizeBase,
        paddingIcon,
        textColorIcon,
        backgroundColorIcon,
        borderIcon,
        focusDefault,
        hoverDefault,
    ]
    .joined(separator: " ")
}
```

---

## 4. Reusing Shared Styles (`ActionButtonStyles`, `InputFieldStyles`, `SearchFieldStyles`)

When a component or composite component needs button, input, or search styling:

### Option A: Delegating in Component `*Styles.swift` (Preferred for Re-exports)
```swift
public struct CheckboxSelectStyles {
    // MARK: - InputFieldStyles Delegation
    public static let inputFieldReset = InputFieldStyles.inputReset
    public static let inputContainerBorder = InputFieldStyles.inputContainerBorder
    public static let inputContainerHover = InputFieldStyles.inputContainerHover
    public static let inputContainerFocus = InputFieldStyles.inputContainerFocus

    // MARK: - SearchFieldStyles Delegation
    public static let searchContainerPadding = SearchFieldStyles.searchContainerPadding
    public static let actionButton = SearchFieldStyles.actionButton
}
```

### Option B: Direct Typealias in Component (When using standard buttons/inputs directly)
```swift
public struct PasswordInput: TemplateRepresentable {
    let data: PasswordInputData
    typealias styles = PasswordInputStyles
    typealias buttonStyles = ActionButtonStyles
    typealias inputStyles = InputFieldStyles
    ...
}
```

### Option C: Reusing Canonical Components (Preferred for Composed UI)
When search functionality is needed inside a composite component (such as `Glossary`, `CheckboxSelect`, or `SimpleTable`), prefer embedding the canonical `SearchField` component directly rather than manually reconstructing search markup and delegating tokens:
```swift
SearchField(
    SearchFieldData(
        bindModel: "filterText",
        bindRef: "filterInput",
        placeholder: "Search",
        ariaLabel: "Search items"
    )
)
.render()
```
`SearchFieldStyles.container(hasTransparentBackground:)` encapsulates the complete composed container class list for search fields across sizes and background variations.

---

## 5. Canonical Implementation Blueprint

### File Structure: `Sources/Raccoon/Components/MyWidget/MyWidgetStyles.swift`
```swift
import Foundation

/// Styles for `MyWidget`.
/// Encapsulates all Tailwind classes and CommonStyles references for the component.
public struct MyWidgetStyles {

    // MARK: - Reusable Primitives
    public static let font: String = [
        CommonStyles.fontSans,
        CommonStyles.fontWeightMedium,
    ]
    .joined(separator: " ")

    public static let textSize: String = CommonStyles.textSizeBase
    public static let textColor: String = CommonStyles.textColorDefault
    public static let border: String = CommonStyles.borderColorDefault

    // MARK: - Focus & Hover Rings
    public static let focus: String = CommonStyles.focusDefault
    public static let hover: String = CommonStyles.hoverDefault

    // MARK: - Composed Variants
    public static let container: String = [
        "flex items-center gap-2",
        CommonStyles.cornerRadiusMedium,
        CommonStyles.backgroundLight,
        border,
    ]
    .joined(separator: " ")

    public static let interactiveItem: String = [
        CommonStyles.cursorPointer,
        font,
        textSize,
        textColor,
        focus,
        hover,
    ]
    .joined(separator: " ")
}
```

### Component Usage: `Sources/Raccoon/Components/MyWidget/MyWidget.swift`
```swift
import HTML
import SGML
import SVG
import Vapor
import WebBuilders

public struct MyWidget: TemplateRepresentable {
    let data: MyWidgetData
    typealias styles = MyWidgetStyles

    public init(_ data: MyWidgetData) {
        self.data = data
    }

    @Builder<Element>
    public func render() -> [Element] {
        Div {
            Span(data.title)
                .addClass(styles.interactiveItem)
        }
        .class(styles.container)
    }
}
```

---

## 6. Review Checklist for Component Styling

When reviewing or writing component and template styling:
- [ ] Does the component/template have its own dedicated `*Styles.swift` file in the same directory?
- [ ] Is `CommonStyles` referenced **only** within `*Styles.swift` and **never** in the component/template `.swift` render file?
- [ ] Does the component declare `typealias styles = <ComponentName>Styles`?
- [ ] Are compound styles defined in `*Styles.swift` (via array `.joined(separator: " ")`) instead of chaining multiple `.addClass(...)` calls in the template markup?
- [ ] Are color definitions inclusive of light, `dark:`, and `print:` modes?
- [ ] If buttons, inputs, or search bars are present, are `ActionButtonStyles`, `InputStyles`, or `SearchFieldStyles` properly reused or delegated?
