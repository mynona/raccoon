import Foundation
import HTML
import SGML
import SVG
import Synchronization
import WebBuilders

private final class ThreadSafeDateFormatter: Sendable {
    private let mutex: Mutex<DateFormatter>

    init(configure: (DateFormatter) -> Void) {
        let formatter = DateFormatter()
        configure(formatter)
        self.mutex = Mutex(formatter)
    }

    func string(from date: Date) -> String {
        mutex.withLock { $0.string(from: date) }
    }
}

private enum DatePickerFormatters {
    static let iso = ThreadSafeDateFormatter {
        $0.dateFormat = "yyyy-MM-dd"
    }

    static let submission = ThreadSafeDateFormatter {
        $0.locale = Locale(identifier: "en_US_POSIX")
        $0.timeZone = TimeZone(identifier: "Europe/Vienna") ?? .current
        $0.dateFormat = "EEE MMM dd yyyy"
    }

    static let day = ThreadSafeDateFormatter {
        $0.dateFormat = "dd"
    }

    static let month = ThreadSafeDateFormatter {
        $0.dateFormat = "MM"
    }

    static let year = ThreadSafeDateFormatter {
        $0.dateFormat = "yyyy"
    }

    static let ddDotMmDotYyyy = ThreadSafeDateFormatter {
        $0.dateFormat = "dd.MM.yyyy"
    }

    static let ddSlashMmSlashYyyy = ThreadSafeDateFormatter {
        $0.dateFormat = "dd/MM/yyyy"
    }

    static let mmSlashDdSlashYyyy = ThreadSafeDateFormatter {
        $0.dateFormat = "MM/dd/yyyy"
    }

    static func display(for format: DatePickerFormat) -> ThreadSafeDateFormatter {
        switch format {
        case .dd_mm_yyyy: ddDotMmDotYyyy
        case .yyyy_mm_dd: iso
        case .dd_slash_mm_slash_yyyy: ddSlashMmSlashYyyy
        case .mm_dd_yyyy: mmSlashDdSlashYyyy
        }
    }
}

public struct DatePicker: TemplateRepresentable {
    let data: DatePickerData
    typealias styles = DatePickerStyles

    public init(
        _ data: DatePickerData
    ) {
        self.data = data
    }

    func mapDate(_ date: Date?) -> String {
        guard let d = date else { return "" }
        return DatePickerFormatters.iso.string(from: d)
    }

    func submissionDate(_ date: Date?) -> String {
        guard let d = date else { return "" }
        return DatePickerFormatters.submission.string(from: d)
    }

    func formatDisplayDate(_ date: Date?, format: DatePickerFormat) -> String {
        guard let d = date else { return "" }
        return DatePickerFormatters.display(for: format).string(from: d)
    }

    func initialDay(_ date: Date?) -> String {
        guard let d = date else { return "" }
        return DatePickerFormatters.day.string(from: d)
    }

    func initialMonth(_ date: Date?) -> String {
        guard let d = date else { return "" }
        return DatePickerFormatters.month.string(from: d)
    }

    func initialYear(_ date: Date?) -> String {
        guard let d = date else { return "" }
        return DatePickerFormatters.year.string(from: d)
    }

    @Builder<Element>
    func renderDelimiterIcon(format: DatePickerFormat) -> [Element] {
        switch format {
        case .dd_mm_yyyy:
            Svg.icon(.dot, width: 14, height: 14)
                .class(
                    "shrink-0 text-on-surface-dim select-none pointer-events-none"
                )
        case .dd_slash_mm_slash_yyyy, .mm_dd_yyyy:
            Svg.icon(.slash, width: 12, height: 12)
                .class(
                    "shrink-0 text-on-surface-dim select-none pointer-events-none"
                )
        case .yyyy_mm_dd:
            Svg.icon(.dash, width: 12, height: 12)
                .class(
                    "shrink-0 text-on-surface-dim select-none pointer-events-none"
                )
        }
    }

    @Builder<Element>
    func renderDaySegment(isFirst: Bool) -> [Element] {
        Input()
            .if(isFirst) {
                $0.id(data.label?.id ?? data.id)
            } else: {
                $0.id("\(data.label?.id ?? data.id)-day")
            }
            .type(.text)
            .setAttribute(name: "inputmode", value: "numeric")
            .placeholder("DD")
            .ariaLabel("Day")
            .value(initialDay(data.value))
            .setAttribute(name: "maxlength", value: "2")
            .setAttribute(name: "size", value: "2")
            .style("width: 2.4ch;")
            .setAttribute(name: "x-model", value: "dayInput")
            .setAttribute(name: "x-ref", value: "dayInput")
            .setAttribute(name: "@input", value: "onDayInput($event)")
            .setAttribute(name: "@keydown", value: "onDayKeydown($event)")
            .setAttribute(name: "@blur", value: "onSegmentBlur()")
            .setAttribute(name: "autocomplete", value: "off")
            .setAttribute(
                name: ":aria-invalid",
                value: "(hasServerError || hasError) ? 'true' : 'false'"
            )
            .class(
                "shrink-0 text-center p-0 block font-normal leading-6 bg-transparent border-0 ring-0 focus:ring-0 focus:outline-hidden"
            )
            .addClass(styles.textSizeSmall)
            .addClass(styles.inputFieldReset)
            .addClass(styles.textColorDefault)
    }

    @Builder<Element>
    func renderMonthSegment(isFirst: Bool) -> [Element] {
        Input()
            .if(isFirst) {
                $0.id(data.label?.id ?? data.id)
            } else: {
                $0.id("\(data.label?.id ?? data.id)-month")
            }
            .type(.text)
            .setAttribute(name: "inputmode", value: "numeric")
            .placeholder("MM")
            .ariaLabel("Month")
            .value(initialMonth(data.value))
            .setAttribute(name: "maxlength", value: "2")
            .setAttribute(name: "size", value: "2")
            .style("width: 2.4ch;")
            .setAttribute(name: "x-model", value: "monthInput")
            .setAttribute(name: "x-ref", value: "monthInput")
            .setAttribute(name: "@input", value: "onMonthInput($event)")
            .setAttribute(name: "@keydown", value: "onMonthKeydown($event)")
            .setAttribute(name: "@blur", value: "onSegmentBlur()")
            .setAttribute(name: "autocomplete", value: "off")
            .setAttribute(
                name: ":aria-invalid",
                value: "(hasServerError || hasError) ? 'true' : 'false'"
            )
            .class(
                "shrink-0 text-center p-0 block font-normal leading-6 bg-transparent border-0 ring-0 focus:ring-0 focus:outline-hidden"
            )
            .addClass(styles.textSizeSmall)
            .addClass(styles.inputFieldReset)
            .addClass(styles.textColorDefault)
    }

    @Builder<Element>
    func renderYearSegment(isFirst: Bool) -> [Element] {
        Input()
            .if(isFirst) {
                $0.id(data.label?.id ?? data.id)
            } else: {
                $0.id("\(data.label?.id ?? data.id)-year")
            }
            .type(.text)
            .setAttribute(name: "inputmode", value: "numeric")
            .placeholder("YYYY")
            .ariaLabel("Year")
            .value(initialYear(data.value))
            .setAttribute(name: "maxlength", value: "4")
            .setAttribute(name: "size", value: "4")
            .style("width: 4.6ch;")
            .setAttribute(name: "x-model", value: "yearInput")
            .setAttribute(name: "x-ref", value: "yearInput")
            .setAttribute(name: "@input", value: "onYearInput($event)")
            .setAttribute(name: "@keydown", value: "onYearKeydown($event)")
            .setAttribute(name: "@blur", value: "onSegmentBlur()")
            .setAttribute(name: "autocomplete", value: "off")
            .setAttribute(
                name: ":aria-invalid",
                value: "(hasServerError || hasError) ? 'true' : 'false'"
            )
            .class(
                "shrink-0 text-center p-0 block font-normal leading-6 bg-transparent border-0 ring-0 focus:ring-0 focus:outline-hidden"
            )
            .addClass(styles.textSizeSmall)
            .addClass(styles.inputFieldReset)
            .addClass(styles.textColorDefault)
    }

    @Builder<Element>
    func renderSegments() -> [Element] {
        switch data.format {
        case .dd_mm_yyyy, .dd_slash_mm_slash_yyyy:
            renderDaySegment(isFirst: true)
            renderDelimiterIcon(format: data.format)
            renderMonthSegment(isFirst: false)
            renderDelimiterIcon(format: data.format)
            renderYearSegment(isFirst: false)
        case .mm_dd_yyyy:
            renderMonthSegment(isFirst: true)
            renderDelimiterIcon(format: data.format)
            renderDaySegment(isFirst: false)
            renderDelimiterIcon(format: data.format)
            renderYearSegment(isFirst: false)
        case .yyyy_mm_dd:
            renderYearSegment(isFirst: true)
            renderDelimiterIcon(format: data.format)
            renderMonthSegment(isFirst: false)
            renderDelimiterIcon(format: data.format)
            renderDaySegment(isFirst: false)
        }
    }

    @Builder<Element>
    func showDatepicker() -> [Element] {
        Div {

            Div {

                Div {

                    // Name of the month
                    Span {}
                        .setAttribute(
                            name: "x-text",
                            value: "MONTH_NAMES[month]"
                        )
                        .class(styles.monthText)
                        .addClass(styles.text)

                    // Year
                    Span {}
                        .setAttribute(
                            name: "x-text",
                            value: "year"
                        )
                        .class("ml-1")
                        .addClass(styles.yearText)
                        .addClass(styles.text)
                }

                // Change month left/right chevrons
                Div {
                    Button {
                        Svg.icon(
                            .chevron_left,
                            width: 20,
                            height: 20
                        )
                    }
                    .type(.button)
                    .setAttribute(
                        name: "@click",
                        value:
                            "month--; if (month < 0) { if (year > 0) { year--; month = 11 } else { month = 0 } }; getNoOfDays();"
                    )
                    .class(
                        "transition ease-in-out duration-100 inline-flex cursor-pointer p-1  rounded-full"
                    )
                    .ariaLabel("Previous Month")
                    .addClass(styles.hoverDefault)
                    .addClass(styles.focusDefault)

                    Button {
                        Svg.icon(
                            .chevron_right,
                            width: 20,
                            height: 20
                        )
                    }
                    .type(.button)
                    .setAttribute(
                        name: "@click",
                        value:
                            "month++; if (month > 11) { if (year < 3000) { year++; month = 0 } else { month = 11 } }; getNoOfDays();"
                    )
                    .class(
                        "transition ease-in-out duration-100 inline-flex cursor-pointer p-1 rounded-full"
                    )
                    .ariaLabel("Next month")
                    .addClass(styles.hoverDefault)
                    .addClass(styles.focusDefault)

                }
                .class("flex items-center space-x-3")

            }
            .class("flex justify-between items-center mb-2")

            // Header Week days
            Div {
                Template {
                    Div {
                        Div {}
                            .setAttribute(
                                name: "x-text",
                                value: "day"
                            )
                            .class(styles.weekDaysText)
                            .addClass(styles.textSizeSmall)
                            .addClass(styles.text)
                    }
                    .style("width: 14.26%;")
                    .class("px-1")
                }
                .setAttribute(
                    name: "x-for",
                    value: "(day, index) in DAYS"
                )
                .setAttribute(
                    name: ":key",
                    value: "index"
                )
            }
            .class("flex flex-wrap mb-3 -mx-1")

            Div {
                Template {
                    Div {}
                        .style("width: 14.28%;")
                        .class(
                            "text-center border p-1 border-transparent"
                        )
                        .addClass(styles.textSizeSmall)
                }
                .setAttribute(
                    name: "x-for",
                    value: "blankday in blankdays"
                )
                Template {
                    Div {
                        Button {}
                            .type(.button)
                            .setAttribute(
                                name: "@click",
                                value: "getDateValue(date)"
                            )
                            .setAttribute(
                                name: "x-text",
                                value: "date"
                            )
                            .setAttribute(
                                name: ":data-day",
                                value: "date"
                            )
                            .setAttribute(
                                name: ":aria-label",
                                value: "formatFullDate(date)"
                            )
                            .setAttribute(
                                name: ":aria-pressed",
                                value: "isSelected(date)"
                            )
                            .setAttribute(
                                name: ":aria-current",
                                value: "isToday(date) ? 'date' : false"
                            )
                            // Roving tabindex: only one day is in the tab order, arrows move within
                            .setAttribute(
                                name: ":tabindex",
                                value: "isFocusable(date) ? 0 : -1"
                            )
                            .setAttribute(
                                name: ":class",
                                value:
                                    "{'\(styles.daySelected)': isSelected(date) == true, '\(styles.dayUnselected)': isSelected(date) == false }"
                            )
                            .class(
                                "cursor-pointer text-center leading-none rounded-md leading-loose transition ease-in-out duration-100 p-1"
                            )
                            .addClass(styles.textSizeSmall)
                            .addClass(styles.hoverDefault)
                            .addClass(styles.focusDefault)

                    }
                    .style("width: 14.28%")
                    .class("px-1 mb-3 w-[28px]")

                }
                .setAttribute(
                    name: "x-for",
                    value: "(date, dateIndex) in no_of_days"
                )
                .setAttribute(
                    name: ":key",
                    value: "dateIndex"
                )

            }
            .setAttribute(name: "x-ref", value: "dayGrid")
            .setAttribute(name: "role", value: "grid")
            .setAttribute(
                name: "@keydown.arrow-right.prevent",
                value: "moveFocus(1)"
            )
            .setAttribute(
                name: "@keydown.arrow-left.prevent",
                value: "moveFocus(-1)"
            )
            .setAttribute(
                name: "@keydown.arrow-down.prevent",
                value: "moveFocus(7)"
            )
            .setAttribute(
                name: "@keydown.arrow-up.prevent",
                value: "moveFocus(-7)"
            )
            .class("flex flex-wrap -mx-1")

        }
        .setAttribute(
            name: "@click.away",
            value: "showDatepicker = false"
        )
        .setAttribute(
            name: "x-show",
            value: "showDatepicker"
        )
        .flagAttribute("x-transition")
        .class(
            "mt-20 rounded-lg shadow p-4 absolute top-0 left-0 z-10"
        )
        .addClass(styles.datepicker)
        .style("width: 17rem")
    }

    @Builder<Element>
    func showLabel() -> [Element] {
        if let label = data.label {
            Label(label).render()
        }
    }

    @Builder<Element>
    func showInfo() -> [Element] {
        Div {

            showLabel()
            P("\(formatDisplayDate(data.value, format: data.format))")

            // Hidden input to be compliant with accessibility rules
            // for the Label id
            if data.label != nil {
                Input()
                    .id(data.label?.id ?? data.id)
                    .name(data.label?.id ?? data.id)
                    .type(.text)
                    .setAttribute(name: "tabindex", value: "-1")
                    .setAttribute(name: "aria-hidden", value: "true")
                    .class("sr-only")

            }
        }
        .class("px-3 pb-1.5 pt-2.5")
        .addClass(styles.info)
        .if(data.backgroundColor != nil) {
            $0.style("background-color: \(data.backgroundColor!);")
        } else: {
            $0.addClass("bg-transparent")
        }
    }

    @Builder<Element>
    func showDisabled() -> [Element] {
        Div {
            Div {

                showLabel()

                Div {
                    Input()
                        .disabled()
                        .id(data.label?.id ?? data.id)
                        .name(data.label?.id ?? data.id)
                        .value(
                            "\(formatDisplayDate(data.value, format: data.format))"
                        )
                        .class(
                            "border-0 font-normal sm:text-sm block w-full p-0 sm:leading-6 bg-transparent cursor-not-allowed"
                        )
                        .addClass(styles.disabledInput)

                    Svg.icon(
                        .calendar,
                        title: "Calendar",
                        width: 16,
                        height: 16,
                        role: .img
                    )

                }
                .class("flex")

            }
            .class(
                "ring-1 relative rounded-md px-3 pb-1.5 pt-2.5 shadow-sm cursor-not-allowed"
            )
            .addClass(styles.disabled)
            .if(data.backgroundColor != nil) {
                $0.style("background-color: \(data.backgroundColor!);")
            } else: {
                $0.addClass("bg-transparent")
            }

        }
        .class("cursor-not-allowed")
    }

    @Builder<Element>
    func showErrorMessages() -> [Element] {
        if let errorMessages = data.errorMessages {
            Div {
                ErrorMessage(errorMessages).render()
            }
            .setAttribute(
                name: "x-show",
                value: "hasServerError"
            )
        }
    }

    @Builder<Element>
    func showEnabled() -> [Element] {

        Script()
            .src("/js/datepicker.js")
            .setAttribute(name: "type", value: "text/javascript")

        Div {
            Div {
                Input()
                    .value("\(submissionDate(data.value))")
                    .type(.hidden)
                    .name(data.id)
                    .setAttribute(name: "x-ref", value: "date")
                    .setAttribute(
                        name: "data-matomo-name",
                        value: "\(data.label?.title ?? "input")"
                    )
                    .class(styles.inputFieldReset)
                    .addClass(styles.textColorInput)

                Div {
                    Div {
                        showLabel()
                        Div {
                            renderSegments()
                            Div {}.class("flex-1 min-w-2")

                            ActionButton(
                                ActionButtonData(
                                    id: "\(data.id)-calendar",
                                    clickAction:
                                        "showDatepicker = !showDatepicker",
                                    bindAriaExpanded: "showDatepicker",
                                    ariaLabel: "Open calendar view",
                                    htmlType: .button,
                                    buttonType: .icon,
                                    icon: .calendar,
                                    contentTracker: MatomoContentTracker(
                                        name: "button",
                                        piece: "datepicker.calendar",
                                        target: ""
                                    )
                                )
                            )
                            .render()

                        }
                        .class("flex items-center py-2.5")
                    }
                    .setAttribute(
                        name: "@keydown.escape",
                        value: "showDatepicker = false"
                    )
                    .setAttribute(
                        name: "@keydown.down",
                        value: "showDatepicker = true"
                    )
                    .class(
                        "w-full pb-1.5 pt-2.5 px-3"
                    )
                    .setAttribute(
                        name: ":class",
                        value:
                            "[(hasServerError || hasError) ? '\(styles.errorBorder)' : '\(styles.regularBorder)', showDatepicker ? 'datepicker-open' : '']"
                    )
                    .if(data.backgroundColor != nil) {
                        $0.style("background-color: \(data.backgroundColor!);")
                    } else: {
                        $0.addClass("bg-transparent")
                    }
                }
                .class("relative")
                .addClass(styles.inputContainerBorder)
                .addClass(styles.inputContainerHover)
                .addClass(styles.inputContainerFocus)
                showDatepicker()
            }
            .class("relative ")
            // Local client-side format validation error
            Div {
                P {}
                    .setAttribute(name: "x-text", value: "errorMessage")
                    .class("\(styles.textColorError) text-sm mt-1")
            }
            .setAttribute(name: "x-show", value: "hasError")
            .flagAttribute("x-cloak")
            showErrorMessages()
        }
        .setAttribute(
            name: "x-data",
            value:
                "datePickerWidget({ value: \(JavaScriptEscaper.alpineStringLiteral(mapDate(data.value))), format: \(JavaScriptEscaper.alpineStringLiteral(data.format.rawValue)), hasServerError: \(data.errorMessages != nil ? "true" : "false") })"
        )
        .setAttribute(
            name: "x-init",
            value: "[initDate(), getNoOfDays()]"
        )
        .flagAttribute("x-cloak")
    }

    @Builder<Element>
    public func render() -> [Element] {
        DebugComment("Datepicker")
        switch data.state {

        case .enabled:
            showEnabled()

        case .disabled, .hidden:
            showDisabled()

        case .info:
            showInfo()
        }
    }

}
