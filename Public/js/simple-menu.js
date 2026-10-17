// V1.0
/* Alpine component: SimpleMenu dropdown navigation and cursor key handling. */

if (!window.__simpleMenuLoaded) {
    window.__simpleMenuLoaded = true;

    const createSimpleMenu = ({ open: initialOpen = false } = {}) => ({
        open: initialOpen,
        activeIndex: -1,
        dropUp: false,

        menuItems() {
            return Array.from(this.$refs.panel ? this.$refs.panel.querySelectorAll('[role^="menuitem"], a, button') : []);
        },

        items() {
            return this.menuItems();
        },

        updatePlacement() {
            if (!this.$refs.button || !this.$refs.panel) return;
            const btnRect = this.$refs.button.getBoundingClientRect();
            const panelHeight = this.$refs.panel.offsetHeight || 200;
            const spaceBelow = window.innerHeight - btnRect.bottom;
            const spaceAbove = btnRect.top;
            const shouldDropUp = spaceBelow < panelHeight + 16 && spaceAbove > spaceBelow;
            this.dropUp = shouldDropUp;

            if (shouldDropUp) {
                this.$refs.panel.style.bottom = '100%';
                this.$refs.panel.style.marginBottom = '0.5rem';
                this.$refs.panel.style.marginTop = '0';
                this.$refs.panel.style.top = 'auto';
            } else {
                this.$refs.panel.style.bottom = '';
                this.$refs.panel.style.marginBottom = '';
                this.$refs.panel.style.marginTop = '';
                this.$refs.panel.style.top = '';
            }
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
                this.updatePlacement();
                const list = this.menuItems();
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
            this.dropUp = false;
            if (this.$refs.panel) {
                this.$refs.panel.style.bottom = '';
                this.$refs.panel.style.marginBottom = '';
                this.$refs.panel.style.marginTop = '';
                this.$refs.panel.style.top = '';
            }
            if (focusAfter) {
                focusAfter.focus();
            }
        },

        nextItem() {
            const list = this.menuItems();
            if (list.length === 0) return;
            this.activeIndex = (this.activeIndex + 1) % list.length;
            list[this.activeIndex].focus();
        },

        prevItem() {
            const list = this.menuItems();
            if (list.length === 0) return;
            this.activeIndex = (this.activeIndex - 1 + list.length) % list.length;
            list[this.activeIndex].focus();
        },

        firstItem() {
            const list = this.menuItems();
            if (list.length === 0) return;
            this.activeIndex = 0;
            list[0].focus();
        },

        lastItem() {
            const list = this.menuItems();
            if (list.length === 0) return;
            this.activeIndex = list.length - 1;
            list[list.length - 1].focus();
        }
    });

    window.createSimpleMenu = createSimpleMenu;

    const registerSimpleMenu = () => {
        Alpine.data('simpleMenu', (options) => createSimpleMenu(options));
    };

    if (window.Alpine) {
        registerSimpleMenu();
    } else {
        document.addEventListener('alpine:init', registerSimpleMenu);
    }
}

