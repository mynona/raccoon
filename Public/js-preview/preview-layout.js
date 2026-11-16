// Preview app only. Alpine components of the Preview layout (Basic.swift) and of demo pages, plus the
// $alert magic.
// They are registered with Alpine.data because the CSP build of Alpine cannot evaluate inline
// object literals with methods, `window`, `if` or several statements.
// Load before the Alpine bundle.

document.addEventListener('alpine:init', () => {
  // $alert('text') -> window.alert, for the click actions of the demo buttons and menus
  Alpine.magic('alert', () => (message) => window.alert(message));

  Alpine.data('previewLayout', () => ({
    showNavigation: false,
    drawerOpen: false,
    search: '',

    init() {
      const mq = window.matchMedia('(min-width: 1024px)');
      mq.addEventListener('change', (e) => {
        if (e.matches) this.closeNavigation();
      });
    },
    toggleNavigation() {
      this.showNavigation = !this.showNavigation;
      this.drawerOpen = true;
    },
    closeNavigation() {
      this.showNavigation = false;
      this.drawerOpen = false;
    },
    onResize() {
      if (window.innerWidth >= 1024) this.closeNavigation();
    },
    onNavigationClick(event) {
      if (event.target.closest('a')) this.closeNavigation();
    },
    get query() {
      return this.search.toLowerCase().trim();
    },
    matchesAny(titles) {
      return !this.query || titles.some((t) => t.includes(this.query));
    },
  }));

  // Static state of the TablePaginator demo variants.
  Alpine.data('paginatorDemo', () => ({
    page: 2,
    per: 10,
    total: 95,
    totalPages: 10,
    rangeLabel: '11 – 20 of 95',
    pageSizeOptions: [5, 10, 20, 50, 100],
    hasPrevious: true,
    hasNext: true,
    isLoading: false,
    hasSearched: true,

    changePageSize(val) {
      this.per = Number(val);
    },
    goToPage(p) {
      this.page = p;
    },
    previousPage() {
      if (this.page > 1) this.page--;
    },
    nextPage() {
      if (this.page < this.totalPages) this.page++;
    },
  }));

  // Buttons of the Toast demo page. The public API is window.RaccoonToast.
  Alpine.data('toastSandbox', () => ({
    success() {
      window.RaccoonToast.success('Saved successfully', 'Your article changes have been committed.', 4000);
    },
    info() {
      window.RaccoonToast.info('New Update Available', 'Version 2.4 has been deployed.', 5000);
    },
    warning() {
      window.RaccoonToast.warning('Unsaved Draft', 'You have changes that were not saved yet.', 6000);
    },
    error() {
      window.RaccoonToast.error('Network Error', 'Failed to connect to API server. Click close to dismiss.', 0);
    },
    stack() {
      const toast = window.RaccoonToast;
      toast.info('Task 1 started', 'Processing background sync...', 5000);
      setTimeout(() => toast.success('Task 1 completed', 'Sync finished.', 5000), 400);
      setTimeout(() => toast.info('Task 2 started', 'Indexing search records...', 5000), 800);
    },
    clearAll() {
      window.RaccoonToast.clearAll();
    },
  }));
});
