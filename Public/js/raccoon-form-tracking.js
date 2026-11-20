// V1.2

/* Tracks forms as Matomo events, one set per form view and not per field:
 * - form_start    first focus in the form
 * - field_error   a validated field shows an error (name = field)
 * - form_submit   on submit (value = milliseconds since form_start)
 * - form_abandon  page left without submit (name = last touched field, value = milliseconds since form_start)
 * Field values and their lengths are never reported. */

(function() {

  // Wait until Matomo (_paq) is available (consent‑aware)
  function waitForMatomo(callback, timeout = 5000) {
    const start = Date.now();

    (function check() {
      if (typeof window._paq !== "undefined" && Array.isArray(window._paq)) {
        callback();
        return;
      }
      if (Date.now() - start > timeout) return;
      requestAnimationFrame(check);
    })();
  }

  // Initialize tracking once Matomo + DOM are ready
  function initMatomoFormTracking() {
    const forms = document.querySelectorAll('form[data-matomo-name]');
    if (!forms.length) return;

    forms.forEach(form => {
      const formName = form.dataset.matomoName;
      const eventCategory = `form.${formName}`;

      let startTime = null;
      let lastFieldId = null;
      let formSubmitted = false;
      let abandonReported = false;

      // Report one event with the form name as custom dimension 2
      function track(action, name, value) {
        const event = ['trackEvent', eventCategory, action, name];
        if (value !== undefined) event.push(value);

        _paq.push(['setCustomDimension', 2, formName]);
        _paq.push(event);
        _paq.push(['deleteCustomDimension', 2]);
      }

      // Track all input-like fields
      const fields = form.querySelectorAll('input, textarea, select');

      fields.forEach(field => {
        if (field.dataset.matomoFieldTracked === "1") return;
        field.dataset.matomoFieldTracked = "1";

        // Field identifier fallback chain
        const fieldId = field.id || field.name || field.dataset.matomoName || 'unnamed_field';

        field.addEventListener('focus', () => {
          lastFieldId = fieldId;
          if (startTime) return;

          startTime = Date.now();
          track('form_start', formName);
        });

        field.addEventListener('blur', () => {
          lastFieldId = fieldId;

          // Track errors only for Alpine-validated fields
          const alpine = field.closest('[x-data]')?.__x?.$data;
          if (alpine) {
            const hasError = alpine.hasError || alpine.hasServerError;
            if (hasError) {
              track('field_error', fieldId, alpine.errorMessage || 'unknown_error');
            }
          }
        });
      });

      // Track form submission and time to complete
      if (!form.dataset.matomoFormTracked) {
        form.dataset.matomoFormTracked = "1";

        form.addEventListener('submit', () => {
          formSubmitted = true;
          track('form_submit', formName, startTime ? Date.now() - startTime : undefined);
        });
      }

      // Track abandonment once, on whichever unload event fires first
      function reportAbandon() {
        if (!startTime || formSubmitted || abandonReported) return;
        abandonReported = true;
        track('form_abandon', lastFieldId || 'no_field', Date.now() - startTime);
      }
      window.addEventListener('pagehide', reportAbandon);
      window.addEventListener('beforeunload', reportAbandon);

    });
  }

  // Start when DOM + Matomo are ready
  function start() {
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', () => {
        waitForMatomo(initMatomoFormTracking);
      });
    } else {
      waitForMatomo(initMatomoFormTracking);
    }
  }

  start();

})();
