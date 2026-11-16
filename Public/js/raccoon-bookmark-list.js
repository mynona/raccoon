// V1.0

/* Alpine component: one page-wise loaded list of bookmarks (library tab), driven by TablePaginator. */

// Guard against double registration if the script is included twice
if (!window.__bookmarkListLoaded) {
  window.__bookmarkListLoaded = true;

  // Error toasts are sticky by default; this one disappears on its own like the others
  const ERROR_TOAST_MS = 8000;

  document.addEventListener('alpine:init', () => {
    // config: { endpoint, topicId?, page, per, total, loaded, pageSizeOptions, countId?, storageKey? }
    // The server answers with { html, total, page, per }; `html` holds the rendered cards.
    // Needs a `cards` x-ref (the container of the cards) inside the component.
    // The page size is kept in localStorage (`storageKey`) and shared by all lists of the page, so it does not
    // fall back to the default when the user moves from tab to tab or visits the page again.
    Alpine.data('bookmarkList', (config = {}) => ({
      endpoint: config.endpoint || '/api/library/',
      topicId: config.topicId || '',
      pageSizeOptions: config.pageSizeOptions || [5, 10, 20, 50, 100],
      countId: config.countId || '',
      storageKey: config.storageKey || 'bookmarkLibrary.pageSize',
      page: config.page || 1,
      per: config.per || 20,
      total: config.total || 0,
      loaded: Boolean(config.loaded),
      // What the cards show right now. A failed request goes back to it instead of leaving the paginator on a page
      // that is not shown.
      shownPage: config.page || 1,
      shownPer: config.per || 20,
      // The page size changed while this list was hidden or before it was loaded: reload when it is shown
      stale: false,
      isLoading: false,
      instanceId: Math.random().toString(36).slice(2),

      init() {
        const stored = this.readStoredPageSize();
        if (stored && stored !== this.per) {
          this.per = stored;
          this.page = 1;
          if (this.total > 0) this.stale = true;
        }

        // A hidden tab panel is loaded when it is shown, a stale one is loaded again
        const observer = new IntersectionObserver((entries) => {
          if (entries.some((entry) => entry.isIntersecting) && (!this.loaded || this.stale)) {
            this.load();
          }
        });
        observer.observe(this.$el);
      },

      readStoredPageSize() {
        try {
          const size = Number(window.localStorage.getItem(this.storageKey));
          return this.pageSizeOptions.includes(size) ? size : null;
        } catch (error) {
          return null;
        }
      },

      storePageSize(size) {
        try {
          window.localStorage.setItem(this.storageKey, String(size));
        } catch (error) {
          // Storage is not available (e.g. private mode): the page size then only lasts for this page
        }
      },

      // Another list of the page got a new page size
      onPageSizeChanged(detail) {
        if (detail.instanceId === this.instanceId || detail.size === this.per) return;
        this.per = detail.size;
        this.page = 1;
        if (this.total > 0) this.stale = true;
      },

      get totalPages() { return Math.max(1, Math.ceil(this.total / this.per)); },
      get hasPrevious() { return this.page > 1; },
      get hasNext() { return this.page < this.totalPages; },
      get rangeLabel() {
        if (this.total === 0) return '0 of 0';
        const start = (this.page - 1) * this.per + 1;
        return `${start} – ${Math.min(this.page * this.per, this.total)} of ${this.total}`;
      },

      async load() {
        if (this.isLoading) return;
        this.isLoading = true;
        try {
          const params = new URLSearchParams({ page: this.page, per: this.per });
          if (this.topicId) params.set('topic', this.topicId);
          const response = await fetch(`${this.endpoint}?${params}`, {
            credentials: 'same-origin',
            headers: { 'Accept': 'application/json' }
          });
          // The blog renders error pages with status 200, so the JSON content type is checked as well
          const isJson = (response.headers.get('Content-Type') || '').includes('application/json');
          if (response.status !== 200 || !isJson) throw new Error(`HTTP ${response.status}`);
          const data = await response.json();
          this.$refs.cards.innerHTML = data.html;
          this.total = data.total;
          this.page = data.page;
          this.per = data.per;
          this.shownPage = data.page;
          // The page size is only kept (and shared with the other lists) once it has been loaded
          if (data.per !== this.shownPer) {
            this.shownPer = data.per;
            this.storePageSize(data.per);
            window.dispatchEvent(new CustomEvent('bookmark-page-size', {
              detail: { size: data.per, instanceId: this.instanceId }
            }));
          }
          this.loaded = true;
          this.stale = false;
          this.updateCount();
        } catch (error) {
          if (this.loaded) {
            this.page = this.shownPage;
            this.per = this.shownPer;
          }
          window.RaccoonToast?.error('Library failed', 'The bookmarks could not be loaded. Please try again.', ERROR_TOAST_MS);
        } finally {
          this.isLoading = false;
        }
      },

      goToPage(page) {
        const target = Math.min(Math.max(1, Number(page)), this.totalPages);
        if (target === this.page || this.isLoading) return;
        this.page = target;
        this.load();
        this.$el.scrollIntoView({ behavior: 'smooth', block: 'start' });
      },
      previousPage() { this.goToPage(this.page - 1); },
      nextPage() { this.goToPage(this.page + 1); },

      // Keeps the first visible bookmark on screen when the page size changes
      changePageSize(size) {
        size = Number(size);
        if (!this.pageSizeOptions.includes(size) || size === this.per) return;
        const firstIndex = (this.page - 1) * this.per;
        this.per = size;
        this.page = Math.floor(firstIndex / size) + 1;
        this.load();
      },

      // A bookmark was removed: the "All" list (no topic) and the list of its topic update count and page
      onRemoved(detail) {
        if (this.topicId && detail.topicId !== this.topicId) return;
        this.total = Math.max(0, this.total - 1);
        this.updateCount();
        if (!this.loaded) return;
        this.page = Math.min(this.page, this.totalPages);
        this.load();
      },

      // The count pill of the tab is rendered by TabGroup, outside of this component
      updateCount() {
        const pill = this.countId ? document.getElementById(this.countId) : null;
        if (!pill) return;
        pill.textContent = String(this.total);
        pill.style.display = this.total === 0 ? 'none' : '';
      }
    }));
  });
}
