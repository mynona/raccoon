// V1.4

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
 *
 * Content tracking (elements with data-track-content, data-content-name, data-content-piece, data-content-target):
 * - every click on such an element is reported as content interaction "click"
 * - an impression is only reported for elements that also carry data-track-impression, once per page view,
 *   when at least half of the element is visible
 * - data-content-ignoreinteraction on an element switches its click reporting off
 *
 * Helpers for widgets, only present while this script is on the page (not with declined consent):
 * - window.RaccoonMatomo.trackFunnelStep(funnel, step)     event "funnel / <funnel> / <step>" for the MyFunnel plugin
 * - window.RaccoonMatomo.trackFeedbackAnswer(widget, answer) event "feedback / <widget> / <answer>", fixed values only
 *
 * After a sign out, Matomo would keep attributing the visitor to the previous user. With accepted consent
 * (Matomo cookies are allowed then) the script therefore remembers in localStorage that this browser was signed in
 * and resets the user on the first signed-out page afterwards, whichever route the sign out took.
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

  // Keys are lowercase and never carry personal data or free text
  const eventKey = /^[a-z][a-z0-9-]{0,39}$/;
  window.RaccoonMatomo = window.RaccoonMatomo || {};
  window.RaccoonMatomo.trackFunnelStep = function (funnel, step) {
    if (!eventKey.test(funnel) || !eventKey.test(step)) return;
    _paq.push(['trackEvent', 'funnel', funnel, step]);
  };
  window.RaccoonMatomo.trackFeedbackAnswer = function (widget, answer) {
    if (!eventKey.test(widget) || !eventKey.test(answer)) return;
    _paq.push(['trackEvent', 'feedback', widget, answer]);
  };

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

  let resetUser = config.resetUser === 'true';

  // Only with accepted consent: remember a signed-in browser to detect the first page after a sign out
  if (config.consent === 'accepted') {
    try {
      if (config.userState === 'signed-in') {
        localStorage.setItem('raccoon-matomo-signed-in', '1');
      } else if (config.userState === 'signed-out' && localStorage.getItem('raccoon-matomo-signed-in')) {
        localStorage.removeItem('raccoon-matomo-signed-in');
        resetUser = true;
      }
    } catch (e) {
      // Storage not available
    }
  }

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

  // The server marks a login as fresh for a time window, so the following pages carry the same events again.
  // With accepted consent, identical events within two minutes are reported only once.
  function alreadyReported(raw) {
    if (config.consent !== 'accepted') return false;
    try {
      const last = parseJson(localStorage.getItem('raccoon-matomo-events'));
      const now = Date.now();
      if (last && last.events === raw && now - last.time < 120000) return true;
      localStorage.setItem('raccoon-matomo-events', JSON.stringify({ events: raw, time: now }));
    } catch (e) {
      // Storage not available
    }
    return false;
  }

  const events = config.events && !alreadyReported(config.events) ? parseJson(config.events) : null;
  if (Array.isArray(events)) {
    events.forEach(function (event) {
      if (Array.isArray(event) && event.length >= 2 && event.every(function (part) { return typeof part === 'string'; })) {
        _paq.push(['trackEvent'].concat(event));
      }
    });
  }

  // trackVisibleContentImpressions is not used: it reports every visible element on every page view, and Matomo
  // only wires its own click tracking while it collects impressions. Both are reported here, explicitly.
  function contentOf(node) {
    const name = node.dataset.contentName;
    const piece = node.dataset.contentPiece;
    if (!name || !piece) return null;
    return [name, piece, node.dataset.contentTarget || undefined];
  }

  // Capture phase: also reported when a component stops the propagation of its click
  document.addEventListener(
    'click',
    function (event) {
      const node = event.target instanceof Element ? event.target.closest('[data-track-content]') : null;
      if (!node || node.hasAttribute('data-content-ignoreinteraction')) return;
      const content = contentOf(node);
      if (content) _paq.push(['trackContentInteraction', 'click'].concat(content));
    },
    true
  );

  function reportImpression(node) {
    const content = contentOf(node);
    if (content) _paq.push(['trackContentImpression'].concat(content));
  }

  function trackImpressions() {
    const nodes = document.querySelectorAll('[data-track-impression]');
    if (!nodes.length) return;
    if (typeof IntersectionObserver !== 'function') {
      nodes.forEach(reportImpression);
      return;
    }
    const observer = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          if (!entry.isIntersecting) return;
          observer.unobserve(entry.target);
          reportImpression(entry.target);
        });
      },
      { threshold: 0.5 }
    );
    nodes.forEach(function (node) {
      observer.observe(node);
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', trackImpressions);
  } else {
    trackImpressions();
  }
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
