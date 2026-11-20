// V1.1

/* Matomo tracker. Configured by data-* attributes on its own <script> tag, so the page needs no inline script:
 * - data-tracker-url   Matomo base URL with a trailing slash
 * - data-site-id       Matomo site ID
 * - data-consent       "banner" (cookie-less until the visitor decides) or "accepted"
 * - data-page-type     "page-view" or "site-search"
 * - data-user-state    optional: "signed-in" or "signed-out"
 * - data-user-id       user ID, only with data-user-state="signed-in"
 * - data-dimensions    optional: JSON object, custom dimension ID to value, e.g. {"4":"google"}
 * - data-events        optional: JSON array of [category, action, name?], reported with the page view
 * - data-reset-user    optional: "true" to forget the user ID and start a new visit (page shown after a sign out)
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

  function parseJson(value) {
    try {
      return JSON.parse(value);
    } catch (e) {
      return null;
    }
  }

  const dimensions = parseJson(config.dimensions);
  if (dimensions && typeof dimensions === 'object') {
    Object.keys(dimensions).forEach(function (id) {
      if (/^\d+$/.test(id) && typeof dimensions[id] === 'string') {
        _paq.push(['setCustomDimension', Number(id), dimensions[id]]);
      }
    });
  }

  const resetUser = config.resetUser === 'true';
  if (resetUser) {
    _paq.push(['resetUserId']);
  }

  // Cookie-less tracking with reduced heart beat time to avoid race conditions
  if (config.consent === 'banner') {
    _paq.push(['disableCookies']);
    _paq.push(['enableHeartBeatTimer', 15, 30]);
  } else {
    _paq.push(['enableHeartBeatTimer', 5, 10]);
  }

  const trackingParams = 'recMode=2';
  // new_visit=1 forces a new visit on every request that carries it, so it is only appended to the page view
  _paq.push(['appendToTrackingUrl', resetUser ? trackingParams + '&new_visit=1' : trackingParams]);

  if (config.pageType === 'site-search') {
    _paq.push(['trackSiteSearch', '', false, false]);
  } else {
    _paq.push(['trackPageView']);
  }

  if (resetUser) {
    _paq.push(['appendToTrackingUrl', trackingParams]);
  }

  const events = parseJson(config.events);
  if (Array.isArray(events)) {
    events.forEach(function (event) {
      if (Array.isArray(event) && event.length >= 2 && event.every(function (part) { return typeof part === 'string'; })) {
        _paq.push(['trackEvent'].concat(event));
      }
    });
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
