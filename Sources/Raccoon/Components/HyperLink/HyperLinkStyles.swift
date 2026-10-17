public struct HyperLinkStyles {
    public static let underlined: String = CommonStyles.linkDecoration
    public static let underlinedLabel: String = CommonStyles.linkDecorationWeight

    public static let visited: String = "visited:text-link-visited"
    public static let hover: String = "hover:!decoration-4 hover:decoration-link-hover dark:hover:decoration-link-hover hover:text-link-hover"
    public static let active: String = "text-link-active"

    public static let link: String = [
        CommonStyles.fontSans,
        CommonStyles.fontWeightNormal,
        CommonStyles.cornerRadiusTiny,
        visited,
        hover,
        active
    ].joined(separator: " ")

    public static let focus: String = CommonStyles.focusDefault
    public static let focusNon: String = CommonStyles.focusReset

}

