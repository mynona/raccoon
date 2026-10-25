// v1.3

/* Alpine component: thumbs/star rating widget with scroll-triggered display, dismissal memory, and in-page docking. */

// Guard against double registration if the script is included twice
if (!window.__ratingLoaded) {
  window.__ratingLoaded = true;

  function getCookie(name) {
    const value = `; ${document.cookie}`;
    const parts = value.split(`; ${name}=`);
    if (parts.length === 2) {
      return parts.pop().split(';').shift().trim();
    }
    return null;
  }

  document.addEventListener('alpine:init', () => {
  Alpine.data('ratingWidget', (uuid = '', showOnScroll = false, cookieName = 'raumnebenan-matomo', isFloating = false) => ({
    uuid,
    showOnScroll,
    cookieName,
    isFloating: isFloating || showOnScroll,
    visible: true,
    closed: false,
    thumb: null,
    rating: 0,
    textarea: '',
    submitting: false,
    error: '',
    showSuccess: false,
    showError: false,
    // A fixed element is positioned relative to the viewport, so center it on its container instead
    // (same position as the docked widget) rather than on the viewport.
    alignFloating() {
      const el = this.$el;
      const container = el && el.parentElement;
      if (!container) return;
      if (!this.isFloating) {
        el.style.removeProperty('left');
        return;
      }
      const rect = container.getBoundingClientRect();
      el.style.left = `${rect.left + rect.width / 2}px`;
    },

    setupFloatingAlignment() {
      if (!this.isFloating) return;
      this.alignFloating();
      this.onResize = () => this.alignFloating();
      window.addEventListener('resize', this.onResize);
      if (typeof ResizeObserver !== 'undefined' && this.$el.parentElement) {
        this.resizeObserver = new ResizeObserver(this.onResize);
        this.resizeObserver.observe(this.$el.parentElement);
      }
      this.$watch('isFloating', () => this.alignFloating());
      this.$watch('visible', () => this.alignFloating());
    },

    init() {
      this.setupFloatingAlignment();

      if (!this.uuid || typeof window === 'undefined' || !window.localStorage) {
        return;
      }

      // Don't show again once the user already rated this uuid
      if (localStorage.getItem(`rating-${this.uuid}`) === 'true') {
        this.visible = false;
        return;
      }

      // Avoid overlap with cookie banner: only required for the floating rating widget
      if (this.isFloating) {
        if (getCookie(this.cookieName) === null) {
          this.visible = false;
        }

        // Hide widget if somebody deletes the cookie and therefore
        // enables the cookie widget
        this.cookieCheck = setInterval(() => {
          if (getCookie(this.cookieName) === null) {
            this.visible = false;
          }
        }, 500);
      }

      if (this.showOnScroll) {
        this.visible = false;

        // Reveal the widget once the user has scrolled through most of the page
        this.onScroll = () => {
          if (this.closed) return;

          // Don't display the widget if the cookie banner is shown
          if (getCookie(this.cookieName) === null) return;

          const scrollEl = document.querySelector('main');
          const isMainScrollable = scrollEl && scrollEl.scrollHeight > scrollEl.clientHeight;
          const currentScroll = isMainScrollable ? scrollEl.scrollTop : window.scrollY;
          const totalHeight = isMainScrollable ? scrollEl.scrollHeight : Math.max(document.documentElement.scrollHeight, document.body.scrollHeight);
          const viewHeight = isMainScrollable ? scrollEl.clientHeight : window.innerHeight;

          if (currentScroll + viewHeight >= totalHeight * 0.80) {

            // Don't display the widget if the cookie banner is shown
            if (getCookie(this.cookieName) === null) return;

            this.visible = true;
            window.removeEventListener('scroll', this.onScroll);
            document.removeEventListener('scroll', this.onScroll);
            if (scrollEl) scrollEl.removeEventListener('scroll', this.onScroll);
          }
        };
        window.addEventListener('scroll', this.onScroll);
        document.addEventListener('scroll', this.onScroll);
        const mainEl = document.querySelector('main');
        if (mainEl) mainEl.addEventListener('scroll', this.onScroll);
      }
    },

    destroy() {
      if (this.cookieCheck) clearInterval(this.cookieCheck);
      if (this.onResize) window.removeEventListener('resize', this.onResize);
      if (this.resizeObserver) this.resizeObserver.disconnect();
      if (this.onScroll) {
        window.removeEventListener('scroll', this.onScroll);
        document.removeEventListener('scroll', this.onScroll);
        const mainEl = document.querySelector('main');
        if (mainEl) mainEl.removeEventListener('scroll', this.onScroll);
      }
    },

    close() {
      this.closed = true;
      if (this.isFloating) {
        this.isFloating = false;
        this.visible = true;
        this.thumb = null;
        this.rating = 0;
        this.textarea = '';
        this.error = '';
        this.showSuccess = false;
        this.showError = false;
      } else {
        this.visible = false;
      }
      if (this.cookieCheck) clearInterval(this.cookieCheck);
      if (this.onScroll) {
        window.removeEventListener('scroll', this.onScroll);
        document.removeEventListener('scroll', this.onScroll);
        const mainEl = document.querySelector('main');
        if (mainEl) mainEl.removeEventListener('scroll', this.onScroll);
      }
    },
    // Selects a thumbs-up/down rating and reveals the feedback textarea
    selectThumb(val) {
      if (this.submitting) return;
      this.thumb = val;
      this.rating = val === 'up' ? 5 : 1;
      this.error = '';
      this.showSuccess = false;
      this.showError = false;
      this.$nextTick(() => { this.$refs.textarea && this.$refs.textarea.focus(); });
    },
    resetThumb() {
      if (this.submitting) return;
      this.thumb = null;
      this.rating = 0;
      this.textarea = '';
      this.error = '';
      this.showSuccess = false;
      this.showError = false;
      this.$nextTick(() => {
        if (this.$refs.textarea) {
          this.$refs.textarea.style.height = '';
        }
        this.$refs.thumbUp && this.$refs.thumbUp.focus();
      });
    },
    // Selects a star rating and reveals the feedback textarea
    selectStar(val) {
      if (this.submitting) return;
      this.rating = val;
      this.error = '';
      this.showSuccess = false;
      this.showError = false;
      this.$nextTick(() => { this.$refs.textarea && this.$refs.textarea.focus(); });
    },
    resetStar() {
      if (this.submitting) return;
      this.rating = 0;
      this.textarea = '';
      this.error = '';
      this.showSuccess = false;
      this.showError = false;
      this.$nextTick(() => {
        if (this.$refs.textarea) {
          this.$refs.textarea.style.height = '';
        }
      });
    },
    focusStar(index) {
      const ref = this.$refs['star' + index];
      if (ref) {
        ref.focus();
      }
    },
    // Submits the rating form and remembers the uuid so the widget won't show again
    submitFeedback(el, url) {
      if (this.submitting) return;
      this.submitting = true;
      this.showError = false;

      fetch(url, { method: 'POST', body: new FormData(el) })
        .then((res) => {
          if (res.ok) {
            this.showSuccess = true;
            if (this.uuid && typeof window !== 'undefined' && window.localStorage) {
              localStorage.setItem(`rating-${this.uuid}`, 'true');
            }
          } else {
            this.showError = true;
          }
        })
        .catch(() => {
          this.showError = true;
        })
        .finally(() => {
          this.submitting = false;
        });
    },
    autoResize(el) {
      el.style.height = 'auto';
      el.style.height = el.scrollHeight + 'px';
    }
  }));
});
}
