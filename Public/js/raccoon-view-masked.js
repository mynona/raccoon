// V1.0

/* Alpine component: shows a secret masked except for its last N characters, with timed reveal. */

// Guard against double registration if the script is included twice
if (!window.__viewMaskedLoaded) {
  window.__viewMaskedLoaded = true;

  // Decodes a base64-encoded UTF-8 string (server sends secrets base64-encoded)
  function decodeBase64Utf8(b64) {
    return decodeURIComponent(
      Array.prototype.map.call(atob(b64), c =>
        '%' + c.charCodeAt(0).toString(16).padStart(2, '0')
      ).join('')
    );
  }

  document.addEventListener('alpine:init', () => {
    Alpine.data('maskedSecret', (secretBase64, revealCount, revealDuration) => ({
      secret: decodeBase64Utf8(secretBase64),
      revealCount,
      revealDuration,
      visible: false,
      hideTimer: null,
      // Masked string: dots for hidden part, plain text for the last `revealCount` characters
      get maskedSecret() {
        const len = this.secret.length;
        const last = this.secret.slice(-this.revealCount);
        return '•'.repeat(Math.max(0, len - this.revealCount)) + last;
      },
      // Shows the full secret and auto-hides it again after `revealDuration`
      toggleReveal() {
        this.visible = !this.visible;
        clearTimeout(this.hideTimer);
        if (this.visible) {
          this.hideTimer = setTimeout(() => this.visible = false, this.revealDuration);
        }
      },
      init() {}
    }));
  });
}
