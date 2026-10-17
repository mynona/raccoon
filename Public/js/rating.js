// v1.2

/* Alpine component: thumbs/star rating widget with scroll-triggered display and dismissal memory. */

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
    init() {
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

        // Don't display the widget if the cookie banner is shown
        if (getCookie(this.cookieName) === null) return;

        // Reveal the widget once the user has scrolled through most of the page
        this.onScroll = () => {
          if (this.closed) return;

          const scrollEl = document.querySelector('main');
          const currentScroll = Math.max(window.scrollY, scrollEl ? scrollEl.scrollTop : 0);
          const totalHeight = Math.max(document.documentElement.scrollHeight, scrollEl ? scrollEl.scrollHeight : 0);
          const viewHeight = scrollEl && scrollEl.clientHeight ? scrollEl.clientHeight : window.innerHeight;

          if (currentScroll + viewHeight >= totalHeight * 0.85) {

            // Don't display the widget if the cookie banner is shown
            if (getCookie(this.cookieName) === null) return;

            this.visible = true;
            window.removeEventListener('scroll', this.onScroll);
            if (scrollEl) scrollEl.removeEventListener('scroll', this.onScroll);
          }
        };
        window.addEventListener('scroll', this.onScroll);
        const mainEl = document.querySelector('main');
        if (mainEl) mainEl.addEventListener('scroll', this.onScroll);
      }
    },

    destroy() {
      if (this.cookieCheck) clearInterval(this.cookieCheck);
      if (this.onScroll) {
        window.removeEventListener('scroll', this.onScroll);
        const mainEl = document.querySelector('main');
        if (mainEl) mainEl.removeEventListener('scroll', this.onScroll);
      }
    },

    close() {
      this.closed = true;
      this.visible = false;
      if (this.cookieCheck) clearInterval(this.cookieCheck);
      if (this.onScroll) {
        window.removeEventListener('scroll', this.onScroll);
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
