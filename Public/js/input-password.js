// V1.0

/* Alpine component: password field with strength criteria, match check, and secure generator. */

// Guard against double registration if the script is included twice
if (!window.__inputPasswordLoaded) {
  window.__inputPasswordLoaded = true;

  document.addEventListener('alpine:init', () => {
    Alpine.data('inputPassword', ({
      hasPasswordServerError = false,
      hasConfirmServerError = false,
      commonWords = []
    } = {}) => ({
    showPassword: false,
    showConfirm: false,
    password: '',
    confirmPassword: '',
    validContent: false,
    passwordServerError: hasPasswordServerError,
    confirmServerError: hasConfirmServerError,
    userTouchedPasswordField: false,
    userTouchedConfirmField: false,
    capsLock: false,
    criteria: {
      hasUppercase: false,
      hasSpecial: false,
      hasMinLength: false,
      hasDigit: false,
      hasLowercase: false,
      hasNoCommonWords: false,
      count: 0
    },
    get passwordsMatch() {
      return this.password === this.confirmPassword;
    },
    resetCriteria() {
      this.criteria = {
        hasUppercase: false,
        hasSpecial: false,
        hasMinLength: false,
        hasDigit: false,
        hasLowercase: false,
        hasNoCommonWords: false,
        count: 0
      };
      this.validContent = false;
    },
    // Re-evaluates all strength criteria against the current password value
    updateCriteria() {
      this.userTouchedPasswordField = true;
      if (this.password.length === 0) {
        this.resetCriteria();
        this.passwordServerError = false;
        return;
      }
      this.criteria.hasUppercase = /[A-Z]/.test(this.password);
      this.criteria.hasSpecial = /[^A-Za-z0-9]/.test(this.password);
      this.criteria.hasMinLength = this.password.length >= 12;
      this.criteria.hasDigit = /[0-9]/.test(this.password);
      this.criteria.hasLowercase = /[a-z]/.test(this.password);
      this.criteria.hasNoCommonWords = !commonWords.some(word => this.password.toLowerCase().includes(word));
      this.criteria.count = [
        this.criteria.hasUppercase,
        this.criteria.hasSpecial,
        this.criteria.hasMinLength,
        this.criteria.hasDigit,
        this.criteria.hasLowercase,
        this.criteria.hasNoCommonWords
      ].filter(Boolean).length;
      this.validContent = this.criteria.count === 6;
      this.passwordServerError = false;
    },
    // Generates a random password meeting all criteria, retrying if it contains a common word
    generatePassword() {
      const length = 16;
      const lowers = 'abcdefghijklmnopqrstuvwxyz';
      const uppers = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
      const digits = '0123456789';
      const specials = '!@#$%^&*()-_=+[]{};:,.<>?';
      const all = lowers + uppers + digits + specials;
      let pwd = [
        this._randChar(uppers),
        this._randChar(lowers),
        this._randChar(digits),
        this._randChar(specials)
      ];
      for (let i = pwd.length; i < length; i++) {
        pwd.push(this._randChar(all));
      }
      pwd = this._shuffle(pwd);
      let candidate = pwd.join('');
      let attempts = 0;
      while (commonWords.some(w => candidate.toLowerCase().includes(w)) && attempts < 3) {
        candidate = this._regenerate(length, lowers, uppers, digits, specials, all, commonWords);
        attempts++;
      }
      this.password = candidate;
      this.showPassword = true;
      this.userTouchedPasswordField = true;
      this.updateCriteria();
      this.confirmPassword = '';
    },
    // Recursive helper used by generatePassword() to retry on a common-word match
    _regenerate(length, lowers, uppers, digits, specials, all, commonWords) {
      let p = [
        this._randChar(uppers),
        this._randChar(lowers),
        this._randChar(digits),
        this._randChar(specials)
      ];
      for (let i = p.length; i < length; i++) {
        p.push(this._randChar(all));
      }
      p = this._shuffle(p);
      const cand = p.join('');
      return commonWords.some(w => cand.toLowerCase().includes(w)) ? this._regenerate(length, lowers, uppers, digits, specials, all, commonWords) : cand;
    },
    _randChar(chars) {
      const idx = this._cryptoIndex(chars.length);
      return chars.charAt(idx);
    },
    // Uses crypto.getRandomValues for an unbiased random index in [0, max)
    _cryptoIndex(max) {
      const array = new Uint32Array(1);
      window.crypto.getRandomValues(array);
      const maxUInt = 0xFFFFFFFF;
      const limit = Math.floor(maxUInt / max) * max;
      let num = array[0];
      if (num >= limit) {
        return this._cryptoIndex(max);
      }
      return num % max;
    },
    // Fisher-Yates shuffle using the crypto-based random index
    _shuffle(arr) {
      for (let i = arr.length - 1; i > 0; i--) {
        const j = this._cryptoIndex(i + 1);
        const tmp = arr[i];
        arr[i] = arr[j];
        arr[j] = tmp;
      }
      return arr;
    }
  }));
});
}
