public struct AudioPlayerStyles {

    // MARK: progress bar
    public static let progressBarActive: String = CommonStyles.progressBarActive
    public static let progressBarInactive: String = CommonStyles
        .progressBarInactive

    // MARK: progress thumb
    public static let progressThumbContainer: String =
        "absolute top-1/2 pointer-events-none transition-all duration-150 ease-out z-20"

    public static let progressThumbCircle: String = [
        CommonStyles.cornerRadiusFull,
        "bg-progressactive",
        "border-2",
        "border-surface dark:border-surface-dark",
        "shadow-md",
        "transition-all duration-150",
        "flex items-center justify-center",
        "forced-colors:outline forced-colors:outline-2",
    ]
    .joined(separator: " ")

    // MARK: tooltip
    public static let tooltipContainer: String =
        "absolute bottom-4 pointer-events-none transition-all duration-100 ease-out z-30"

    public static let tooltipBubble: String = [
        "relative px-2 py-0.5 shadow-md flex items-center justify-center",
        TooltipStyles.backgroundColor,
        TooltipStyles.cornerRadius,
        "forced-colors:outline forced-colors:outline-1",
    ]
    .joined(separator: " ")

    public static let tooltipText: String = [
        CommonStyles.fontMono,
        CommonStyles.fontWeightSemibold,
        CommonStyles.textNoWrap,
        CommonStyles.textSizeTiny,
        CommonStyles.textColorInverse,
        "leading-tight",
    ]
    .joined(separator: " ")

    public static let tooltipArrowWrapper: String =
        "bottom-0 -translate-x-1/2 left-1/2 w-2.5 translate-y-full absolute inline-flex items-center justify-center overflow-visible"

    public static let tooltipArrow: String = [
        "w-1.5 h-1.5 transform origin-top-left -rotate-45",
        TooltipStyles.backgroundColor,
    ]
    .joined(separator: " ")

    // MARK: scrubber
    public static let scrubberButton: String = [
        "absolute bottom-0 right-0 left-0 h-3 z-100 cursor-pointer",
        CommonStyles.backgroundTransparent,
        "focus:outline-none",
    ]
    .joined(separator: " ")

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
