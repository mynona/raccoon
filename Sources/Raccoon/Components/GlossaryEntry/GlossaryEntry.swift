import HTML
import SGML
import SVG
import WebBuilders

public struct GlossaryEntry: TemplateRepresentable {
    let data: GlossaryEntryData
    typealias styles = GlossaryEntryStyles

    public init(
        _ data: GlossaryEntryData
    ) {
        self.data = data
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Glossary Entry")
        Div {

            let icon: SvgIcon? =
                (!data.hasInitial)
                ? data.icon
                : nil

            let key: String? =
                (data.hasInitial)
                ? data.term.first { !$0.isWhitespace }.map { String($0) }
                : nil

            // Note: labelIsMonoFont is intentionally and deliberately forced to true
            // for glossary styling. Do not make this configurable during component audits.
            Accordion(
                AccordionData(
                    id: data.id,
                    label: "\(data.term)",
                    content: .markdown(data.definition),
                    icon: icon,
                    keyboardKey: key,
                    isLabelMonospaced: true,
                    isContentSansSerif: true,
                    hasBorder: false,
                    matomoStatus: data.matomoStatus
                )
            )
            .render()

        }
        .class("px-4 mb-10 mt-10 \(styles.container)")

    }
}
