// V1.0

if (!window.__raccoonAlpineLoaded) {
  window.__raccoonAlpineLoaded = true;

  const register = () => {
    // $t('key', { name: 'x' }, 'Fallback') -> translated text, or the fallback if the store is missing
    Alpine.magic('t', () => (key, variables, fallback) =>
      window.RaccoonI18n ? window.RaccoonI18n.t(key, variables, fallback) : fallback);

    // $pick({ en: 'Save', de: 'Speichern' }, null, 'Save') -> text for the current language
    Alpine.magic('pick', () => (values, variables, fallback) =>
      window.RaccoonI18n ? window.RaccoonI18n.pick(values, variables, fallback) : fallback);

    // $isDesktop -> true from the Tailwind `lg` breakpoint (1024px) up
    Alpine.magic('isDesktop', () => window.innerWidth >= 1024);

    // $returnToCallerPage() -> calls the page's global returnToCallerPage(), if it defines one
    Alpine.magic('returnToCallerPage', () => () => {
      if (typeof window.returnToCallerPage === 'function') {
        window.returnToCallerPage();
      }
    });

    // $navigate('/path') -> opens the URL in the current tab (clickable table rows)
    Alpine.magic('navigate', () => (url) => {
      window.location = url;
    });

    // $postForm('/path') -> submits an empty POST form to the URL (create item after another item)
    Alpine.magic('postForm', () => (url) => {
      const form = document.createElement('form');
      form.method = 'POST';
      form.action = url;
      document.body.appendChild(form);
      form.submit();
    });

    // $clickFirstNavLink($el) -> clicks the first link of the visible (filtered) menu items
    Alpine.magic('clickFirstNavLink', () => (el) => {
      const root = el.closest('[x-data]');
      const first = root && root.querySelector('ul li:not([style*="display: none"]) a');
      if (first) first.click();
    });

    // Body state of the CMS and system layouts: mobile navigation, drawer and menu filter
    Alpine.data('dashboardLayout', () => ({
      showNavigation: false,
      drawerOpen: false,
      search: '',

      init() {
        const mq = window.matchMedia('(min-width: 1024px)');
        mq.addEventListener('change', (e) => {
          if (e.matches) {
            this.showNavigation = false;
            this.drawerOpen = false;
          }
        });
      }
    }));

    // Body state of the frontend layout; Cmd/Ctrl+K opens the search page
    Alpine.data('frontendLayout', () => ({
      isScrollAtTop: true,
      showNavigation: false,
      drawerOpen: false,

      openSearch() {
        window.location.replace('/search/?');
      }
    }));

    // Renders HTML that the server has already sanitised. Not for user input.
    Alpine.directive('safe-html', (el, { expression }, { effect, evaluateLater }) => {
      const evaluate = evaluateLater(expression);
      effect(() => evaluate((value) => { el.innerHTML = value ?? ''; }));
    });
  };

  if (window.Alpine) {
    register();
  } else {
    document.addEventListener('alpine:init', register);
  }
}
