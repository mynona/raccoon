// V1.0

/* Alpine component: dark/light colour mode toggle with localStorage persistence. */

// Guard against double registration if the script is included twice
if (!window.__darkLightModeLoaded) {
   window.__darkLightModeLoaded = true;

   document.addEventListener('alpine:init', () => {
      Alpine.data('darkLightModeToggle', (isTracking = false) => ({

         // true when light is the active colour mode
         lightMode: true,

         init() {
            this.lightMode = localStorage.getItem('colorMode') !== 'dark';
         },

         setColorMode(mode) {
            if (mode === 'dark') {
               document.documentElement.classList.add('dark');
               localStorage.setItem('colorMode', 'dark');
            } else {
               document.documentElement.classList.remove('dark');
               localStorage.setItem('colorMode', 'light');
            }
         },

         toggle() {
            this.lightMode = !this.lightMode;
            if (isTracking && Array.isArray(window._paq)) {
               window._paq.push(['trackEvent', 'Button', 'click', 'DarkLightMode']);
            }
            this.setColorMode(this.lightMode ? 'light' : 'dark');
         },

         // Alt+M / Option+M is global, so ignore it while the user is typing.
         // Check altKey + code === 'KeyM' because on macOS Option+M produces 'µ' (event.key), breaking key-based listeners.
         toggleFromKeyboard(event) {
            if (!event.altKey || event.code !== 'KeyM') return;
            const target = event.target;
            if (!target) return;
            if (['INPUT', 'TEXTAREA', 'SELECT'].includes(target.tagName)) return;
            if (target.isContentEditable) return;
            event.preventDefault();
            this.toggle();
         }

      }));
   });
}
