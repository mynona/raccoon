// V1.0

/* Matomo tracker. Configured by data-* attributes on its own <script> tag, so the page needs no inline script:
 * - data-tracker-url   Matomo base URL with a trailing slash
 * - data-site-id       Matomo site ID
 * - data-consent       "banner" (cookie-less until the visitor decides) or "accepted"
 * - data-page-type     "page-view" or "site-search"
 * - data-user-state    optional: "signed-in" or "signed-out"
 * - data-user-id       user ID, only with data-user-state="signed-in"
 */

(function () {
  const script = document.currentScript;
  if (!script) return;
  const config = script.dataset;

  const _paq = (window._paq = window._paq || []);
  _paq.push([
    'setExcludedQueryParams',
    ['[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}'],
  ]);

  if (config.userState === 'signed-in') {
    _paq.push(['setUserId', config.userId]);
    _paq.push(['setCustomDimension', 1, 'signed-in']);
  } else if (config.userState === 'signed-out') {
    _paq.push(['setCustomDimension', 1, 'not-signed-in']);
  }

  _paq.push(['setCustomDimension', 3, 'js']);

  // Cookie-less tracking with reduced heart beat time to avoid race conditions
  if (config.consent === 'banner') {
    _paq.push(['disableCookies']);
    _paq.push(['enableHeartBeatTimer', 15, 30]);
  } else {
    _paq.push(['enableHeartBeatTimer', 5, 10]);
  }

  _paq.push(['appendToTrackingUrl', 'recMode=2']);

  if (config.pageType === 'site-search') {
    _paq.push(['trackSiteSearch', '', false, false]);
  } else {
    _paq.push(['trackPageView']);
  }

  _paq.push(['trackVisibleContentImpressions']);
  _paq.push(['enableLinkTracking']);

  const url = config.trackerUrl;
  _paq.push(['setTrackerUrl', url + 'matomo.php']);
  _paq.push(['setSiteId', config.siteId]);

  const loader = document.createElement('script');
  loader.async = true;
  loader.src = url + 'matomo.js';
  const first = document.getElementsByTagName('script')[0];
  first.parentNode.insertBefore(loader, first);
})();
