// V1.0

/* Alpine component: theme switcher dropdown with localStorage persistence. */

// Guard against double registration if the script is included twice
if (!window.__themeSwitcherLoaded) {
   window.__themeSwitcherLoaded = true;

   document.addEventListener('alpine:init', () => {
      Alpine.data('themeSwitcher', (defaultTheme = 'raumnebenan', isTracking = false) => ({

         open: false,
         currentTheme: defaultTheme,

         init() {
            try {
               if (window.localStorage) {
                  const stored = localStorage.getItem('theme');
                  this.currentTheme = stored || defaultTheme;
               } else {
                  this.currentTheme = defaultTheme;
               }
            } catch (e) {
               this.currentTheme = defaultTheme;
            }
         },

         setTheme(theme) {
            this.currentTheme = theme;
            document.documentElement.setAttribute('data-theme', theme);
            try {
               if (window.localStorage) {
                  localStorage.setItem('theme', theme);
               }
            } catch (e) {}
            if (isTracking && Array.isArray(window._paq)) {
               window._paq.push(['trackEvent', 'Button', 'click', 'ThemeSwitcher', theme]);
            }
            this.close(this.$refs.button);
         },

         toggle() {
            if (this.open) {
               return this.close();
            }
            this.$refs.button.focus();
            this.open = true;
         },

         close(focusAfter) {
            if (!this.open) return;
            this.open = false;
            focusAfter && focusAfter.focus();
         }

      }));
   });
}
