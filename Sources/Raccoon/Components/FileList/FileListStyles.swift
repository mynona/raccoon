public struct FileListStyles {
    public static let container: String = [
        CommonStyles.cornerRadiusMedium,
        "mt-4 py-4 w-full bg-overlay-hover"
    ].joined(separator: " ")

    public static let row: String = "pe-6 flex items-center mt-2"

    // MARK: text
    public static let textColorDefault: String = CommonStyles.textColorDefault
    public static let metaTextSize: String = CommonStyles.textSizeTiny
}
