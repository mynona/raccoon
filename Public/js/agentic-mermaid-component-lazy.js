// V0.4.2

/* Alpine component: renders Mermaid diagrams via the lazy-loaded agentic-mermaid ESM bundle (async per-family chunks instead of the 2.9MB classic bundle), re-rendering on theme changes. */

// Guard against double registration if the script is included twice
if (!window.__beautifulMermaidComponentLoaded) {
  window.__beautifulMermaidComponentLoaded = true;

  // Starts fetching the small lazy entry once; family chunks are fetched on first use and cached by the browser
  const rendererPromise = import(
    "https://unpkg.com/agentic-mermaid@0.5.4/dist/browser-lazy/index.js"
  );

  const DEBUG = false;
  function log(...args) {
    if (DEBUG) console.debug("[beautiful-mermaid-lazy]", ...args);
  }

  // Theme token palettes matching Raccoon AppTheme and raccoon-min.css
  const THEME_PALETTES = {
    "emerald-mine": {
      dark: {
        colors: {
          bg: "#0a251d", // --color-emerald-mine-theme-950
          fg: "#a3a3a3", // --color-gray-400
          accent: "#40CDA0", // --color-emerald-mine-theme-500
          line: "#40CDA0", // --color-emerald-mine-theme-500
          muted: "#a3a3a3", // --color-gray-400
          surface: "#114132", // --color-emerald-mine-theme-900
          border: "#a3a3a3", // --color-gray-400
        },
        font: "IBM Plex Sans, sans-serif",
        stroke: "crisp",
        strokeWidth: 1,
      },
      light: {
        colors: {
          bg: "#ffffff",
          fg: "#114132", // --color-emerald-mine-theme-900
          accent: "#40CDA0", // --color-emerald-mine-theme-500
          line: "#40CDA0", // --color-emerald-mine-theme-500
          muted: "#114132", // --color-emerald-mine-theme-900
          surface: "#ffffff",
          border: "#114132", // --color-emerald-mine-theme-900
        },
        font: "IBM Plex Sans, sans-serif",
        stroke: "crisp",
        strokeWidth: 1,
      },
    },

    "black-and-white": {
      dark: {
        colors: {
          bg: "#0a0a0a", // --color-gray-950
          fg: "#ffffff", // --color-white
          accent: "#ffffff",
          line: "#ffffff",
          muted: "#a3a3a3", // --color-gray-400
          surface: "#171717", // --color-gray-900
          border: "#a3a3a3",
        },
        font: "IBM Plex Sans, sans-serif",
        stroke: "crisp",
        strokeWidth: 1,
      },
      light: {
        colors: {
          bg: "#ffffff",
          fg: "#0a0a0a", // --color-gray-950
          accent: "#0a0a0a",
          line: "#0a0a0a",
          muted: "#525252", // --color-gray-600
          surface: "#ffffff",
          border: "#0a0a0a",
        },
        font: "IBM Plex Sans, sans-serif",
        stroke: "crisp",
        strokeWidth: 1,
      },
    },

    "beacon-blue": {
      dark: {
        colors: {
          bg: "#141a33", // --color-beacon-blue-dark-900
          fg: "#dde1ee", // --color-beacon-blue-dark-100
          accent: "#86a6ff", // --color-beacon-blue-accent-light
          line: "#86a6ff",
          muted: "#9f9f98", // --color-beacon-blue-400
          surface: "#1f2542", // --color-beacon-blue-dark-800
          border: "#2a3150", // --color-beacon-blue-dark-700
        },
        font: "IBM Plex Sans, sans-serif",
        stroke: "crisp",
        strokeWidth: 1,
      },
      light: {
        colors: {
          bg: "#f9f9f7", // --color-beacon-blue-50
          fg: "#141b34", // --color-beacon-blue-800
          accent: "#1f4bb0", // --color-beacon-blue-accent
          line: "#1f4bb0",
          muted: "#5b6075", // --color-beacon-blue-500
          surface: "#ffffff",
          border: "#464c63", // --color-beacon-blue-600
        },
        font: "IBM Plex Sans, sans-serif",
        stroke: "crisp",
        strokeWidth: 1,
      },
    },
  };

  const registerComponent = () => {
    Alpine.data("beautifulMermaidComponent", () => ({
      code: "",
      target: null,
      themeObserver: null,
      generation: 0,

      // Color/style config for the diagram, switching palette based on the active theme and dark/light mode
      get config() {
        const isDark = document.documentElement.classList.contains("dark");
        const theme = document.documentElement.getAttribute("data-theme") || "raumnebenan";
        const themePalette = THEME_PALETTES[theme] || THEME_PALETTES.raumnebenan;
        const palette = isDark ? themePalette.dark : themePalette.light;

        const style = isDark
          ? ["zinc-dark", palette]
          : ["zinc-light", palette];

        log("config() → theme:", theme, "dark?:", isDark);
        log("config() → style stack:", style);

        return {
          style,
          security: "strict",
        };
      },

      // Parses the Mermaid code into an SVG and swaps it into the target element
      async render() {
        // Guards against a slower earlier render overwriting a later one when the theme toggles rapidly
        const generation = ++this.generation;
        try {
          const { renderMermaidSVGAsync } = await rendererPromise;
          const cfg = this.config;
          const svg = await renderMermaidSVGAsync(this.code, cfg);

          if (generation !== this.generation) return;
          if (!this.target) return;

          const parsed = new DOMParser().parseFromString(svg, "image/svg+xml");
          const root = parsed.documentElement;

          if (root.localName !== "svg") return;

          this.target.replaceChildren(
            document.importNode(root, true)
          );
        } catch (err) {
          console.error("BeautifulMermaid lazy render error:", err);
        }
      },

      init() {
        const source = this.$el.querySelector(".mermaid-source");
        this.target = this.$el.querySelector(".mermaid-target");

        if (!source || !this.target) return;

        this.code = source.textContent.trim();
        this.render();

        // Re-render whenever the page's dark/light theme changes
        this.themeObserver = new MutationObserver(() => {
          this.render();
        });
        this.themeObserver.observe(document.documentElement, {
          attributes: true,
          attributeFilter: ["class", "data-theme"],
        });
      },

      // Disconnect observer on component teardown to prevent leaks
      destroy() {
        if (this.themeObserver) {
          this.themeObserver.disconnect();
          this.themeObserver = null;
        }
      },
    }));
  };

  if (window.Alpine) {
    registerComponent();
  } else {
    document.addEventListener("alpine:init", registerComponent);
  }
}
