// V1.0

/* Alpine component: adds / removes a bookmark through the blog BFF and reports the result with toasts. */

// Guard against double registration if the script is included twice
if (!window.__bookmarkToggleLoaded) {
  window.__bookmarkToggleLoaded = true;

  // Error toasts are sticky by default; these disappear on their own like the others
  const ERROR_TOAST_MS = 8000;

  document.addEventListener('alpine:init', () => {
    // config: { articleId: string, bookmarkId?: string, topicId?: string, libraryLinkId?: string }
    // libraryLinkId is the id of an element around the "View library (n)" link; its number follows add and remove.
    Alpine.data('bookmarkToggle', (config = {}) => ({
      articleId: config.articleId || '',
      bookmarkId: config.bookmarkId || '',
      topicId: config.topicId || '',
      libraryLinkId: config.libraryLinkId || '',
      isBookmarked: Boolean(config.bookmarkId),
      isBusy: false,

      // Changes the number in brackets of the link to the library, e.g. "View library (33)"
      adjustLibraryCount(delta) {
        const link = this.libraryLinkId ? document.getElementById(this.libraryLinkId) : null;
        if (!link) return;
        const label = [...link.querySelectorAll('span')].find((span) => /\(\d+\)/.test(span.textContent));
        if (!label) return;
        label.textContent = label.textContent.replace(/\((\d+)\)/, (match, count) => `(${Math.max(0, Number(count) + delta)})`);
      },

      async toggle() {
        if (this.isBusy) return;
        this.isBusy = true;
        const isRemoving = this.isBookmarked;
        try {
          if (isRemoving) {
            await this.remove();
          } else {
            await this.add();
          }
        } catch (error) {
          if (isRemoving) {
            window.RaccoonToast?.error('Bookmark failed', 'The bookmark could not be removed. Please try again.', ERROR_TOAST_MS);
          } else {
            window.RaccoonToast?.error('Bookmark failed', 'The bookmark could not be saved. Please try again.', ERROR_TOAST_MS);
          }
        } finally {
          this.isBusy = false;
        }
      },

      async add() {
        const response = await fetch('/api/bookmarks/', {
          method: 'POST',
          credentials: 'same-origin',
          headers: { 'Content-Type': 'application/json', 'Accept': 'application/json' },
          body: JSON.stringify({ article_id: this.articleId })
        });
        // The blog renders error pages with status 200, so only the exact success status counts
        if (response.status !== 201) throw new Error(`HTTP ${response.status}`);
        const body = await response.json();
        if (!body.id) throw new Error('Missing bookmark id');
        this.bookmarkId = body.id;
        this.isBookmarked = true;
        this.adjustLibraryCount(1);
        window.RaccoonToast?.success('Bookmark added', 'The article was added to your library.');
      },

      async remove() {
        const response = await fetch(`/api/bookmarks/${encodeURIComponent(this.bookmarkId)}/`, {
          method: 'DELETE',
          credentials: 'same-origin',
          headers: { 'Accept': 'application/json' }
        });
        if (response.status !== 204) throw new Error(`HTTP ${response.status}`);
        this.bookmarkId = '';
        this.isBookmarked = false;
        this.adjustLibraryCount(-1);
        // Lets the library lists update their counts and reload (they match on the topic of the article)
        window.dispatchEvent(new CustomEvent('bookmark-removed', { detail: { articleId: this.articleId, topicId: this.topicId } }));
        window.RaccoonToast?.success('Bookmark removed', 'The article was removed from your library.');
      }
    }));
  });
}
