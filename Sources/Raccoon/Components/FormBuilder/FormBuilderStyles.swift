public struct FormBuilderStyles {

    // MARK: layout
    // Vertical rhythm of the registration forms: 1rem between fields, 2rem between the last field
    // and the actions (1rem `gap` + 1rem `pt-4`).
    // `gap` is used instead of `space-y` because fields render several sibling elements
    // (for example a script and a container) and hidden inputs, which do not create a box.
    public static let form: String = "flex flex-col gap-y-4"

    public static let group: String =
        "flex flex-col gap-y-4 min-w-0 m-0 p-0 border-0"
    public static let row: String =
        "grid grid-cols-1 gap-4 sm:grid-flow-col sm:auto-cols-fr"

    // MARK: legend
    public static let legendVisible: String = [
        "pb-4",
        CommonStyles.textSizeLarge,
        CommonStyles.fontWeightSemibold,
        CommonStyles.textColorEmphasized,
    ]
    .joined(separator: " ")
    public static let legendHidden: String = "sr-only"

    // MARK: actions
    public static let actionsPage: String = "flex flex-row flex-wrap gap-4 pt-4"
    public static let actionsDialog: String =
        "flex flex-col sm:flex-row justify-end gap-4 pt-4"
    public static let actionsBanner: String =
        "pt-4 flex flex-col sm:flex-row gap-4"
    public static let actionsWidget: String = "flex flex-col gap-4 pt-4"
    public static let action: String = "flex-initial"
}
