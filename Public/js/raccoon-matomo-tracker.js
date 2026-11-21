// V2.1

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
 * Events from other scripts (this file is the only one that talks to Matomo; others dispatch a DOM event that nobody
 * hears without consent, because this script is then not on the page):
 *   window.dispatchEvent(new CustomEvent('raccoon:track', { detail: { type: ..., ... } }))
 * - { type: 'funnel', funnel, step }         event "funnel / <funnel> / <step>" for the MyFunnel plugin
 * - { type: 'feedback', widget, answer }     event "feedback / <widget> / <answer>", fixed values only
 * - { type: 'site-search', term, count }     site search with the number of results
 * - { type: 'heatmap', payload }              heatmap data of raccoon-heatmap.js, sent as the parameter "myheatmap"
 * Funnel, step, widget and answer are lowercase keys (letters, digits, hyphen), never personal data or free text.
 *
 * Forms with data-matomo-name are tracked once per form view, never per field and never with values:
 * - form_start    first focus in the form
 * - field_error   a validated field shows an error (name = field)
 * - form_submit   on submit (value = milliseconds since form_start)
 * - form_abandon  page left without submit (name = last touched field, value = milliseconds since form_start)
 *
 * After a sign out, Matomo would keep attributing the visitor to the previous user. With accepted consent
 * (Matomo cookies are allowed then) the script therefore remembers in localStorage that this browser was signed in
 * and resets the user on the first signed-out page afterwards, whichever route the sign out took.
 */

(function () {
  const script = document.currentScript;
  if (!script) return;
  const config = script.dataset;

  window._paq = window._paq || [];

  // matomo.js replaces window._paq by its own object once it is loaded, so the array above is dead from then on.
  // Every call, early or late, has to go through window._paq.
  function push(call) {
    window._paq.push(call);
  }

  push([
    'setExcludedQueryParams',
    ['[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}'],
  ]);

  if (config.userState === 'signed-in') {
    push(['setUserId', config.userId]);
    push(['setCustomDimension', 1, 'signed-in']);
  } else if (config.userState === 'signed-out') {
    push(['setCustomDimension', 1, 'not-signed-in']);
  }

  push(['setCustomDimension', 3, 'js']);

  const eventKey = /^[a-z][a-z0-9-]{0,39}$/;
  window.addEventListener('raccoon:track', function (event) {
    const d = event.detail;
    if (!d || typeof d !== 'object') return;
    if (d.type === 'funnel' && eventKey.test(d.funnel) && eventKey.test(d.step)) {
      push(['trackEvent', 'funnel', d.funnel, d.step]);
    } else if (d.type === 'feedback' && eventKey.test(d.widget) && eventKey.test(d.answer)) {
      push(['trackEvent', 'feedback', d.widget, d.answer]);
    } else if (d.type === 'site-search' && typeof d.term === 'string' && d.term && Number.isInteger(d.count)) {
      push(['trackSiteSearch', d.term, false, d.count]);
    } else if (d.type === 'heatmap' && d.payload && typeof d.payload === 'object') {
      // numbers and element ids only (raccoon-heatmap.js); the Matomo plugin validates it again
      const json = JSON.stringify(d.payload);
      if (json.length <= 6000) push(['trackRequest', 'myheatmap=' + encodeURIComponent(json)]);
    }
  });

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
        push(['setCustomDimension', Number(id), dimensions[id]]);
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
    push(['resetUserId']);
  }

  // Cookie-less tracking with reduced heart beat time to avoid race conditions
  if (config.consent === 'banner') {
    push(['disableCookies']);
    push(['enableHeartBeatTimer', 15, 30]);
  } else {
    push(['enableHeartBeatTimer', 5, 10]);
  }

  const trackingParams = 'recMode=2';
  // new_visit=1 forces a new visit on every request that carries it, so it is only appended to the page view
  push(['appendToTrackingUrl', resetUser ? trackingParams + '&new_visit=1' : trackingParams]);

  if (config.pageType === 'site-search') {
    push(['trackSiteSearch', '', false, false]);
  } else {
    push(['trackPageView']);
  }

  if (resetUser) {
    push(['appendToTrackingUrl', trackingParams]);
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
        push(['trackEvent'].concat(event));
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
      if (content) push(['trackContentInteraction', 'click'].concat(content));
    },
    true
  );

  function reportImpression(node) {
    const content = contentOf(node);
    if (content) push(['trackContentImpression'].concat(content));
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
  function trackForms() {
    document.querySelectorAll('form[data-matomo-name]').forEach(function (form) {
      const formName = form.dataset.matomoName;
      const category = 'form.' + formName;
      let startTime = null;
      let lastFieldId = null;
      let submitted = false;
      let abandonReported = false;

      // One event with the form name as custom dimension 2
      function track(action, name, value) {
        const event = ['trackEvent', category, action, name];
        if (value !== undefined) event.push(value);
        push(['setCustomDimension', 2, formName]);
        push(event);
        push(['deleteCustomDimension', 2]);
      }

      // Only Alpine validated fields can show an error
      function hasError(field) {
        const holder = field.closest('[x-data]');
        const state = holder && window.Alpine && typeof Alpine.$data === 'function' ? Alpine.$data(holder) : null;
        return !!(state && (state.hasError || state.hasServerError));
      }

      form.querySelectorAll('input, textarea, select').forEach(function (field) {
        const fieldId = field.id || field.name || field.dataset.matomoName || 'unnamed_field';
        field.addEventListener('focus', function () {
          lastFieldId = fieldId;
          if (startTime) return;
          startTime = Date.now();
          track('form_start', formName);
        });
        field.addEventListener('blur', function () {
          lastFieldId = fieldId;
          if (hasError(field)) track('field_error', fieldId);
        });
      });

      form.addEventListener('submit', function () {
        submitted = true;
        track('form_submit', formName, startTime ? Date.now() - startTime : undefined);
      });

      // Once, on whichever unload event fires first
      function reportAbandon() {
        if (!startTime || submitted || abandonReported) return;
        abandonReported = true;
        track('form_abandon', lastFieldId || 'no_field', Date.now() - startTime);
      }
      window.addEventListener('pagehide', reportAbandon);
      window.addEventListener('beforeunload', reportAbandon);
    });
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', trackForms);
  } else {
    trackForms();
  }
  push(['enableLinkTracking']);

  const url = config.trackerUrl;
  push(['setTrackerUrl', url + 'matomo.php']);
  push(['setSiteId', config.siteId]);

  // Heatmaps (Matomo plugin MyHeatmap): only with accepted consent. The data is anonymous (element ids and numbers), so it is recorded for signed-in users too. The collector
  // asks Matomo which heatmaps apply to the page and records nothing otherwise.
  if (config.consent === 'accepted' && /raccoon-matomo-tracker\.js/.test(script.src)) {
    const collector = document.createElement('script');
    collector.async = true;
    collector.src = script.src.replace(/raccoon-matomo-tracker\.js/, 'raccoon-heatmap.js');
    collector.dataset.trackerUrl = url;
    collector.dataset.siteId = config.siteId;
    document.head.appendChild(collector);
  }

  const loader = document.createElement('script');
  loader.async = true;
  loader.src = url + 'matomo.js';
  const first = document.getElementsByTagName('script')[0];
  first.parentNode.insertBefore(loader, first);
})();
