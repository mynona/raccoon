// V2.0

// Guard against double registration if the script is included twice
if (!window.__datePickerLoaded) {
  window.__datePickerLoaded = true;

  const DEFAULT_MONTH_NAMES = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  const DEFAULT_DAYS = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  const LOCALES = {
    'DD.MM.YYYY': {
      placeholder: 'DD.MM.YYYY'
    },
    'YYYY-MM-DD': {
      placeholder: 'YYYY-MM-DD'
    },
    'DD/MM/YYYY': {
      placeholder: 'DD/MM/YYYY'
    },
    'MM/DD/YYYY': {
      placeholder: 'MM/DD/YYYY'
    }
  };

  function normalizeFormat(fmt) {
    const s = String(fmt || '').toUpperCase().trim();
    if (s === 'YYYY-MM-DD' || s === 'YYY-MM-DD' || s === 'ISO') return 'YYYY-MM-DD';
    if (s === 'DD/MM/YYYY' || s === 'UK') return 'DD/MM/YYYY';
    if (s === 'MM/DD/YYYY' || s === 'US') return 'MM/DD/YYYY';
    if (s === 'DD.MM.YYYY' || s === 'DACH' || s === 'AUSTRIAN') return 'DD.MM.YYYY';
    return 'DD.MM.YYYY';
  }

  LOCALES.dach = LOCALES['DD.MM.YYYY'];
  LOCALES.austrian = LOCALES['DD.MM.YYYY'];
  LOCALES.iso = LOCALES['YYYY-MM-DD'];
  LOCALES.uk = LOCALES['DD/MM/YYYY'];
  LOCALES.us = LOCALES['MM/DD/YYYY'];

  function registerDatePicker() {
    if (typeof Alpine === 'undefined') return;

    Alpine.data('datePickerWidget', ({
      value = '',
      endValue = '',
      format = 'DD.MM.YYYY',
      hasServerError = false,
      isRange = false,
      isEmpty = false,
      minYear = null,
      maxYear = null
    } = {}) => {
      const activeFormat = normalizeFormat(format);

      return {
        showDatepicker: false,
        datepickerValue: '',
        dayInput: '',
        monthInput: '',
        yearInput: '',
        hasServerError,
        hasError: false,
        errorMessage: '',
        format: activeFormat,
        isDeleting: false,
        month: 0,
        year: 0,
        no_of_days: [],
        blankdays: [],
        calendarRows: [],
        calendarRows2: [],
        DAYS: DEFAULT_DAYS,
        MONTH_NAMES: DEFAULT_MONTH_NAMES,
        selectedDate: null,
        // Day number of the currently tab-reachable cell (roving tabindex)
        focusedDate: null,
        // Date range extension
        isRange,
        rangeStart: null,
        rangeEnd: null,
        hoverDate: null,
        openMonthDropdown: false,
        openWeekDropdown: false,
        openYearDropdown: false,

      // Auto-masks digits into date format (e.g. DD.MM.YYYY or DD/MM/YYYY) so user doesn't need to type delimiters
      applyMask(raw) {
        if (!raw) return '';
        const str = String(raw);
        let digits = str.replace(/\D/g, '');

        // If user typed a delimiter explicitly after 1 or 3 digits (e.g. "6." or "06.2.")
        if (!this.isDeleting && (str.endsWith('.') || str.endsWith('/') || str.endsWith('-'))) {
          if (this.format !== 'YYYY-MM-DD') {
            if (digits.length === 1) {
              digits = '0' + digits;
            } else if (digits.length === 3) {
              digits = digits.slice(0, 2) + '0' + digits.slice(2);
            }
          }
        }

        if (this.format === 'YYYY-MM-DD') {
          const limited = digits.slice(0, 8);
          if (limited.length <= 4) {
            return (limited.length === 4 && !this.isDeleting) ? limited + '-' : limited;
          }
          if (limited.length <= 6) {
            const p1 = limited.slice(0, 4) + '-';
            const p2 = limited.slice(4);
            return (limited.length === 6 && !this.isDeleting) ? p1 + p2 + '-' : p1 + p2;
          }
          return limited.slice(0, 4) + '-' + limited.slice(4, 6) + '-' + limited.slice(6, 8);
        }

        const delim = this.format === 'DD.MM.YYYY' ? '.' : '/';
        const limited = digits.slice(0, 8);
        if (limited.length <= 2) {
          return (limited.length === 2 && !this.isDeleting) ? limited + delim : limited;
        }
        if (limited.length <= 4) {
          const p1 = limited.slice(0, 2) + delim;
          const p2 = limited.slice(2);
          return (limited.length === 4 && !this.isDeleting) ? p1 + p2 + delim : p1 + p2;
        }
        return limited.slice(0, 2) + delim + limited.slice(2, 4) + delim + limited.slice(4, 8);
      },

      // ISO-8601 calendar week calculation
      getISOWeekNumber(d) {
        if (!d || isNaN(d.getTime())) return 1;
        const target = new Date(Date.UTC(d.getFullYear(), d.getMonth(), d.getDate()));
        const dayNr = target.getUTCDay() === 0 ? 7 : target.getUTCDay();
        target.setUTCDate(target.getUTCDate() + 4 - dayNr);
        const yearStart = new Date(Date.UTC(target.getUTCFullYear(), 0, 1));
        return Math.ceil((((target - yearStart) / 86400000) + 1) / 7);
      },

      formatWeek(d) {
        return 'W' + String(this.getISOWeekNumber(d)).padStart(2, '0');
      },

      get currentWeekNum() {
        const d = this.selectedDate || new Date();
        return this.getISOWeekNumber(d);
      },

      get currentWeekText() {
        const d = this.selectedDate || new Date();
        if (this.isRange && this.rangeStart) {
          const w1 = this.formatWeek(this.rangeStart);
          if (!this.rangeEnd) return w1;
          const w2 = this.formatWeek(this.rangeEnd);
          return w1 === w2 ? w1 : `${w1}–${w2}`;
        }
        return this.formatWeek(d);
      },

      get month2() {
        return Number(this.month) === 11 ? 0 : Number(this.month) + 1;
      },

      get year2() {
        return Number(this.month) === 11 ? Number(this.year) + 1 : Number(this.year);
      },

      formatDateStr(d) {
        if (!d || isNaN(d.getTime())) return '';
        const day = String(d.getDate()).padStart(2, '0');
        const mon = String(d.getMonth() + 1).padStart(2, '0');
        const yr = d.getFullYear();
        if (this.format === 'YYYY-MM-DD') return `${yr}-${mon}-${day}`;
        if (this.format === 'MM/DD/YYYY') return `${mon}/${day}/${yr}`;
        if (this.format === 'DD/MM/YYYY') return `${day}/${mon}/${yr}`;
        return `${day}.${mon}.${yr}`;
      },

      // Step month back via quick arrow
      prevMonth() {
        let cur = this.selectedDate ? new Date(this.selectedDate) : new Date();
        let m = cur.getMonth() - 1;
        let y = cur.getFullYear();
        if (m < 0) {
          m = 11;
          y--;
        }
        const maxDays = this.getMaxDays(y, m + 1);
        const day = Math.min(cur.getDate(), maxDays);
        const target = new Date(2000, 0, 1);
        target.setFullYear(y, m, day);
        this.applyDate(target);
        this.syncInputsFromDate(target);
        this.hasError = false;
        this.hasServerError = false;
        this.errorMessage = '';
      },

      // Step month forward via quick arrow
      nextMonth() {
        let cur = this.selectedDate ? new Date(this.selectedDate) : new Date();
        let m = cur.getMonth() + 1;
        let y = cur.getFullYear();
        if (m > 11) {
          m = 0;
          y++;
        }
        const maxDays = this.getMaxDays(y, m + 1);
        const day = Math.min(cur.getDate(), maxDays);
        const target = new Date(2000, 0, 1);
        target.setFullYear(y, m, day);
        this.applyDate(target);
        this.syncInputsFromDate(target);
        this.hasError = false;
        this.hasServerError = false;
        this.errorMessage = '';
      },

      selectToday() {
        const today = new Date();
        this.applyDate(today);
        this.syncInputsFromDate(today);
        if (this.isRange) {
          this.rangeStart = today;
          this.rangeEnd = today;
          if (this.$refs.date) this.$refs.date.value = today.toDateString();
          if (this.$refs.endDate) this.$refs.endDate.value = today.toDateString();
        }
        this.hasError = false;
        this.hasServerError = false;
        this.errorMessage = '';
        this.showDatepicker = false;
      },

      selectYesterday() {
        const d = new Date();
        d.setDate(d.getDate() - 1);
        this.applyDate(d);
        this.syncInputsFromDate(d);
        if (this.isRange) {
          this.rangeStart = d;
          this.rangeEnd = d;
          if (this.$refs.date) this.$refs.date.value = d.toDateString();
          if (this.$refs.endDate) this.$refs.endDate.value = d.toDateString();
        }
        this.hasError = false;
        this.hasServerError = false;
        this.errorMessage = '';
        this.showDatepicker = false;
      },

      selectThisMonth() {
        const now = new Date();
        const d = new Date(2000, 0, 1);
        d.setFullYear(now.getFullYear(), now.getMonth(), 1);
        this.applyDate(d);
        this.syncInputsFromDate(d);
        if (this.isRange) {
          this.rangeStart = d;
          this.rangeEnd = new Date(now.getFullYear(), now.getMonth() + 1, 0);
          if (this.$refs.date) this.$refs.date.value = this.rangeStart.toDateString();
          if (this.$refs.endDate) this.$refs.endDate.value = this.rangeEnd.toDateString();
        }
        this.hasError = false;
        this.hasServerError = false;
        this.errorMessage = '';
        this.showDatepicker = false;
      },

      selectThisWeek() {
        const now = new Date();
        const day = now.getDay() || 7;
        const start = new Date(now);
        start.setDate(now.getDate() - day + 1);
        this.applyDate(start);
        this.syncInputsFromDate(start);
        if (this.isRange) {
          this.rangeStart = start;
          const end = new Date(start);
          end.setDate(start.getDate() + 6);
          this.rangeEnd = end;
          if (this.$refs.date) this.$refs.date.value = start.toDateString();
          if (this.$refs.endDate) this.$refs.endDate.value = end.toDateString();
        }
        this.hasError = false;
        this.hasServerError = false;
        this.errorMessage = '';
        this.showDatepicker = false;
      },

      setPreset(preset) {
        const now = new Date();
        let start = new Date();
        let end = new Date();
        if (preset === 'today') {
          start = new Date(now.getFullYear(), now.getMonth(), now.getDate());
          end = new Date(now.getFullYear(), now.getMonth(), now.getDate());
        } else if (preset === 'this-week') {
          const day = now.getDay() || 7;
          start = new Date(now);
          start.setDate(now.getDate() - day + 1);
          end = new Date(start);
          end.setDate(start.getDate() + 6);
        } else if (preset === 'last-7-days') {
          start = new Date(now);
          start.setDate(now.getDate() - 6);
          end = now;
        } else if (preset === 'this-month') {
          start = new Date(now.getFullYear(), now.getMonth(), 1);
          end = new Date(now.getFullYear(), now.getMonth() + 1, 0);
        } else if (preset === 'last-month') {
          start = new Date(now.getFullYear(), now.getMonth() - 1, 1);
          end = new Date(now.getFullYear(), now.getMonth(), 0);
        } else if (preset === 'year-to-date') {
          start = new Date(now.getFullYear(), 0, 1);
          end = now;
        }
        this.rangeStart = start;
        this.rangeEnd = end;
        this.applyDate(start);
        this.syncInputsFromDate(start);
        if (this.$refs.date) this.$refs.date.value = start.toDateString();
        if (this.$refs.endDate) this.$refs.endDate.value = end.toDateString();
        this.hasError = false;
        this.hasServerError = false;
        this.errorMessage = '';
        this.showDatepicker = false;
      },

      selectMonth(monthIndex) {
        let cur = this.selectedDate ? new Date(this.selectedDate) : new Date();
        let y = Number(this.year);
        let m = Number(monthIndex);
        const maxDays = this.getMaxDays(y, m + 1);
        const day = Math.min(cur.getDate(), maxDays);
        const target = new Date(2000, 0, 1);
        target.setFullYear(y, m, day);
        this.applyDate(target);
        this.syncInputsFromDate(target);
      },

      selectWeek(weekNum) {
        const y = Number(this.year);
        const simple = new Date(Date.UTC(y, 0, 1 + (Number(weekNum) - 1) * 7));
        const dow = simple.getUTCDay();
        const ISOweekStart = simple;
        if (dow <= 4) {
          ISOweekStart.setUTCDate(simple.getUTCDate() - simple.getUTCDay() + 1);
        } else {
          ISOweekStart.setUTCDate(simple.getUTCDate() + 8 - simple.getUTCDay());
        }
        const target = new Date(2000, 0, 1);
        target.setFullYear(ISOweekStart.getUTCFullYear(), ISOweekStart.getUTCMonth(), ISOweekStart.getUTCDate());
        this.applyDate(target);
        this.syncInputsFromDate(target);
      },

      yearsList(baseYear) {
        const current = Number(baseYear) || Number(this.year) || new Date().getFullYear();
        // Configured bounds win; otherwise 50 years around the displayed year
        let start = minYear ?? Math.max(1900, current - 50);
        let end = maxYear ?? Math.min(2100, current + 50);
        if (start > end) [start, end] = [end, start];
        const list = [];
        for (let y = start; y <= end; y++) list.push(y);
        return list;
      },

      selectYear(newYear) {
        this.year = Number(newYear);
        const cur = this.selectedDate ? new Date(this.selectedDate) : new Date();
        const maxDays = this.getMaxDays(this.year, Number(this.month) + 1);
        const day = Math.min(cur.getDate(), maxDays);
        const target = new Date(2000, 0, 1);
        target.setFullYear(this.year, Number(this.month), day);
        this.applyDate(target);
        this.syncInputsFromDate(target);
        this.openYearDropdown = false;
      },

      // Format a Date object to the configured locale string (e.g. DD.MM.YYYY)
      formatDate(date) {
        if (!date || isNaN(date.getTime())) return '';
        const y = String(date.getFullYear()).padStart(4, '0');
        const m = String(date.getMonth() + 1).padStart(2, '0');
        const d = String(date.getDate()).padStart(2, '0');
        switch (this.format) {
          case 'YYYY-MM-DD':
            return `${y}-${m}-${d}`;
          case 'MM/DD/YYYY':
            return `${m}/${d}/${y}`;
          case 'DD/MM/YYYY':
            return `${d}/${m}/${y}`;
          case 'DD.MM.YYYY':
          default:
            return `${d}.${m}.${y}`;
        }
      },

      // Format a Date object to ISO string YYYY-MM-DD
      formatISO(date) {
        if (!date || isNaN(date.getTime())) return '';
        const y = String(date.getFullYear()).padStart(4, '0');
        const m = String(date.getMonth() + 1).padStart(2, '0');
        const d = String(date.getDate()).padStart(2, '0');
        return `${y}-${m}-${d}`;
      },

      // Returns the number of days in a given month (1..12) for a given year (0..3000)
      getMaxDays(year, month) {
        const d = new Date(2000, 0, 1);
        d.setFullYear(year, month, 0);
        return d.getDate();
      },

      // Parse user input text into a valid Date object within the supported year range (0..3000)
      parseInput(input) {
        const text = String(input || '').trim();
        if (!text) return null;

        let day, month, year;

        // 1. ISO format: YYYY-MM-DD
        const isoMatch = text.match(/^(\d{1,4})-(\d{1,2})-(\d{1,2})$/);
        if (isoMatch) {
          year = Number(isoMatch[1]);
          month = Number(isoMatch[2]);
          day = Number(isoMatch[3]);
        } else if (/^\d{8}$/.test(text)) {
          // 2. 8 continuous digits: YYYYMMDD (iso), MMDDYYYY (us), or DDMMYYYY (dd.mm.yyyy / dd/mm/yyyy)
          if (this.format === 'YYYY-MM-DD') {
            year = Number(text.slice(0, 4));
            month = Number(text.slice(4, 6));
            day = Number(text.slice(6, 8));
          } else if (this.format === 'MM/DD/YYYY') {
            month = Number(text.slice(0, 2));
            day = Number(text.slice(2, 4));
            year = Number(text.slice(4, 8));
          } else {
            day = Number(text.slice(0, 2));
            month = Number(text.slice(2, 4));
            year = Number(text.slice(4, 8));
          }
        } else {
          // 3. Delimited by dot, slash, dash, or space: DD.MM.YYYY / MM/DD/YYYY
          const sepMatch = text.match(/^(\d{1,2})[./\s-](\d{1,2})[./\s-](\d{1,4})$/);
          if (sepMatch) {
            const p1 = Number(sepMatch[1]);
            const p2 = Number(sepMatch[2]);
            year = Number(sepMatch[3]);
            if (this.format === 'MM/DD/YYYY') {
              month = p1;
              day = p2;
            } else {
              day = p1;
              month = p2;
            }
          } else {
            // 4. Fallback native Date parsing (e.g. "Thu Oct 15 2026" from toDateString() or ISO timestamp)
            const parsedNative = new Date(text);
            if (!isNaN(parsedNative.getTime())) {
              const y = parsedNative.getFullYear();
              if (y >= 0 && y <= 3000) {
                return parsedNative;
              }
            }
            return null;
          }
        }

        // Strict range checks: Day 1-31, Month 1-12, Year 0-3000
        if (month < 1 || month > 12 || day < 1 || day > 31 || year < 0 || year > 3000) {
          return null;
        }

        const d = new Date(2000, 0, 1);
        d.setFullYear(year, month - 1, day);
        // Verify no overflow (e.g. Feb 31 -> Mar 3)
        if (d.getFullYear() === year && d.getMonth() === month - 1 && d.getDate() === day) {
          return d;
        }
        return null;
      },

      // Sets month/year to the given value, or today if none was supplied
      initDate() {
        // Without an initial value the picker starts with no selection (used by filters)
        if (isEmpty && !this.parseInput(value)) {
          // Open on today, or on the nearest allowed year when today is out of bounds
          const now = new Date();
          this.year = now.getFullYear();
          this.month = now.getMonth();
          if (maxYear !== null && this.year > maxYear) { this.year = maxYear; this.month = 11; }
          if (minYear !== null && this.year < minYear) { this.year = minYear; this.month = 0; }
          this.getNoOfDays();
          this.watchChanges();
          return;
        }
        const today = this.parseInput(value) || new Date();
        this.applyDate(today);
        this.syncInputsFromDate(today);
        if (this.isRange) {
          this.rangeStart = today;
          const parsedEnd = this.parseInput(endValue);
          if (parsedEnd) {
            this.rangeEnd = parsedEnd;
            if (this.$refs.endDate) {
              this.$refs.endDate.value = parsedEnd.toDateString();
            }
          }
        }
        this.watchChanges();
      },

      // Notifies the outside world about selection changes. Detail values are ISO dates or ''.
      watchChanges() {
        const emit = () => this.emitChange();
        if (this.isRange) {
          this.$watch('rangeStart', emit);
          this.$watch('rangeEnd', emit);
        } else {
          this.$watch('selectedDate', emit);
        }
      },

      toIsoDate(d) {
        if (!d || isNaN(d.getTime())) return '';
        const yr = String(d.getFullYear()).padStart(4, '0');
        const mon = String(d.getMonth() + 1).padStart(2, '0');
        const day = String(d.getDate()).padStart(2, '0');
        return `${yr}-${mon}-${day}`;
      },

      emitChange() {
        const detail = this.isRange
          ? { value: this.toIsoDate(this.rangeStart), endValue: this.toIsoDate(this.rangeEnd) }
          : { value: this.toIsoDate(this.selectedDate), endValue: '' };
        this.$dispatch('datepicker-change', detail);
      },

      // Removes the selection (single date or range)
      clear() {
        this.selectedDate = null;
        this.rangeStart = null;
        this.rangeEnd = null;
        this.hoverDate = null;
        this.focusedDate = null;
        this.syncInputsFromDate(null);
        if (this.$refs.date) this.$refs.date.value = '';
        if (this.$refs.endDate) this.$refs.endDate.value = '';
        this.hasError = false;
        this.hasServerError = false;
        this.errorMessage = '';
      },

      // Sets the selection from ISO dates (YYYY-MM-DD); an empty `start` clears it
      setValue(start, end = '') {
        const startDate = this.parseInput(start);
        if (!startDate) {
          this.clear();
          return;
        }
        this.applyDate(startDate);
        this.syncInputsFromDate(startDate);
        if (this.isRange) {
          const endDate = this.parseInput(end);
          this.rangeStart = startDate;
          this.rangeEnd = endDate;
          if (this.$refs.endDate) this.$refs.endDate.value = endDate ? endDate.toDateString() : '';
        }
        this.hasError = false;
        this.hasServerError = false;
        this.errorMessage = '';
      },

      // Updates internal state and calendar grid to the given date
      applyDate(d) {
        this.year = d.getFullYear();
        this.month = d.getMonth();
        this.selectedDate = d;
        this.focusedDate = d.getDate();
        this.getNoOfDays();
        if (this.$refs.date) {
          this.$refs.date.value = d.toDateString();
        }
      },

      // Synchronizes all segmented inputs (day, month, year) and single value
      syncInputsFromDate(d) {
        if (!d || isNaN(d.getTime())) {
          this.dayInput = '';
          this.monthInput = '';
          this.yearInput = '';
          this.datepickerValue = '';
          return;
        }
        this.dayInput = String(d.getDate()).padStart(2, '0');
        this.monthInput = String(d.getMonth() + 1).padStart(2, '0');
        this.yearInput = String(d.getFullYear());
        this.datepickerValue = this.formatDate(d);
      },

      // Segment input: Day
      onDayInput(e) {
        let val = String(this.dayInput || '').trim();
        // Handle pasting full date into day segment
        if (val.length > 2) {
          const parsed = this.parseInput(val);
          if (parsed) {
            this.applyDate(parsed);
            this.syncInputsFromDate(parsed);
            this.hasError = false;
            this.hasServerError = false;
            this.errorMessage = '';
            this.$refs.yearInput?.focus();
            return;
          }
        }
        this.dayInput = val.replace(/\D/g, '').slice(0, 2);
        this.onSegmentChange();
        if (this.dayInput.length === 2 && !this.hasError) {
          this.focusNextSegment('day');
        }
      },

      onDayKeydown(e) {
        if (!e) return;
        if (e.key === '.' || e.key === '/' || e.key === '-') {
          e.preventDefault();
          if (this.dayInput && this.dayInput.length === 1) {
            this.dayInput = '0' + this.dayInput;
          }
          this.onSegmentChange();
          if (!this.hasError) {
            this.focusNextSegment('day');
          }
        }
      },

      // Segment input: Month
      onMonthInput(e) {
        let val = String(this.monthInput || '').trim();
        if (val.length > 2) {
          const parsed = this.parseInput(val);
          if (parsed) {
            this.applyDate(parsed);
            this.syncInputsFromDate(parsed);
            this.hasError = false;
            this.hasServerError = false;
            this.errorMessage = '';
            this.$refs.yearInput?.focus();
            return;
          }
        }
        this.monthInput = val.replace(/\D/g, '').slice(0, 2);
        this.onSegmentChange();
        if (this.monthInput.length === 2 && !this.hasError) {
          this.focusNextSegment('month');
        }
      },

      onMonthKeydown(e) {
        if (!e) return;
        if (e.key === '.' || e.key === '/' || e.key === '-') {
          e.preventDefault();
          if (this.monthInput && this.monthInput.length === 1) {
            this.monthInput = '0' + this.monthInput;
          }
          this.onSegmentChange();
          if (!this.hasError) {
            this.focusNextSegment('month');
          }
        } else if (e.key === 'Backspace' && (!this.monthInput || this.monthInput.length === 0)) {
          this.focusPrevSegment('month');
        }
      },

      // Segment input: Year
      onYearInput(e) {
        let val = e && e.target ? String(e.target.value) : String(this.yearInput || '');
        this.yearInput = val.replace(/\D/g, '').slice(0, 4);
        this.onSegmentChange();
      },

      onYearKeydown(e) {
        if (!e) return;
        if (e.key === 'Backspace' && (!this.yearInput || this.yearInput.length === 0)) {
          this.focusPrevSegment('year');
        }
      },

      focusNextSegment(from) {
        if (this.format === 'MM/DD/YYYY') {
          if (from === 'month') this.$refs.dayInput?.focus();
          else if (from === 'day') this.$refs.yearInput?.focus();
        } else if (this.format === 'YYYY-MM-DD') {
          if (from === 'year') this.$refs.monthInput?.focus();
          else if (from === 'month') this.$refs.dayInput?.focus();
        } else {
          // DD.MM.YYYY and DD/MM/YYYY
          if (from === 'day') this.$refs.monthInput?.focus();
          else if (from === 'month') this.$refs.yearInput?.focus();
        }
      },

      focusPrevSegment(from) {
        if (this.format === 'MM/DD/YYYY') {
          if (from === 'year') this.$refs.dayInput?.focus();
          else if (from === 'day') this.$refs.monthInput?.focus();
        } else if (this.format === 'YYYY-MM-DD') {
          if (from === 'day') this.$refs.monthInput?.focus();
          else if (from === 'month') this.$refs.yearInput?.focus();
        } else {
          // DD.MM.YYYY and DD/MM/YYYY
          if (from === 'year') this.$refs.monthInput?.focus();
          else if (from === 'month') this.$refs.dayInput?.focus();
        }
      },

      onSegmentChange() {
        const dayStr = String(this.dayInput || '').trim();
        const monthStr = String(this.monthInput || '').trim();
        const yearStr = String(this.yearInput || '').trim();

        // Show calendar on user typing
        if (dayStr || monthStr || yearStr) {
          this.showDatepicker = true;
        }

        // Validate Day range immediately
        if (dayStr) {
          const d = Number(dayStr);
          if (d < 1 || d > 31) {
            this.hasError = true;
            this.errorMessage = 'Day must be between 1 and 31';
            if (this.$refs.date) this.$refs.date.value = '';
            return;
          }
        }

        // Validate Month range immediately
        if (monthStr) {
          const m = Number(monthStr);
          if (m < 1 || m > 12) {
            this.hasError = true;
            this.errorMessage = 'Month must be between 1 and 12';
            if (this.$refs.date) this.$refs.date.value = '';
            return;
          }
        }

        // Validate Year range: 0 to 3000
        if (yearStr && yearStr.length === 4) {
          const y = Number(yearStr);
          if (isNaN(y) || y < 0 || y > 3000) {
            this.hasError = true;
            this.errorMessage = 'Year must be between 0 and 3000';
            if (this.$refs.date) this.$refs.date.value = '';
            return;
          }
        }

        // Validate days in that specific month if both day and month are present
        if (dayStr && monthStr) {
          const d = Number(dayStr);
          const m = Number(monthStr);
          if (m >= 1 && m <= 12) {
            const hasCompleteYear = yearStr.length === 4;
            const monthName = DEFAULT_MONTH_NAMES[m - 1] || 'This month';

            if (hasCompleteYear) {
              const y = Number(yearStr);
              if (y >= 0 && y <= 3000) {
                const maxDays = this.getMaxDays(y, m);
                if (d > maxDays) {
                  this.hasError = true;
                  this.errorMessage = `${monthName} only has ${maxDays} days in ${y}`;
                  if (this.$refs.date) this.$refs.date.value = '';
                  return;
                }
              }
            } else {
              // No year specified yet: allow max possible days for this month (e.g. 29 for February)
              const maxPossibleDays = (m === 2) ? 29 : new Date(2024, m, 0).getDate();
              if (d > maxPossibleDays) {
                this.hasError = true;
                this.errorMessage = (m === 2)
                  ? 'February only has 28 or 29 days'
                  : `${monthName} only has ${maxPossibleDays} days`;
                if (this.$refs.date) this.$refs.date.value = '';
                return;
              }
            }
          }
        }

        // If all 3 are complete and valid
        if (dayStr && monthStr && yearStr.length === 4) {
          const d = Number(dayStr);
          const m = Number(monthStr);
          const y = Number(yearStr);
          if (y >= 0 && y <= 3000) {
            const testDate = new Date(2000, 0, 1);
            testDate.setFullYear(y, m - 1, d);
            if (testDate.getFullYear() === y && testDate.getMonth() === m - 1 && testDate.getDate() === d) {
              this.applyDate(testDate);
              this.datepickerValue = this.formatDate(testDate);
              this.hasError = false;
              this.hasServerError = false;
              this.errorMessage = '';
              return;
            } else {
              this.hasError = true;
              const monthName = DEFAULT_MONTH_NAMES[m - 1] || 'This month';
              const maxDays = this.getMaxDays(y, m);
              if (d > maxDays) {
                this.errorMessage = `${monthName} only has ${maxDays} days in ${y}`;
              } else {
                this.errorMessage = `Invalid date format. Expected ${this.format}`;
              }
              if (this.$refs.date) this.$refs.date.value = '';
              return;
            }
          }
        }

        // Live-update calendar grid if year/month are present
        const y = Number(yearStr);
        const m = Number(monthStr);
        const d = Number(dayStr);
        if (y >= 1000 && y <= 9999) {
          this.year = y;
          if (m >= 1 && m <= 12) this.month = m - 1;
          if (d >= 1 && d <= 31) this.focusedDate = d;
          this.getNoOfDays();
        }

        this.hasError = false;
        this.errorMessage = '';
      },

      onSegmentBlur() {
        const dayStr = String(this.dayInput || '').trim();
        const monthStr = String(this.monthInput || '').trim();
        const yearStr = String(this.yearInput || '').trim();

        if (!dayStr && !monthStr && !yearStr) {
          this.selectedDate = null;
          if (this.$refs.date) this.$refs.date.value = '';
          this.hasError = false;
          this.hasServerError = false;
          this.errorMessage = '';
          return;
        }

        // Auto-pad single digit Day on blur if valid
        if (dayStr.length === 1 && Number(dayStr) >= 1 && Number(dayStr) <= 9) {
          this.dayInput = '0' + dayStr;
        }

        // Auto-pad single digit Month on blur if valid
        if (monthStr.length === 1 && Number(monthStr) >= 1 && Number(monthStr) <= 9) {
          this.monthInput = '0' + monthStr;
        }

        this.onSegmentChange();

        // If still incomplete or invalid on blur, show error
        if (!this.hasError) {
          if (!this.dayInput || !this.monthInput || this.yearInput.length !== 4) {
            this.hasError = true;
            this.errorMessage = `Please enter a complete date (${this.format})`;
            if (this.$refs.date) this.$refs.date.value = '';
          }
        }
      },

      // Tracks backspace / delete to avoid trapping user on delimiters
      onKeydown(e) {
        this.isDeleting = (e && (e.key === 'Backspace' || e.key === 'Delete'));
      },

      // Called when user types into the input field
      onInput(e) {
        // Auto-mask digits as the user types (adds . or / or - without manual typing)
        const masked = this.applyMask(this.datepickerValue);
        this.datepickerValue = masked;

        // Activate the calendar popup so user sees live update
        this.showDatepicker = true;

        if (!masked) {
          this.selectedDate = null;
          if (this.$refs.date) {
            this.$refs.date.value = '';
          }
          this.hasError = false;
          this.hasServerError = false;
          this.errorMessage = '';
          return;
        }

        // Check if current input represents a valid date
        const parsed = this.parseInput(masked);
        if (parsed) {
          this.applyDate(parsed);
          this.hasError = false;
          this.hasServerError = false;
          this.errorMessage = '';
        }
      },

      // Called on input change (e.g. Enter pressed or committed)
      onChange() {
        this.commitInput();
      },

      // Called when input loses focus
      onBlur() {
        this.commitInput();
      },

      // Validates and converts input text to formatted date string
      commitInput() {
        const val = (this.datepickerValue || '').trim();
        if (!val) {
          this.selectedDate = null;
          if (this.$refs.date) {
            this.$refs.date.value = '';
          }
          this.hasError = false;
          this.hasServerError = false;
          this.errorMessage = '';
          return;
        }

        const parsed = this.parseInput(val);
        if (parsed) {
          this.applyDate(parsed);
          this.datepickerValue = this.formatDate(parsed);
          this.hasError = false;
          this.hasServerError = false;
          this.errorMessage = '';
        } else {
          // Input was not a valid date
          this.hasError = true;
          this.errorMessage = `Invalid date format. Expected ${this.format}`;
          if (this.$refs.date) {
            this.$refs.date.value = '';
          }
        }
      },

      isSelected(date, targetMonth = this.month, targetYear = this.year) {
        if (!date) return false;
        const d = new Date(2000, 0, 1);
        d.setFullYear(Number(targetYear), Number(targetMonth), Number(date));
        const t = d.toDateString();
        if (this.isRange) {
          const isStart = this.rangeStart && this.rangeStart.toDateString() === t;
          const isEnd = this.rangeEnd && this.rangeEnd.toDateString() === t;
          return Boolean(isStart || isEnd);
        }
        if (!this.selectedDate) return false;
        return this.selectedDate.toDateString() === t;
      },

      isInRange(date, targetMonth = this.month, targetYear = this.year) {
        if (!this.isRange || !this.rangeStart || date === null) return false;
        const d = new Date(2000, 0, 1);
        d.setFullYear(Number(targetYear), Number(targetMonth), Number(date));
        const t = d.getTime();
        const startT = new Date(this.rangeStart.getFullYear(), this.rangeStart.getMonth(), this.rangeStart.getDate()).getTime();
        if (this.rangeEnd) {
          const endT = new Date(this.rangeEnd.getFullYear(), this.rangeEnd.getMonth(), this.rangeEnd.getDate()).getTime();
          return t > startT && t < endT;
        }
        if (this.hoverDate) {
          const hoverT = new Date(this.hoverDate.getFullYear(), this.hoverDate.getMonth(), this.hoverDate.getDate()).getTime();
          return t > startT && t <= hoverT;
        }
        return false;
      },

      isToday(date, targetMonth = this.month, targetYear = this.year) {
        const d = new Date(2000, 0, 1);
        d.setFullYear(Number(targetYear), Number(targetMonth), Number(date));
        return new Date().toDateString() === d.toDateString();
      },

      isFocusable(date) {
        return Number(date) === Number(this.focusedDate);
      },

      formatFullDate(date, targetMonth = this.month, targetYear = this.year) {
        const d = new Date(2000, 0, 1);
        d.setFullYear(Number(targetYear), Number(targetMonth), Number(date));
        return d.toLocaleDateString('en-US', {
          weekday: 'long',
          year: 'numeric',
          month: 'long',
          day: 'numeric'
        });
      },

      // Moves the roving focus by `delta` days, rolling over into the adjacent month
      moveFocus(delta) {
        const daysInMonth = this.getMaxDays(this.year, this.month + 1);
        let target = Number(this.focusedDate) + Number(delta);
        if (target < 1) {
          this.month--;
          if (this.month < 0) {
            this.year--;
            if (this.year < 0) this.year = 0;
            this.month = 11;
          }
          this.getNoOfDays();
          target += this.getMaxDays(this.year, this.month + 1);
        } else if (target > daysInMonth) {
          target -= daysInMonth;
          this.month++;
          if (this.month > 11) {
            this.year++;
            if (this.year > 3000) this.year = 3000;
            this.month = 0;
          }
          this.getNoOfDays();
        }
        this.focusedDate = target;
        this.$nextTick(() => this.focusDay());
      },

      focusDay() {
        const grid = this.$refs.dayGrid;
        if (!grid) return;
        const cell = grid.querySelector(`[data-day="${String(this.focusedDate)}"]`);
        if (cell) cell.focus();
      },

      // Writes the selected date (YYYY-MM-DD) into the hidden input and closes the picker
      getDateValue(date, targetMonth = this.month, targetYear = this.year) {
        const y = Number(targetYear);
        const m = Number(targetMonth);
        const d = Number(date);
        const sel = new Date(2000, 0, 1);
        sel.setFullYear(y, m, d);

        if (!this.isRange) {
          this.applyDate(sel);
          this.syncInputsFromDate(sel);
          this.hasError = false;
          this.hasServerError = false;
          this.errorMessage = '';
          this.showDatepicker = false;
          return;
        }

        // In range mode:
        if (!this.rangeStart || (this.rangeStart && this.rangeEnd)) {
          this.rangeStart = sel;
          this.rangeEnd = null;
          this.syncInputsFromDate(sel);
          if (this.$refs.date) this.$refs.date.value = sel.toDateString();
          if (this.$refs.endDate) this.$refs.endDate.value = '';
        } else if (this.rangeStart && !this.rangeEnd) {
          if (sel < this.rangeStart) {
            this.rangeEnd = this.rangeStart;
            this.rangeStart = sel;
          } else {
            this.rangeEnd = sel;
          }
          if (this.$refs.date) this.$refs.date.value = this.rangeStart.toDateString();
          if (this.$refs.endDate) this.$refs.endDate.value = this.rangeEnd.toDateString();
          this.syncInputsFromDate(this.rangeStart);
          this.hasError = false;
          this.hasServerError = false;
          this.errorMessage = '';
          this.showDatepicker = false;
        }
      },

      // Computes the leading blank cells and day cells for the current month grid
      getNoOfDays() {
        let daysInMonth = this.getMaxDays(this.year, this.month + 1);
        const firstDay = new Date(2000, 0, 1);
        firstDay.setFullYear(this.year, this.month, 1);
        // Monday-first: Mon=0, Tue=1, ..., Sun=6
        let dayOfWeek = firstDay.getDay() - 1;
        if (dayOfWeek === -1) dayOfWeek = 6;
        let blankdaysArray = [];
        for (let i = 0; i < dayOfWeek; i++) blankdaysArray.push(i + 1);
        let daysArray = [];
        for (let i = 1; i <= daysInMonth; i++) daysArray.push(i);
        this.blankdays = blankdaysArray;
        this.no_of_days = daysArray;
        this.calendarRows = this.buildCalendarRows(this.year, this.month, daysInMonth, dayOfWeek);

        if (this.isRange) {
          const m2 = this.month2;
          const y2 = this.year2;
          const daysInMonth2 = this.getMaxDays(y2, m2 + 1);
          const firstDay2 = new Date(2000, 0, 1);
          firstDay2.setFullYear(y2, m2, 1);
          let dayOfWeek2 = firstDay2.getDay() - 1;
          if (dayOfWeek2 === -1) dayOfWeek2 = 6;
          this.calendarRows2 = this.buildCalendarRows(y2, m2, daysInMonth2, dayOfWeek2);
        }

        this.focusedDate = this.defaultFocusedDate(daysInMonth);
      },

      buildCalendarRows(y, m, daysInMonth, leadingBlankCount) {
        const rows = [];
        let currentDay = 1;
        let row = { week: '', days: [] };

        for (let i = 0; i < leadingBlankCount; i++) {
          row.days.push(null);
        }

        while (currentDay <= daysInMonth) {
          row.days.push(currentDay);

          if (row.days.length === 7) {
            const sampleDay = row.days[3] || row.days.find(x => x !== null);
            const d = new Date(2000, 0, 1);
            d.setFullYear(Number(y), Number(m), sampleDay);
            row.week = this.formatWeek(d);
            rows.push(row);
            row = { week: '', days: [] };
          }
          currentDay++;
        }

        if (row.days.length > 0) {
          while (row.days.length < 7) {
            row.days.push(null);
          }
          const sampleDay = row.days.find(x => x !== null) || daysInMonth;
          const d = new Date(2000, 0, 1);
          d.setFullYear(Number(y), Number(m), sampleDay);
          row.week = this.formatWeek(d);
          rows.push(row);
        }
        return rows;
      },

      // Keeps the roving tabindex on a day that exists in the displayed month
      defaultFocusedDate(daysInMonth) {
        let day = Number(this.focusedDate);
        if (!day || Number.isNaN(day)) {
          const sel = this.selectedDate;
          day = sel && sel.getMonth() === Number(this.month) && sel.getFullYear() === Number(this.year)
            ? sel.getDate()
            : 1;
        }
        return Math.min(Math.max(day, 1), daysInMonth);
      }
    };
  });
}

if (window.Alpine) {
  registerDatePicker();
} else {
  document.addEventListener('alpine:init', registerDatePicker);
}
}

