// V1.1

/* Alpine component: copies text to the clipboard and shows brief feedback (inline or toast). */

// Guard against double registration if the script is included twice
if (!window.__copyToClipboardLoaded) {
  window.__copyToClipboardLoaded = true;

  document.addEventListener('alpine:init', () => {
    Alpine.data('copyToClipboard', (config = {}) => ({
      copied: false,
      copyFailed: false,
      hasToast: config.hasToast || false,
      toastText: config.toastText || '',

      triggerToast(type, title, text) {
        if (window.RaccoonToast && typeof window.RaccoonToast[type] === 'function') {
          window.RaccoonToast[type](title, text);
        } else {
          window.dispatchEvent(new CustomEvent('raccoon:toast', {
            detail: { type, title, text }
          }));
        }
      },

      getToastStrings() {
        const el = this.$el;
        let title = 'Copied';
        let text = this.toastText || (el && el.dataset && el.dataset.toastText) || 'Copied to clipboard for copy-paste';
        const titleKey = 'copytoclipboard.copied';
        const textKey = (el && el.dataset && el.dataset.i18nToastText) || (el && el.getAttribute && el.getAttribute('data-i18n-toast-text')) || 'copytoclipboard.toast';

        if (window.RaccoonI18n && typeof window.RaccoonI18n.t === 'function') {
          title = window.RaccoonI18n.t(titleKey, null, title);
          if (textKey) {
            text = window.RaccoonI18n.t(textKey, null, text);
          }
        }
        return { title, text };
      },

      copy(text) {
        const el = this.$el;
        const isToast = this.hasToast || (el && el.dataset && el.dataset.hasToast === 'true');

        if (!navigator.clipboard || !navigator.clipboard.writeText) {
          this.copyFailed = true;
          setTimeout(() => this.copyFailed = false, 2000);
          if (isToast) {
            let failTitle = 'Failed to copy';
            if (window.RaccoonI18n && typeof window.RaccoonI18n.t === 'function') {
              failTitle = window.RaccoonI18n.t('copytoclipboard.failed', null, failTitle);
            }
            this.triggerToast('error', failTitle, '');
          }
          return;
        }
        navigator.clipboard.writeText(text || '')
          .then(() => {
            this.copied = true;
            this.copyFailed = false;
            // Reset the "copied" state after 2s
            setTimeout(() => this.copied = false, 2000);
            if (isToast) {
              const { title, text: toastMsg } = this.getToastStrings();
              this.triggerToast('success', title, toastMsg);
            }
          })
          .catch(() => {
            this.copyFailed = true;
            setTimeout(() => this.copyFailed = false, 2000);
            if (isToast) {
              let failTitle = 'Failed to copy';
              if (window.RaccoonI18n && typeof window.RaccoonI18n.t === 'function') {
                failTitle = window.RaccoonI18n.t('copytoclipboard.failed', null, failTitle);
              }
              this.triggerToast('error', failTitle, '');
            }
          });
      }
    }));
  });
}
