// V1.0

/* Alpine component: live search across tags/pages/images/documents/articles, with Matomo tracking. */

// Guard against double registration if the script is included twice
if (!window.__searchViewLoaded) {
  window.__searchViewLoaded = true;

  function searchItemsCount(collection) {
    if (typeof collection?.count === 'number') return collection.count;
    if (typeof collection?.total === 'number') return collection.total;
    if (Array.isArray(collection?.items)) return collection.items.length;
    if (Array.isArray(collection)) return collection.length;
    return 0;
  }

  function searchItems(collection) {
    if (Array.isArray(collection)) return collection;
    return Array.isArray(collection?.items) ? collection.items : [];
  }

  function emptySearchCollection() {
    return { count: 0, total: 0, items: [] };
  }

  function searchCollectionHasItems(collection) {
    return searchItemsCount(collection) > 0;
  }

  function relativeCallerPage(url) {
    return `${url.pathname}${url.search}${url.hash}`;
  }

  function persistCallerPage() {
    try {
      const referrer = document.referrer;

      if (!referrer) {
        return;
      }

      const referrerUrl = new URL(referrer, window.location.origin);
      const currentUrl = new URL(window.location.href);
      const isSameOrigin = referrerUrl.origin === currentUrl.origin;
      const isSearchPage = referrerUrl.pathname.startsWith('/search');

      // Only remember same-origin, non-search referrers, for returnToCallerPage()
      if (isSameOrigin && !isSearchPage) {
        localStorage.setItem('callerPage', relativeCallerPage(referrerUrl));
      }
    } catch {
      // Ignore storage and URL parsing failures.
    }
  }

  const registerSearchView = () => {
    Alpine.data('searchView', (config = {}) => {
      const fallbackConfig = window.searchPageConfig ?? {};
      const cfg = config && typeof config === 'object' && Object.keys(config).length > 0 ? config : fallbackConfig;
      const rawEndpoint = cfg.searchEndpoint ?? '/search/';
      const searchEndpoint = rawEndpoint.includes('?') || rawEndpoint.endsWith('/')
        ? rawEndpoint
        : `${rawEndpoint}/`;
      const initialSearchTerm = cfg.searchTerm ?? '';
      const isMatomoEnabled = cfg.isMatomoEnabled ?? false;

      return {
        searchEndpoint,
        searchTerm: initialSearchTerm,
        isLoading: false,
        hasConnectionError: false,
        isMatomoEnabled,
        tags: emptySearchCollection(),
        pages: emptySearchCollection(),
        images: emptySearchCollection(),
        documents: emptySearchCollection(),
        articles: emptySearchCollection(),
        glossary: emptySearchCollection(),
        articleItems: emptySearchCollection(),

        showArticles() {
          return searchCollectionHasItems(this.articles);
        },

        showPages() {
          return searchCollectionHasItems(this.pages);
        },

        showDocuments() {
          return searchCollectionHasItems(this.documents);
        },

        showImages() {
          return searchCollectionHasItems(this.images);
        },

        showTags() {
          return searchCollectionHasItems(this.tags);
        },

        showGlossary() {
          return searchCollectionHasItems(this.glossary);
        },

        showArticleItems() {
          return searchCollectionHasItems(this.articleItems);
        },

        showClearSearchButton() {
          return this.searchTerm.length > 0;
        },

        get noResultsFound() {
          if (this.searchTerm.length <= 2) {
            return false;
          }

          return !(
            searchItems(this.pages).length ||
            searchItems(this.articles).length ||
            searchItems(this.images).length ||
            searchItems(this.documents).length ||
            searchItems(this.tags).length ||
            searchItems(this.glossary).length ||
            searchItems(this.articleItems).length
          );
        },

        isNoResultsFound() {
          return this.noResultsFound;
        },

        clearSearch() {
          this.searchTerm = '';
          this.resetResults();
          this.hasConnectionError = false;
          this.$nextTick(() => {
            this.$refs.searchInput?.click();
            this.$refs.searchInput?.focus();
          });
        },

        resetResults() {
          this.pages = emptySearchCollection();
          this.articles = emptySearchCollection();
          this.documents = emptySearchCollection();
          this.tags = emptySearchCollection();
          this.images = emptySearchCollection();
          this.glossary = emptySearchCollection();
          this.articleItems = emptySearchCollection();
        },

        // Assigns a result collection from the response, or clears it if missing
        assignCollection(data, key) {
          const collection = data?.[key];

          if (!collection) {
            this[key] = emptySearchCollection();
            return 0;
          }

          this[key] = collection;
          return searchItemsCount(collection);
        },

        // Fetches search results for the current term and reports the count to Matomo
        getData() {
          if (this.searchTerm.length <= 2) {
            this.resetResults();
            this.hasConnectionError = false;
            return;
          }

          this.isLoading = true;
          this.hasConnectionError = false;
          const baseUri = this.searchEndpoint;
          const separator = baseUri.includes('?') ? '&' : '?';
          const uri = `${baseUri}${separator}q=${encodeURIComponent(this.searchTerm)}`;

          fetch(uri, { method: 'POST' })
            .then((res) => {
              if (!res.ok) {
                throw new Error(`HTTP error ${res.status}`);
              }
              return res.json();
            })
            .then((data) => {
              let itemsFound = 0;

              itemsFound += this.assignCollection(data, 'tags');
              itemsFound += this.assignCollection(data, 'pages');
              itemsFound += this.assignCollection(data, 'images');
              itemsFound += this.assignCollection(data, 'documents');
              itemsFound += this.assignCollection(data, 'articles');
              itemsFound += this.assignCollection(data, 'glossary');
              itemsFound += this.assignCollection(data, 'articleItems');

              this.isLoading = false;

              if (this.isMatomoEnabled === true && typeof window._paq !== 'undefined') {
                window._paq.push(['trackSiteSearch', this.searchTerm, false, itemsFound]);
              }
            })
            .catch((error) => {
              this.isLoading = false;
              this.hasConnectionError = true;
              console.log('Connection error', error);
            });
        },

        init() {
          persistCallerPage();
        }
      };
    });
  };

  if (window.Alpine) {
    registerSearchView();
  } else {
    document.addEventListener('alpine:init', registerSearchView);
  }
}