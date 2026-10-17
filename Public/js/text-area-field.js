// V1.0

/* Alpine factory for a textarea field with regex validation and auto-resize. */

// Guard against double registration if the script is included twice
if (!window.__textAreaFieldLoaded) {
    window.__textAreaFieldLoaded = true;

    // Decodes a base64-encoded UTF-8 string (server sends initial values base64-encoded)
    function decodeBase64Utf8(b64) {
        return decodeURIComponent(
            Array.prototype.map.call(atob(b64), c =>
                '%' + c.charCodeAt(0).toString(16).padStart(2, '0')
            ).join('')
        );
    }

    // Exposed as a plain factory (not Alpine.data) so it can be called inline via x-data
    window.textAreaFieldAlpine = function({
        regexPattern = null,
        errorMessage = '',
        hasServerError = false,
        hasInitialValue = false,
        initialValue = ''
    } = {}) {
        return {
            initialized: false,
            // Server sends the initial value base64-encoded
            value: initialValue ? decodeBase64Utf8(initialValue) : '',
            regexPattern: regexPattern,
            regex: null,
            errorMessage: errorMessage,
            hasError: false,
            hasServerError: hasServerError,
            isValid: false,
            isTouched: false,
            hasInitialValue: hasInitialValue,
            validate() {
                if (!this.regex) {
                    this.isValid = true;
                    this.hasError = false;
                    return;
                }
                this.isValid = this.regex.test(this.value);
                this.hasError = !this.isValid;
            },
            // Grows the textarea to fit its content
            autoResize(el) {
                el.style.height = 'auto';
                el.style.height = el.scrollHeight + 'px';
            }
        };
    };
}
