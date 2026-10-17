public struct ActionButtonStyles {

    // MARK: primary
    public static let textColorPrimary: String = CommonStyles
        .buttonTextColorPrimary
    public static let backgroundColorPrimary: String = CommonStyles
        .buttonBackgroundColorPrimary
    public static let borderPrimary: String = CommonStyles.buttonBorderPrimary
    public static let primaryPadding: String = CommonStyles.buttonPaddingPrimary

    // MARK: secondary
    public static let textColorSecondary: String = CommonStyles
        .buttonTextColorSecondary
    public static let backgroundColorSecondary: String = CommonStyles
        .buttonBackgroundColorSecondary
    public static let borderSecondary: String = CommonStyles
        .buttonBorderSecondary
    public static let paddingSecondary: String = CommonStyles
        .buttonPaddingSecondary

    // MARK: tertiary
    public static let textColorTertiary: String = CommonStyles
        .buttonTextColorTertiary
    public static let backgroundColorTertiary: String = CommonStyles
        .buttonBackgroundColorTertiary
    public static let borderTertiary: String = CommonStyles.buttonBorderTertiary
    public static let paddingTertiary: String = CommonStyles
        .buttonPaddingTertiary

    // MARK: warning
    public static let textColorWarning: String = CommonStyles
        .buttonTextColorWarning
    public static let backgroundColorWarning: String = CommonStyles
        .buttonBackgroundColorWarning
    public static let borderWarning: String = CommonStyles.buttonBorderWarning
    public static let paddingWarning: String = CommonStyles.buttonPaddingWarning

    // MARK: icon button
    public static let textColorIcon: String = CommonStyles.buttonTextColorIcon
    public static let backgroundColorIcon: String = CommonStyles
        .buttonBackgroundColorIcon
    public static let borderIcon: String = CommonStyles.buttonBorderIcon
    public static let paddingIcon: String = CommonStyles.buttonPaddingIcon

    // MARK: disabled
    public static let textColorDisabled: String = CommonStyles
        .buttonTextColorDisabled
    public static let backgroundColorDisabled: String = CommonStyles
        .buttonBackgroundColorDisabled
    public static let borderDisabled: String = CommonStyles.buttonBorderDisabled
    public static let paddingDisabled: String = CommonStyles
        .buttonPaddingDisabled

    // MARK: font
    public static let font = [
        CommonStyles.fontSans,
        CommonStyles.fontWeightMedium,
    ]
    .joined(separator: " ")

    // MARK: text size
    public static let textSizeBase = CommonStyles.textSizeBase
    public static let textSizeSmall = CommonStyles.textSizeSmall
    public static let textSizeLarge = CommonStyles.textSizeLarge

    // MARK: hover
    public static let hoverError: String = CommonStyles.hoverError
    public static let hoverDefault: String = CommonStyles.hoverDefault

    // MARK: focus
    public static let focusError: String = CommonStyles.focusError
    public static let focusDefault: String = CommonStyles.focusDefault

    // MARK: icon button
    // The complete class set for a bare icon button, so call sites don't re-assemble it.
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

    public static let secondaryButton: String = [
        CommonStyles.cursorPointer,
        font,
        textSizeBase,
        paddingSecondary,
        textColorSecondary,
        backgroundColorSecondary,
        borderSecondary,
        focusDefault,
        hoverDefault,
    ]
    .joined(separator: " ")

    public static let tertiaryButton: String = [
        CommonStyles.cursorPointer,
        font,
        textSizeBase,
        paddingTertiary,
        textColorTertiary,
        backgroundColorTertiary,
        borderTertiary,
        focusDefault,
        hoverDefault,
    ]
    .joined(separator: " ")

    // Warning carries the error focus/hover ring, not the default one.
    public static let warningButton: String = [
        CommonStyles.cursorPointer,
        font,
        textSizeBase,
        paddingWarning,
        textColorWarning,
        backgroundColorWarning,
        borderWarning,
        focusError,
        hoverError,
    ]
    .joined(separator: " ")

    // Disabled has no focus or hover ring.
    public static let disabledButton: String = [
        CommonStyles.cursorNotAllowed,
        font,
        textSizeBase,
        paddingDisabled,
        textColorDisabled,
        backgroundColorDisabled,
        borderDisabled,
    ]
    .joined(separator: " ")

}
