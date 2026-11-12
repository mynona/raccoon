// V1.0

/* Form error summary: moves focus to the summary when the page loads with problems,
   and moves focus to the control when a link in the summary is activated. */

// Guard against double registration if the script is included twice
if (!window.__errorSummaryLoaded) {
  window.__errorSummaryLoaded = true;

  const NATIVE_CONTROL = 'input:not([type="hidden"]), select, textarea, button';
  const FOCUS_TARGET = [
    'input:not([type="hidden"]):not([aria-hidden="true"]):not([tabindex="-1"])',
    'select:not([aria-hidden="true"])',
    'textarea',
    'button:not([tabindex="-1"])',
    '[tabindex]:not([tabindex="-1"])'
  ].join(', ');

  const isVisible = (el) => el.getClientRects().length > 0 && !el.closest('[hidden]');

  // A list field has no element with its id: its rows are rendered by a template. Its label
  // (id "label-<id>") is inside the same scope as its controls, so that is used instead.
  const findTarget = (id) =>
    document.getElementById(id) || document.getElementsByName(id)[0] || document.getElementById('label-' + id);

  // The id in a summary link is not always a focusable element: a radio group or a select
  // widget puts it on a container or on a hidden input. Fall back to the first control inside,
  // preferring a field over a button.
  function resolveControl(id) {
    const el = findTarget(id);
    if (!el) return null;
    if (el.matches(NATIVE_CONTROL) && !el.disabled && isVisible(el) && el.getAttribute('aria-hidden') !== 'true') {
      return el;
    }
    const root = el.closest('[x-data], fieldset') || el.parentElement || el;
    return firstControlIn(root) || el;
  }

  // The first control to focus in a scope, preferring a field over a button
  function firstControlIn(scope) {
    const candidates = [...scope.querySelectorAll(FOCUS_TARGET)].filter((c) => !c.disabled && isVisible(c));
    return candidates.find((c) => c.matches('input, textarea, select')) || candidates[0] || null;
  }

  document.addEventListener('alpine:init', () => {
    Alpine.data('errorSummary', () => ({
      focusField(id) {
        resolveControl(id)?.focus();
      }
    }));
  });

  // ---- Live summary and submit gate -------------------------------------------------------
  // Only forms that use `validationMethod: .errorSummary` (a summary is rendered) or `.submit`
  // (`data-validation="submit"`) are touched. Fields stay unchanged: a
  // field is "live" when its Alpine scope has a reactive `hasError` (input, textarea, date picker)
  // or `hasServerError`, which the field clears when the user changes it (dropdown, selects, uploads).
  // Other fields keep the entry the server rendered until the next submit.

  const FIELD_CONTROL = 'input:not([type="hidden"]), textarea, select';
  const FORM_LEVEL = '[data-i18n="errorsummary.form"]';
  const states = new WeakMap(); // form -> state

  const clean = (text) => (text || '').replace(/\s+/g, ' ').trim();

  function labelOf(form, root, control) {
    const label =
      (control && control.id && form.querySelector('label[for="' + CSS.escape(control.id) + '"]')) ||
      root.querySelector('label, legend');
    if (!label) return control ? control.name || control.id : '';
    const copy = label.cloneNode(true);
    copy.querySelectorAll('svg, [aria-hidden="true"], .sr-only').forEach((node) => node.remove());
    return clean(copy.textContent);
  }

  // The entries the server rendered: label and message come from the link text
  function readSeeds(summary) {
    return [...summary.querySelectorAll('li')].flatMap((li) => {
      const link = li.querySelector('a');
      if (!link) return [];
      const spans = [...link.querySelectorAll('span')];
      return [{
        li,
        id: link.hash.slice(1),
        formLevel: !!li.querySelector(FORM_LEVEL),
        label: clean(spans[0] && spans[0].textContent),
        message: clean(spans.slice(2).map((span) => span.textContent).join(' ')),
        root: null
      }];
    });
  }

  function seedsInside(el, seeds) {
    return seeds.filter((seed) => {
      if (seed.formLevel || seed.root) return false;
      const target = findTarget(seed.id);
      return !!target && el.contains(target);
    });
  }

  // A channel is one entry of the summary: the control it links to and how to read its current problem
  function channelsFor(form, el, data, seeds) {
    const inside = seedsInside(el, seeds);
    const control = el.querySelector(FIELD_CONTROL);

    // Password and confirmation are two entries. Each has a server error, shown until the user
    // types, and a client error: the unmet rules of the checklist, or the mismatch text.
    if ('passwordServerError' in data) {
      const unmetRules = () =>
        [...el.querySelectorAll('ul li')].flatMap((li) => {
          const rule = /!criteria\.(\w+)/.exec(li.querySelector('svg[\\:class*="!criteria."]')?.getAttribute(':class') || '');
          return rule && !data.criteria[rule[1]] ? [clean(li.querySelector('span')?.textContent)] : [];
        });
      const mismatch = () => clean(el.querySelector('[data-i18n="passwordinput.mismatch"]')?.textContent);
      const fields = {
        password: {
          server: () => data.passwordServerError && !data.userTouchedPasswordField,
          client: () =>
            data.userTouchedPasswordField && data.password.length > 0 && !data.validContent
              ? unmetRules().join(', ')
              : null
        },
        confirmPassword: {
          server: () => data.confirmServerError && !data.userTouchedConfirmField,
          client: () => (data.confirmPassword.length > 0 && !data.passwordsMatch ? mismatch() : null)
        }
      };
      return Object.entries(fields).flatMap(([model, field]) => {
        const target = el.querySelector('[x-model="' + model + '"]');
        if (!target || !target.id) return [];
        const seed = inside.find((s) => findTarget(s.id) === target);
        return [{
          id: target.id,
          seed,
          label: seed ? seed.label : labelOf(form, el, target),
          problem: () => (field.server() && seed ? seed.message : field.client())
        }];
      });
    }

    const seed = inside[0];
    // A dropdown has no visible field: its id is on a hidden input
    const idControl = control || el.querySelector('input[id], button[id]');
    const id = seed ? seed.id : idControl && idControl.id;
    if (!id) return [];
    const label = seed ? seed.label : labelOf(form, el, idControl);

    // Input list: the first invalid row, else the problem the server rendered
    if ('rowErrors' in data) {
      return [{
        id, seed, label,
        problem: () => {
          const row = (data.rowErrors || []).find(Boolean);
          return row ? clean(row) : seed ? seed.message : null;
        }
      }];
    }

    if ('hasError' in data || 'hasServerError' in data) {
      return [{
        id, seed, label,
        problem: () => {
          if (data.hasServerError && seed) return seed.message;
          if (data.hasError) return clean(data.errorMessage);
          if (data.hasServerError) {
            const box = el.querySelector('[id$="-server-error"]');
            return clean(box && box.textContent);
          }
          return null;
        }
      }];
    }
    return [];
  }

  function findRoots(form, summary, seeds) {
    const roots = [];
    form.querySelectorAll('[x-data]').forEach((el) => {
      if (summary && summary.contains(el)) return;
      if (roots.some((root) => root.el.contains(el))) return;
      const data = Alpine.$data(el);
      if (!data) return;
      const channels = channelsFor(form, el, data, seeds);
      if (channels.length === 0) return;
      channels.forEach((channel) => {
        if (channel.seed) channel.seed.root = channel;
      });
      roots.push({ el, data, control: el.querySelector(FIELD_CONTROL), channels });
    });
    return roots;
  }

  const byPosition = (a, b) => {
    const x = findTarget(a.id);
    const y = findTarget(b.id);
    if (!x || !y || x === y) return 0;
    return x.compareDocumentPosition(y) & Node.DOCUMENT_POSITION_FOLLOWING ? -1 : 1;
  };

  // Seeds without a live field stay as rendered. Live fields report their current problem.
  function collect(state) {
    const items = [];
    state.seeds.forEach((seed) => {
      if (!seed.root && !seed.resolved) {
        items.push({ id: seed.id, label: seed.label, message: seed.message, seed, formLevel: seed.formLevel });
      }
    });
    state.roots.forEach((root) => {
      root.channels.forEach((channel) => {
        const message = channel.problem();
        if (message !== null) {
          items.push({ id: channel.id, label: channel.label, message, seed: channel.seed, formLevel: false });
        }
      });
    });
    const fields = items.filter((item) => !item.formLevel).sort(byPosition);
    return fields.concat(items.filter((item) => item.formLevel));
  }

  const signature = (items) => JSON.stringify(items.map((i) => [i.id, i.label, i.message, i.formLevel]));

  function buildItem(summary, item) {
    // Same markup as the server: keeps the translation markers of unchanged entries
    if (item.seed && item.seed.label === item.label && item.seed.message === item.message) return item.seed.li;
    const li = document.createElement('li');
    li.className = summary.dataset.itemClass || '';
    const link = document.createElement('a');
    link.href = '#' + item.id;
    link.className = summary.dataset.linkClass || '';
    [item.label, ': ', item.message].forEach((text) => {
      const span = document.createElement('span');
      span.textContent = text;
      link.appendChild(span);
    });
    li.appendChild(link);
    return li;
  }

  function updateHeading(summary, count) {
    const heading = document.getElementById(summary.id + '-heading');
    if (!heading) return;
    const one = count === 1;
    const fallback = (one ? summary.dataset.headingOne : summary.dataset.headingOther) || '';
    heading.setAttribute('data-i18n', one ? 'errorsummary.one' : 'errorsummary.other');
    if (one) {
      heading.removeAttribute('data-i18n-vars');
    } else {
      heading.setAttribute('data-i18n-vars', JSON.stringify({ count: String(count) }));
    }
    heading.textContent = fallback.replace('{{count}}', String(count));
    if (window.RaccoonI18n) window.RaccoonI18n.apply(heading);
  }

  function render(state, force) {
    const items = collect(state);
    const sig = signature(items);
    if (!force && sig === state.signature) return items;
    state.signature = sig;
    const { summary } = state;
    const list = summary.querySelector('ul');
    if (list) list.replaceChildren(...items.map((item) => buildItem(summary, item)));
    updateHeading(summary, items.length);
    if (items.length === 0) state.visible = false;
    summary.hidden = !state.visible || items.length === 0;
    return items;
  }

  // Submit validation: the submit buttons are aria-disabled while a field has an error. The
  // error can come from the browser (a check fails) or from the server (shown until the user
  // changes the field). The buttons stay focusable and are announced as unavailable. The attempt
  // itself is blocked in the submit handler below.
  function firstProblem(state) {
    for (const root of state.roots) {
      for (const channel of root.channels) {
        if (channel.problem() !== null) return { focus: () => resolveControl(channel.id)?.focus() };
      }
    }
    const open = state.statics.find((item) => !item.resolved);
    return open ? { focus: () => firstControlIn(open.scope)?.focus() } : null;
  }

  // Server errors of fields without an Alpine error state (radio group, checkbox select, ...). The
  // error block follows the field, or sits inside its fieldset. The error is dropped as soon as the
  // user changes the field. The error block of the form itself is not a field error.
  function findStaticErrors(form, roots) {
    return [...form.querySelectorAll('[role="alert"]')].flatMap((alert) => {
      if (alert.parentElement === form || roots.some((root) => root.el.contains(alert))) return [];
      const previous = alert.previousElementSibling;
      const scope =
        previous && previous.querySelector('input, select, textarea, button') ? previous : alert.closest('fieldset');
      return scope && scope !== form ? [{ alert, scope, resolved: false }] : [];
    });
  }

  function syncSubmit(state) {
    const blocked = firstProblem(state) !== null;
    state.form.querySelectorAll('button[type="submit"], input[type="submit"]').forEach((button) => {
      if (blocked) {
        button.setAttribute('aria-disabled', 'true');
        if (!button.hasAttribute('data-validation-blocked')) {
          button.setAttribute('data-validation-blocked', '');
          button.classList.add('opacity-50', 'cursor-not-allowed');
        }
      } else if (button.hasAttribute('data-validation-blocked')) {
        button.removeAttribute('aria-disabled');
        button.removeAttribute('data-validation-blocked');
        button.classList.remove('opacity-50', 'cursor-not-allowed');
      }
    });
  }

  function schedule(state) {
    if (state.scheduled) return;
    state.scheduled = true;
    queueMicrotask(() => {
      state.scheduled = false;
      if (state.mode === 'submit') syncSubmit(state);
      else render(state, false);
    });
  }

  // Both modes read the same field states. A form with a summary (`summary` set) lists them,
  // a form with submit validation (`summary` null) disables its submit button.
  function setup(form, summary) {
    if (!form || states.has(form)) return;
    const seeds = summary ? readSeeds(summary) : [];
    const roots = findRoots(form, summary, seeds);
    const state = {
      mode: summary ? 'summary' : 'submit',
      summary,
      form,
      seeds,
      roots,
      statics: summary ? [] : findStaticErrors(form, roots),
      visible: !!summary && !summary.hidden,
      scheduled: false,
      signature: ''
    };
    state.signature = signature(
      seeds.map((s) => ({ id: s.id, label: s.label, message: s.message, formLevel: s.formLevel }))
    );
    states.set(form, state);

    // Fields without an Alpine error state (radio group, checkbox select, ...) behave like an
    // input: the server error is dropped as soon as the user changes the field.
    seeds.forEach((seed) => {
      if (seed.root || seed.formLevel) return;
      const target = findTarget(seed.id);
      const scope = target && (target.closest('fieldset, [x-data]') || target.parentElement);
      if (!scope) return;
      const resolve = () => {
        seed.resolved = true;
        schedule(state);
      };
      scope.addEventListener('change', resolve);
      scope.addEventListener('input', resolve);
    });
    state.statics.forEach((item) => {
      const resolve = () => {
        item.resolved = true;
        schedule(state);
      };
      item.scope.addEventListener('change', resolve);
      item.scope.addEventListener('input', resolve);
    });
    roots.forEach((root) => {
      Alpine.effect(() => {
        // Reading these makes the effect re-run when the field changes its error state
        void root.data.hasError;
        void root.data.hasServerError;
        void root.data.errorMessage;
        root.channels.forEach((channel) => channel.problem());
        schedule(state);
      });
    });
  }

  document.addEventListener('alpine:initialized', () => {
    document.querySelectorAll('[data-error-summary]').forEach((summary) => setup(summary.closest('form'), summary));
    document.querySelectorAll('form[data-validation="submit"]').forEach((form) => setup(form, null));
  });

  // Submit gate: a form with a summary is not posted while a live field has a client-side error,
  // a form with submit validation while any field has an error. With a summary, server errors never
  // block, so a form can always be sent again. Click and Enter both end up here. It runs in the
  // capture phase so that handlers on the form (tracking, ...) do not see an attempt that is not
  // posted.
  document.addEventListener(
    'submit',
    (event) => {
      const state = states.get(event.target);
      if (!state) return;
      state.roots.forEach((root) => {
        const { data, control } = root;
        if (typeof data.validate !== 'function' || !control) return;
        // An optional field that is empty has nothing to check
        if (control.value === '' && !control.required) return;
        data.validate();
        if (data.hasError && 'isTouched' in data) data.isTouched = true;
      });
      if (state.mode === 'submit') {
        const problem = firstProblem(state);
        syncSubmit(state);
        if (!problem) return;
        event.preventDefault();
        event.stopPropagation();
        // There is no summary: take the user to the first field with an error
        problem.focus();
        return;
      }
      if (!state.roots.some((root) => root.data.hasError)) return;
      event.preventDefault();
      event.stopPropagation();
      state.visible = true;
      render(state, true);
      state.summary.focus();
    },
    true
  );

  // Links created on the client are handled here. Links of the server render also have their own handler.
  document.addEventListener('click', (event) => {
    const link = event.target instanceof Element && event.target.closest('a');
    const summary = link && link.closest('[data-error-summary]');
    if (!summary || !link.hash) return;
    event.preventDefault();
    resolveControl(link.hash.slice(1))?.focus();
  });

  // After a failed POST the page reloads with the summary rendered. Focus it, so a screen reader
  // announces the whole list. Only the first visible summary is focused, and never one inside a
  // dialog or banner, which manage their own focus. Never on keystroke or blur.
  document.addEventListener('DOMContentLoaded', () => {
    const summary = [...document.querySelectorAll('[data-error-summary]')].find(
      (s) => !s.hidden && !s.closest('[role="dialog"], [aria-modal="true"], dialog')
    );
    summary?.focus();
  });
}
