// V1.0

/* Alpine component: glossary search. Terms are lowercase, the query is trimmed and lowercased. */

// Guard against double registration if the script is included twice
if (!window.__glossaryLoaded) {
  window.__glossaryLoaded = true;

  document.addEventListener('alpine:init', () => {
    Alpine.data('glossarySearch', (terms = []) => ({
      search: '',
      terms,

      get query() {
        return this.search.trim().toLowerCase();
      },

      matchesTerm(term) {
        return !this.query || term.includes(this.query);
      },

      matchesAnyTerm(list) {
        return !this.query || list.some((term) => term.includes(this.query));
      },

      get noResults() {
        return this.query.length > 0 && !this.matchesAnyTerm(this.terms);
      },
    }));
  });
}
