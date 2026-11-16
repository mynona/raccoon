// Alpine component: yes/no rating widget with radio options and optional comment textarea.

if (!window.__yesNoRatingLoaded) {
  window.__yesNoRatingLoaded = true;

  document.addEventListener('alpine:init', () => {
    Alpine.data('yesNoRatingWidget', (uuid = '', submitUrl = '') => ({
      uuid,
      submitUrl,
      visible: true,
      choice: null, // 'yes' | 'no'
      selectedOption: null,
      comment: '',
      submitting: false,
      showSuccess: false,

      init() {
        if (!this.uuid || typeof window === 'undefined' || !window.localStorage) {
          return;
        }
        if (localStorage.getItem(`yesno-rating-${this.uuid}`) === 'true') {
          this.visible = false;
        }
      },

      selectChoice(val) {
        if (this.submitting) return;
        this.choice = val;
        this.selectedOption = null;
        this.comment = '';
        const radios = this.$el.querySelectorAll('input[type="radio"]');
        radios.forEach(r => { r.checked = false; });
        const textarea = this.$el.querySelector('textarea');
        if (textarea) {
          textarea.value = '';
          textarea.style.height = '';
          textarea.dispatchEvent(new Event('input'));
        }
      },

      selectOption(val) {
        if (this.submitting) return;
        this.selectedOption = val;
      },

      resetChoice() {
        if (this.submitting) return;
        this.choice = null;
        this.selectedOption = null;
        this.comment = '';
        const radios = this.$el.querySelectorAll('input[type="radio"]');
        radios.forEach(r => { r.checked = false; });
        const textarea = this.$el.querySelector('textarea');
        if (textarea) {
          textarea.value = '';
          textarea.style.height = '';
          textarea.dispatchEvent(new Event('input'));
        }
        this.$nextTick(() => {
          if (this.$refs.yesBtn) this.$refs.yesBtn.focus();
        });
      },

      getOptionText(formEl) {
        const checked = formEl.querySelector('input[type="radio"]:checked');
        if (!checked) return this.selectedOption || '';
        const label = formEl.querySelector(`label[for="${checked.id}"]`) || checked.closest('label');
        return label ? label.textContent.trim() : (checked.value || this.selectedOption || '');
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

        let successTitle = ds.toastSuccessTitle || 'Rating';
        let successText = ds.toastSuccessText || 'Rating successfully submitted';
        let errorTitle = ds.toastErrorTitle || 'Server error';
        let errorText = ds.toastErrorText || 'Rating has not been submitted.';

        if (window.RaccoonI18n && typeof window.RaccoonI18n.t === 'function') {
          if (ds.i18nToastSuccessTitle) successTitle = window.RaccoonI18n.t(ds.i18nToastSuccessTitle, null, successTitle);
          if (ds.i18nToastSuccessText) successText = window.RaccoonI18n.t(ds.i18nToastSuccessText, null, successText);
          if (ds.i18nToastErrorTitle) errorTitle = window.RaccoonI18n.t(ds.i18nToastErrorTitle, null, errorTitle);
          if (ds.i18nToastErrorText) errorText = window.RaccoonI18n.t(ds.i18nToastErrorText, null, errorText);
        }

        return { successTitle, successText, errorTitle, errorText };
      },

      submitFeedback(el, overrideUrl) {
        if (!this.selectedOption || this.submitting) return;
        this.submitting = true;

        const targetUrl = overrideUrl || this.submitUrl;
        const optionText = this.getOptionText(el);
        const textarea = el.querySelector('textarea');
        const commentVal = textarea ? textarea.value.trim() : this.comment.trim();
        const feedbackValue = commentVal ? `${optionText}: ${commentVal}` : optionText;
        const ratingValue = this.choice === 'yes' ? '5' : '1';

        const formData = new FormData(el);
        formData.set('id', this.uuid);
        formData.set('rating', ratingValue);
        formData.set('feedback', feedbackValue);

        fetch(targetUrl, { method: 'POST', body: formData })
          .then((res) => {
            if (res.ok) {
              this.showSuccess = true;
              const { successTitle, successText } = this.getToastStrings();
              this.triggerToast('success', successTitle, successText);
              if (this.uuid && typeof window !== 'undefined' && window.localStorage) {
                localStorage.setItem(`yesno-rating-${this.uuid}`, 'true');
              }
            } else {
              const { errorTitle, errorText } = this.getToastStrings();
              this.triggerToast('error', errorTitle, errorText, 8000);
            }
          })
          .catch(() => {
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
