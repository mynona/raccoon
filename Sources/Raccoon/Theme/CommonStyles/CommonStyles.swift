/// CommonStyles
///
/// CommonStyles is the only place where a value is defined without a component prefix.
/// ActionButtonStyles and InputFieldStyles inherit from CommonStyles.
/// Other components reference ActionButtonStyles and InputFieldStyles if they need button or input styling.
///
/// Conventions:
/// - Naming is `<property><Variant/State>`, e.g. `textColorError`, not `errorTextColor`.
/// - Every colour constant declares light, `dark:` and `print:` together, so a consumer
///   can never style one render mode in isolation.
/// - Focus and hover rings are defined here only.
/// - Values are Tailwind utility classes; colour tokens come from Public/css/raccoon-min.css.
///
public struct CommonStyles {

    // MARK: cursor
    public static let cursorPointer: String = "cursor-pointer"
    public static let cursorNotAllowed: String = "cursor-not-allowed"
    public static let cursorGrab: String = "cursor-grab"

    // MARK: font
    public static let fontSans: String = "font-sans"
    public static let fontMono: String = "font-mono"
    public static let fontSerif: String = "font-serif"

    // MARK: font weight
    public static let fontWeightNormal: String = "font-normal"
    public static let fontWeightMedium: String = "font-medium"
    public static let fontWeightSemibold: String = "font-semibold"
    public static let fontWeightBold: String = "font-bold"

    // MARK: text
    public static let textNoWrap: String = "whitespace-nowrap"

    // MARK: textSize
    public static let textSizeTiny = "text-xs"
    public static let textSizeSmall = "text-sm"
    public static let textSizeBase = "text-base"
    public static let textSizeLarge = "text-lg"
    public static let textSizeExtraLarge = "text-xl"

    // MARK: textColor
    public static let textColorWhite: String = "text-white"
    public static let textColorDefault: String =
        "text-on-surface print:text-print"
    public static let textColorInverse: String =
        "text-on-inverse-surface"
    public static let textColorEmphasized: String =
        "text-on-surface-bright print:text-print"
    public static let textColorInput: String =
        "text-on-surface-bright print:text-print"
    public static let textColorPlaceholder: String =
        "placeholder:text-on-surface-dim print:placeholder:text-print"
    public static let textColorError: String =
        "text-on-error-variant print:text-print"
    public static let textColorSuccess: String =
        "text-on-success print:text-print"
    public static let textColorDisabled: String =
        "text-on-disabled print:text-print"

    // MARK: prose
    public static let prose: String =
        "prose prose-stone font-serif prose-base sm:prose-lg xl:prose-xl prose-a:underline prose-a:underline-offset-8 prose-a:decoration-on-theme prose-a:decoration-1 prose-a:decoration-solid prose-a:text-on-surface-bright prose-h2:font-medium prose-h2:text-on-surface-variant prose-h4:text-on-surface-variant prose-h2:pt-4 prose-h3:font-medium prose-h3:font-light prose-h3:text-on-surface-variant prose-h3:pt-6 prose-h4:pt-4 prose-h4:font-medium prose-ul:marker:text-on-surface prose-ol:marker:text-on-surface max-w-none dark:prose-invert prose-h1:text-on-surface-variant text-on-surface prose-strong:text-on-surface print:text-print"
    public static let proseNon: String = "not-prose"

    // MARK: border
    public static let inputBorder: String =
        "rounded-md border-1 border-on-surface"

    // MARK: borderColor
    public static let borderColorDefault: String =
        "border-on-surface"
    public static let borderColorTheme: String =
        "border-on-theme"
    public static let borderColorError: String =
        "border-on-error-variant"
    public static let borderColorSuccess: String =
        "border-on-success"
    public static let borderColorDisabled =
        "border-on-disabled ring-0 border-1"

    // MARK: divider
    public static let divideColorDefault: String =
        "divide-outline"

    // MARK: cornerRadius
    public static let cornerRadiusTiny: String = "rounded-xs"
    public static let cornerRadiusMedium: String = "rounded-md"
    public static let cornerRadiusLarge: String = "rounded-lg"
    public static let cornerRadiusFull: String = "rounded-full"

    // MARK: backgroundColor
    public static let backgroundTransparent: String = "bg-transparent"
    public static let backgroundLight: String =
        "bg-surface print:bg-white"
    public static let backgroundDark: String =
        "bg-surface-dark print:bg-white"
    public static let backgroundInverse: String =
        "bg-inverse-surface"
    public static let backdropColor: String = "bg-scrim"

    // MARK: reset (normalization)
    public static let focusReset: String =
        "focus:outline-hidden focus-visible:outline-hidden focus-within:outline-hidden"
    public static let inputReset: String =
        "shadow-none ring-0 border-0 focus:ring-0 focus:outline-hidden focus-within:outline-hidden focus-visible:outline-hidden bg-transparent"
    public static let proseReset: String =
        "!ring-0 !bg-transparent"

    // MARK: hover
    public static let hoverDefault: String =
        "hover:ring-2 hover:ring-offset-4 hover:ring-offset-white dark:hover:ring-offset-black hover:ring-hoverring hover:rounded-md hover:!no-underline"
    public static let hoverDefaultCheckbox =
        "hover:ring-2 hover:ring-offset-2 hover:ring-offset-white dark:hover:ring-offset-black hover:ring-hoverring hover:rounded-xs"
    public static let hoverError: String =
        "hover:ring-2 hover:ring-offset-4 hover:ring-offset-white dark:hover:ring-offset-black hover:ring-error hover:rounded-md"

    // MARK: focus
    public static let focusDefault: String =
        "focus:outline-none focus-within:ring-2 focus-within:ring-offset-4 ring-offset-white dark:ring-offset-black focus-within:ring-focusring focus-within:rounded-md focus:!no-underline"
    public static let focusDefaultCheckbox =
        "focus:outline-none focus-within:ring-2 focus-within:ring-offset-2 ring-offset-white dark:ring-offset-black focus-within:ring-focusring focus-within:rounded-xs"
    public static let focusError: String =
        "focus:outline-none focus-within:ring-2 focus-within:ring-offset-4 ring-offset-white dark:ring-offset-black focus-within:ring-error focus-within:rounded-md"

    // MARK: button

    // Button primary
    public static let buttonTextColorPrimary: String =
    "text-on-primary print:text-print"
    public static let buttonBackgroundColorPrimary: String =
    "bg-primary print:bg-white"
    public static let buttonBorderPrimary: String =
        "rounded-md border border-primary print:border-print"
    public static let buttonPaddingPrimary: String = "px-4 py-1.5 transition"

    // Button secondary
    public static let buttonTextColorSecondary: String =
        "text-on-secondary print:text-print"
    public static let buttonBackgroundColorSecondary: String =
        "bg-secondary print:bg-white"
    public static let buttonBorderSecondary: String =
        "rounded-md border border-on-secondary print:border-print"
    public static let buttonPaddingSecondary: String = "px-4 py-1.5 transition"

    // Button tertiary
    public static let buttonTextColorTertiary: String =
        "text-on-tertiary print:text-print"
    public static let buttonBackgroundColorTertiary: String =
        "bg-tertiary print:bg-white"
    public static let buttonBorderTertiary: String =
        "rounded-md border border-tertiary print:border-print"
    public static let buttonPaddingTertiary: String = "px-4 py-1.5 transition"

    // Button warning
    public static let buttonTextColorWarning: String =
        "text-on-error print:text-print"
    public static let buttonBackgroundColorWarning: String =
        "bg-error print:bg-white"
    public static let buttonBorderWarning: String =
        "rounded-md border border-error"
    public static let buttonPaddingWarning: String = "px-4 py-1.5 transition"

    // Icon button
    public static let buttonTextColorIcon: String =
        "text-on-icon print:text-print"
    public static let buttonBackgroundColorIcon: String =
        "bg-icon print:bg-white"
    public static let buttonBorderIcon: String = "rounded-md border-0"
    public static let buttonPaddingIcon: String = "p-1.5"

    // Button disabled
    public static let buttonTextColorDisabled: String =
        "disabled:text-on-disabled print:text-print"
    public static let buttonBackgroundColorDisabled: String =
        "disabled:bg-disabled print:bg-white"
    public static let buttonBorderDisabled: String =
        "!cursor-not-allowed !rounded-md border-0 border-on-disabled !ring-0 focus-within:ring-0! ring-offset-transparent dark:ring-offset-transparent"
    public static let buttonPaddingDisabled: String = "p-1.5 px-4"

    // MARK: hyperlink
    public static let linkDecoration: String =
        "underline underline-offset-8 decoration-on-theme decoration-solid dark:decoration-on-theme"
    public static let linkDecorationWeight: String =
        "decoration-1 hover:decoration-4"

    // MARK: progressBar
    public static let progressBarActive: String =
        "bg-progressactive print:bg-print"
    public static let progressBarInactive: String =
        "bg-progressinactive print:bg-white"

    // MARK: skip link – black/white for all themes
    public static let skipLink: String =
        "skip-link bg-white dark:bg-black text-black dark:text-white rounded focus:outline-hidden focus-within:outline-hidden focus-within:ring-1 focus-within:ring-black focus-visible:outline-hidden focus-visible:ring-2 focus-visible:ring-black dark:focus-within:ring-white dark:focus-visible:ring-white"

}
