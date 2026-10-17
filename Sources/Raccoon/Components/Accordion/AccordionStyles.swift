/// All font, text, color and animation styles
public struct AccordionStyles {

    // MARK: summary
    public static let summaryLabel: String = [
        CommonStyles.fontWeightBold,
        CommonStyles.textColorInput,
        CommonStyles.textSizeBase,
        CommonStyles.proseNon,
    ]
    .joined(separator: " ")

    public static let summaryLabelBorder: String =
        "border-t border-on-surface"

    public static let summaryOpenCloseToggleAnimation: String =
        "transition-transform group-open:-rotate-45"

    // MARK: details
    public static let detailsProse: String = CommonStyles.prose

    // MARK: font
    public static let fontSans: String = CommonStyles.fontSans
    public static let fontMono: String = CommonStyles.fontMono

    // MARK: hover
    public static let focusDefault: String = CommonStyles.focusDefault

    // MARK: focus
    public static let hoverDefault: String = CommonStyles.hoverDefault

    // MARK: content
    public static let contentReset: String = CommonStyles.proseReset

}
