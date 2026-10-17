// V1.0

/* Alpine component: editable list of regex-validated string values (add/remove/validate rows). */

// Guard against double registration if the script is included twice
if (!window.__inputListLoaded) {
  window.__inputListLoaded = true;

  document.addEventListener('alpine:init', () => {
    Alpine.data('inputListForm', (initialValues = [], regexPattern = '', errorMessage = 'Invalid value.') => ({
      values: Array.isArray(initialValues) ? initialValues : [],
      newValue: '',
      newError: '',
      rowErrors: [],
      rowValid: [],
      regex: new RegExp(regexPattern),
      defaultMessage: errorMessage,

      init() {
        // Validate every existing row up front so errors show immediately
        this.rowErrors = Array(this.values.length).fill('');
        this.rowValid  = Array(this.values.length).fill(false);
        this.values.forEach((_, index) => this.setValidity(index));
        this.validateNew();
      },

      validate(value) {
        return this.regex.test((value || '').toString());
      },

      // Updates error/valid state for an existing row
      setValidity(index) {
        const val = (this.values[index] || '').trim();
        if (val === '') {
          this.rowErrors[index] = 'Value cannot be empty.';
          this.rowValid[index] = false;
        } else if (!this.validate(val)) {
          this.rowErrors[index] = this.defaultMessage;
          this.rowValid[index] = false;
        } else {
          this.rowErrors[index] = '';
          this.rowValid[index] = true;
        }
      },

      validateExisting(index) {
        this.setValidity(index);
      },

      // Validates the pending new-value input without adding it
      validateNew() {
        const val = (this.newValue || '').trim();
        if (val === '') {
          this.newError = '';
        } else if (!this.validate(val)) {
          this.newError = this.defaultMessage;
        } else {
          this.newError = '';
        }
      },

      // Adds the new value as a row if it's non-empty, valid, and unique
      add() {
        const trimmed = (this.newValue || '').trim();
        if (trimmed === '') {
          this.newError = 'Value cannot be empty.';
          return;
        }
        if (!this.validate(trimmed)) {
          this.newError = this.defaultMessage;
          return;
        }
        if (this.values.includes(trimmed)) {
          this.newError = 'This value already exists.';
          return;
        }
        this.values.push(trimmed);
        this.newValue = '';
        this.newError = '';
        const idx = this.values.length - 1;
        this.rowValid.splice(idx, 0, true);
        this.rowErrors.splice(idx, 0, '');
      },

      remove(index) {
        this.values.splice(index, 1);
        this.rowErrors.splice(index, 1);
        this.rowValid.splice(index, 1);
      },

      clearAll() {
        this.values = [];
        this.rowErrors = [];
        this.rowValid = [];
        this.newError = '';
      },

      clearInput() {
        this.newValue = '';
        this.newError = '';
      }
    }));
  });
}
