// V1.0



(function () {
  const script = document.currentScript;
  const config = script ? script.dataset : {};

  const INTERACTIVE =
    'a, button, input, select, textarea, summary, label, [role="button"], [role="switch"], [role="tab"], ' +
    '[role="menuitem"], [role="checkbox"], [role="radio"], [role="link"], [role="combobox"], [data-heatmap-label]';
  const MEDIA = 'img, svg, video, canvas, iframe, picture, object, embed';
  const FORM_FIELD = 'input, select, textarea';
  const SKIP_TAGS = /^(script|style|noscript|template|head|meta|link|title|br|wbr|source|track|option|optgroup)$/i;
  const UI_TEXT = 'button, summary, [role="button"], [role="tab"], [role="menuitem"], [role="switch"]';
  const CHROME = 'nav, header, footer, [role="navigation"], [role="menubar"], [role="tablist"]';

  function fnv1a(text) {
    let hash = 0x811c9dc5;
    for (let i = 0; i < text.length; i++) {
      hash ^= text.charCodeAt(i);
      hash = Math.imul(hash, 0x01000193) >>> 0;
    }
    return ('00000000' + hash.toString(16)).slice(-8);
  }

  function elementId(el) {
    const parts = [];
    for (let node = el; node && node.nodeType === 1; node = node.parentElement) {
      let index = 1;
      for (let sibling = node.previousElementSibling; sibling; sibling = sibling.previousElementSibling) index++;
      parts.push(node.tagName.toLowerCase() + ':' + index);
    }
    return fnv1a(parts.join('>'));
  }

  function hasDirectText(el) {
    for (let node = el.firstChild; node; node = node.nextSibling) {
      if (node.nodeType === 3 && /\S/.test(node.nodeValue)) return true;
    }
    return false;
  }

  function isInline(style) {
    return style.display === 'inline' || style.display === 'contents';
  }

  function isVisual(el) {
    if (SKIP_TAGS.test(el.tagName)) return false;
    if (el.matches(INTERACTIVE) || el.matches(MEDIA)) return true;
    const style = getComputedStyle(el);
    if (isInline(style)) return false;
    if (hasDirectText(el)) return true;
    const transparent = /^(rgba\(0, 0, 0, 0\)|transparent)$/;
    return (
      !transparent.test(style.backgroundColor) ||
      style.backgroundImage !== 'none' ||
      parseFloat(style.borderTopWidth) > 0 ||
      parseFloat(style.borderBottomWidth) > 0
    );
  }

  function contains(el, x, y) {
    const rect = el.getBoundingClientRect();
    return x >= rect.left - 1 && x <= rect.right + 1 && y >= rect.top - 1 && y <= rect.bottom + 1;
  }

  // The element that stands for a hit target: the closest control, else the closest visual ancestor. With a point
  // (clientX, clientY) only elements that contain it qualify, so overflowing content is not pinned to a smaller parent.
  function nodeFor(target, x, y) {
    if (!(target instanceof Element)) return null;
    const hasPoint = typeof x === 'number' && typeof y === 'number';
    const control = target.closest(INTERACTIVE);
    if (control && (!hasPoint || contains(control, x, y))) return control;
    for (let el = target; el && el !== document.documentElement; el = el.parentElement) {
      if (isVisual(el) && (!hasPoint || contains(el, x, y))) return el;
    }
    return document.body;
  }

  function cleanText(text, max) {
    return String(text).replace(/\s+/g, ' ').trim().slice(0, max);
  }

  // A name for a control: markup hints first, then UI wording. Text of links is only used inside navigation areas.
  function labelOf(el) {
    const hint = el.getAttribute('data-heatmap-label');
    if (hint) return cleanText(hint, 60);
    const name = el.getAttribute('data-content-name');
    if (name) {
      const piece = el.getAttribute('data-content-piece');
      return cleanText(piece ? name + ' ' + piece : name, 60);
    }
    const aria = el.getAttribute('aria-label');
    if (aria) return cleanText(aria, 60);
    if (el.matches(FORM_FIELD)) {
      const type = el.tagName.toLowerCase() === 'input' ? el.getAttribute('type') || 'text' : el.tagName.toLowerCase();
      return type + ' field';
    }
    if (el.matches(UI_TEXT) && el.children.length === 0) {
      const text = cleanText(el.textContent, 30);
      if (text) return text;
    }
    if (el.tagName.toLowerCase() === 'a') {
      if (el.closest(CHROME) && el.children.length === 0) {
        const text = cleanText(el.textContent, 40);
        if (text) return text;
      }
      return 'link';
    }
    const role = el.getAttribute('role');
    return role || el.tagName.toLowerCase();
  }

  function kindOf(el) {
    if (el.matches(FORM_FIELD)) return 'i';
    if (el.matches(MEDIA)) return 'm';
    if (el.matches(INTERACTIVE)) return 'c';
    return hasDirectText(el) ? 't' : 'b';
  }

  function isIgnored(el, excluded) {
    if (el.closest('[data-heatmap-ignore]')) return true;
    for (let i = 0; i < excluded.length; i++) {
      try {
        if (el.closest(excluded[i])) return true;
      } catch (e) {
        // an invalid selector excludes nothing
      }
    }
    return false;
  }

  /* The abstract layout of the page as boxes (never text, only short control labels). Used by the capture script. */
  function snapshot(options) {
    const excluded = (options && options.excludedElements) || [];
    const limit = (options && options.limit) || 5000;
    const scrollX = window.scrollX;
    const scrollY = window.scrollY;
    const nodes = [];
    const ids = new Map();
    const all = document.body.querySelectorAll('*');
    for (let i = 0; i < all.length && nodes.length < limit; i++) {
      const el = all[i];
      if (SKIP_TAGS.test(el.tagName) || !isVisual(el) || isIgnored(el, excluded)) continue;
      const style = getComputedStyle(el);
      if (style.visibility === 'hidden' || style.display === 'none') continue;
      const rect = el.getBoundingClientRect();
      const w = Math.round(rect.width);
      const h = Math.round(rect.height);
      if (w < 1 || h < 1) continue;
      const id = elementId(el);
      ids.set(el, id);
      let parent = el.parentElement;
      while (parent && !ids.has(parent)) parent = parent.parentElement;
      const kind = kindOf(el);
      const node = {
        i: id,
        t: el.tagName.toLowerCase(),
        k: kind,
        x: Math.round(rect.left + scrollX),
        y: Math.round(rect.top + scrollY),
        w: w,
        h: h,
      };
      if (kind === 'c' || kind === 'i') node.l = labelOf(el);
      if (parent) node.p = ids.get(parent);
      if (style.position === 'fixed' || style.position === 'sticky') node.s = 1;
      nodes.push(node);
    }
    const doc = document.documentElement;
    return { v: 1, width: Math.round(doc.clientWidth), height: Math.round(doc.scrollHeight), nodes: nodes };
  }

  window.RaccoonHeatmapKit = { elementId, nodeFor, isVisual, labelOf, kindOf, snapshot };

  // ---- recording: only with the settings of the tracker script ----
  if (!config.trackerUrl || !config.siteId) return;
  if (typeof PointerEvent !== 'function' || typeof fetch !== 'function') return;
  if (navigator.doNotTrack === '1' || window.doNotTrack === '1') return;

  const path = location.pathname;
  // ?myheatmap_sample=1 forces and =0 prevents the recording of this page view (own tests); automated browsers
  // are only recorded when forced
  const forced = /[?&]myheatmap_sample=([01])(&|$)/.exec(location.search);
  if (navigator.webdriver && !forced) return;

  function randomToken() {
    const bytes = new Uint8Array(8);
    if (window.crypto && crypto.getRandomValues) crypto.getRandomValues(bytes);
    else for (let i = 0; i < 8; i++) bytes[i] = Math.floor(Math.random() * 256);
    return Array.prototype.map
      .call(bytes, function (b) {
        return ('0' + b.toString(16)).slice(-2);
      })
      .join('');
  }

  const LIMITS = { clicks: 400, moves: 800, states: 100 };
  const CHUNK = 40;

  function startRecording(heatmaps) {
    const sessions = heatmaps.map(function (heatmap) {
      return {
        key: heatmap.key,
        token: randomToken(),
        excluded: heatmap.excludedElements || [],
        states: heatmap.states || [],
        breakpoints: heatmap.breakpoints,
        current: '',
        buffers: {},
        totals: { clicks: 0, moves: 0, states: 0 },
        toggled: {},
      };
    });

    let scrollReach = 0;
    let lastGesture = 0;
    let sentOnce = false;
    let dirty = false;

    function pageHeight() {
      return Math.max(document.documentElement.scrollHeight, document.body ? document.body.scrollHeight : 0, 1);
    }

    function updateScroll() {
      const reach = Math.min(1000, Math.round(((window.scrollY + window.innerHeight) / pageHeight()) * 1000));
      if (reach > scrollReach) {
        scrollReach = reach;
        dirty = true;
      }
    }

    function buffer(session) {
      const key = session.current;
      return session.buffers[key] || (session.buffers[key] = { clicks: [], moves: {}, states: [] });
    }

    function relative(el, event) {
      const rect = el.getBoundingClientRect();
      const clamp = function (v) {
        return Math.max(0, Math.min(2000, Math.round(v)));
      };
      if (rect.width <= 0 || rect.height <= 0) return [0, 0];
      return [clamp(((event.clientX - rect.left) / rect.width) * 2000), clamp(((event.clientY - rect.top) / rect.height) * 2000)];
    }

    function matchesState(el, selector) {
      try {
        return !!el.closest(selector);
      } catch (e) {
        return false;
      }
    }

    function onPointerUp(event) {
      if (!event.isPrimary || (event.pointerType === 'mouse' && event.button !== 0)) return;
      lastGesture = Date.now();
      const el = nodeFor(event.target, event.clientX, event.clientY);
      if (!el) return;
      sessions.forEach(function (session) {
        // a state is entered by a click on its trigger and left by the next click on it
        session.states.forEach(function (state) {
          if (!matchesState(event.target, state.click)) return;
          setTimeout(function () {
            const trigger = event.target.closest(state.click);
            const expanded = trigger ? trigger.getAttribute('aria-expanded') : null;
            if (expanded === 'true') session.current = state.name;
            else if (expanded === 'false') session.current = '';
            else {
              session.toggled[state.name] = !session.toggled[state.name];
              session.current = session.toggled[state.name] ? state.name : '';
            }
          }, 60);
        });
        if (isIgnored(el, session.excluded) || session.totals.clicks >= LIMITS.clicks) return;
        const pos = relative(el, event);
        buffer(session).clicks.push([2, elementId(el), pos[0], pos[1], 1]);
        session.totals.clicks++;
        dirty = true;
      });
    }

    let lastMove = 0;
    function onPointerMove(event) {
      const now = Date.now();
      if (now - lastMove < 100) return;
      lastMove = now;
      const el = nodeFor(event.target, event.clientX, event.clientY);
      if (!el) return;
      sessions.forEach(function (session) {
        if (isIgnored(el, session.excluded)) return;
        const pos = relative(el, event);
        const cell = elementId(el) + ':' + Math.floor(pos[0] / 20) + ':' + Math.floor(pos[1] / 20);
        const moves = buffer(session).moves;
        if (!moves[cell] && session.totals.moves >= LIMITS.moves) return;
        if (!moves[cell]) {
          moves[cell] = [1, elementId(el), Math.floor(pos[0] / 20) * 20 + 10, Math.floor(pos[1] / 20) * 20 + 10, 0];
          session.totals.moves++;
        }
        moves[cell][4]++;
        dirty = true;
      });
    }

    // State changes of controls (menu opened, switch turned on): only counted shortly after a user gesture
    function recordState(el, on) {
      if (Date.now() - lastGesture > 1500) return;
      const node = nodeFor(el);
      if (!node) return;
      sessions.forEach(function (session) {
        if (isIgnored(node, session.excluded) || session.totals.states >= LIMITS.states) return;
        buffer(session).states.push([4, elementId(node), on ? 1 : 0, 0, 1]);
        session.totals.states++;
        dirty = true;
      });
    }

    if (typeof MutationObserver === 'function') {
      new MutationObserver(function (mutations) {
        mutations.forEach(function (mutation) {
          const el = mutation.target;
          const name = mutation.attributeName;
          if (name === 'open') recordState(el, el.hasAttribute('open'));
          else if (/^aria-(expanded|checked|pressed)$/.test(name)) recordState(el, el.getAttribute(name) === 'true');
        });
      }).observe(document.documentElement, {
        attributes: true,
        subtree: true,
        attributeFilter: ['aria-expanded', 'aria-checked', 'aria-pressed', 'open'],
      });
    }
    document.addEventListener(
      'change',
      function (event) {
        const el = event.target;
        if (el instanceof HTMLInputElement && (el.type === 'checkbox' || el.type === 'radio')) recordState(el, el.checked);
      },
      true
    );

    function send(session, state, events) {
      const width = window.innerWidth;
      const payload = {
        v: 1,
        h: session.key,
        pv: session.token,
        p: path,
        w: width,
        ph: pageHeight(),
        vh: window.innerHeight,
        sr: scrollReach,
        af: Math.min(1000, Math.round((window.innerHeight / pageHeight()) * 1000)),
        ev: events,
      };
      if (state) payload.st = state;
      window.dispatchEvent(new CustomEvent('raccoon:track', { detail: { type: 'heatmap', payload: payload } }));
    }

    function flush() {
      updateScroll();
      if (!dirty && sentOnce) return;
      dirty = false;
      sessions.forEach(function (session) {
        let sent = false;
        Object.keys(session.buffers).forEach(function (state) {
          const b = session.buffers[state];
          const events = b.clicks.concat(Object.keys(b.moves).map(function (k) { return b.moves[k]; }), b.states);
          b.clicks = [];
          b.moves = {};
          b.states = [];
          for (let i = 0; i < events.length; i += CHUNK) {
            send(session, state, events.slice(i, i + CHUNK));
            sent = true;
          }
        });
        if (!sent) send(session, '', []);
      });
      sentOnce = true;
    }

    document.addEventListener('pointerup', onPointerUp, true);
    document.addEventListener('pointermove', onPointerMove, { passive: true, capture: true });
    window.addEventListener('scroll', updateScroll, { passive: true });
    setTimeout(flush, 2000);
    setInterval(flush, 10000);
    document.addEventListener('visibilitychange', function () {
      if (document.visibilityState === 'hidden') flush();
    });
    window.addEventListener('pagehide', flush);
    updateScroll();
  }

  function sampled(heatmap) {
    if (forced) return forced[1] === '1';
    return Math.random() * 100 < Number(heatmap.sampleRate);
  }

  const settingsUrl =
    config.trackerUrl +
    'index.php?module=MyHeatmap&action=config&idsite=' +
    encodeURIComponent(config.siteId) +
    '&path=' +
    encodeURIComponent(path);

  fetch(settingsUrl, { credentials: 'omit', mode: 'cors' })
    .then(function (response) {
      return response.ok ? response.json() : null;
    })
    .then(function (settings) {
      if (!settings || !Array.isArray(settings.heatmaps)) return;
      const chosen = settings.heatmaps.filter(sampled);
      if (chosen.length) startRecording(chosen);
    })
    .catch(function () {
      // no settings, no recording
    });
})();
