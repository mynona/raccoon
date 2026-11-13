// V1.0 - Raccoon Toast Notification Client Engine

/* Alpine.js store & component for accessible, stacked, timed toast notifications. */

if (!window.__raccoonToastLoaded) {
  window.__raccoonToastLoaded = true;

  document.addEventListener('alpine:init', () => {
    Alpine.store('toasts', {
      items: [],
      defaultDuration: 5000,
      hasPauseOnHover: true,
      hasPauseOnFocus: true,
      shortcutKey: 't',
      previousActiveElement: null,

      init() {
        // Global keyboard shortcut: Alt+T / Option+T to focus newest toast (WCAG 2.1.1)
        window.addEventListener('keydown', (e) => {
          if (e.altKey && e.key.toLowerCase() === this.shortcutKey) {
            e.preventDefault();
            this.focusNewestToast();
          }
        });
      },

      add(toast) {
        if (!toast) return;
        const id = toast.id || 'toast-' + Date.now() + '-' + Math.random().toString(36).substr(2, 9);
        const type = toast.type || 'info';
        const title = toast.title || '';
        const text = toast.text || '';

        // Dynamic reading speed calculation: base 4s + 250ms per word
        const words = (title + ' ' + text).trim().split(/\s+/).filter(Boolean).length;
        const readingDuration = Math.max(5000, 3000 + words * 250);

        // Sticky (duration: 0) by default for error; otherwise configured or reading duration
        let duration = this.defaultDuration;
        if (toast.duration !== undefined) {
          duration = toast.duration;
        } else if (toast.durationMs !== undefined) {
          duration = toast.durationMs;
        } else if (type === 'error') {
          duration = 0; // Sticky by default for errors (WCAG 2.2.1)
        } else {
          duration = readingDuration;
        }

        const item = {
          id,
          type,
          title,
          text,
          duration,
          remaining: duration,
          timer: null,
          startTime: null,
          isPaused: false
        };

        this.items.push(item);

        // Start timer if auto-dismiss is enabled
        if (duration > 0) {
          this.startTimer(item);
        }

        // Announce through pre-mounted live region for screen readers (WCAG 4.1.3)
        this.announce(item);
      },

      remove(id) {
        const index = this.items.findIndex(t => t.id === id);
        if (index !== -1) {
          const item = this.items[index];
          if (item.timer) {
            clearTimeout(item.timer);
          }
          this.items.splice(index, 1);
        }

        // Restore focus if focus was inside the removed toast
        if (this.previousActiveElement && typeof this.previousActiveElement.focus === 'function') {
          const active = document.activeElement;
          const container = document.getElementById('raccoon-toast-container');
          if (!container || !container.contains(active) || this.items.length === 0) {
            this.previousActiveElement.focus();
            this.previousActiveElement = null;
          }
        }
      },

      pause(id) {
        if (!this.hasPauseOnHover) return;
        const item = this.items.find(t => t.id === id);
        if (!item || item.duration === 0 || item.isPaused) return;

        if (item.timer) {
          clearTimeout(item.timer);
          item.timer = null;
        }
        item.remaining -= (Date.now() - item.startTime);
        item.isPaused = true;
      },

      resume(id) {
        if (!this.hasPauseOnHover) return;
        const item = this.items.find(t => t.id === id);
        if (!item || item.duration === 0 || !item.isPaused) return;

        item.isPaused = false;
        // Ensure at least 1500ms safety buffer on resume
        this.startTimer(item, Math.max(item.remaining, 1500));
      },

      startTimer(item, duration = item.remaining) {
        item.startTime = Date.now();
        item.timer = setTimeout(() => {
          this.remove(item.id);
        }, duration);
      },

      announce(item) {
        const isAssertive = item.type === 'error' || item.type === 'warning';
        const announcerId = isAssertive ? 'raccoon-toast-announcer-assertive' : 'raccoon-toast-announcer-polite';
        const el = document.getElementById(announcerId);
        if (!el) return;

        const message = [item.title, item.text].filter(Boolean).join('. ');
        el.textContent = message;
      },

      focusNewestToast() {
        if (this.items.length === 0) return;
        this.previousActiveElement = document.activeElement;
        setTimeout(() => {
          const container = document.getElementById('raccoon-toast-container');
          if (!container) return;
          const focusables = container.querySelectorAll('button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])');
          if (focusables.length > 0) {
            // Focus the close button of the most recent toast
            focusables[focusables.length - 1].focus();
          }
        }, 50);
      },

      clearAll() {
        this.items.forEach(t => {
          if (t.timer) clearTimeout(t.timer);
        });
        this.items = [];
      }
    });

    // Alpine data component for toast container
    Alpine.data('toastManager', (config = {}) => ({
      init() {
        if (config.durationMs !== undefined) {
          this.$store.toasts.defaultDuration = config.durationMs;
        }
        if (config.hasPauseOnHover !== undefined) {
          this.$store.toasts.hasPauseOnHover = config.hasPauseOnHover;
        }
        if (config.hasPauseOnFocus !== undefined) {
          this.$store.toasts.hasPauseOnFocus = config.hasPauseOnFocus;
        }
        if (config.shortcutKey) {
          this.$store.toasts.shortcutKey = config.shortcutKey.toLowerCase();
        }

        // Hydrate initial pre-rendered server toasts if any
        if (Array.isArray(config.initialToasts)) {
          config.initialToasts.forEach(item => {
            this.$store.toasts.add(item);
          });
        }
      },

      get items() {
        return this.$store.toasts.items;
      },

      remove(id) {
        this.$store.toasts.remove(id);
      },

      pause(id) {
        this.$store.toasts.pause(id);
      },

      resume(id) {
        this.$store.toasts.resume(id);
      },

      getVariantBackground(type) {
        switch (type) {
          case 'success':
            return 'bg-surface-success';
          case 'warning':
            return 'bg-surface-warning';
          case 'error':
            return 'bg-surface-error';
          case 'info':
          default:
            return 'bg-surface-info';
        }
      },

      getVariantBorder(type) {
        switch (type) {
          case 'success':
            return 'border-on-surface-success text-on-surface-success';
          case 'warning':
            return 'border-on-surface-warning text-on-surface-warning';
          case 'error':
            return 'border-on-error-variant text-on-surface-error';
          case 'info':
          default:
            return 'border-on-surface-info text-on-surface-info';
        }
      },

      getVariantClasses(type) {
        return this.getVariantBackground(type) + ' ' + this.getVariantBorder(type);
      }
    }));

    // Listen for custom dispatch events: window.dispatchEvent(new CustomEvent('raccoon:toast', { detail: ... }))
    window.addEventListener('raccoon:toast', (event) => {
      if (event && event.detail) {
        Alpine.store('toasts').add(event.detail);
      }
    });
  });

  // Global browser API shortcut
  window.RaccoonToast = {
    show: (detail) => window.dispatchEvent(new CustomEvent('raccoon:toast', { detail })),
    success: (title, text, duration) => window.RaccoonToast.show({ type: 'success', title, text, duration }),
    info: (title, text, duration) => window.RaccoonToast.show({ type: 'info', title, text, duration }),
    warning: (title, text, duration) => window.RaccoonToast.show({ type: 'warning', title, text, duration }),
    error: (title, text, duration) => window.RaccoonToast.show({ type: 'error', title, text, duration }),
    clearAll: () => {
      if (window.Alpine && window.Alpine.store('toasts')) {
        window.Alpine.store('toasts').clearAll();
      }
    }
  };
}
