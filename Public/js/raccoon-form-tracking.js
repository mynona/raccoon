// V1.0

/* Tracks form field focus/blur/input/change, submission, and abandonment as Matomo events. */

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

      // Track all input-like fields
      const fields = form.querySelectorAll('input, textarea, select');

      fields.forEach(field => {
        if (field.dataset.matomoFieldTracked === "1") return;
        field.dataset.matomoFieldTracked = "1";

        // Field identifier fallback chain
        const fieldId = field.id || field.name || field.dataset.matomoName || 'unnamed_field';

        field.addEventListener('focus', () => {
          if (!startTime) startTime = Date.now();
          lastFieldId = fieldId;

          _paq.push(['setCustomDimension', 2, formName]);
          _paq.push(['trackEvent', eventCategory, 'field_focus', fieldId]);
          _paq.push(['deleteCustomDimension', 2]);
        });

        field.addEventListener('blur', () => {
          lastFieldId = fieldId;

          _paq.push(['setCustomDimension', 2, formName]);
          _paq.push(['trackEvent', eventCategory, 'field_blur', fieldId]);
          _paq.push(['deleteCustomDimension', 2]);

          // Track errors only for Alpine-validated fields
          const alpine = field.closest('[x-data]')?.__x?.$data;
          if (alpine) {
            const hasError = alpine.hasError || alpine.hasServerError;
            if (hasError) {
              const errorMessage = alpine.errorMessage || 'unknown_error';

              _paq.push(['setCustomDimension', 2, formName]);
              _paq.push([
                'trackEvent',
                eventCategory,
                'field_error',
                fieldId,
                errorMessage
              ]);
              _paq.push(['deleteCustomDimension', 2]);
            }
          }
        });

        // Granular tracking for text inputs
        if (field.tagName === 'INPUT' && field.type === 'text') {
          field.addEventListener('input', () => {
            const valueLength = field.value?.length || 0;
            lastFieldId = fieldId;

            _paq.push(['setCustomDimension', 2, formName]);
            _paq.push(['trackEvent', eventCategory, 'field_input', fieldId, valueLength]);
            _paq.push(['deleteCustomDimension', 2]);
          });
        }

        // Fallback for selects, checkboxes, radios, etc.
        field.addEventListener('change', () => {
          const valueLength = field.value?.length || 0;
          lastFieldId = fieldId;

          _paq.push(['setCustomDimension', 2, formName]);
          _paq.push(['trackEvent', eventCategory, 'field_change', fieldId, valueLength]);
          _paq.push(['deleteCustomDimension', 2]);
        });
      });

      // Track form submission + time to complete
      if (!form.dataset.matomoFormTracked) {
        form.dataset.matomoFormTracked = "1";

        form.addEventListener('submit', () => {
          formSubmitted = true;

          _paq.push(['setCustomDimension', 2, formName]);
          _paq.push(['trackEvent', eventCategory, 'form_submit', formName]);
          _paq.push(['deleteCustomDimension', 2]);

          if (startTime) {
            const duration = Date.now() - startTime;

            _paq.push(['setCustomDimension', 2, formName]);
            _paq.push([
              'trackEvent',
              eventCategory,
              'form_time_to_complete',
              formName,
              duration
            ]);
            _paq.push(['deleteCustomDimension', 2]);
          }
        });
      }

      // Track abandonment
      window.addEventListener('beforeunload', () => {
        if (!startTime || formSubmitted) return;

        const duration = Date.now() - startTime;

        _paq.push(['setCustomDimension', 2, formName]);
        _paq.push([
          'trackEvent',
          eventCategory,
          'form_abandon',
          lastFieldId || 'no_field',
          duration
        ]);
        _paq.push(['deleteCustomDimension', 2]);
      });

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
