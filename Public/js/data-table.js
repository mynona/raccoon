// v1.0

/* Alpine factory for DataTable: backend driven sorting, filtering and pagination.
   Composes the unchanged `datatable()` factory (SimpleTable) for the column configurator
   (visibility, order, drag and keyboard reorder, persistence). */

if (!window.__dataTableLoaded) {
  window.__dataTableLoaded = true;

  // Decodes the base64 UTF-8 JSON that the server renders into the x-data attribute
  window.dataTableConfig = function (b64) {
    const bytes = Uint8Array.from(atob(b64), c => c.charCodeAt(0));
    return JSON.parse(new TextDecoder().decode(bytes));
  };

  const getPath = (object, path) =>
    path.split(".").reduce((value, part) => (value == null ? value : value[part]), object);

  const escapeRegExp = text => text.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");

  window.dataTable = function (config) {

    const lang = document.documentElement.lang || undefined;
    const formatters = {
      integer: new Intl.NumberFormat(lang, { maximumFractionDigits: 0 }),
      double: new Intl.NumberFormat(lang, { minimumFractionDigits: 2, maximumFractionDigits: 2 })
    };
    const columnsByKey = new Map(config.columns.map(c => [c.key, c]));
    const filterColumns = config.columns.filter(c => c.filter);
    const defaultVisible = config.columns.filter(c => c.visible).map(c => c.key);

    // Matches the configured filter parameter, e.g. filter[{key}][{op}], in the URL
    const filterParamPattern = new RegExp(
      "^" + escapeRegExp(config.endpoint.filterParam)
        .replace("\\{key\\}", "(.+?)")
        .replace("\\{op\\}", "(.+?)") + "$"
    );

    // Compose the SimpleTable factory. Getters must be copied as descriptors, a spread would freeze them.
    const base = datatable({
      meta: {
        storageKey: config.id,
        hasIndexColumn: false,
        hasColumnConfigurator: config.hasColumnConfigurator,
        hasSearch: false,
        hasCopyToClipboard: false,
        columns: config.columns.map(c => ({
          key: c.key,
          label: c.label,
          type: c.type,
          align: c.align,
          sortable: c.sortable,
          hideable: c.hideable
        }))
      },
      rows: []
    });
    const baseInit = base.init;
    const baseReset = base.resetTableState;
    const table = Object.defineProperties({}, Object.getOwnPropertyDescriptors(base));

    const state = {
      status: "loading", // loading | ready | error
      announcement: "",
      page: 1,
      per: config.defaultPageSize,
      total: 0,
      rows: [],
      pageSizeOptions: config.pageSizeOptions,
      filterPanelOpen: false,
      draft: {},
      applied: {},
      filterMode: "and",
      minHeight: 0,
      requestId: 0,
      controller: null,
      silent: false,
      debounceTimer: null
    };
    Object.entries(Object.getOwnPropertyDescriptors(state))
      .forEach(([name, descriptor]) => Object.defineProperty(table, name, descriptor));

    const methods = {

      /* ------------------------------------------------------------------
       INIT / PERSISTENCE
       ------------------------------------------------------------------ */
      init() {
        baseInit.call(this);

        const stored = this.readStored();
        if (!stored || !stored.visibleColumns) {
          this.visibleColumns = new Set(defaultVisible);
        }
        if (stored && config.pageSizeOptions.includes(stored.per)) this.per = stored.per;

        if (config.defaultSort) {
          this.sortKey = config.defaultSort.key;
          this.sortDirection = config.defaultSort.direction;
        }
        if (config.hasUrlState) this.readUrl();

        this.$nextTick(() => this.syncControls());
        this.load();
      },

      readStored() {
        try {
          return JSON.parse(localStorage.getItem(config.id) || "null");
        } catch (error) {
          return null;
        }
      },

      // Sort and filters live in the URL, never in local storage
      persistState() {
        try {
          localStorage.setItem(config.id, JSON.stringify({
            visibleColumns: [...this.visibleColumns],
            columnOrder: [...this.columnOrder],
            per: this.per
          }));
        } catch (error) { /* storage unavailable */ }
      },

      resetTableState() {
        baseReset.call(this);
        this.visibleColumns = new Set(defaultVisible);
        this.tempVisibleColumns = new Set(defaultVisible);
        this.persistState();
      },

      /* ------------------------------------------------------------------
       URL STATE
       ------------------------------------------------------------------ */
      readUrl() {
        const params = new URLSearchParams(location.search);
        const e = config.endpoint;
        const page = parseInt(params.get(e.pageParam), 10);
        const per = parseInt(params.get(e.sizeParam), 10);
        if (page > 0) this.page = page;
        if (config.pageSizeOptions.includes(per)) this.per = per;

        const [key, direction] = (params.get(e.sortParam) || "").split(":");
        if (columnsByKey.get(key)?.sortable && (direction === "asc" || direction === "desc")) {
          this.sortKey = key;
          this.sortDirection = direction;
        }
        if (params.get(e.filterModeParam) === "or") this.filterMode = "or";

        for (const [name, value] of params) {
          const match = filterParamPattern.exec(name);
          const filter = columnsByKey.get(match?.[1])?.filter;
          if (!filter || (filter.kind === "dateRange" && match[2] !== "between")) continue;
          this.applied[match[1]] = { op: match[2], value };
        }
        this.draft = this.draftFromApplied();
        // Normalise to column order so `hasPendingFilters` compares like with like
        this.applied = this.desiredFilters();
      },

      writeUrl() {
        if (!config.hasUrlState) return;
        const params = this.buildQuery(false);
        history.replaceState(null, "", params.toString() ? "?" + params : location.pathname);
      },

      /* ------------------------------------------------------------------
       REQUEST
       ------------------------------------------------------------------ */
      buildQuery(withFixed = true) {
        const e = config.endpoint;
        const params = new URLSearchParams();
        if (withFixed) Object.entries(config.fixedQuery).forEach(([k, v]) => params.set(k, v));
        if (config.hasPagination) {
          params.set(e.pageParam, this.page);
          params.set(e.sizeParam, this.per);
        }
        if (this.sortKey) params.set(e.sortParam, `${this.sortKey}:${this.sortDirection}`);
        for (const [key, filter] of Object.entries(this.applied)) {
          params.set(e.filterParam.replace("{key}", key).replace("{op}", filter.op), filter.value);
        }
        if (config.hasFilterMode && Object.keys(this.applied).length > 1) {
          params.set(e.filterModeParam, this.filterMode);
        }
        return params;
      },

      async load() {
        if (this.controller) this.controller.abort();
        const controller = new AbortController();
        this.controller = controller;
        const requestId = ++this.requestId;

        const scroll = this.$root.querySelector("[role=region]");
        if (scroll && scroll.offsetHeight > this.minHeight) this.minHeight = scroll.offsetHeight;
        this.status = "loading";
        this.announcement = config.labels.loading;

        try {
          const e = config.endpoint;
          const response = await fetch(`${e.url}?${this.buildQuery()}`, {
            method: e.method,
            headers: { Accept: "application/json", ...e.headers },
            credentials: "same-origin",
            signal: controller.signal
          });
          if (requestId !== this.requestId) return;

          // Expired session: the server answers with a login redirect or HTML
          const contentType = response.headers.get("Content-Type") || "";
          if (response.redirected || response.status === 401 || response.status === 403 ||
              (response.ok && !contentType.includes("json"))) {
            if (this.reloadForLogin()) return;
            throw new Error("unexpected response");
          }
          if (!response.ok) throw new Error(`HTTP ${response.status}`);

          const json = await response.json();
          if (requestId !== this.requestId) return;

          const items = getPath(json, e.itemsPath);
          const total = Number(getPath(json, e.totalPath));
          if (!Array.isArray(items) || Number.isNaN(total)) throw new Error("invalid payload");

          this.total = total;
          if (config.hasPagination && total > 0 && this.page > this.totalPages) {
            this.page = this.totalPages;
            return this.load();
          }
          this.rows = items;
          this.status = "ready";
          this.announcement = config.labels.results.replace("{count}", total);
          this.writeUrl();
          this.$nextTick(() => { this.minHeight = 0; });
        } catch (error) {
          if (error.name === "AbortError" || requestId !== this.requestId) return;
          this.status = "error";
          this.announcement = config.labels.error;
        }
      },

      // Reloads once; a second failure within 10 s shows the error instead of looping
      reloadForLogin() {
        const key = `${config.id}:reloaded`;
        const last = Number(sessionStorage.getItem(key) || 0);
        if (Date.now() - last < 10000) return false;
        sessionStorage.setItem(key, String(Date.now()));
        window.location.reload();
        return true;
      },

      /* ------------------------------------------------------------------
       SORT / PAGING (server side)
       ------------------------------------------------------------------ */
      // Cycles ascending → descending → no sort (the backend default order applies)
      sort(key) {
        if (this.sortKey !== key) {
          this.sortKey = key;
          this.sortDirection = "asc";
        } else if (this.sortDirection === "asc") {
          this.sortDirection = "desc";
        } else {
          this.sortKey = null;
          this.sortDirection = null;
        }
        this.page = 1;
        this.load();
      },

      ariaSort(col) {
        if (!col.sortable) return null;
        if (this.sortKey !== col.key) return "none";
        return this.sortDirection === "asc" ? "ascending" : "descending";
      },

      get totalPages() { return Math.max(1, Math.ceil(this.total / this.per)); },
      get hasPrevious() { return this.page > 1; },
      get hasNext() { return this.page < this.totalPages; },
      get isLoading() { return this.status === "loading"; },
      get rangeLabel() {
        if (this.total === 0) return "0 of 0";
        const start = (this.page - 1) * this.per + 1;
        return `${start} – ${Math.min(this.page * this.per, this.total)} of ${this.total}`;
      },

      goToPage(page) {
        const target = Math.min(Math.max(1, Number(page)), this.totalPages);
        if (target === this.page || this.isLoading) return;
        this.page = target;
        this.load();
      },
      previousPage() { this.goToPage(this.page - 1); },
      nextPage() { this.goToPage(this.page + 1); },

      // Keeps the first visible row on screen when the page size changes
      changePageSize(size) {
        size = Number(size);
        if (!config.pageSizeOptions.includes(size) || size === this.per) return;
        const firstIndex = (this.page - 1) * this.per;
        this.per = size;
        this.page = Math.floor(firstIndex / size) + 1;
        this.persistState();
        this.load();
      },

      /* ------------------------------------------------------------------
       DERIVED VIEW STATE
       ------------------------------------------------------------------ */
      get columnCount() { return this.activeColumns.length + (config.hasRowNumbers ? 1 : 0); },
      get skeletonRows() { return Array.from({ length: config.hasPagination ? this.per : 5 }, (_, i) => i); },
      get minHeightStyle() { return this.minHeight ? `min-height: ${this.minHeight}px` : ""; },
      get emptyText() {
        return this.activeFilterCount > 0 ? config.labels.noResults : config.labels.noData;
      },

      rowNumber(index) { return (this.page - 1) * this.per + index + 1; },

      isEmpty(row, col) {
        const value = row[col.key];
        return value === null || value === undefined || value === "";
      },

      cellText(row, col) {
        const value = row[col.key];
        if (this.isEmpty(row, col)) return "";
        const formatter = formatters[col.type];
        return formatter && Number.isFinite(Number(value)) ? formatter.format(Number(value)) : String(value);
      },

      tableTemplate(row, template, encode = false) {
        return template.replace(/\{(\w+)\}/g, (_, field) => {
          const value = row[field] ?? "";
          return encode ? encodeURIComponent(value) : value;
        });
      },
      tableHref(row, template) { return this.tableTemplate(row, template, true); },

      // Flips a boolean toggle cell optimistically, saves it and reverts on failure
      async toggleRow(row, key, url) {
        if (!url || row.__saving) return;
        const previous = Boolean(row[key]);
        row[key] = !previous;
        row.__saving = true;
        try {
          const response = await fetch(url, {
            method: "POST",
            credentials: "same-origin",
            headers: { "Content-Type": "application/json", Accept: "application/json", ...config.endpoint.headers },
            body: JSON.stringify({ value: !previous }),
          });
          if (response.status === 401 || response.status === 403 || response.redirected) {
            row[key] = previous;
            this.reloadForLogin();
            return;
          }
          if (!response.ok) throw new Error(`HTTP ${response.status}`);
        } catch (error) {
          row[key] = previous;
          this.announcement = config.labels.toggleFailed;
        } finally {
          row.__saving = false;
        }
      },

      /* ------------------------------------------------------------------
       FILTERS
       ------------------------------------------------------------------ */
      get activeFilterCount() { return Object.keys(this.applied).length; },

      get filterToggleLabel() {
        return this.activeFilterCount > 0
          ? config.labels.filtersActive.replace("{count}", this.activeFilterCount)
          : config.labels.filters;
      },

      get chips() {
        return Object.entries(this.applied).map(([key, filter]) => {
          const col = columnsByKey.get(key);
          const text = `${col.filter.label}: ${this.filterText(col, filter)}`;
          return { key, text, removeLabel: config.labels.removeFilter.replace("{filter}", text) };
        });
      },

      filterText(col, filter) {
        const kind = col.filter.kind;
        if (kind === "dateRange") return filter.value.replace(",", " – ");
        if (kind === "enumeration" || kind === "boolean-dropdown") {
          return col.filter.options.find(o => o.value === filter.value)?.title ?? filter.value;
        }
        if (kind === "boolean-check") return config.labels.yes;
        return filter.value;
      },

      // Applied filters implied by the current control values
      desiredFilters() {
        const result = {};
        for (const col of filterColumns) {
          const { kind, operator } = col.filter;
          if (kind === "dateRange") {
            const value = (this.draft[col.key] || "").trim();
            if (/^\d{4}-\d{2}-\d{2},\d{4}-\d{2}-\d{2}$/.test(value)) result[col.key] = { op: "between", value };
            continue;
          }
          const value = (this.draft[col.key] || "").trim();
          if (!value) continue;
          if ((kind === "integer" || kind === "double") && Number.isNaN(Number(value))) continue;
          result[col.key] = { op: operator, value };
        }
        return result;
      },

      draftFromApplied() {
        const draft = {};
        for (const [key, filter] of Object.entries(this.applied)) draft[key] = filter.value;
        return draft;
      },

      get hasPendingFilters() {
        return JSON.stringify(this.desiredFilters()) !== JSON.stringify(this.applied);
      },

      onFilterControl(event) {
        if (this.silent) return;
        const wrapper = event.target.closest("[data-filter-field]");
        if (!wrapper) return;
        const field = wrapper.dataset.filterField;
        // Only the picker's own event counts, not the segment inputs inside it
        if (wrapper.dataset.filterKind === "datepicker" && event.type !== "datepicker-change") return;

        let value;
        if (event.type === "dropdown-change") value = event.detail.value;
        else if (event.type === "datepicker-change") {
          const { value: start, endValue: end } = event.detail;
          const isRange = columnsByKey.get(wrapper.dataset.filterKey).filter.kind === "dateRange";
          // A range with only its start selected is still being picked
          if (isRange && Boolean(start) !== Boolean(end)) return;
          value = isRange ? (start ? `${start},${end}` : "") : start;
          // Programmatic writes (restore, clear) echo the draft back
          if (value === (this.draft[field] ?? "")) return;
        } else if (event.type === "change") {
          if (event.target.type !== "checkbox") return;
          value = event.target.checked ? "true" : "";
        } else if (event.type === "input") value = event.target.value;
        else return;

        if (field === "__mode") {
          this.filterMode = value;
          if (this.activeFilterCount > 1) { this.page = 1; this.load(); }
          return;
        }
        this.draft[field] = value;

        const isText = event.type === "input";
        if (config.filterTrigger === "immediate") {
          clearTimeout(this.debounceTimer);
          if (isText) this.debounceTimer = setTimeout(() => this.applyFilters(), 300);
          else this.applyFilters();
        } else if (config.filterTrigger === "mixed" && !isText) {
          this.applyFilters();
        }
      },

      onFilterEnter(event) {
        const inPicker = event.target.closest("[data-filter-kind=datepicker]");
        if (!inPicker && event.target.tagName === "INPUT" && event.target.type !== "checkbox") {
          event.preventDefault();
          this.applyFilters();
        }
      },

      applyFilters() {
        clearTimeout(this.debounceTimer);
        this.applied = this.desiredFilters();
        this.page = 1;
        this.load();
      },

      clearFilters() {
        this.draft = {};
        this.applied = {};
        this.page = 1;
        this.syncControls();
        this.load();
        this.$nextTick(() => this.$refs.filterToggle?.focus());
      },

      removeFilter(key) {
        delete this.applied[key];
        this.draft = this.draftFromApplied();
        this.page = 1;
        this.syncControls();
        this.load();
      },

      // Writes the draft into the wrapped components through their own Alpine scopes.
      // Relies on the component state names `value`, `selectedValue`, `selectedTitle` and on
      // DatePicker's `setValue()`/`datepicker-change` (see Tests/RaccoonTests/DataTableTests.swift).
      syncControls() {
        this.silent = true;
        this.$root.querySelectorAll("[data-filter-field]").forEach(wrapper => {
          const field = wrapper.dataset.filterField;
          if (field === "__mode") return;
          const value = this.draft[field] ?? "";
          const kind = wrapper.dataset.filterKind;
          const root = wrapper.querySelector("[x-data]");
          if (!root) return;

          if (kind === "check") {
            const input = wrapper.querySelector("input[type=checkbox]");
            if (input) input.checked = value === "true";
          } else if (kind === "datepicker") {
            const [start, end] = value.split(",");
            Alpine.$data(root).setValue(start || "", end || "");
          } else if (kind === "dropdown") {
            const scope = Alpine.$data(root);
            const col = columnsByKey.get(wrapper.dataset.filterKey);
            const option = col.filter.options.find(o => o.value === value);
            scope.selectedValue = value;
            scope.selectedTitle = option ? option.title : config.labels.all;
          } else {
            const scope = Alpine.$data(root);
            scope.value = value;
            scope.isTouched = false;
          }
        });
        this.$nextTick(() => { this.silent = false; });
      }
    };

    Object.entries(Object.getOwnPropertyDescriptors(methods))
      .forEach(([name, descriptor]) => Object.defineProperty(table, name, descriptor));

    return table;
  };
}
