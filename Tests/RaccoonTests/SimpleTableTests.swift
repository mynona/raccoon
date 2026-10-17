import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("SimpleTable")
struct SimpleTableTests {

    private let meta = """
        {"hasIndexColumn":false,"columns":[{"key":"name","label":"Name","type":"text","align":"left","sortable":false},{"key":"role","label":"Role","type":"text","align":"left","sortable":false}]}
        """
    private let metaWithFeatures = """
        {"hasIndexColumn":true,"columns":[{"key":"name","label":"Name","type":"text","align":"left","sortable":true},{"key":"role","label":"Role","type":"text","align":"left","sortable":false}]}
        """
    private let rows = """
        [{"name":"Alice","role":"Designer"},{"name":"Bob","role":"Engineer"}]
        """

    @Test("renders caption when provided")
    func rendersCaption() async throws {

        let html = renderHTML(
            SimpleTable(
                SimpleTableData(meta: meta, rows: rows, caption: "Team members")
            )
            .render()
        )
        #expect(html.contains("Team members"))
    }

    @Test("renders table element")
    func rendersTableElement() async throws {

        let html = renderHTML(
            SimpleTable(SimpleTableData(meta: meta, rows: rows, caption: nil))
                .render()
        )
        #expect(html.contains("<table"))
    }

    @Test("renders column headers from meta")
    func rendersColumnHeaders() async throws {

        let html = renderHTML(
            SimpleTable(SimpleTableData(meta: meta, rows: rows, caption: nil))
                .render()
        )
        #expect(html.contains("Name"))
        #expect(html.contains("Role"))
    }

    @Test("renders toolbar actions when feature defaults are enabled")
    func rendersToolbarActionsWhenFeatureDefaultsEnabled() async throws {

        let html = renderHTML(
            SimpleTable(
                SimpleTableData(
                    meta: metaWithFeatures,
                    rows: rows,
                    caption: "Team members"
                )
            )
            .render()
        )

        #expect(html.contains("Copy table"))
        #expect(html.contains("Toggle filter"))
        #expect(html.contains("Select visible columns"))
        #expect(html.contains("/js/datatable.js"))
        #expect(html.contains("$nextTick"))
        #expect(html.contains(":colspan=\"activeColumns.length\""))
        #expect(html.contains("'text-left': col.align === 'left'"))
    }

    @Test("renders synthetic index column when enabled")
    func rendersSyntheticIndexColumnWhenEnabled() async throws {

        let html = renderHTML(
            SimpleTable(
                SimpleTableData(
                    meta: metaWithFeatures,
                    rows: rows,
                    caption: "Team members"
                )
            )
            .render()
        )

        #expect(html.contains("x-text=\"col.label\""))
        #expect(html.contains("'key':'id'"))
        #expect(html.contains("#"))
    }

    @Test("renders search field with filter bindings and clear button tracking")
    func rendersSearchFieldWithFilterBindings() async throws {

        let html = renderHTML(
            SimpleTable(
                SimpleTableData(
                    meta: metaWithFeatures,
                    rows: rows,
                    caption: "Team members"
                )
            )
            .render()
        )

        #expect(html.contains("x-model=\"filterText\""))
        #expect(html.contains("x-ref=\"filterInput\""))
        #expect(html.contains("aria-label=\"Search table rows\""))
        #expect(html.contains("aria-label=\"Clear filter\""))
        #expect(html.contains("data-content-name=\"simple-table\""))
        #expect(html.contains("data-content-piece=\"search.clear\""))
        #expect(html.contains("data-content-target=\"Team members\""))
        #expect(html.contains("x-show=\"showFilter\""))
    }

    @Test("suppresses rendering when meta json is invalid")
    func suppressesRenderingWhenMetaJsonIsInvalid() async throws {

        let html = renderHTML(
            SimpleTable(
                SimpleTableData(meta: "{invalid", rows: rows, caption: "Broken")
            )
            .render()
        )

        #expect(html.isEmpty)
    }
}
