// V2.1

// Guard against double initialization: the script tag is written once per page, but stay safe
if (!window.RaccoonI18n) {
  (function () {
    const ATTRIBUTES = ['aria-label', 'title', 'placeholder', 'alt'];
    const SELECTOR = ['[data-i18n]', '[data-i18n-values]']
      .concat(
        ATTRIBUTES.map((name) => '[data-i18n-' + name + ']'),
        ATTRIBUTES.map((name) => '[data-i18n-' + name + '-values]')
      )
      .join(',');

    // { namespace: { language: { key: value } } }, registered by the page
    const defaults = {};
    // Text rendered by Swift, used when nothing else is found
    const originals = new WeakMap();

    function warn(message) {
      console.warn('[i18n] ' + message);
    }

    function baseLanguage(tag) {
      const base = String(tag || '').toLowerCase().split(/[-_]/)[0];
      return base === 'no' || base === 'nn' ? 'nb' : base;
    }

    function currentLanguage() {
      return baseLanguage(document.documentElement.lang) || 'en';
    }

    function addEntries(namespace, languages) {
      const target = defaults[namespace] || (defaults[namespace] = {});
      Object.keys(languages).forEach((language) => {
        const entries = languages[language];
        const bucket = target[language] || (target[language] = {});
        Object.keys(entries).forEach((key) => {
          if (Object.prototype.hasOwnProperty.call(bucket, key)) {
            if (bucket[key] !== entries[key]) {
              warn(namespace + '.' + language + '.' + key + ' is already registered, first registration wins');
            }
            return;
          }
          bucket[key] = entries[key];
        });
      });
      scheduleApply();
    }

    function interpolate(template, variables, label) {
      return template.replace(/\{\{(\w+)\}\}/g, (placeholder, name) => {
        if (variables && Object.prototype.hasOwnProperty.call(variables, name)) {
          return String(variables[name]);
        }
        warn(label + ' is missing the value for ' + placeholder);
        return placeholder;
      });
    }

    // Built-in text: requested language -> en. Returns `fallback` (default null) if nothing is found.
    function translate(fullKey, variables, fallback) {
      track();
      const dot = fullKey.indexOf('.');
      const namespace = fullKey.slice(0, dot);
      const key = fullKey.slice(dot + 1);
      const language = currentLanguage();
      const chain = language === 'en' ? ['en'] : [language, 'en'];
      const group = defaults[namespace];
      for (let i = 0; i < chain.length; i++) {
        const value = group && group[chain[i]] && group[chain[i]][key];
        if (typeof value === 'string' && value !== '') return interpolate(value, variables, fullKey);
      }
      warn(fullKey + ' has no translation for "' + language + '" or "en"');
      return fallback === undefined ? null : fallback;
    }

    // Consumer text: values is { language: text }. Requested language -> en.
    function pick(values, variables, fallback) {
      track();
      const language = currentLanguage();
      const text = (values && values[language]) || (values && values.en);
      if (typeof text === 'string' && text !== '') return interpolate(text, variables, 'text');
      return fallback === undefined ? null : fallback;
    }

    function readJson(element, name) {
      const raw = element.getAttribute(name);
      if (!raw) return null;
      try {
        return JSON.parse(raw);
      } catch (error) {
        warn('invalid ' + name + ': ' + raw);
        return null;
      }
    }

    function applyElement(element) {
      const saved = originals.get(element) || {};
      originals.set(element, saved);
      const variables = readJson(element, 'data-i18n-vars');

      const textKey = element.getAttribute('data-i18n');
      const textValues = readJson(element, 'data-i18n-values');
      if (textKey || textValues) {
        if (saved.text === undefined) saved.text = element.textContent;
        const text = textKey
          ? translate(textKey, variables, saved.text)
          : pick(textValues, variables, saved.text);
        if (element.textContent !== text) element.textContent = text;
      }

      ATTRIBUTES.forEach((name) => {
        const key = element.getAttribute('data-i18n-' + name);
        const values = readJson(element, 'data-i18n-' + name + '-values');
        if (!key && !values) return;
        if (saved[name] === undefined) saved[name] = element.getAttribute(name);
        const value = key ? translate(key, variables, saved[name]) : pick(values, variables, saved[name]);
        if (element.getAttribute(name) !== value) element.setAttribute(name, value);
      });
    }

    function apply(root) {
      const scope = root || document;
      if (scope.nodeType === 1 && scope.matches(SELECTOR)) applyElement(scope);
      scope.querySelectorAll(SELECTOR).forEach(applyElement);
    }

    let scheduled = false;
    let ready = false;

    // Alpine expressions that call t() or pick() depend on this counter, so they re-run when the
    // language changes or translations are registered.
    let reactive = null;
    function track() {
      if (!reactive && window.Alpine && window.Alpine.reactive) {
        reactive = window.Alpine.reactive({ version: 0 });
      }
      return reactive ? reactive.version : 0;
    }
    function notify() {
      if (reactive) reactive.version++;
    }

    function scheduleApply() {
      notify();
      if (!ready || scheduled) return;
      scheduled = true;
      queueMicrotask(() => {
        scheduled = false;
        apply(document);
      });
    }

    // Built-in translations that the page embeds as JSON data blocks. A block is read once.
    function loadDictionaries() {
      document
        .querySelectorAll('script[type="application/json"][data-raccoon-i18n]')
        .forEach((block) => {
          if (block.hasAttribute('data-raccoon-i18n-loaded')) return;
          block.setAttribute('data-raccoon-i18n-loaded', '');
          let dictionary;
          try {
            dictionary = JSON.parse(block.textContent);
          } catch (error) {
            warn('invalid translations in <script data-raccoon-i18n>');
            return;
          }
          Object.keys(dictionary).forEach((namespace) => addEntries(namespace, dictionary[namespace]));
        });
    }

    function start() {
      ready = true;
      // The data block can also come after this script in the document
      loadDictionaries();
      apply(document);
      // Language change: <html lang> is observed, no reload required
      new MutationObserver(() => {
        notify();
        apply(document);
      }).observe(document.documentElement, {
        attributes: true,
        attributeFilter: ['lang'],
      });
      // Elements added later (Alpine templates, dialogs, ...)
      new MutationObserver((mutations) => {
        mutations.forEach((mutation) => {
          mutation.addedNodes.forEach((node) => {
            if (node.nodeType === 1) apply(node);
          });
        });
      }).observe(document.body, { childList: true, subtree: true });
    }

    window.RaccoonI18n = {
      /** Registers built-in translations: register('label', { en: { required: '(required)' }, de: { required: '(erforderlich)' } }) */
      register: (namespace, languages) => addEntries(namespace, languages),
      /** Translates a built-in key for scripts: t('label.required', null, '(required)') */
      t: (fullKey, variables, fallback) => translate(fullKey, variables, fallback),
      /** Picks a consumer text: pick({ en: 'Save', de: 'Speichern' }, null, 'Save') */
      pick: (values, variables, fallback) => pick(values, variables, fallback),
      apply: apply,
      // Reading the language inside an Alpine expression makes it follow live language changes
      get language() {
        track();
        return currentLanguage();
      },
    };

    // The data block normally comes before this script, so the texts are available from the first lookup on
    loadDictionaries();

    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', start);
    } else {
      start();
    }
  })();
}
