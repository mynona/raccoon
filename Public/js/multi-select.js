// V1.0

/* Alpine component: multi-select combobox with search filtering and removable chips. */

// Guard against double registration if the script is included twice
if (!window.__multiSelectLoaded) {
  window.__multiSelectLoaded = true;

  document.addEventListener('alpine:init', () => {
    Alpine.data('multiSelect', ({
      frameworks = [],
      preselected = [],
      hasServerError = false
    } = {}) => ({
    query: '',
    frameworks,
    selected: [],
    hasServerError,
    clearInput() {
      this.query = '';
      this.selected = [];
      this.hasServerError = false;
      this.$nextTick(() => {
        const input = this.$el.querySelector('[x-combobox\\:input]');
        if (input && typeof input.focus === 'function') {
          input.focus();
        }
      });
    },
    onEsc(event) {
      if (event.key === 'Escape') {
        this.clearInput();
      }
    },
    get filteredFrameworks() {
      let base = this.query === ''
        ? this.frameworks
        : this.frameworks.filter((framework) => {
            return framework.name.toLowerCase().includes(this.query.toLowerCase());
          });
      // Exclude already selected items
      return base.filter(f => !this.selected.some(s => s.id === f.id));
    },
    remove(framework) {
      this.selected = this.selected.filter((i) => i !== framework);
      this.$nextTick(() => {
        const input = this.$el.querySelector('[x-combobox\\:input]');
        if (input && typeof input.focus === 'function') {
          input.focus();
        }
      });
    },
    // Builds <option> markup for the selected items, used to submit a native <select>
    selectedOptions() {
      let str = '';
      for (const item of this.selected) {
        if (!item) continue;
        const id = item.id;
        const name = item.name;
        str += `<option value='${id}' selected>${name}</option>`;
      }
      return str;
    },
    init() {
      // Resolve preselected indexes into framework objects
      for (const element of preselected) {
        if (this.frameworks[element]) {
          this.selected.push(this.frameworks[element]);
        }
      }
      this.$watch('selected', (value, oldValue) => {
        if (value.length > 0) {
          this.hasServerError = false;
        }
      });
    }
  }));
});
}
