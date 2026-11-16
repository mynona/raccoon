// V1.0

/* Alpine component: scope shared by the CMS feedback tables and their delete dialog. */

// Guard against double registration if the script is included twice
if (!window.__feedbackTableLoaded) {
  window.__feedbackTableLoaded = true;

  const registerFeedbackTable = () => {
    // config: { kind?: 'article' | 'page' }
    Alpine.data('feedbackTable', (config = {}) => ({
      deleteDialogOpen: false,
      deleteKind: config.kind || 'article',
      deleteUrl: '',

      askDelete(kind, url) {
        this.deleteKind = kind;
        this.deleteUrl = url;
        this.deleteDialogOpen = true;
      },

      closeDialog() {
        this.deleteDialogOpen = false;
        this.$store.modal = false;
      },

      async closeFeedback(url) {
        await this.postRequest(url);
        this.reloadTables();
      },

      async postRequest(url) {
        try {
          const response = await fetch(url, { method: 'POST', credentials: 'same-origin' });
          if (!response.ok) throw new Error(response.status);
        } catch (error) {
          console.error('[feedback-table] Request failed:', error);
        }
      },

      // Reloads every DataTable inside this scope
      reloadTables() {
        for (const element of this.$root.querySelectorAll('[x-data]')) {
          const data = Alpine.$data(element);
          if (data && typeof data.load === 'function') data.load();
        }
      }
    }));
  };

  if (window.Alpine) {
    registerFeedbackTable();
  } else {
    document.addEventListener('alpine:init', registerFeedbackTable);
  }
}
