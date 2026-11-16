// V1.0

/* Alpine component: submits a boolean toggle to a server endpoint, with rollback on failure. */

// Guard against double registration if the script is included twice
if (!window.__toggleLoaded) {
   window.__toggleLoaded = true;

   document.addEventListener('alpine:init', () => {
      Alpine.data('toggleSwitch', ({ initialValue = false, apiUrl = null } = {}) => ({
         value: initialValue,
         isSubmitting: false,

         // Flips the value optimistically, then confirms with the server; reverts on error
         async updateStatus(path) {
            const targetUrl = path || apiUrl;
            if (!targetUrl || this.isSubmitting) return;

            const previousValue = this.value;
            const nextValue = !previousValue;
            this.isSubmitting = true;

            try {
               const res = await fetch(targetUrl, {
                  method: 'POST',
                  headers: {
                     'Content-Type': 'application/json; charset=UTF-8',
                     'Accept': 'application/json'
                  },
                  body: JSON.stringify({ value: nextValue })
               });

               if (!res.ok) {
                  throw new Error(`Toggle request failed with status: ${res.status}`);
               }
            } catch (error) {
               console.error('[toggleSwitch] Request failed, rolling back:', error);
               this.value = previousValue;
               this.$dispatch('toggle-error', { error, previousValue });
            } finally {
               this.isSubmitting = false;
            }
         }
      }));
   });
}

