// Public/js/raccoon-tooltip.js
// Raccoon Alpine CSP component for accessible, positioned tooltips.

if (!window.__tooltipLoaded) {
  window.__tooltipLoaded = true;

  const register = () => {
    Alpine.data('tooltip', (tooltipArrow = false, tooltipPosition = 'top') => ({
      tooltipVisible: false,
      tooltipArrow,
      tooltipPosition,

      // The anchor check keeps the old behaviour: only show when the trigger exists on the page
      onShow(event, id) {
        if (event.detail && event.detail.id === id) {
          if (document.querySelector(`[x-ref='${id}']`)) {
            this.tooltipVisible = true;
          }
        }
      },
      onHide(event, id) {
        if (event.detail && event.detail.id === id) {
          this.tooltipVisible = false;
        }
      },
    }));
  };

  if (window.Alpine) {
    register();
  } else {
    document.addEventListener('alpine:init', register);
  }
}
