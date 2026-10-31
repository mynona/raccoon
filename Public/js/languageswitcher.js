// V1.0
/* Alpine component: LanguageSwitcher. Wraps the Dropdown and keeps <html lang> in sync (primary subtag only). */

if (!window.__languageSwitcherLoaded) {
    window.__languageSwitcherLoaded = true;

    const primary = (code) => (code || '').split(/[-_]/)[0].toLowerCase();

    const registerLanguageSwitcher = () => {
        Alpine.data('languageSwitcher', ({ fallback = 'en', ariaLabel = 'Language' } = {}) => ({
            init() {
                this.$nextTick(() => {
                    const root = document.documentElement;
                    const options = Array.from(this.$root.querySelectorAll('[role="option"]'));
                    const lang = primary(root.getAttribute('lang'));
                    const known = (code) => options.some((o) => o.getAttribute('lang') === code);
                    const code = known(lang) ? lang : fallback;

                    // Without a page language the fallback becomes the page language.
                    if (!root.getAttribute('lang')) {
                        root.setAttribute('lang', code);
                    }
                    this.show(code);

                    // Follow the dropdown selection, independent of how it was changed.
                    let first = true;
                    Alpine.effect(() => {
                        const dd = this.dropdown();
                        const selected = dd ? dd.selectedValue : null;
                        if (first) {
                            first = false;
                            return;
                        }
                        if (selected) this.setLanguage(selected);
                    });

                    // Keep several switchers on one page in sync.
                    new MutationObserver(() => {
                        const current = primary(root.getAttribute('lang'));
                        if (known(current)) this.show(current);
                    }).observe(root, { attributes: true, attributeFilter: ['lang'] });
                });
            },

            dropdown() {
                const el = this.$root.querySelector('[x-ref="button"]')?.closest('[x-data]');
                return el ? Alpine.$data(el) : null;
            },

            show(code) {
                const option = Array.from(this.$root.querySelectorAll('[role="option"]'))
                    .find((o) => o.getAttribute('lang') === code);
                if (!option) return;
                const title = option.textContent.trim();
                const dd = this.dropdown();
                if (dd) {
                    dd.selectedValue = code;
                    dd.selectedTitle = title;
                }
                const button = this.$root.querySelector('[x-ref="button"]');
                const text = button?.querySelector('[x-text="selectedTitle"]');
                // x-text only replaces the text, so the lang attribute set here stays.
                if (text) text.setAttribute('lang', code);
                // The accessible name must contain the visible text (WCAG 2.5.3).
                if (button) button.setAttribute('aria-label', `${ariaLabel}: ${title}`);
            },

            setLanguage(code) {
                const lang = primary(code);
                document.documentElement.setAttribute('lang', lang);
                this.show(lang);
            }
        }));
    };

    if (window.Alpine) {
        registerLanguageSwitcher();
    } else {
        document.addEventListener('alpine:init', registerLanguageSwitcher);
    }
}
