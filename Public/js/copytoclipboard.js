// V1.0

/* Alpine component: copies text to the clipboard and shows brief "copied" feedback. */

// Guard against double registration if the script is included twice
if (!window.__copyToClipboardLoaded) {
  window.__copyToClipboardLoaded = true;

  document.addEventListener('alpine:init', () => {
    Alpine.data('copyToClipboard', () => ({
      copied: false,
      copyFailed: false,
      copy(text) {
        if (!navigator.clipboard || !navigator.clipboard.writeText) {
          this.copyFailed = true;
          setTimeout(() => this.copyFailed = false, 2000);
          return;
        }
        navigator.clipboard.writeText(text)
          .then(() => {
            this.copied = true;
            this.copyFailed = false;
            // Reset the "copied" state after 2s
            setTimeout(() => this.copied = false, 2000);
          })
          .catch(() => {
            this.copyFailed = true;
            setTimeout(() => this.copyFailed = false, 2000);
          });
      }
    }));
  });
}
