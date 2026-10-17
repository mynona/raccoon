import Markdown

// Function to apply multiple regex replacements for pre-processing markdown
func applyRegexReplacements(to text: String) -> String {
    let replacements: [(pattern: String, replacement: String)] = [
        (#"(\d{2}) min"#, "$1 minutes"),  // Convert "15 min" to "15 minutes"
        (#"~(\d{2}:\d{2})"#, "around $1"),  // Convert "~14:30" to "around 14:30"
        (#"(?i)\(cf\. .*?\)"#, ""),  // Remove references like "(Cf. Fitzpatrick 2019:150f)"
        (#"Q\+A"#, "Q&A"),  // Replace "Q+A" with "Q&A"
    ]

    return replacements.reduce(text) { result, replacement in
        result.replacingOccurrences(
            of: replacement.pattern,
            with: replacement.replacement,
            options: .regularExpression
        )
    }
}

// Helper function to format row content with column titles
private func formatRowContent(rowIndex: Int, cells: [String]) -> String? {
    guard !cells.isEmpty else { return nil }  // Skip empty rows
    let rowData = ["Row \(rowIndex):"] + cells
    return rowData.joined(separator: " –– ") + "\n\n"
}

// Struct to extract plain text from a markdown document
struct TextExtractor: MarkupWalker {
    var outputText = ""
    var columnTitles: [String] = []
    var rowIndex = 0

    mutating func visitText(_ text: Markdown.Text) {
        outputText.append(text.string)
    }

    mutating func visitParagraph(_ paragraph: Markdown.Paragraph) {
        descendInto(paragraph)
        outputText.append("\n\n")  // Ensures a newline after each paragraph
    }

    mutating func visitEmphasis(_ emphasis: Markdown.Emphasis) {
        descendInto(emphasis)  // Treats emphasis as regular text
    }

    mutating func visitInlineCode(_ inlineCode: Markdown.InlineCode) {
        descendInto(inlineCode)
    }

    mutating func visitCodeBlock(_ codeBlock: Markdown.CodeBlock) {
        let codeText = codeBlock.format()
            .replacingOccurrences(of: "`", with: "")
        outputText.append(codeText + "\n")
    }

    mutating func visitStrong(_ strong: Markdown.Strong) {
        descendInto(strong)  // Treats strong text inline
    }

    mutating func visitHeading(_ heading: Markdown.Heading) {
        outputText.append("\n")
        descendInto(heading)
        outputText.append(" [pause:0.5s] ")
        outputText.append("\n\n")  // Separate headings with a newline
    }

    mutating func visitListItem(_ listItem: Markdown.ListItem) {
        outputText.append("- ")
        descendInto(listItem)
    }

    mutating func visitSoftBreak(_ softBreak: Markdown.SoftBreak) {
        descendInto(softBreak)
    }

    mutating func visitTable(_ table: Markdown.Table) {
        outputText.append("Table:\n\n")  // Adds table label
        columnTitles = table.head.children.compactMap { cell in
            (cell as? Markdown.Table.Cell).map { extractCellText($0) } ?? ""
        }

        rowIndex = 0  // Reset row index for each new table
        descendInto(table.body)  // Process table body
    }

    mutating func visitTableRow(_ row: Markdown.Table.Row) {
        rowIndex += 1  // Increment row number correctly

        var rowData: [String] = []

        for (index, cell) in row.cells.enumerated() {
            let cellText = extractCellText(cell)
                .trimmingCharacters(in: .whitespacesAndNewlines)
            let columnTitle =
                index < columnTitles.count ? columnTitles[index] : ""

            if !cellText.isEmpty {  // **Only add non-empty cells**
                if columnTitle.isEmpty {
                    rowData.append("\(cellText)")  // No column title, output only the cell
                }
                else {
                    rowData.append("\(columnTitle): \(cellText)")  // Format with column title
                }
            }
        }

        if let formattedRow = formatRowContent(
            rowIndex: rowIndex,
            cells: rowData
        ) {
            outputText.append(formattedRow)
        }
    }

    private func extractCellText(_ cell: Markdown.Table.Cell) -> String {
        cell.children.compactMap { ($0 as? Markdown.Text)?.string }.joined()
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// Main function to process markdown and extract plain text
public func renderMarkdownAsText(_ source: String) -> String {
    let processedMarkdown = applyRegexReplacements(to: source)
    let document = Document(parsing: processedMarkdown)

    var walker = TextExtractor()
    walker.visit(document)

    return walker.outputText
}
