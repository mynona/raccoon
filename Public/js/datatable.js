// v1.14

/* Alpine factory: sortable/filterable data table with configurable, reorderable, persisted columns. */

function datatable(data) {

  /* --------------------------------------------------------------------
   DEBUG FLAG
   -------------------------------------------------------------------- */
  const DEBUG = false;
  const tableId =
  data.meta?.storageKey
  ? data.meta.storageKey
  : `tableWithoutStorageKey-${Math.floor(Math.random() * 1_000_000)}`;

  function log(...args) {
    if (DEBUG) console.log(`[datatable:${tableId}]`, ...args);
  }

  /* --------------------------------------------------------------------
   LOCAL STORAGE
   -------------------------------------------------------------------- */
  function persistTableState(key, state) {
    if (!key) return;
    try {
      log("persistTableState: saving", key, state);
      localStorage.setItem(key, JSON.stringify(state));
    } catch (err) {
      log("persistTableState failed", key, err);
    }
  };

  function restoreTableState(key, columns) {
    if (!key) return null;
    try {
      const raw = localStorage.getItem(key);
      if (!raw) {
        log("restoreTableState: no stored state", key);
        return null;
      }

      const parsed = JSON.parse(raw);
      const valid = new Set(columns.map(c => c.key));

      const restored = {
        visibleColumns: parsed.visibleColumns?.filter(k => valid.has(k)) ?? null,
        columnOrder: parsed.columnOrder?.filter(k => valid.has(k)) ?? null,
      sort:
        parsed.sort &&
        valid.has(parsed.sort.key) &&
        (parsed.sort.direction === "asc" || parsed.sort.direction === "desc")
        ? parsed.sort
        : null
      };

      log("restoreTableState: restored", key, restored);
      return restored;
    } catch (err) {
      log("restoreTableState failed", key, err);
      return null;
    }
  };

  /* --------------------------------------------------------------------
   ASCII TABLE
   -------------------------------------------------------------------- */
  function buildAsciiTable(headers, rows) {
    log("buildAsciiTable", { headerCount: headers.length, rowCount: rows.length });

    const widths = headers.map((h, i) =>
                               Math.max(h.length, ...rows.map(r => String(r[i]).length))
                               );
    const pad = (v, w) => String(v).padEnd(w, " ");
    const border = "|-" + widths.map(w => "-".repeat(w)).join("-|-") + "-|";
    const headerRow = "| " + headers.map((h, i) => pad(h, widths[i])).join(" | ") + " |";
    const body = rows.map(r => "| " + r.map((v, i) => pad(v, widths[i])).join(" | ") + " |");
    return [border, headerRow, border, ...body, border].join("\n");
  };

  return {

    /* --------------------------------------------------------------------
     CORE STATE
     -------------------------------------------------------------------- */
    meta: data.meta,
    rows: data.rows,

    /* --------------------------------------------------------------------
     FEATURE FLAGS
     -------------------------------------------------------------------- */
    hasIndexColumn: data.meta?.hasIndexColumn === true,
    hasColumnConfigurator: data.meta?.hasColumnConfigurator === true,
    hasSearch: data.meta?.hasSearch === true,
    hasCopyToClipboard: data.meta?.hasCopyToClipboard === true,

    columnOrder: data.meta.columns.map(c => c.key),
    columnByKey: null,

    sortKey: null,
    sortDirection: "asc",

    /* --------------------------------------------------------------------
     POINTER DRAG STATE
     -------------------------------------------------------------------- */
    draggingTempKey: null,
    tempColumnOrder: [],
    tempDropIndex: null, // slot index 0..N
    tempPointerActive: false,
    tempPointerFromIndex: null,

    /* --------------------------------------------------------------------
     KEYBOARD DRAG STATE
     -------------------------------------------------------------------- */
    keyboardDraggingKey: null,
    keyboardAnnouncement: "",

    /* --------------------------------------------------------------------
     FILTER
     -------------------------------------------------------------------- */
    filterText: "",
    showFilter: false,

    /* --------------------------------------------------------------------
     UI STATE
     -------------------------------------------------------------------- */
    hasRestoredState: false,
    copied: false,
    showColumnModal: false,

    visibleColumns: new Set(data.meta.columns.map(c => c.key)),
    tempVisibleColumns: new Set(),

    /* --------------------------------------------------------------------
     DERIVED LISTS
     -------------------------------------------------------------------- */
    get orderedColumns() {
      return this.columnOrder.map(k => this.columnByKey.get(k)).filter(Boolean);
    },

    get activeColumns() {
      return this.orderedColumns.filter(c => this.visibleColumns.has(c.key));
    },

    get tempColumns() {
      return this.tempColumnOrder.map(k => this.columnByKey.get(k)).filter(Boolean);
    },

    get canCopy() {
      return this.meta?.columns?.length && this.rows?.length;
    },

    /* --------------------------------------------------------------------
     INIT
     -------------------------------------------------------------------- */
    init() {
      if (this.hasRestoredState) return;

      log("init", this.meta.storageKey);

      this.columnByKey = new Map(this.meta.columns.map(c => [c.key, c]));

      const restored = restoreTableState(this.meta.storageKey, this.meta.columns);
      if (restored?.visibleColumns) this.visibleColumns = new Set(restored.visibleColumns);
      if (restored?.columnOrder) this.columnOrder = restored.columnOrder;
      if (restored?.sort) {
        this.sortKey = restored.sort.key;
        this.sortDirection = restored.sort.direction;
      }

      this.hasRestoredState = true;

      log("after init", {
        visibleColumns: [...this.visibleColumns],
        columnOrder: this.columnOrder,
        sortKey: this.sortKey,
        sortDirection: this.sortDirection
      });

      // --- Filter auto-focus watcher ---
      this.$watch('showFilter', value => {
        if (value) {
          this.$nextTick(() => {
            const el = this.$refs.filterInput;
            if (el) el.focus();
          });
        }
      });

    },

    /* --------------------------------------------------------------------
     PERSIST
     -------------------------------------------------------------------- */
    persistState() {
      const state = {
        visibleColumns: [...this.visibleColumns],
        columnOrder: [...this.columnOrder],
        sort: this.sortKey ? { key: this.sortKey, direction: this.sortDirection } : null
      };

      log("persistState", state);
      persistTableState(this.meta.storageKey, state);
    },

    /* --------------------------------------------------------------------
     POPOVER OPEN/CLOSE
     -------------------------------------------------------------------- */
    openColumnModal() {
      // Do nothing if hasColumnConfigurator == false
      if (!this.hasColumnConfigurator) return;
      log("openColumnModal");

      this.tempVisibleColumns = new Set(this.visibleColumns);

      const visibleKeys = this.activeColumns.map(c => c.key);
      const hiddenKeys = this.columnOrder.filter(k => !visibleKeys.includes(k));
      this.tempColumnOrder = [...visibleKeys, ...hiddenKeys];

      this.showColumnModal = true;
      this.rememberTriggerAndFocusPopover();
    },

    cancelColumnChanges() {
      // Do nothing if hasColumnConfigurator == false
      if (!this.hasColumnConfigurator) return;
      log("cancelColumnChanges");

      // Discard temp column changes and return focus to the trigger button
      this.showColumnModal = false;
      this.keyboardDraggingKey = null;
      this.keyboardAnnouncement = "";
      this.$nextTick(() => {
        if (this._columnTrigger?.focus) this._columnTrigger.focus();
      });
    },

    applyColumnChanges() {
      // Do nothing if hasColumnConfigurator == false
      if (!this.hasColumnConfigurator) return;
      log("applyColumnChanges", {
        tempVisibleColumns: [...this.tempVisibleColumns],
        tempColumnOrder: [...this.tempColumnOrder]
      });

      // Commit temp visibility/order as the real state and persist it
      this.visibleColumns = new Set(this.tempVisibleColumns);
      this.columnOrder = [...this.tempColumnOrder];
      this.showColumnModal = false;
      this.keyboardDraggingKey = null;
      this.keyboardAnnouncement = "";
      this.persistState();
    },

    /* --------------------------------------------------------------------
     VISIBILITY TOGGLE
     -------------------------------------------------------------------- */
    isHideable(col) {
      return col.hideable !== false && col.hideable !== "false";
    },

    // True only if every column may be hidden (used to enforce keeping one visible)
    get allColumnsAreHideable() {
      return this.meta.columns.every(c => this.isHideable(c));
    },

    toggleTempColumn(key) {
      const col = this.columnByKey.get(key);
      if (!col) {
        log("toggleTempColumn: col not found", key);
        return;
      }

      log("toggleTempColumn before", key, {
        isHideable: this.isHideable(col),
        tempVisibleColumns: [...this.tempVisibleColumns]
      });

      if (!this.isHideable(col)) {
        this.tempVisibleColumns.add(key);
      } else if (this.tempVisibleColumns.has(key)) {
        const hideableCount = [...this.tempVisibleColumns].filter(k => {
          const c = this.columnByKey.get(k);
          return c && this.isHideable(c);
        }).length;

        if (this.allColumnsAreHideable && hideableCount <= 1) {
          log("toggleTempColumn blocked: last hideable column", key);
          return;
        }
        this.tempVisibleColumns.delete(key);
      } else {
        this.tempVisibleColumns.add(key);
      }

      log("toggleTempColumn after", key, [...this.tempVisibleColumns]);
    },

    /* --------------------------------------------------------------------
     SORTING
     -------------------------------------------------------------------- */
    // Sorts by `key`, toggling asc/desc if it's already the active sort key
    sort(key) {
      const oldKey = this.sortKey;
      const oldDir = this.sortDirection;

      this.sortDirection =
      this.sortKey === key && this.sortDirection === "asc" ? "desc" : "asc";
      this.sortKey = key;

      log("sort", {
        from: { key: oldKey, dir: oldDir },
        to: { key, dir: this.sortDirection }
      });

      this.persistState();
    },

    get sortedRows() {
      // Apply filter first
      const rows = this.filteredRows;

      // Logging: before sorting
      log("sortedRows: before sort", {
        sortKey: this.sortKey,
        sortDirection: this.sortDirection,
        rowCount: rows.length,
        sample: rows.slice(0, 3)
      });

      // No sort key → return filtered rows as-is
      if (!this.sortKey) {
        log("sortedRows: no sortKey, returning filtered rows");
        return rows;
      }

      const col = this.columnByKey.get(this.sortKey);
      if (!col) {
        log("sortedRows: sortKey not found in columnByKey", this.sortKey);
        return rows;
      }

      // Perform sorted copy
      const sorted = [...rows].sort((a, b) => {
        let x = a[this.sortKey];
        let y = b[this.sortKey];

        if (col.type === "number") {
          x = Number(x);
          y = Number(y);
        } else if (col.type === "date") {
          x = new Date(x).getTime();
          y = new Date(y).getTime();
        } else {
          x = String(x).toLowerCase();
          y = String(y).toLowerCase();
        }

        if (x === y) return 0;
        return this.sortDirection === "asc"
        ? (x > y ? 1 : -1)
        : (x < y ? 1 : -1);
      });

      // Logging: after sorting
      log("sortedRows: after sort", {
        sortKey: this.sortKey,
        sortDirection: this.sortDirection,
        rowCount: sorted.length,
        sample: sorted.slice(0, 3)
      });

      return sorted;
    },

    /* --------------------------------------------------------------------
     FOCUS TRAP
     -------------------------------------------------------------------- */
    // Remembers which element opened the popover so focus can return to it
    rememberTriggerAndFocusPopover() {
      log("rememberTriggerAndFocusPopover");
      this._columnTrigger = this.$root.querySelector("[data-column-trigger]") || null;
      this.$nextTick(() => this.focusFirstInPopover());
    },

    focusFirstInPopover() {
      log("focusFirstInPopover");
      const root = this.$root.querySelector("[data-column-popover]");
      if (!root) return;

      const focusables = root.querySelectorAll(
                                               'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
                                               );
      const first = [...focusables].find(el => !el.disabled);
      if (first) first.focus();
    },

    // Cycles Tab focus within the popover instead of leaving it
    trapTab(event) {
      if (this.keyboardDraggingKey) return;
      if (event.key !== "Tab") return;

      log("trapTab");

      const root = this.$root.querySelector("[data-column-popover]");
      if (!root) return;

      const focusables = [...root.querySelectorAll(
                                                   'button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])'
                                                   )].filter(el => !el.disabled);

      if (!focusables.length) return;

      const first = focusables[0];
      const last = focusables[focusables.length - 1];
      const active = document.activeElement;

      if (event.shiftKey && active === first) {
        event.preventDefault();
        last.focus();
      } else if (!event.shiftKey && active === last) {
        event.preventDefault();
        first.focus();
      }
    },

    /* ====================================================================
     KEYBOARD REORDERING
     ==================================================================== */
    // Focuses the drag-handle button for `key` once it's rendered
    focusGrip(key) {
      log("focusGrip requested", key);
      this.$nextTick(() => {
        requestAnimationFrame(() => {
          requestAnimationFrame(() => {
            const el = this.$root.querySelector(`[data-grip="${key}"]`);
            if (el) {
              log("focusGrip found element", key);
              el.focus({ preventScroll: true });
            } else {
              log("focusGrip element not found", key);
            }
          });
        });
      });
    },

    toggleKeyboardDrag(key) {
      // do nothing if hasColumnConfigurator == false
      if (!this.hasColumnConfigurator) return;
      // Picks up or drops the column identified by `key` for keyboard reordering
      const wasDragging = this.keyboardDraggingKey === key;

      this.keyboardDraggingKey = wasDragging ? null : key;
      this.keyboardAnnouncement = wasDragging
      ? `Dropped ${key}.`
      : `Picked up ${key}. Use arrow keys to move.`;

      log("toggleKeyboardDrag", {
        key,
        nowDragging: this.keyboardDraggingKey,
        announcement: this.keyboardAnnouncement
      });
    },

    cancelKeyboardDrag() {
      // do nothing if hasColumnConfigurator == false
      if (!this.hasColumnConfigurator) return;
      if (!this.keyboardDraggingKey) return;

      log("cancelKeyboardDrag", this.keyboardDraggingKey);

      this.keyboardAnnouncement = `Cancelled reordering ${this.keyboardDraggingKey}.`;
      this.keyboardDraggingKey = null;
    },

    moveKeyboard(key, delta) {
      // do nothing if hasColumnConfigurator == false
      if (!this.hasColumnConfigurator) return;
      // Moves the picked-up column by `delta` positions in tempColumnOrder
      if (this.keyboardDraggingKey !== key) {
        log("moveKeyboard ignored (not dragging this key)", key);
        return;
      }

      const keys = [...this.tempColumnOrder];
      const from = keys.indexOf(key);
      if (from === -1) {
        log("moveKeyboard: key not found", key, keys);
        return;
      }

      let to = Math.max(0, Math.min(keys.length - 1, from + delta));

      log("moveKeyboard before", { key, delta, from, to, order: keys });

      if (to !== from) {
        const [moved] = keys.splice(from, 1);
        keys.splice(to, 0, moved);
        this.tempColumnOrder = keys;
      }

      const pos = this.tempColumnOrder.indexOf(key) + 1;
      this.keyboardAnnouncement = `Moved ${key} to position ${pos}.`;

      log("moveKeyboard after", {
        key,
        from,
        to,
        newOrder: this.tempColumnOrder,
        announcement: this.keyboardAnnouncement
      });

      this.focusGrip(key);
    },

    moveKeyboardToStart(key) {
      // do nothing if hasColumnConfigurator == false
      if (!this.hasColumnConfigurator) return;
      if (this.keyboardDraggingKey !== key) return;

      const keys = [...this.tempColumnOrder];
      const from = keys.indexOf(key);
      if (from === -1) return;

      log("moveKeyboardToStart before", { key, from, order: keys });

      if (from > 0) {
        const [moved] = keys.splice(from, 1);
        keys.unshift(moved);
        this.tempColumnOrder = keys;
      }

      this.keyboardAnnouncement = `Moved ${key} to the first position.`;

      log("moveKeyboardToStart after", {
        key,
        newOrder: this.tempColumnOrder,
        announcement: this.keyboardAnnouncement
      });

      this.focusGrip(key);
    },

    moveKeyboardToEnd(key) {
      // do nothing if hasColumnConfigurator == false
      if (!this.hasColumnConfigurator) return;
      if (this.keyboardDraggingKey !== key) return;

      const keys = [...this.tempColumnOrder];
      const from = keys.indexOf(key);
      if (from === -1) return;

      log("moveKeyboardToEnd before", { key, from, order: keys });

      if (from !== keys.length - 1) {
        const [moved] = keys.splice(from, 1);
        keys.push(moved);
        this.tempColumnOrder = keys;
      }

      this.keyboardAnnouncement = `Moved ${key} to the last position.`;

      log("moveKeyboardToEnd after", {
        key,
        newOrder: this.tempColumnOrder,
        announcement: this.keyboardAnnouncement
      });

      this.focusGrip(key);
    },

    finishKeyboardDrag(key, event) {
      // do nothing if hasColumnConfigurator == false
      if (!this.hasColumnConfigurator) return;
      if (this.keyboardDraggingKey !== key) {
        log("finishKeyboardDrag ignored (not dragging this key)", {
          key,
          eventKey: event.key
        });
        return;
      }

      log("finishKeyboardDrag", { key, eventKey: event.key });

      this.keyboardDraggingKey = null;
      this.keyboardAnnouncement = `Dropped ${key}.`;
      event.preventDefault();
    },

    /* ====================================================================
     POINTER DRAG
     ==================================================================== */
    // Begins a pointer-based column drag from its current index
    startTempPointerDown(event, key) {
      // do nothing if hasColumnConfigurator == false
      if (!this.hasColumnConfigurator) return;
      event.preventDefault();
      this.tempPointerActive = true;
      this.draggingTempKey = key;
      this.tempPointerFromIndex = this.tempColumnOrder.indexOf(key);

      log("startTempPointerDown", {
        key,
        fromIndex: this.tempPointerFromIndex,
        order: [...this.tempColumnOrder]
      });
    },

    tempPointerMove(event) {
      // do nothing if hasColumnConfigurator == false
      if (!this.hasColumnConfigurator) return;
      if (!this.tempPointerActive || !this.draggingTempKey) return;

      event.preventDefault();

      // Determine which row slot the pointer is currently over
      const container = this.$root.querySelector("[data-draggable-container]");
      const rows = [...container.querySelectorAll("[data-draggable-row]")];

      const y = event.clientY;
      const oldSlot = this.tempDropIndex;

      // Default: drop after last row
      let slot = rows.length;

      // --- Logging: pointer position ---
      log("tempPointerMove: pointer", {
        draggingKey: this.draggingTempKey,
        clientY: y,
        rowCount: rows.length
      });

      for (let i = 0; i < rows.length; i++) {
        const r = rows[i].getBoundingClientRect();
        const mid = r.top + r.height / 2;

        // --- Logging: row geometry ---
        log("tempPointerMove: rowCheck", {
          index: i,
          rowTop: r.top,
          rowBottom: r.bottom,
          rowMid: mid,
          pointerY: y
        });

        if (y < mid) {
          slot = i;
          break;
        }
      }

      // --- Logging: slot decision ---
      log("tempPointerMove: slotUpdate", {
        from: oldSlot,
        to: slot,
        draggingKey: this.draggingTempKey
      });

      this.tempDropIndex = slot;
    },


    endTempPointer() {
      // do nothing if hasColumnConfigurator == false
      if (!this.hasColumnConfigurator) return;
      // Commits the drop slot as the new column position
      if (!this.tempPointerActive || this.tempDropIndex == null) {
        log("endTempPointer: no active drag or no dropIndex", {
          tempPointerActive: this.tempPointerActive,
          tempDropIndex: this.tempDropIndex,
          draggingTempKey: this.draggingTempKey
        });

        this.tempPointerActive = false;
        this.draggingTempKey = null;
        return;
      }

      const keys = [...this.tempColumnOrder];
      const from = this.tempPointerFromIndex;
      let to = this.tempDropIndex;

      log("endTempPointer before reorder", {
        from,
        to,
        keysBefore: keys
      });

      // Remove original
      const [moved] = keys.splice(from, 1);

      // Adjust target if removing from above
      if (to > from) to -= 1;

      // Insert at slot
      keys.splice(to, 0, moved);

      this.tempColumnOrder = keys;

      log("endTempPointer after reorder", {
        from,
        to,
        keysAfter: this.tempColumnOrder
      });

      // Reset
      this.tempPointerActive = false;
      this.draggingTempKey = null;
      this.tempDropIndex = null;
      this.tempPointerFromIndex = null;
    },

    /* --------------------------------------------------------------------
     RESET TABLE TO DEFAULTS
     -------------------------------------------------------------------- */
    // Clears persisted state and restores columns/sort/filter to their initial values
    resetTableState() {
      log("resetTableState");

      // 1. Clear persisted state
      if (this.meta?.storageKey) {
        try {
          localStorage.removeItem(this.meta.storageKey);
          log("resetTableState: removed localStorage key", this.meta.storageKey);
        } catch (err) {
          log("resetTableState: failed to remove localStorage key", err);
        }
      }

      // 2. Restore defaults from meta
      this.visibleColumns = new Set(this.meta.columns.map(c => c.key));
      this.columnOrder = this.meta.columns.map(c => c.key);
      this.sortKey = null;
      this.sortDirection = "asc";

      // 3. Reset temporary UI state
      this.tempVisibleColumns = new Set(this.visibleColumns);
      this.tempColumnOrder = [...this.columnOrder];
      this.keyboardDraggingKey = null;
      this.keyboardAnnouncement = "";

      this.filterText = "";
      this.showFilter = false;

      // 4. Re-render
      this.$nextTick(() => {
        log("resetTableState: applied defaults", {
          visibleColumns: [...this.visibleColumns],
          columnOrder: this.columnOrder,
          sortKey: this.sortKey,
          sortDirection: this.sortDirection
        });
      });
    },

    /* ====================================================================
     FILTER
     ==================================================================== */
    // Rows matching the filter text in any currently visible column
    get filteredRows() {
      if (!this.filterText) return this.rows;

      const q = this.filterText.toLowerCase();

      // Only search in visible columns
      const visibleKeys = this.activeColumns.map(c => c.key);

      return this.rows.filter(row => {
        return visibleKeys.some(key => {
          const value = row[key];
          return value != null && String(value).toLowerCase().includes(q);
        });
      });
    },


    /* ====================================================================
     COPY TABLE
     ==================================================================== */
    // Copies the visible, sorted table to the clipboard as TSV, ASCII, and HTML
    copyTable() {
      log("copyTable");

      const headers = this.activeColumns.map(c => c.label);
      const rows = this.sortedRows.map(r =>
        this.activeColumns.map(c => this.format(r[c.key], c))
      );

      // TSV (semicolon-separated in your case)
      const tsv = [headers.join("; "), ...rows.map(r => r.join("; "))].join("\n");

      // ASCII table
      const ascii = buildAsciiTable(headers, rows);

      // Combined plain text
      const plain = tsv + "\n\n" + ascii;

      // HTML table
      const html =
        "<table><thead><tr>" +
        headers.map(h => `<th>${h}</th>`).join("") +
        "</tr></thead><tbody>" +
        rows
          .map(r => "<tr>" + r.map(v => `<td>${v}</td>`).join("") + "</tr>")
          .join("") +
        "</tbody></table>";

      // Cross‑browser safe clipboard write
      navigator.clipboard.write([
        new ClipboardItem({
          "text/plain": new Blob([plain], { type: "text/plain" }),
          "text/html": new Blob([html], { type: "text/html" })
        })
      ]);
    },

    copyWithFeedback() {
      log("copyWithFeedback");
      this.copyTable();
      this.copied = true;
      setTimeout(() => (this.copied = false), 2000);
    },

    /* ====================================================================
     VALUE FORMATTING
     ==================================================================== */
    // Formats a cell value for display (dates get locale formatting)
    format(value, col) {
      if (value == null) return "";
      if (col.type === "date") return new Date(value).toLocaleString();
      return value;
    }
  };
}


