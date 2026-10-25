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
            // Grows the textarea to fit its content while respecting the rows minimum floor
            autoResize(el) {
                if (!el) return;
                // If element is hidden/unmeasured, do not zero out its height
                if (el.scrollHeight === 0 && (el.offsetHeight === 0 || el.offsetParent === null)) {
                    // Recalculate once element becomes visible/measured
                    if (!el.__resizeObserverAttached && typeof ResizeObserver !== 'undefined') {
                        el.__resizeObserverAttached = true;
                        const ro = new ResizeObserver((entries) => {
                            for (const entry of entries) {
                                if (entry.contentRect.height > 0 || el.scrollHeight > 0) {
                                    ro.disconnect();
                                    el.__resizeObserverAttached = false;
                                    this.autoResize(el);
                                }
                            }
                        });
                        ro.observe(el);
                    }
                    return;
                }

                const prevHeight = el.style.height;
                el.style.height = 'auto';
                const contentHeight = el.scrollHeight;

                if (contentHeight === 0) {
                    el.style.height = prevHeight || '';
                    return;
                }

                // Determine row floor based on rows attribute and computed line-height
                const rowsAttr = parseInt(el.getAttribute('rows') || '1', 10);
                const computed = window.getComputedStyle(el);
                const lineHeight = parseFloat(computed.lineHeight) || (parseFloat(computed.fontSize) || 16) * 1.5;
                const paddingTop = parseFloat(computed.paddingTop) || 0;
                const paddingBottom = parseFloat(computed.paddingBottom) || 0;
                const minRowHeight = (rowsAttr * lineHeight) + paddingTop + paddingBottom;

                const targetHeight = Math.max(minRowHeight, contentHeight);
                el.style.height = targetHeight + 'px';
            }
        };
    };
}
