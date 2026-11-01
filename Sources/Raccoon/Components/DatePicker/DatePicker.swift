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

    static func display(for format: DatePickerFormat) -> ThreadSafeDateFormatter
    {
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

    func initialWeek(_ date: Date?) -> String {
        guard let d = date else { return "W01" }
        var calendar = Calendar(identifier: .gregorian)
        calendar.firstWeekday = 2
        calendar.minimumDaysInFirstWeek = 4
        let week = calendar.component(.weekOfYear, from: d)
        return String(format: "W%02d", week)
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
            .setAttribute(
                name: "@keydown.enter.prevent",
                value: "showDatepicker = true"
            )
            .setAttribute(
                name: "@keydown.down.prevent",
                value: "showDatepicker = true"
            )
            .setAttribute(name: "@focus", value: "showDatepicker = true")
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
            .setAttribute(
                name: "@keydown.enter.prevent",
                value: "showDatepicker = true"
            )
            .setAttribute(
                name: "@keydown.down.prevent",
                value: "showDatepicker = true"
            )
            .setAttribute(name: "@focus", value: "showDatepicker = true")
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
            .setAttribute(
                name: "@keydown.enter.prevent",
                value: "showDatepicker = true"
            )
            .setAttribute(
                name: "@keydown.down.prevent",
                value: "showDatepicker = true"
            )
            .setAttribute(name: "@focus", value: "showDatepicker = true")
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
    func renderShortcutsSidebar() -> [Element] {
        Div {
            Div {
                Span(data.isRange ? "Quick Ranges" : "Quick Select")
                    .class(styles.weekNumberBadge)
                    .addClass(
                        "block text-xs uppercase tracking-wider mb-2 font-semibold"
                    )

                if !data.isRange {
                    Div {
                        Button {
                            Span("Today")
                        }
                        .type(.button)
                        .setAttribute(name: "@click", value: "selectToday()")
                        .class(styles.shortcutButton)

                        Button {
                            Span("Yesterday")
                        }
                        .type(.button)
                        .setAttribute(
                            name: "@click",
                            value: "selectYesterday()"
                        )
                        .class(styles.shortcutButton)

                        Button {
                            Span("This Week")
                        }
                        .type(.button)
                        .setAttribute(name: "@click", value: "selectThisWeek()")
                        .class(styles.shortcutButton)

                        Button {
                            Span("This Month")
                        }
                        .type(.button)
                        .setAttribute(
                            name: "@click",
                            value: "selectThisMonth()"
                        )
                        .class(styles.shortcutButton)
                    }
                    .id("\(data.id)-grid")
                    .class("datepicker-responsive-grid space-y-1.5")
                }
                else {
                    Div {
                        Button {
                            Span("Today")
                        }
                        .type(.button)
                        .setAttribute(
                            name: "@click",
                            value: "setPreset('today')"
                        )
                        .class(styles.shortcutButton)

                        Button {
                            Span("This Week")
                        }
                        .type(.button)
                        .setAttribute(
                            name: "@click",
                            value: "setPreset('this-week')"
                        )
                        .class(styles.shortcutButton)

                        Button {
                            Span("Last 7 Days")
                        }
                        .type(.button)
                        .setAttribute(
                            name: "@click",
                            value: "setPreset('last-7-days')"
                        )
                        .class(styles.shortcutButton)

                        Button {
                            Span("This Month")
                        }
                        .type(.button)
                        .setAttribute(
                            name: "@click",
                            value: "setPreset('this-month')"
                        )
                        .class(styles.shortcutButton)

                        Button {
                            Span("Last Month")
                        }
                        .type(.button)
                        .setAttribute(
                            name: "@click",
                            value: "setPreset('last-month')"
                        )
                        .class(styles.shortcutButton)

                        Button {
                            Span("Year to Date")
                        }
                        .type(.button)
                        .setAttribute(
                            name: "@click",
                            value: "setPreset('year-to-date')"
                        )
                        .class(styles.shortcutButton)
                    }
                    .id("\(data.id)-grid")
                    .class("datepicker-responsive-grid space-y-1.5")
                }
            }
        }
        .id("\(data.id)-sidebar")
        .class(styles.shortcutsSidebar)
        .addClass("datepicker-responsive-sidebar")
    }

    @Builder<Element>
    func renderCalendarHeader() -> [Element] {
        Div {
            Div {
                Span {}
                    .setAttribute(
                        name: "x-text",
                        value: "MONTH_NAMES[month]"
                    )
                    .class(styles.monthText)
                    .addClass(styles.text)

                // Year dropdown
                Div {
                    Button {
                        Span {}
                            .setAttribute(name: "x-text", value: "year")
                        Svg.icon(.chevron_down, width: 12, height: 12)
                            .class(styles.textColorMuted)
                    }
                    .type(.button)
                    .setAttribute(
                        name: "@click",
                        value:
                            "openYearDropdown = !openYearDropdown; openYearDropdown2 = false"
                    )
                    .class(styles.yearDropdownTrigger)
                    .ariaLabel("Select Year")

                    Div {
                        Template {
                            Button {
                                Span {}
                                    .setAttribute(name: "x-text", value: "y")
                            }
                            .type(.button)
                            .setAttribute(
                                name: "@click",
                                value: "selectYear(y)"
                            )
                            .class(styles.dropdownItem)
                            .setAttribute(
                                name: ":class",
                                value:
                                    "year === y ? '\(styles.daySelected)' : '\(styles.dayUnselected)'"
                            )
                        }
                        .setAttribute(
                            name: "x-for",
                            value: "y in yearsList(year)"
                        )
                        .setAttribute(name: ":key", value: "y")
                    }
                    .setAttribute(name: "x-show", value: "openYearDropdown")
                    .setAttribute(
                        name: "@click.away",
                        value: "openYearDropdown = false"
                    )
                    .flagAttribute("x-cloak")
                    .class(
                        "absolute left-0 mt-1 w-24 max-h-48 overflow-y-auto z-50 p-1"
                    )
                    .addClass(styles.dropdownPanel)
                }
                .class("relative inline-block ml-1.5")
            }
            .class("flex items-center")

            Div {
                Button {
                    Svg.icon(
                        .chevron_left,
                        width: 18,
                        height: 18
                    )
                }
                .type(.button)
                .setAttribute(
                    name: "@click",
                    value:
                        "month--; if (month < 0) { if (year > 0) { year--; month = 11 } else { month = 0 } }; getNoOfDays();"
                )
                .class(
                    "p-1 rounded-md transition"
                )
                .addClass(styles.textColorMuted)
                .addClass(styles.hoverDefault)
                .addClass(styles.focusDefault)
                .ariaLabel("Previous Month")

                if !data.isRange {
                    Button {
                        Svg.icon(
                            .chevron_right,
                            width: 18,
                            height: 18
                        )
                    }
                    .type(.button)
                    .setAttribute(
                        name: "@click",
                        value:
                            "month++; if (month > 11) { if (year < 3000) { year++; month = 0 } else { month = 11 } }; getNoOfDays();"
                    )
                    .class(
                        "p-1 rounded-md transition"
                    )
                    .addClass(styles.textColorMuted)
                    .addClass(styles.hoverDefault)
                    .addClass(styles.focusDefault)
                    .ariaLabel("Next month")
                }
            }
            .class("flex items-center space-x-1")
        }
        .class("flex justify-between items-center mb-3")

        // Day of Week Headers: CSS Grid with 8 columns
        Div {
            Div {
                Span("Wk")
            }
            .class("text-[11px] border-r pr-1")
            .addClass(styles.regularBorder)

            Div {
                Span("Mo")
            }
            Div {
                Span("Tu")
            }
            Div {
                Span("We")
            }
            Div {
                Span("Th")
            }
            Div {
                Span("Fr")
            }
            Div {
                Span("Sa")
            }
            Div {
                Span("Su")
            }
        }
        .class(
            "grid grid-cols-8 text-center text-xs font-medium pb-1.5 border-b mb-1"
        )
        .style(
            "display: grid; grid-template-columns: 2.25rem repeat(7, minmax(0, 1fr));"
        )
        .addClass(styles.regularBorder)
        .addClass(styles.textColorMuted)
    }

    @Builder<Element>
    func renderCalendarRows() -> [Element] {
        Div {
            Template {
                Div {
                    // Column 1: Week number
                    Div {
                        Span {}
                            .setAttribute(
                                name: "x-text",
                                value: "row.week"
                            )
                    }
                    .class(styles.weekNumberColumn)

                    // Columns 2..8: 7 days
                    Template {
                        Div {
                            Template {
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
                                        value:
                                            "formatFullDate(date)"
                                    )
                                    .setAttribute(
                                        name: ":aria-pressed",
                                        value: "isSelected(date)"
                                    )
                                    .setAttribute(
                                        name: ":aria-current",
                                        value:
                                            "isToday(date) ? 'date' : false"
                                    )
                                    .setAttribute(
                                        name: ":tabindex",
                                        value:
                                            "isFocusable(date) ? 0 : -1"
                                    )
                                    .setAttribute(
                                        name: ":class",
                                        value:
                                            "{'\(styles.daySelected)': isSelected(date) == true, '\(styles.dayInRange)': isInRange(date) == true, '\(styles.dayToday)': isToday(date) && !isSelected(date), '\(styles.dayUnselected)': !isSelected(date) && !isInRange(date) }"
                                    )
                                    .class(
                                        "w-7 h-7 flex items-center justify-center rounded-md text-xs transition font-normal"
                                    )
                                    .addClass(styles.hoverDefault)
                                    .addClass(styles.focusDefault)
                            }
                            .setAttribute(
                                name: "x-if",
                                value: "date !== null"
                            )

                            Template {
                                Span("")
                                    .class("w-7 h-7 block")
                            }
                            .setAttribute(
                                name: "x-if",
                                value: "date === null"
                            )
                        }
                        .class(
                            "p-0.5 flex items-center justify-center"
                        )
                    }
                    .setAttribute(
                        name: "x-for",
                        value: "(date, dateIndex) in row.days"
                    )
                    .setAttribute(
                        name: ":key",
                        value: "dateIndex"
                    )
                }
                .class(
                    "grid grid-cols-8 items-center text-center text-xs border-b border-outline-variant dark:border-on-surface-dark py-0.5"
                )
                .style(
                    "display: grid; grid-template-columns: 2.25rem repeat(7, minmax(0, 1fr));"
                )
            }
            .setAttribute(
                name: "x-for",
                value: "(row, rowIndex) in calendarRows"
            )
            .setAttribute(
                name: ":key",
                value: "rowIndex"
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
        .class("space-y-1 mt-1")
    }

    @Builder<Element>
    func renderSecondMonth() -> [Element] {
        Div {
            // Month 2 Header & Next Chevron
            Div {
                Div {
                    Span {}
                        .setAttribute(
                            name: "x-text",
                            value: "MONTH_NAMES[month2]"
                        )
                        .class(styles.monthText)
                        .addClass(styles.text)

                    Span {}
                        .setAttribute(
                            name: "x-text",
                            value: "year2"
                        )
                        .class("ml-1 font-normal")
                        .addClass(styles.textColorMuted)
                }
                .class("flex items-center")

                Div {
                    Button {
                        Svg.icon(
                            .chevron_right,
                            width: 18,
                            height: 18
                        )
                    }
                    .type(.button)
                    .setAttribute(
                        name: "@click",
                        value:
                            "month++; if (month > 11) { if (year < 3000) { year++; month = 0 } else { month = 11 } }; getNoOfDays();"
                    )
                    .class(
                        "p-1 rounded-md transition"
                    )
                    .addClass(styles.textColorMuted)
                    .addClass(styles.hoverDefault)
                    .addClass(styles.focusDefault)
                    .ariaLabel("Next month")
                }
                .class("flex items-center space-x-1")
            }
            .class("flex justify-between items-center mb-3")

            // Day of Week Headers: CSS Grid with 8 columns
            Div {
                Div {
                    Span("Wk")
                }
                .class("text-[11px] border-r pr-1")
                .addClass(styles.regularBorder)

                Div {
                    Span("Mo")
                }
                Div {
                    Span("Tu")
                }
                Div {
                    Span("We")
                }
                Div {
                    Span("Th")
                }
                Div {
                    Span("Fr")
                }
                Div {
                    Span("Sa")
                }
                Div {
                    Span("Su")
                }
            }
            .class(
                "grid grid-cols-8 text-center text-xs font-medium pb-1.5 border-b mb-1"
            )
            .style(
                "display: grid; grid-template-columns: 2.25rem repeat(7, minmax(0, 1fr));"
            )
            .addClass(styles.regularBorder)
            .addClass(styles.textColorMuted)

            // Month 2 Rows with Week Numbers Column & Days
            Div {
                Template {
                    Div {
                        // Column 1: Week number
                        Div {
                            Span {}
                                .setAttribute(
                                    name: "x-text",
                                    value: "row.week"
                                )
                        }
                        .class(styles.weekNumberColumn)

                        // Columns 2..8: 7 days
                        Template {
                            Div {
                                Template {
                                    Button {}
                                        .type(.button)
                                        .setAttribute(
                                            name: "@click",
                                            value:
                                                "getDateValue(date, month2, year2)"
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
                                            value:
                                                "formatFullDate(date, month2, year2)"
                                        )
                                        .setAttribute(
                                            name: ":aria-pressed",
                                            value:
                                                "isSelected(date, month2, year2)"
                                        )
                                        .setAttribute(
                                            name: ":aria-current",
                                            value:
                                                "isToday(date, month2, year2) ? 'date' : false"
                                        )
                                        .setAttribute(
                                            name: ":tabindex",
                                            value:
                                                "isFocusable(date) ? 0 : -1"
                                        )
                                        .setAttribute(
                                            name: ":class",
                                            value:
                                                "{'\(styles.daySelected)': isSelected(date, month2, year2) == true, '\(styles.dayInRange)': isInRange(date, month2, year2) == true, '\(styles.dayToday)': isToday(date, month2, year2) && !isSelected(date, month2, year2), '\(styles.dayUnselected)': !isSelected(date, month2, year2) && !isInRange(date, month2, year2) }"
                                        )
                                        .class(
                                            "w-7 h-7 flex items-center justify-center rounded-md text-xs transition font-normal"
                                        )
                                        .addClass(styles.hoverDefault)
                                        .addClass(styles.focusDefault)
                                }
                                .setAttribute(
                                    name: "x-if",
                                    value: "date !== null"
                                )

                                Template {
                                    Span("")
                                        .class("w-7 h-7 block")
                                }
                                .setAttribute(
                                    name: "x-if",
                                    value: "date === null"
                                )
                            }
                            .class(
                                "p-0.5 flex items-center justify-center"
                            )
                        }
                        .setAttribute(
                            name: "x-for",
                            value: "(date, dateIndex) in row.days"
                        )
                        .setAttribute(
                            name: ":key",
                            value: "dateIndex"
                        )
                    }
                    .class(
                        "grid grid-cols-8 items-center text-center text-xs border-b border-outline-variant dark:border-on-surface-dark py-0.5"
                    )
                    .style(
                        "display: grid; grid-template-columns: 2.25rem repeat(7, minmax(0, 1fr));"
                    )
                }
                .setAttribute(
                    name: "x-for",
                    value: "(row, rowIndex) in calendarRows2"
                )
                .setAttribute(
                    name: ":key",
                    value: "rowIndex"
                )
            }
            .class("space-y-1 mt-1")
        }
        .id("\(data.id)-month2")
        .class(styles.calendarGridContainer)
        .addClass(styles.regularBorder)
    }

    @Builder<Element>
    func showDatepicker() -> [Element] {
        Div {
            renderShortcutsSidebar()

            Div {
                Div {
                    renderCalendarHeader()
                    renderCalendarRows()
                }
                .class(styles.calendarGridContainer)

                if data.isRange {
                    renderSecondMonth()
                }
            }
            .id("\(data.id)-calendars")
            .class("flex flex-col md:flex-row")
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
        .id("\(data.id)-popup")
        .class(
            "mt-2 shadow-xl absolute top-full left-0 z-50 flex overflow-hidden max-w-[calc(100vw-2rem)] datepicker-responsive-popup"
        )
        .addClass(styles.datepicker)
        .if(data.isRange) {
            $0.style("width: max-content; max-width: calc(100vw - 2rem);")
        } else: {
            $0.style("width: max-content; max-width: calc(100vw - 2rem);")
        }
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

        if data.isRange {
            Style(
                """
                @media (min-width: 1025px) {
                  #\(data.id)-popup { flex-direction: row !important; }
                  #\(data.id)-sidebar { width: auto !important; min-width: fit-content !important; border-bottom-width: 0 !important; border-right-width: 1px !important; }
                  #\(data.id)-grid { display: flex !important; flex-direction: column !important; }
                }
                @media (max-width: 1024px) {
                  #\(data.id)-popup { flex-direction: column !important; width: 100% !important; max-width: calc(100vw - 2rem) !important; }
                  #\(data.id)-sidebar { width: 100% !important; border-bottom-width: 1px !important; border-right-width: 0 !important; }
                  #\(data.id)-grid { display: grid !important; grid-template-columns: repeat(3, minmax(0, 1fr)) !important; gap: 0.375rem !important; }
                }
                @media (min-width: 769px) {
                  #\(data.id)-calendars { flex-direction: row !important; }
                  #\(data.id)-month2 { border-left-width: 1px !important; border-top-width: 0 !important; }
                }
                @media (max-width: 768px) {
                  #\(data.id)-calendars { flex-direction: column !important; }
                  #\(data.id)-month2 { border-top-width: 1px !important; border-left-width: 0 !important; }
                }
                """
            )
        }
        else {
            Style(
                """
                @media (min-width: 769px) {
                  #\(data.id)-popup { flex-direction: row !important; }
                  #\(data.id)-sidebar { width: auto !important; min-width: fit-content !important; border-bottom-width: 0 !important; border-right-width: 1px !important; }
                  #\(data.id)-grid { display: flex !important; flex-direction: column !important; }
                }
                @media (max-width: 768px) {
                  #\(data.id)-popup { flex-direction: column !important; width: 100% !important; max-width: calc(100vw - 2rem) !important; }
                  #\(data.id)-sidebar { width: 100% !important; border-bottom-width: 1px !important; border-right-width: 0 !important; }
                  #\(data.id)-grid { display: grid !important; grid-template-columns: repeat(2, minmax(0, 1fr)) !important; gap: 0.375rem !important; }
                }
                """
            )
        }

        Div {
            Div {
                // Primary hidden input for single date or range start (preserves CMS backend compatibility)
                Input()
                    .value("\(submissionDate(data.value))")
                    .type(.hidden)
                    .name(data.id)
                    .setAttribute(name: "x-ref", value: "date")
                    .setAttribute(
                        name: "data-matomo-name",
                        value: "\(data.label?.title?.english ?? "input")"
                    )
                    .class(styles.inputFieldReset)
                    .addClass(styles.textColorInput)

                // Optional secondary hidden input for range end date
                if data.isRange {
                    Input()
                        .value("\(submissionDate(data.endValue))")
                        .type(.hidden)
                        .name(data.endId ?? "\(data.id)_end")
                        .setAttribute(name: "x-ref", value: "endDate")
                        .class(styles.inputFieldReset)
                        .addClass(styles.textColorInput)
                }

                Div {
                    Div {
                        showLabel()
                        Div {
                            // Left quick stepper: previous month (single mode only)
                            if !data.isRange {
                                Button {
                                    Svg.icon(
                                        .chevron_left,
                                        width: 16,
                                        height: 16
                                    )
                                }
                                .type(.button)
                                .setAttribute(
                                    name: "@click.stop",
                                    value: "prevMonth()"
                                )
                                .ariaLabel("Previous month")
                                .class(styles.stepperButton)
                            }

                            // Centered group: calendar icon, date segments, pipe, and week number
                            Div {
                                Svg.icon(
                                    .calendar,
                                    title: "Calendar",
                                    width: 16,
                                    height: 16,
                                    role: .img
                                )
                                .class(
                                    "shrink-0 select-none pointer-events-none"
                                )
                                .addClass(styles.textColorInput)

                                if !data.isRange {
                                    Div {
                                        renderSegments()
                                    }
                                    .class("flex items-center")
                                }
                                else {
                                    Div {
                                        Span(
                                            data.value == nil
                                                ? "Select a date range"
                                                : "\(formatDisplayDate(data.value, format: data.format)) – \(formatDisplayDate(data.endValue, format: data.format))"
                                        )
                                        .setAttribute(
                                            name: "x-text",
                                            value:
                                                "rangeStart ? formatDateStr(rangeStart) + ' – ' + (rangeEnd ? formatDateStr(rangeEnd) : '...') : 'Select a date range'"
                                        )
                                        .class("text-sm font-medium")
                                        .addClass(styles.textColorInput)
                                    }
                                    .class("flex items-center")
                                }

                                Span("|")
                                    .class(styles.pipeDelimiter)
                                    .setAttribute(
                                        name: "x-show",
                                        value: "selectedDate || rangeStart"
                                    )

                                Span(initialWeek(data.value))
                                    .setAttribute(
                                        name: "x-text",
                                        value: "currentWeekText"
                                    )
                                    .setAttribute(
                                        name: "x-show",
                                        value: "selectedDate || rangeStart"
                                    )
                                    .class(styles.weekNumberBadge)
                            }
                            .ariaLabel("Open calendar view")
                            .setAttribute(
                                name: ":aria-expanded",
                                value: "showDatepicker"
                            )
                            .class(
                                "flex items-center space-x-2 cursor-pointer select-none mx-auto"
                            )
                            .setAttribute(
                                name: "@click",
                                value: "showDatepicker = !showDatepicker"
                            )

                            // Right quick stepper: next month (single mode only)
                            if !data.isRange {
                                Button {
                                    Svg.icon(
                                        .chevron_right,
                                        width: 16,
                                        height: 16
                                    )
                                }
                                .type(.button)
                                .setAttribute(
                                    name: "@click.stop",
                                    value: "nextMonth()"
                                )
                                .ariaLabel("Next month")
                                .class(styles.stepperButton)
                            }
                        }
                        .class(styles.pillContainer)
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
                "datePickerWidget({ value: \(JavaScriptEscaper.alpineStringLiteral(mapDate(data.value))), endValue: \(JavaScriptEscaper.alpineStringLiteral(mapDate(data.endValue))), format: \(JavaScriptEscaper.alpineStringLiteral(data.format.rawValue)), hasServerError: \(data.errorMessages != nil ? "true" : "false"), isRange: \(data.isRange ? "true" : "false"), isEmpty: \(data.value == nil ? "true" : "false"), minYear: \(data.minYear.map(String.init) ?? "null"), maxYear: \(data.maxYear.map(String.init) ?? "null") })"
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
