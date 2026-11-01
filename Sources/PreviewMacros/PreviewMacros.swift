import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

func normalizeIndentation(_ text: String) -> String {
    let lines = text.components(separatedBy: "\n")
    guard lines.count > 1 else {
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    let nonEmptyFollowers = lines.dropFirst()
        .filter {
            !$0.trimmingCharacters(in: .whitespaces).isEmpty
        }
    let minIndent =
        nonEmptyFollowers.map { line in
            line.prefix(while: { $0 == " " || $0 == "\t" }).count
        }
        .min() ?? 0

    let reindented =
        [lines[0]]
        + lines.dropFirst()
        .map { line in
            if line.count >= minIndent {
                return String(line.dropFirst(minIndent))
            }
            return line.trimmingCharacters(in: .whitespaces)
        }

    return reindented.joined(separator: "\n")
        .trimmingCharacters(
            in: .whitespacesAndNewlines
        )
}

public struct PreviewVariantMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        let validArguments = Array(
            node.arguments.filter {
                !$0.expression.trimmedDescription.isEmpty
            }
        )
        guard validArguments.count >= 2 else {
            throw MacroExpansionErrorMessage(
                "#previewVariant requires a label string and a component data expression"
            )
        }

        let labelExpr = validArguments[0].expression
        let dataExpr = validArguments[1].expression
        var sourceText = normalizeIndentation(dataExpr.trimmedDescription)
        if sourceText.hasSuffix(",") {
            sourceText = String(sourceText.dropLast())
                .trimmingCharacters(
                    in: .whitespacesAndNewlines
                )
        }

        return
            "PreviewVariant(label: \(labelExpr), code: ##\"\"\"\n\(raw: sourceText)\n\"\"\"##, data: \(dataExpr))"
    }
}

public struct PreviewCodeMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let dataExpr = node.arguments.first?.expression else {
            throw MacroExpansionErrorMessage(
                "#previewCode requires a component data expression"
            )
        }
        let sourceText = normalizeIndentation(dataExpr.trimmedDescription)

        return
            "(code: ##\"\"\"\n\(raw: sourceText)\n\"\"\"##, data: \(dataExpr))"
    }
}

struct MacroExpansionErrorMessage: Error, CustomStringConvertible {
    let description: String
    init(_ description: String) { self.description = description }
}

@main
struct PreviewMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        PreviewVariantMacro.self,
        PreviewCodeMacro.self,
    ]
}
