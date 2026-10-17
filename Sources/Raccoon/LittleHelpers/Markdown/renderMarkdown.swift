import Markdown

public func renderMarkdownAsHTML(_ source: String) -> String {

    var result: String = HTMLFormatter.format(source, options: [])

    // MARK: clean-up

    let pattern = #"<input([^>]*)\s*/?>[\t\r\n ]*<p>([\s\S]*?)<\/p>"#
    result = result.replacingOccurrences(
        of: pattern,
        with: "<input$1 aria-label='$2'/> $2",
        options: [.regularExpression, .caseInsensitive]
    )

    // Remove <p> after <li>
    result = result.replacingOccurrences(
        of: "<li><p>",
        with: "<li>"
    )
    result = result.replacingOccurrences(
        of: "</p>\n</li>",
        with: "</li>"
    )

    result = result.replacingOccurrences(
        of: "<li>([\\s\\S]*?)<p>\\s*</p>",
        with: "<li>$1",
        options: .regularExpression
    )

    // MARK: add classes

    // <a>
    result = result.replacingOccurrences(
        of: "<a",
        with:
            "<a class='p-1 \(HyperLinkStyles.link) \(HyperLinkStyles.focus)'"
    )

    // <pre>
    result = result.replacingOccurrences(
        of: "<pre",
        with:
            "<pre tabindex='-1' class='bg-white ring-1 ring-gray-950 text-gray-950 dark:bg-transparent dark:ring-gray-400 dark:print:!bg-white dark:text-gray-400'"
    )

    return result
}
