// V1.0
/* Alpine component: Dropdown form select with cursor key navigation. */

if (!window.__dropdownLoaded) {
    window.__dropdownLoaded = true;

    const registerDropdown = () => {
        Alpine.data('dropdown', ({
            selectedValue = '',
            selectedTitle = '',
            hasServerError = false
        } = {}) => ({
            open: false,
            selectedValue,
            selectedTitle,
            hasServerError,
            activeIndex: -1,

            menuItems() {
                return Array.from(this.$refs.panel ? this.$refs.panel.querySelectorAll('[role="option"], button') : []);
            },

            items() {
                return this.menuItems();
            },

            openMenu() {
                this.open = true;
                this.$nextTick(() => {
                    const list = this.menuItems();
                    if (list.length > 0) {
                        const sel = list.findIndex(el => el.getAttribute('aria-selected') === 'true');
                        const target = sel !== -1 ? sel : 0;
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

            select(val, title) {
                this.selectedValue = val;
                this.selectedTitle = title;
                this.close(this.$refs.button);
                this.hasServerError = false;
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
        }));
    };

    if (window.Alpine) {
        registerDropdown();
    } else {
        document.addEventListener('alpine:init', registerDropdown);
    }
}
