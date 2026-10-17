// V1.0
/* Alpine component: SimpleMenu dropdown navigation and cursor key handling. */

if (!window.__simpleMenuLoaded) {
    window.__simpleMenuLoaded = true;

    const registerSimpleMenu = () => {
        Alpine.data('simpleMenu', ({ open: initialOpen = false } = {}) => ({
            open: initialOpen,
            activeIndex: -1,

            items() {
                return Array.from(this.$refs.panel ? this.$refs.panel.querySelectorAll('[role^="menuitem"], a, button') : []);
            },

            toggle() {
                if (this.open) {
                    this.close(this.$refs.button);
                } else {
                    this.openMenu(0);
                }
            },

            openMenu(index = 0) {
                this.open = true;
                this.$nextTick(() => {
                    const list = this.items();
                    if (list.length > 0) {
                        const target = index === -1 ? list.length - 1 : Math.max(0, Math.min(index, list.length - 1));
                        this.activeIndex = target;
                        list[target].focus();
                    }
                });
            },

            close(focusAfter) {
                this.open = false;
                this.activeIndex = -1;
                if (focusAfter) {
                    focusAfter.focus();
                }
            },

            nextItem() {
                const list = this.items();
                if (list.length === 0) return;
                this.activeIndex = (this.activeIndex + 1) % list.length;
                list[this.activeIndex].focus();
            },

            prevItem() {
                const list = this.items();
                if (list.length === 0) return;
                this.activeIndex = (this.activeIndex - 1 + list.length) % list.length;
                list[this.activeIndex].focus();
            },

            firstItem() {
                const list = this.items();
                if (list.length === 0) return;
                this.activeIndex = 0;
                list[0].focus();
            },

            lastItem() {
                const list = this.items();
                if (list.length === 0) return;
                this.activeIndex = list.length - 1;
                list[list.length - 1].focus();
            }
        }));
    };

    if (window.Alpine) {
        registerSimpleMenu();
    } else {
        document.addEventListener('alpine:init', registerSimpleMenu);
    }
}
