// V1.0

/* Alpine component: checkbox list with select-all, indeterminate state, and debounced search. */

// Guard against double registration if the script is included twice
if (!window.__checkboxSelectLoaded) {
    window.__checkboxSelectLoaded = true;

    document.addEventListener('alpine:init', () => {
        Alpine.data('checkboxSelect', (initialValues = []) => ({
            values: Array.isArray(initialValues) ? initialValues : [],
            selectAll: false,
            searchRaw: '',
            search: '',
            formatLabel(title) { return (title || ''); },

            // Syncs the select-all checkbox (checked/indeterminate) with the filtered rows
            updateSelectAll() {
                if (this.searchRaw.length > 0) return;
                const all = this.filteredValues.every(v => v.selected);
                const some = this.filteredValues.some(v => v.selected);
                this.selectAll = all;
                this.$nextTick(() => {
                    const el = this.$root.querySelector('[id$="-selectAll"]');
                    if (el) el.indeterminate = !all && some;
                    if (el) el.setAttribute('aria-checked', all ? 'true' : some ? 'mixed' : 'false');
                });
            },

            toggleAll() {
                this.values.forEach(v => v.selected = this.selectAll);
                this.updateSelectAll();
            },

            get filteredValues() {
                return this.values.filter(v =>
                    this.formatLabel(v.title).toLowerCase().includes(this.search.toLowerCase())
                );
            },

            // Comma-separated selected values, e.g. for a hidden input
            get joined() {
                return this.values
                    .filter(v => v.selected)
                    .map(v => v.value)
                    .join(',');
            },

            init() {
                // Debounce search input to avoid filtering on every keystroke
                let debounceTimer;
                this.$watch('searchRaw', value => {
                    clearTimeout(debounceTimer);
                    debounceTimer = setTimeout(() => {
                        this.search = value;
                    }, 300);
                });
                // Ctrl+A toggles select-all instead of selecting page text
                this.$root.addEventListener('keydown', (e) => {
                    if (e.ctrlKey && e.key === 'a') {
                        e.preventDefault();
                        this.selectAll = !this.selectAll;
                        this.toggleAll();
                    }
                });
            }
        }));
    });
}
