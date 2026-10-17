public struct CodeBlockStyles {
    public static let codeText: String =
        "text-sm md:text-base lg:text-lg pr-[72px] leading-[1.35]"

    public static let codeContainer: String = [
        CommonStyles.fontMono,
        CommonStyles.backgroundTransparent,
        CommonStyles.inputBorder,
        CommonStyles.cornerRadiusLarge,
        CommonStyles.textColorDefault
    ].joined(separator: " ")

    public static let copyContainer: String = [
        CommonStyles.fontSans,
        CommonStyles.fontWeightNormal,
        CommonStyles.textSizeBase,
        CommonStyles.textNoWrap,
        "border border-r-0 border-t-0 border-b-0 border-l-1 border-on-surface rounded-r-lg",
        ].joined(separator: " ")
}

