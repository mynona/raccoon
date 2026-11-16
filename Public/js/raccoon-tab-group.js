// V1.0
/* Alpine component: Accessible WAI-ARIA tab navigation with keyboard cycling and focus control. */

if (!window.__tabGroupLoaded) {
    window.__tabGroupLoaded = true;

    const registerTabGroup = () => {
        Alpine.data('tabGroup', ({ initialTab = '', tabIds = [] } = {}) => ({
            selectedTab: initialTab,
            tabIds: Array.isArray(tabIds) ? tabIds : [],

            selectTab(id) {
                if (!this.tabIds.includes(id)) return;
                this.selectedTab = id;
                this.$nextTick(() => {
                    const activeEl = document.getElementById(`tab-${id}`);
                    if (activeEl) {
                        activeEl.focus();
                    }
                });
            },

            nextTab() {
                if (this.tabIds.length === 0) return;
                const currentIndex = this.tabIds.indexOf(this.selectedTab);
                const nextIndex = (currentIndex + 1) % this.tabIds.length;
                this.selectTab(this.tabIds[nextIndex]);
            },

            previousTab() {
                if (this.tabIds.length === 0) return;
                const currentIndex = this.tabIds.indexOf(this.selectedTab);
                const prevIndex = (currentIndex - 1 + this.tabIds.length) % this.tabIds.length;
                this.selectTab(this.tabIds[prevIndex]);
            },

            firstTab() {
                if (this.tabIds.length > 0) {
                    this.selectTab(this.tabIds[0]);
                }
            },

            lastTab() {
                if (this.tabIds.length > 0) {
                    this.selectTab(this.tabIds[this.tabIds.length - 1]);
                }
            }
        }));
    };

    if (window.Alpine) {
        registerTabGroup();
    } else {
        document.addEventListener('alpine:init', registerTabGroup);
    }
}
