// V1.0

/* Alpine component: text input with regex validation and base64-decoded initial value. */

// Guard against double registration if the script is included twice
if (!window.__inputFieldLoaded) {
  window.__inputFieldLoaded = true;

  // Decodes a base64-encoded UTF-8 string (server sends initial values base64-encoded)
  function decodeBase64Utf8(b64) {
    return decodeURIComponent(
      Array.prototype.map.call(atob(b64), c =>
        '%' + c.charCodeAt(0).toString(16).padStart(2, '0')
      ).join('')
    );
  }

  const register = () => {
    Alpine.data('inputField', ({
        value = '',
        regexPattern = null,
        errorMessage = '',
        hasServerError = false,
        hasInitialValue = false
    } = {}) => ({
        initialized: false,
        value: decodeBase64Utf8(value),
        regexPattern,
        regex: null,
        errorMessage,
        hasError: false,
        hasServerError,
        isValid: false,
        isTouched: false,
        hasInitialValue,
        validate() {
            if (!this.regex) {
                this.isValid = true;
                this.hasError = false;
                return;
            }
            this.isValid = this.regex.test(this.value);
            this.hasError = !this.isValid;
        },
        touch() {
            this.isTouched = true;
            this.hasServerError = false;
            this.validate();
        },
        onInput() {
            this.touch();
        },
        onBlur() {
            this.touch();
        },
        init() {
            this.regex = this.regexPattern ? new RegExp(this.regexPattern) : null;
            this.initialized = true;
            // Validate immediately if there's already a value to check
            if (this.initialized && (this.hasInitialValue || this.value)) this.validate();
        }
    }));
  };

  if (window.Alpine) {
    register();
  } else {
    document.addEventListener('alpine:init', register);
  }
}
