// V1.0

/* Alpine component: open/close state for a modal dialog, mirrored in a global store. */

// Guard against double registration if the script is included twice
if (!window.__modalLoaded) {
    window.__modalLoaded = true;

    document.addEventListener('alpine:init', () => {
        // Global flag other components can watch (e.g. to disable page scroll)
        Alpine.store('modal', false);
        Alpine.data('modalDialog', (open = false) => ({
            open,
            init() {
                // Trap focus, close on escape, etc. handled by Alpine x-trap and x-on:keydown.escape
            },
            close() {
                this.open = false;
                this.$store.modal = false;
            },
            openDialog() {
                this.open = true;
                this.$store.modal = true;
            }
        }));
    });
}
