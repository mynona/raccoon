import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("Dropdown")
struct DropdownTests {

    let sampleOptions = [
        OptionValue(title: "Option Alpha", value: "alpha"),
        OptionValue(title: "Option Beta", value: "beta"),
        OptionValue(title: "Option Gamma", value: "gamma"),
    ]

    @Test(
        "renders enabled dropdown with label, hidden input, and trigger button"
    )
    func rendersEnabledDropdown() async throws {
        let data = DropdownData(
            id: "article_category",
            name: "category_id",
            label: LabelData(id: "article_category", title: "Category"),
            value: "beta",
            options: sampleOptions,
            helperText: HelperTextData(
                id: "cat_helper",
                text: "Select a topic category"
            )
        )
        let html = renderHTML(Dropdown(data).render())

        // Script and clean Alpine initialization
        #expect(html.contains("src=\"/js/dropdown.js\""))
        #expect(html.contains("x-data=\"dropdown({ selectedValue:"))

        // Label
        #expect(html.contains("Category"))

        // Hidden input for form POST submission
        #expect(
            html.contains(
                "<input type=\"hidden\" id=\"article_category\" name=\"category_id\" :value=\"selectedValue\""
            )
        )

        // Trigger button
        #expect(
            html.contains(
                "<button type=\"button\" id=\"article_category-trigger\""
            )
        )
        #expect(html.contains("x-ref=\"button\""))
        #expect(html.contains("@click=\"open = !open\""))
        #expect(html.contains("@keydown.down.prevent.stop=\"openMenu()\""))
        #expect(html.contains("@keydown.up.prevent.stop=\"openMenu()\""))
        #expect(html.contains(":aria-expanded=\"open\""))
        #expect(html.contains(":aria-controls=\"$id('dropdown-panel')\""))
        #expect(html.contains("x-text=\"selectedTitle\""))

        // Floating dropdown panel
        #expect(html.contains("x-ref=\"panel\""))
        #expect(html.contains("x-show=\"open\""))
        #expect(html.contains("@click.outside=\"open = false\""))
        #expect(
            html.contains(
                "@keydown.down.prevent.stop=\"open ? nextItem() : openMenu()\""
            )
        )
        #expect(
            html.contains(
                "@keydown.up.prevent.stop=\"open ? prevItem() : openMenu()\""
            )
        )
        #expect(
            html.contains("@keydown.home.prevent.stop=\"open && firstItem()\"")
        )
        #expect(
            html.contains("@keydown.end.prevent.stop=\"open && lastItem()\"")
        )
        #expect(html.contains("@keydown.escape.window=\"close($refs.button)\""))
        #expect(html.contains("@keydown.tab=\"open && close()\""))
        #expect(html.contains("role=\"listbox\""))

        // Options
        #expect(html.contains("Option Alpha"))
        #expect(html.contains("Option Beta"))
        #expect(html.contains("Option Gamma"))
        #expect(html.contains("role=\"option\""))
        #expect(html.contains("@click=\"select('alpha', 'Option Alpha')\""))
        #expect(html.contains("@click=\"select('beta', 'Option Beta')\""))
        #expect(html.contains(":aria-selected=\"selectedValue === 'beta'\""))

        // Helper text
        #expect(html.contains("Select a topic category"))
    }

    @Test("initializes directly from SingleSelectData for seamless switching")
    func initializesFromSingleSelectData() async throws {
        let singleSelectData = SingleSelectData(
            id: "author_id",
            name: "author",
            label: LabelData(id: "author_id", title: "Author"),
            value: "alpha",
            options: sampleOptions,
            state: .enabled
        )

        // Dropdown(singleSelectData) directly
        let html = renderHTML(Dropdown(singleSelectData).render())

        #expect(html.contains("Author"))
        #expect(html.contains("id=\"author_id\" name=\"author\""))
        #expect(html.contains("@click=\"select('alpha', 'Option Alpha')\""))
    }

    @Test("renders disabled state with disabled button and hidden input")
    func rendersDisabledState() async throws {
        let data = DropdownData(
            id: "disabled_select",
            label: LabelData(id: "disabled_select", title: "Locked Field"),
            value: "gamma",
            options: sampleOptions,
            state: .disabled
        )
        let html = renderHTML(Dropdown(data).render())

        #expect(
            html.contains(
                "<input type=\"hidden\" id=\"disabled_select\" name=\"disabled_select\" value=\"gamma\""
            )
        )
        #expect(html.contains("<button type=\"button\""))
        #expect(html.contains("disabled"))
        #expect(html.contains("Option Gamma"))
        #expect(!html.contains("role=\"listbox\""))
    }

    @Test("renders hidden state with hidden input only")
    func rendersHiddenState() async throws {
        let data = DropdownData(
            id: "hidden_field",
            value: "alpha",
            state: .hidden
        )
        let html = renderHTML(Dropdown(data).render())

        #expect(
            html.contains(
                "<input type=\"hidden\" id=\"hidden_field\" name=\"hidden_field\" value=\"alpha\""
            )
        )
        #expect(!html.contains("<button"))
    }

    @Test("renders info state with read-only summary display")
    func rendersInfoState() async throws {
        let data = DropdownData(
            id: "info_field",
            label: LabelData(id: "info_field", title: "Read Only Field"),
            value: "beta",
            options: sampleOptions,
            state: .info
        )
        let html = renderHTML(Dropdown(data).render())

        #expect(html.contains("Read Only Field"))
        #expect(html.contains("Option Beta"))
        #expect(
            !html.contains("<button type=\"button\" id=\"info_field-trigger\"")
        )
    }
}
