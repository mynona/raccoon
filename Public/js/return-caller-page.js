// V1.0

/* Navigates back to the page the user came from, with a fallback to the home page. */

function returnToCallerPage() {
  // Prefer the caller page persisted by search-view.js
  const callerPage = localStorage.getItem('callerPage');

  if (callerPage) {
    window.location = callerPage;
    return;
  }

  if (document.referrer) {
    try {
      const referrerUrl = new URL(document.referrer, window.location.origin);
      const isSameOrigin = referrerUrl.origin === window.location.origin;
      const isSearchPage = referrerUrl.pathname.startsWith('/search');

      // Only trust same-origin, non-search referrers
      if (isSameOrigin && !isSearchPage) {
        window.location = `${referrerUrl.pathname}${referrerUrl.search}${referrerUrl.hash}`;
        return;
      }
    } catch {
      // Ignore malformed referrers and fall back to home.
    }
  }

  window.location = '/home/';
}