/// Styles for `SearchField`.
/// Encapsulates all Tailwind classes and CommonStyles references for the search field component.
public struct SearchFieldStyles {

    // Text styles
    public static let textColorIcon: String =
        "text-black dark:text-gray-400 print:text-black"
    public static let textColorInput: String = CommonStyles.textColorInput
    public static let textColorNoResults: String = CommonStyles.textColorDefault

    // Styling of the container
    public static let searchContainerPadding: String = "py-2.5"
    public static let searchContainerBorderColor: String = CommonStyles
        .borderColorDefault
    public static let searchContainerBorder: String = InputFieldStyles
        .inputContainerBorder
    public static let searchContainerFocus: String = InputFieldStyles
        .inputContainerFocus
    public static let searchContainerHover: String = InputFieldStyles
        .inputContainerHover

    // Composed Container
    /// Composed styling for the outer container element.
    ///
    /// - Parameter hasTransparentBackground: Whether to apply `bg-transparent` to the container.
    /// - Returns: A joined string of Tailwind utility classes.
    public static func container(hasTransparentBackground: Bool = false)
        -> String
    {
        [
            "flex flex-row items-center w-full rounded-lg",
            hasTransparentBackground ? "bg-transparent" : "",
            searchContainerPadding,
            searchContainerBorderColor,
            searchContainerBorder,
            searchContainerFocus,
            searchContainerHover,
        ]
        .filter { !$0.isEmpty }
        .joined(separator: " ")
    }

    // Action button
    public static let actionButton: String = ActionButtonStyles.iconButton

}
