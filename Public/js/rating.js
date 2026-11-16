// v2.0

/* Alpine component: floating rating widget with modal feedback dialog, dismissal memory, and page metadata. */

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
  Alpine.data('ratingWidget', (uuid = '', showOnScroll = false, cookieName = 'raumnebenan-matomo', isFloating = true) => ({
    uuid,
    showOnScroll: typeof showOnScroll === 'boolean' ? showOnScroll : false,
    cookieName: typeof showOnScroll === 'string' ? showOnScroll : cookieName,
    isFloating: true,
    open: false,
    visible: true,
    closed: false,
    thumb: null,
    rating: 0,
    widgetEl: null,
    submitting: false,
    error: '',
    showSuccess: false,
    showError: false,
    // Set when the server answered 429: the submission limit is enforced server side
    limitReached: false,

    openModal() {
      this.open = true;
      this.$nextTick(() => {
        this.validateFeedback();
        const panel = document.getElementById(`rating-floating-panel-${this.uuid}`) || this.widgetEl;
        const focusable = panel ? panel.querySelector('button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])') : null;
        if (focusable) focusable.focus();
      });
    },

    closeModal() {
      // If a child dropdown listbox is currently open and visible, allow Dropdown's escape handler to close it first
      const listbox = this.$el ? this.$el.querySelector('[role="listbox"]') : null;
      if (listbox && listbox.offsetParent !== null) {
        return;
      }
      this.open = false;
      if (this.showSuccess) {
        this.thumb = null;
        this.rating = 0;
        this.clearFeedback();
        this.showSuccess = false;
      }
      this.$nextTick(() => {
        const trigger = document.getElementById(`rating-trigger-${this.uuid}`);
        if (trigger) trigger.focus();
      });
    },

    init() {
      this.widgetEl =
        document.getElementById(`rating-floating-panel-${this.uuid}`) ||
        document.getElementById(`rating-panel-${this.uuid}`);

      // Avoid overlap with cookie banner: only show once cookie consent is handled
      if (getCookie(this.cookieName) === null) {
        this.visible = false;
      }

      this.cookieCheck = setInterval(() => {
        if (getCookie(this.cookieName) === null) {
          this.visible = false;
        } else if (!this.limitReached) {
          this.visible = true;
        }
      }, 500);

      if (this.showOnScroll) {
        this.visible = false;

        // Reveal the widget once the user has scrolled through most of the page
        this.onScroll = () => {
          if (this.closed || this.limitReached) return;

          // Don't display the widget if the cookie banner is shown
          if (getCookie(this.cookieName) === null) return;

          const scrollEl = document.querySelector('main');
          const isMainScrollable = scrollEl && scrollEl.scrollHeight > scrollEl.clientHeight;
          const currentScroll = isMainScrollable ? scrollEl.scrollTop : window.scrollY;
          const totalHeight = isMainScrollable ? scrollEl.scrollHeight : Math.max(document.documentElement.scrollHeight, document.body.scrollHeight);
          const viewHeight = isMainScrollable ? scrollEl.clientHeight : window.innerHeight;

          if (currentScroll + viewHeight >= totalHeight * 0.80) {
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
      if (this.onScroll) {
        window.removeEventListener('scroll', this.onScroll);
        document.removeEventListener('scroll', this.onScroll);
        const mainEl = document.querySelector('main');
        if (mainEl) mainEl.removeEventListener('scroll', this.onScroll);
      }
    },

    close() {
      this.closeModal();
    },

    // The feedback field is a FormBuilder text area with its own Alpine scope
    feedbackTextarea() {
      const panel = document.getElementById(`rating-floating-panel-${this.uuid}`) || this.widgetEl;
      return panel ? panel.querySelector('textarea') : null;
    },
    focusFeedback() {
      this.$nextTick(() => {
        const textarea = this.feedbackTextarea();
        if (textarea) textarea.focus();
      });
    },
    feedbackField() {
      const textarea = this.feedbackTextarea();
      return textarea ? Alpine.$data(textarea.closest('[x-data]')) : null;
    },
    // Empty is invalid for this required field. The message stays hidden until the field is touched
    validateFeedback() {
      const field = this.feedbackField();
      if (field) field.validate();
    },
    clearFeedback() {
      const field = this.feedbackField();
      if (!field) return;
      field.value = '';
      field.isTouched = false;
      field.validate();
      const textarea = this.feedbackTextarea();
      if (textarea) textarea.style.height = '';
    },
    // The question above the feedback field: the one for a positive rating (5) or the other
    followUpLabel() {
      const kind = this.rating >= 5 ? 'positive' : 'negative';
      const panel = document.getElementById(`rating-floating-panel-${this.uuid}`) || this.widgetEl;
      const template = panel ? panel.querySelector(`template[data-follow-up="${kind}"]`) : null;
      return template ? template.innerHTML : '';
    },
    // Selects a thumbs-up/down rating and reveals the feedback textarea
    selectThumb(val) {
      if (this.submitting) return;
      this.thumb = val;
      this.rating = val === 'up' ? 5 : 1;
      this.error = '';
      this.showSuccess = false;
      this.showError = false;
      this.focusFeedback();
    },
    resetThumb() {
      if (this.submitting) return;
      this.thumb = null;
      this.rating = 0;
      this.clearFeedback();
      this.error = '';
      this.showSuccess = false;
      this.showError = false;
      this.$nextTick(() => {
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
      this.focusFeedback();
    },
    resetStar() {
      if (this.submitting) return;
      this.rating = 0;
      this.clearFeedback();
      this.error = '';
      this.showSuccess = false;
      this.showError = false;
      this.$nextTick(() => {
        this.$refs.star1 && this.$refs.star1.focus();
      });
    },
    focusStar(index) {
      const ref = this.$refs['star' + index];
      if (ref) {
        ref.focus();
      }
    },

    triggerToast(type, title, text, duration) {
      if (window.RaccoonToast && typeof window.RaccoonToast[type] === 'function') {
        window.RaccoonToast[type](title, text, duration);
      } else {
        window.dispatchEvent(new CustomEvent('raccoon:toast', {
          detail: { type, title, text, duration }
        }));
      }
    },

    getToastStrings() {
      const el = this.$el;
      const ds = (el && el.dataset) || {};

      let errorTitle = ds.toastErrorTitle || 'Server error';
      let errorText = ds.toastErrorText || 'Rating has not been submitted.';

      if (window.RaccoonI18n && typeof window.RaccoonI18n.t === 'function') {
        if (ds.i18nToastErrorTitle) errorTitle = window.RaccoonI18n.t(ds.i18nToastErrorTitle, null, errorTitle);
        if (ds.i18nToastErrorText) errorText = window.RaccoonI18n.t(ds.i18nToastErrorText, null, errorText);
      }

      return { errorTitle, errorText };
    },

    // Submits the rating form. The submission limit per user and page is enforced by the server
    submitFeedback(el, url) {
      if (this.submitting) return;

      const categoryInput = el.querySelector('input[name="category"]');
      if (categoryInput && !categoryInput.value) {
        const dropdownEl = categoryInput.closest('[x-data*="dropdown"]');
        if (dropdownEl && window.Alpine) {
          const ddData = Alpine.$data(dropdownEl);
          if (ddData) {
            ddData.hasServerError = true;
          }
        }
        return;
      }

      this.submitting = true;
      this.showError = false;

      const formData = new FormData(el);
      formData.set('page', window.location.href.replace(/^https?:\/\//, ''));
      formData.set('user_agent', navigator.userAgent);
      if (!formData.get('rating') || formData.get('rating') === '0') {
        formData.set('rating', '3');
      }
      if (!formData.get('category')) {
        formData.delete('category');
      }

      fetch(url, { method: 'POST', body: formData })
        .then((res) => {
          if (res.ok) {
            this.showSuccess = true;
            setTimeout(() => this.closeModal(), 2500);
          } else {
            this.showError = true;
            if (res.status === 429) {
              this.limitReached = true;
              this.open = false;
              this.visible = false;
            }
            const { errorTitle, errorText } = this.getToastStrings();
            this.triggerToast('error', errorTitle, errorText, 8000);
          }
        })
        .catch(() => {
          this.showError = true;
          const { errorTitle, errorText } = this.getToastStrings();
          this.triggerToast('error', errorTitle, errorText, 8000);
        })
        .finally(() => {
          this.submitting = false;
        });
    }
  }));
});
}
