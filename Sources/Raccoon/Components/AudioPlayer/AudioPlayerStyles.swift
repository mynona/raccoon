public struct AudioPlayerStyles {

    // MARK: progress bar
    public static let progressBarActive: String = CommonStyles.progressBarActive
    public static let progressBarInactive: String = CommonStyles
        .progressBarInactive

    // MARK: titleText
    public static let titleText: String = [
        CommonStyles.textColorDefault,
        CommonStyles.textSizeSmall,
        CommonStyles.fontWeightBold,
    ]
    .joined(separator: " ")

    // MARK: disclaimerText
    public static let disclaimerText: String = [
        CommonStyles.textColorDefault,
        CommonStyles.fontWeightNormal,
        CommonStyles.textSizeSmall,
    ]
    .joined(separator: " ")

    // MARK: timecodeText
    public static let timecodeText: String = [
        CommonStyles.textColorDefault,
        CommonStyles.fontWeightNormal,
        CommonStyles.textSizeSmall,
        CommonStyles.fontMono,
    ]
    .joined(separator: " ")

    // MARK: player
    public static let playerBorder: String =
        "border-4 border-b-0! border-on-theme"

    // MARK: font
    public static let fontSans: String = [
        CommonStyles.fontSans,
        CommonStyles.proseNon,
    ]
    .joined(separator: " ")

    // MARK: hover
    public static let hoverDefault = CommonStyles.hoverDefault

    // MARK: focus
    public static let focusDefault = CommonStyles.focusDefault

    // MARK: background
    public static let backgroundTransparent = CommonStyles.backgroundTransparent

}
