import HTML
import SGML
import SVG
import WebBuilders

/// Custom cell content rendered once on the server inside the cell template of a column.
///
/// The elements may use Alpine expressions with `row` (current row) and `col` (current column) in scope,
/// e.g. `x-text="row.status"`, `:class` or `:href`.
public struct DataTableCellTemplate: Sendable {

    let build: @Sendable () -> [Element]

    /// Creates a custom cell template.
    ///
    /// - Parameter content: Builder returning the cell elements.
    public init(
        @Builder<Element> _ content: @escaping @Sendable () -> [Element]
    ) {
        self.build = content
    }
}

/// Ready-made custom cells for common cases. All values come from `row[key]` and are rendered escaped.
extension DataTableCellTemplate {

    typealias styles = DataTableStyles

    /// Escapes text for a single-quoted JavaScript string inside a double-quoted HTML attribute.
    private static func js(_ value: String) -> String {
        JavaScriptEscaper.htmlAttributeEscape(
            JavaScriptEscaper.escapeSingleQuotedString(value)
        )
    }

    /// Value shown as a bordered badge.
    ///
    /// - Parameter key: Row property holding the badge text.
    public static func badge(key: String) -> DataTableCellTemplate {
        DataTableCellTemplate {
            Span {}
                .class(styles.badge)
                .setAttribute(name: "x-text", value: "row['\(js(key))']")
        }
    }

    /// Value shown as a link.
    ///
    /// - Parameters:
    ///   - key: Row property holding the link text.
    ///   - href: Link target. `{field}` placeholders are replaced by the URL encoded row value.
    public static func link(key: String, href: String)
        -> DataTableCellTemplate
    {
        DataTableCellTemplate {
            A {}
                .class(styles.cellLink)
                .setAttribute(name: "x-text", value: "row['\(js(key))']")
                .setAttribute(
                    name: ":href",
                    value: "tableHref(row, '\(js(href))')"
                )
        }
    }

    /// Boolean value shown as visible text, so meaning never depends on colour.
    ///
    /// - Parameters:
    ///   - key: Row property holding the boolean.
    ///   - yes: Text for `true`.
    ///   - no: Text for `false`.
    public static func yesNo(
        key: String,
        yes: String = "Yes",
        no: String = "No"
    ) -> DataTableCellTemplate {
        DataTableCellTemplate {
            Span {}
                .setAttribute(
                    name: "x-text",
                    value: "row['\(js(key))'] ? '\(js(yes))' : '\(js(no))'"
                )
        }
    }

    /// Boolean value shown as an icon plus screen reader text.
    ///
    /// - Parameters:
    ///   - key: Row property holding the boolean.
    ///   - trueIcon: Icon for `true`.
    ///   - falseIcon: Icon for `false`.
    ///   - trueLabel: Accessible text for `true`.
    ///   - falseLabel: Accessible text for `false`.
    public static func icon(
        key: String,
        trueIcon: SvgIcon = .check_lg,
        falseIcon: SvgIcon = .dash_lg,
        trueLabel: String = "Yes",
        falseLabel: String = "No"
    ) -> DataTableCellTemplate {
        DataTableCellTemplate {
            Span {
                Span {
                    Svg.icon(trueIcon, width: 16, height: 16)
                }
                .setAttribute(name: "x-show", value: "row['\(js(key))']")
                .setAttribute(name: "aria-hidden", value: "true")
                Span {
                    Svg.icon(falseIcon, width: 16, height: 16)
                }
                .setAttribute(name: "x-show", value: "!row['\(js(key))']")
                .setAttribute(name: "aria-hidden", value: "true")
                Span {}
                    .class("sr-only")
                    .setAttribute(
                        name: "x-text",
                        value:
                            "row['\(js(key))'] ? '\(js(trueLabel))' : '\(js(falseLabel))'"
                    )
            }
            .class(styles.icon)
        }
    }

    /// Array of strings shown as a list.
    ///
    /// - Parameter key: Row property holding the array.
    public static func list(key: String) -> DataTableCellTemplate {
        DataTableCellTemplate {
            Ul {
                Template {
                    Li {}
                        .setAttribute(name: "x-text", value: "item")
                }
                .setAttribute(
                    name: "x-for",
                    value: "(item, i) in (row['\(js(key))'] || [])"
                )
                .setAttribute(name: ":key", value: "i")
            }
            .class(styles.cellList)
        }
    }
}

/// Cell type of a `DataTable` column.
public enum DataTableCellType: Sendable {
    /// Plain, escaped text.
    case text
    /// Markdown. The backend sends sanitised HTML in `row[key + "_html"]`.
    case markdown
    /// Integer, right aligned with tabular figures.
    case integer
    /// Number with two decimal places, right aligned.
    case double
    /// One or more action buttons or links.
    case actions([DataTableAction])
    /// Custom content, see `DataTableCellTemplate`.
    case custom(DataTableCellTemplate)

    var wireName: String {
        switch self {
        case .text: "text"
        case .markdown: "markdown"
        case .integer: "integer"
        case .double: "double"
        case .actions: "actions"
        case .custom: "custom"
        }
    }
}

/// Horizontal alignment of a column.
public enum DataTableAlign: String, Sendable {
    case left
    case center
    case right
}
