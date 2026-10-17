import Foundation
import HTML
import Raccoon
import SGML
import Testing

@testable import Raccoon

@Suite("DatePicker")
struct DatePickerTests {
    private func renderHTML(_ elements: [any SGML.Element]) -> String {
        elements.map { Document(root: $0).render(indent: 0) }.joined()
    }

    private func makeData(
        label: LabelData? = nil,
        errorMessages: ErrorMessageData? = nil,
        state: ComponentState = .enabled,
        backgroundColor: String? = nil
    ) -> DatePickerData {
        DatePickerData(
            id: "date",
            label: label,
            value: Date(timeIntervalSince1970: 1_717_349_200),
            state: state,
            errorMessages: errorMessages,
            backgroundColor: backgroundColor
        )
    }

    @Test("renders default date picker")
    func testDefaultDatePicker() {
        let ctx = makeData()
        let html = renderHTML(DatePicker(ctx).render())
        #expect(html.contains("/js/datepicker.js"))
        #expect(html.contains("datePickerWidget({ value:"))
        #expect(html.contains("x-init=\"[initDate(), getNoOfDays()]\""))
    }

    @Test("renders error state in Alpine config when server errors exist")
    func rendersErrorStateInAlpineConfig() {
        let ctx = makeData(
            label: LabelData(id: "date", title: "Date"),
            errorMessages: ErrorMessageData(
                errorMessages: ["Required"]
            )
        )
        let html = renderHTML(DatePicker(ctx).render())

        #expect(html.contains("hasServerError: true"))
        #expect(html.contains("Required"))
    }

    @Test("renders disabled state with disabled input")
    func rendersDisabledState() {
        let ctx = makeData(
            label: LabelData(id: "date", title: "Date"),
            state: .disabled
        )
        let html = renderHTML(DatePicker(ctx).render())

        #expect(html.contains("disabled"))
        #expect(html.contains("cursor-not-allowed"))
        #expect(html.contains("Calendar"))
    }

    @Test("renders info state with screen-reader input")
    func rendersInfoState() {
        let ctx = makeData(
            label: LabelData(id: "date", title: "Date"),
            state: .info,
            backgroundColor: "#ffffff"
        )
        let html = renderHTML(DatePicker(ctx).render())

        #expect(html.contains("sr-only"))
        #expect(html.contains("aria-hidden=\"true\""))
        #expect(html.contains("background-color: #ffffff;"))
    }

    @Test("renders hidden state like disabled")
    func rendersHiddenStateLikeDisabled() {
        let ctx = makeData(state: .hidden)
        let html = renderHTML(DatePicker(ctx).render())

        #expect(html.contains("disabled"))
        #expect(html.contains("cursor-not-allowed"))
    }

    @Test("renders calendar button and keyboard navigation attributes")
    func testCalendarButtonAndKeyboardAttributes() {
        let ctx = makeData(
            label: LabelData(id: "birthdate", title: "Birthdate")
        )
        let html = renderHTML(DatePicker(ctx).render())

        #expect(html.contains("@keydown.escape=\"showDatepicker = false\""))
        #expect(html.contains("@keydown.down=\"showDatepicker = true\""))
        #expect(html.contains("aria-label=\"Open calendar view\""))
        #expect(html.contains("name=\"date\""))
        #expect(html.contains("id=\"birthdate\""))
        #expect(!html.contains("name=\"birthdate\""))
    }

    @Test(
        "date field conforms to /cms controller expectations and parses successfully"
    )
    func testCmsControllerDateSubmission() throws {
        // 2024-06-02 12:06:40 UTC -> epoch 1_717_349_200
        let initialDate = Date(timeIntervalSince1970: 1_717_349_200)
        let ctx = DatePickerData(
            id: "date",
            label: LabelData(id: "date", title: "Publishing date"),
            value: initialDate,
            state: .enabled
        )
        let html = renderHTML(DatePicker(ctx).render())

        // 1. Verify hidden input is rendered with the format expected by CMS (EEE MMM dd yyyy)
        #expect(html.contains("type=\"hidden\""))
        #expect(html.contains("value=\"Sun Jun 02 2024\""))
        #expect(html.contains("name=\"date\""))

        // 2. Verify segmented inputs do not have a name attribute, avoiding hijacking
        let nameMatches =
            html.components(separatedBy: "name=\"date\"").count - 1
        #expect(
            nameMatches == 1,
            "Only the hidden input should carry name=\"date\""
        )

        // 3. Extract the hidden input value from HTML to simulate browser submission
        guard let range = html.range(of: "name=\"date\"") else {
            Issue.record("Missing name=\"date\" input")
            return
        }
        let inputPrefix = html[..<range.lowerBound]
        guard
            let tagStart = inputPrefix.range(of: "<input", options: .backwards)
        else {
            Issue.record("Could not locate <input start")
            return
        }
        let inputSuffix = html[range.lowerBound...]
        guard let tagEnd = inputSuffix.range(of: ">") else {
            Issue.record("Could not locate <input end")
            return
        }
        let inputTag = String(html[tagStart.lowerBound..<tagEnd.upperBound])
        guard let valueRangeStart = inputTag.range(of: "value=\""),
            let valueRangeEnd = inputTag[valueRangeStart.upperBound...]
                .range(of: "\"")
        else {
            Issue.record(
                "Could not extract value from hidden input: \(inputTag)"
            )
            return
        }
        let submittedDateString = String(
            inputTag[valueRangeStart.upperBound..<valueRangeEnd.lowerBound]
        )
        #expect(submittedDateString == "Sun Jun 02 2024")

        // 4. Simulate the /cms controller DateFormatter validation of the submitted value
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "Europe/Vienna")
        // DatePicker returns this format
        dateFormatter.dateFormat = "EEE MMM dd yyyy"

        guard let dateRetrieved = dateFormatter.date(from: submittedDateString)
        else {
            Issue.record(
                "Failed to parse date using CMS controller DateFormatter: \(submittedDateString)"
            )
            return
        }

        let calendar = Calendar(identifier: .gregorian)
        #expect(calendar.component(.year, from: dateRetrieved) == 2024)
        #expect(calendar.component(.month, from: dateRetrieved) == 6)
        #expect(calendar.component(.day, from: dateRetrieved) == 2)
    }

    @Test("calendar toggle exposes its expanded state")
    func testCalendarToggleAriaExpanded() {
        let html = renderHTML(DatePicker(makeData()).render())

        #expect(html.contains(":aria-expanded=\"showDatepicker\""))
    }

    @Test("day buttons expose selection, today and roving tabindex state")
    func testDayButtonAriaState() {
        let html = renderHTML(DatePicker(makeData()).render())

        #expect(html.contains(":aria-label=\"formatFullDate(date)\""))
        #expect(html.contains(":aria-pressed=\"isSelected(date)\""))
        #expect(
            html.contains(
                ":aria-current=\"isToday(date) ? 'date' : false\""
            )
        )
        #expect(html.contains(":tabindex=\"isFocusable(date) ? 0 : -1\""))
        #expect(html.contains(":data-day=\"date\""))
    }

    @Test("day grid supports arrow-key navigation")
    func testDayGridArrowKeyNavigation() {
        let html = renderHTML(DatePicker(makeData()).render())

        #expect(html.contains("x-ref=\"dayGrid\""))
        #expect(html.contains("role=\"grid\""))
        #expect(
            html.contains("@keydown.arrow-right.prevent=\"moveFocus(1)\"")
        )
        #expect(
            html.contains("@keydown.arrow-left.prevent=\"moveFocus(-1)\"")
        )
        #expect(
            html.contains("@keydown.arrow-down.prevent=\"moveFocus(7)\"")
        )
        #expect(
            html.contains("@keydown.arrow-up.prevent=\"moveFocus(-7)\"")
        )
    }

    @Test(
        "renders default DD.MM.YYYY format with segmented inputs and delimiter icons"
    )
    func testDefaultDDMMYYYYFormatAndInputAttributes() {
        let ctx = makeData()
        let html = renderHTML(DatePicker(ctx).render())

        #expect(html.contains("format: 'DD.MM.YYYY'"))
        #expect(html.contains("placeholder=\"DD\""))
        #expect(html.contains("placeholder=\"MM\""))
        #expect(html.contains("placeholder=\"YYYY\""))
        #expect(html.contains("x-model=\"dayInput\""))
        #expect(html.contains("x-model=\"monthInput\""))
        #expect(html.contains("x-model=\"yearInput\""))
        #expect(html.contains("x-text=\"errorMessage\""))
        #expect(html.contains("x-show=\"hasError\""))
    }

    @Test("renders YYYY-MM-DD format configuration correctly")
    func testYYYYMMDDFormatConfiguration() {
        let ctx = DatePickerData(
            id: "iso-date",
            label: LabelData(id: "iso-date", title: "Date"),
            value: Date(timeIntervalSince1970: 1_717_349_200),
            format: .YYYY_MM_DD,
            state: .enabled
        )
        let html = renderHTML(DatePicker(ctx).render())

        #expect(html.contains("format: 'YYYY-MM-DD'"))
        #expect(html.contains("placeholder=\"YYYY\""))
        #expect(html.contains("placeholder=\"MM\""))
        #expect(html.contains("placeholder=\"DD\""))
    }

    @Test("renders MM/DD/YYYY format configuration correctly")
    func testMMDDYYYYFormatConfiguration() {
        let ctx = DatePickerData(
            id: "us-date",
            label: LabelData(id: "us-date", title: "Date"),
            value: Date(timeIntervalSince1970: 1_717_349_200),
            format: .MM_DD_YYYY,
            state: .enabled
        )
        let html = renderHTML(DatePicker(ctx).render())

        #expect(html.contains("format: 'MM/DD/YYYY'"))
        #expect(html.contains("placeholder=\"MM\""))
        #expect(html.contains("placeholder=\"DD\""))
        #expect(html.contains("placeholder=\"YYYY\""))
    }

    @Test("renders DD/MM/YYYY format configuration correctly")
    func testDDMMYYYYSlashFormatConfiguration() {
        let ctx = DatePickerData(
            id: "uk-date",
            label: LabelData(id: "uk-date", title: "Date"),
            value: Date(timeIntervalSince1970: 1_717_349_200),
            format: "DD/MM/YYYY",
            state: .enabled
        )
        let html = renderHTML(DatePicker(ctx).render())

        #expect(html.contains("format: 'DD/MM/YYYY'"))
        #expect(html.contains("placeholder=\"DD\""))
        #expect(html.contains("placeholder=\"MM\""))
        #expect(html.contains("placeholder=\"YYYY\""))
    }

    @Test(
        "renders theme tokens for day selection and border without hardcoded colors"
    )
    func testThemeTokensNoHardcodedColors() {
        let html = renderHTML(DatePicker(makeData()).render())

        #expect(html.contains(DatePickerStyles.daySelected))
        #expect(html.contains(DatePickerStyles.dayUnselected))
        #expect(!html.contains("bg-brand-700"))
        #expect(!html.contains("dark:bg-brand-500"))
        #expect(!html.contains("ring-gray-300"))
        #expect(!html.contains("ring-error-500"))
    }

    @Test("DatePickerFormat enum values and aliases")
    func testDatePickerFormatEnum() {
        #expect(DatePickerFormat.dd_mm_yyyy.rawValue == "DD.MM.YYYY")
        #expect(DatePickerFormat.yyyy_mm_dd.rawValue == "YYYY-MM-DD")
        #expect(
            DatePickerFormat.dd_slash_mm_slash_yyyy.rawValue == "DD/MM/YYYY"
        )
        #expect(DatePickerFormat.mm_dd_yyyy.rawValue == "MM/DD/YYYY")
        #expect(DatePickerFormat.DD_MM_YYYY == .dd_mm_yyyy)
        #expect(DatePickerFormat.YYYY_MM_DD == .yyyy_mm_dd)
        #expect(
            DatePickerFormat.DD_SLASH_MM_SLASH_YYYY == .dd_slash_mm_slash_yyyy
        )
        #expect(DatePickerFormat.MM_DD_YYYY == .mm_dd_yyyy)
        #expect(DatePickerFormat.dach == .dd_mm_yyyy)
        #expect(DatePickerFormat.iso == .yyyy_mm_dd)
        #expect(DatePickerFormat.uk == .dd_slash_mm_slash_yyyy)
        #expect(DatePickerFormat.us == .mm_dd_yyyy)
        #expect(DatePickerFormat("DD.MM.YYYY") == .dd_mm_yyyy)
        #expect(DatePickerFormat("YYYY-MM-DD") == .yyyy_mm_dd)
        #expect(DatePickerFormat("DD/MM/YYYY") == .dd_slash_mm_slash_yyyy)
        #expect(DatePickerFormat("MM/DD/YYYY") == .mm_dd_yyyy)
        #expect(DatePickerFormat.dd_mm_yyyy.placeholder == "DD.MM.YYYY")
        #expect(DatePickerFormat.yyyy_mm_dd.placeholder == "YYYY-MM-DD")
        #expect(
            DatePickerFormat.dd_slash_mm_slash_yyyy.placeholder == "DD/MM/YYYY"
        )
        #expect(DatePickerFormat.mm_dd_yyyy.placeholder == "MM/DD/YYYY")
        #expect(DatePickerFormat.dd_mm_yyyy.dateFormat == "dd.MM.yyyy")
        #expect(DatePickerFormat.yyyy_mm_dd.dateFormat == "yyyy-MM-dd")
        #expect(
            DatePickerFormat.dd_slash_mm_slash_yyyy.dateFormat == "dd/MM/yyyy"
        )
        #expect(DatePickerFormat.mm_dd_yyyy.dateFormat == "MM/dd/yyyy")
    }

    @Test("renders date picker with epoch date correctly")
    func testDatePickerWithEpochDate() {
        let epochDate = Date(timeIntervalSince1970: 0) // 1970-01-01 00:00:00 UTC
        let ctx = DatePickerData(
            id: "epoch-date",
            label: LabelData(id: "epoch-date", title: "Epoch Date"),
            value: epochDate,
            state: .enabled
        )
        let html = renderHTML(DatePicker(ctx).render())

        #expect(html.contains("name=\"epoch-date\""))
        #expect(html.contains("1970"))
    }

    @Test("renders exact segmented input initial values for specific date")
    func testDatePickerSegmentedInputValuesForSpecificDate() {
        let date = Date(timeIntervalSince1970: 1_717_349_200) // 2024-06-02 17:26:40 UTC
        let ctx = DatePickerData(
            id: "scheduled-date",
            label: LabelData(id: "scheduled-date", title: "Scheduled"),
            value: date,
            format: .dd_mm_yyyy,
            state: .enabled
        )
        let html = renderHTML(DatePicker(ctx).render())

        // Initial day, month, year values rendered into the component initialization and inputs
        #expect(html.contains("value: '2024-06-02'"))
        #expect(html.contains("value=\"Sun Jun 02 2024\""))
        #expect(html.contains("value=\"02\""))
        #expect(html.contains("value=\"06\""))
        #expect(html.contains("value=\"2024\""))
    }

    @Test("concurrent DatePicker rendering is thread-safe")
    func testConcurrenDatePickerRendering() async {
        let date = Date(timeIntervalSince1970: 1_717_349_200)
        let ctx = DatePickerData(
            id: "concurrent-date",
            label: LabelData(id: "concurrent-date", title: "Concurrent"),
            value: date,
            format: .dd_mm_yyyy,
            state: .enabled
        )

        await withTaskGroup(of: String.self) { group in
            for _ in 0..<20 {
                group.addTask {
                    self.renderHTML(DatePicker(ctx).render())
                }
            }

            var results: [String] = []
            for await html in group {
                results.append(html)
            }
            #expect(results.count == 20)
            let first = results[0]
            for html in results {
                #expect(html == first)
            }
        }
    }
}
