// V1.0

/* Alpine component: single-select combobox with search filtering and a preselected value. */

// Guard against double registration if the script is included twice
if (!window.__singleSelectLoaded) {
  window.__singleSelectLoaded = true;

  document.addEventListener('alpine:init', () => {
    Alpine.data('singleSelect', ({
      id = '',
      frameworks = [],
      preselected = null,
      hasServerError = false,
      debug = false // Per-instance debug flag
    } = {}) => ({
    isOpen: false,
    query: '',
    frameworks,
    selected: null,
    hasServerError,
    clearInput() {
      this.query = '';
      this.selected = null;
      this.hasServerError = false;
      if (this.debug) console.debug(`[SingleSelect:${id}:clearInput] Cleared selection`);
      this.$nextTick(() => {
        this.$refs.comboInput?.focus();
      });
    },
    onEsc(event) {
      if (event.key === 'Escape') {
        this.clearInput();
      }
    },
    get filteredFrameworks() {
      if (this.query === '') return this.frameworks;
      const q = this.query.toLowerCase();
      return this.frameworks.filter(framework => framework.name.toLowerCase().includes(q));
    },
    init() {
      if (this.debug) console.debug(`[SingleSelect:${id}:init]`, { id, preselected, frameworks, selected: this.selected });
      // Resolve the preselected id to a framework object, if any
      if (preselected !== null && preselected !== '') {
        const found = this.frameworks.find(f => f.id === preselected);
        this.selected = found ?? null;
        if (this.debug) console.debug(`[SingleSelect:${id}:init] Preselected found:`, found);
      } else {
        this.selected = null;
        if (this.debug) console.debug(`[SingleSelect:${id}:init] No preselected value`);
      }
      // Keep the visible query text in sync with the selected item
      this.$watch('selected', value => {
        if (value) {
          this.query = value.name;
          this.hasServerError = false;
          if (this.debug) {
            console.debug(`[SingleSelect:${id}:selected changed]`, value);
            const hiddenInput = this.$root.querySelector('input[type=hidden][name="' + id + '"]');
            if (hiddenInput) {
              console.debug(`[SingleSelect:${id}:hidden input value]`, hiddenInput.value);
            }
          }
        }
      });
    },
    debug // expose debug flag to the instance
  }));
});
}
