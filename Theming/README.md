# Theming & Client-Side Configuration for Raccoon

This directory provides the complete configuration and build setup for compiling **Tailwind CSS v4** stylesheets and bundling **Alpine.js** for applications using the **Raccoon** UI component library.

---

## Architecture Overview

Raccoon components are decoupled from pre-compiled CSS and monolithic JavaScript bundles:
- **Semantic Utility Classes**: Components output standard Tailwind CSS utility classes and semantic design tokens (such as `bg-primary`, `text-on-surface`, `focus-within:ring-focusring`).
- **Interactive UI with Alpine.js**: Components use declarative Alpine.js directives (`x-data`, `x-bind`, `x-trap`, etc.) for client-side interactions, keyboard navigation, and accessibility.
- **Build-Time Scanning**: Tailwind CSS v4 scans your Swift source files (and Raccoon package checkouts) via the `@source` directive to generate a lean, purged stylesheet containing only the classes your project actually uses.

> **Note**: This repository does not build or run Node.js code itself. This directory serves as the template and configuration standard for consuming applications (e.g., your Vapor / Hummingbird web app).

---

## Serving Assets in Consumer Applications

If your application uses the built-in themes (`raumnebenan`, `black-and-white`, or `beacon-blue`), **you do not need to build CSS or JavaScript from scratch**.

Raccoon ships with pre-rendered, production-ready assets in its [`Public/`](../Public) folder:
- **`Public/css/raccoon-min.css`**: Pre-rendered Tailwind CSS v4 stylesheet covering all 57 Raccoon components and all predefined themes (including dark mode).
- **`Public/js/bundle-min.js`**: Pre-bundled Alpine.js runtime including the required `@alpinejs/focus`, `@alpinejs/sort`, and `@alpinejs/ui` plugins.
- **`Public/js/*.js`**: Standalone component scripts (e.g. `agentic-mermaid-component-lazy.js`, `dropdown.js`, `datepicker.js`, `simple-menu.js`, `modal.js`).

### Consumer App Asset Delivery Requirement

Your consumer web application **must serve these CSS and JS files** at the paths expected by the components and browser:

1. **Static File Serving**: In Vapor, ensure `FileMiddleware` is registered in `configure.swift`:
   ```swift
   app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
   ```
2. **Asset Placement**: Copy, symlink, or deploy the contents of `Public/css/` and `Public/js/` into your consumer application's public root (`Public/css/` and `Public/js/`).
3. **HTML Document Inclusions**: Ensure your base HTML layout includes:
   ```html
   <!-- Pre-rendered Tailwind CSS for defined themes -->
   <link rel="stylesheet" href="/css/raccoon-min.css">

   <!-- Pre-rendered Alpine.js bundle with required plugins -->
   <script defer src="/js/bundle-min.js"></script>
   ```

Use the build workflow in this `Theming` directory only when you need to **customize** design tokens, change theme palettes, add custom utilities, or scan custom application templates.

---

## Files in this Directory

| File | Description |
|---|---|
| [package.json](./package.json) | NPM configuration declaring Tailwind CSS v4, Alpine.js, required plugins, and build scripts. |
| [index.js](./index.js) | Alpine.js entrypoint registering mandatory accessibility and UI plugins, and exposing `window.Alpine`. |
| [postcss.config.js](./postcss.config.js) | PostCSS configuration loading `@tailwindcss/postcss`. |
| [src/input.css](./src/input.css) | Core stylesheet defining `@theme` tokens, dark mode variants, color scales, and custom components. |
| [theme-values.md](./theme-values.md) | Comprehensive dictionary of all semantic color tokens and their mappings across Raccoon components. |
| [.stylelintrc.json](./.stylelintrc.json) | Stylelint configuration for linting custom CSS. |

---

## Required Plugins (Do Not Remove)

When customizing this setup for your project, **keep the following plugins enabled**. Core Raccoon components rely on them for layout formatting, form controls, and accessible keyboard interactions.

### Tailwind CSS Plugins (`package.json` & `src/input.css`)
- **`@tailwindcss/typography`** (`@plugin '@tailwindcss/typography';`):
  Required for rich text and documentation rendering in `MarkdownBlock`, `KeyTakeaways`, and article templates.
- **`@tailwindcss/forms`** (`@plugin '@tailwindcss/forms';`):
  Required for cross-browser reset and styling of standard form controls (`InputField`, `TextAreaField`, `SingleSelect`, `Check`, `CheckboxSelect`, `PasswordInput`).

### Alpine.js Plugins (`package.json` & `index.js`)
- **`@alpinejs/focus`** (`Alpine.plugin(focus);`):
  Required for accessible focus trapping (`x-trap`) and focus restoration in dialogs, menus, and overlays (`DeleteModal`, `SimpleMenu`, `Dropdown`, `DatePicker`).
- **`@alpinejs/sort`** (`Alpine.plugin(sort);`):
  Required for interactive drag-and-drop sorting lists.
- **`@alpinejs/ui`** (`Alpine.plugin(ui);`):
  Required for accessible headless UI components and list controls.

---

## How to Set Up in Your Project

### 1. Copy or Reference Configuration

Copy the files from this `Theming` folder into your project's frontend or assets directory (e.g., `frontend/` or `Theming/`).

### 2. Configure Swift Source Scanning (`src/input.css`)

In [src/input.css](./src/input.css), locate the `@source` directive:

```css
/* Content sources: Scan Swift files for class detection */
@source '/link/to/your/sourcecode/';
```

Replace `/link/to/your/sourcecode/` with the relative path to your Swift application code **and** the Raccoon package source files (where `*Styles.swift` live):

```css
/* 1. Your application Swift code */
@source '../Sources/**/*.swift';

/* 2. Raccoon package source files (required to scan Raccoon component styles) */
/* When using SwiftPM CLI / Vapor: */
@source '../.build/checkouts/raccoon/**/*.swift';

/* When developing with Xcode: */
@source '~/Library/Developer/Xcode/DerivedData/**/SourcePackages/checkouts/raccoon/**/*.swift';

/* When using a local package path: */
@source '../../raccoon/**/*.swift';
```

Tailwind CSS v4 will scan all Swift files in these directories for utility classes used in `*Styles.swift` and component templates.

### 3. Install Dependencies

In the folder containing `package.json`, install dependencies:

```bash
npm install
```

### 4. Build Styles and Scripts

Compile production-ready minified bundles:

```bash
npm run build
```

This compiles:
- `src/input.css` into minified CSS (`./dist/css/raccoon.min.css` by default)
- `index.js` (Alpine + plugins) into a minified bundle (`./dist/js/bundle.min.js`)

For local development with auto-rebuild on file changes:

```bash
npm run dev
```

Adjust the output paths in the `scripts` section of `package.json` to match your web framework's public assets folder (e.g. `../Public/css/` and `../Public/js/`).

---

## Customizing Themes to Your Needs

You can completely rebrand and customize your application's appearance while maintaining full compatibility with Raccoon components.

### 1. Semantic Color Tokens

Raccoon maps all component styles through semantic design tokens defined in [src/input.css](./src/input.css) under `@theme`.

To change your brand appearance, edit the semantic tokens in [src/input.css](./src/input.css):

```css
@theme {
  /* Customize Primary Action Button colors */
  --color-primary: #0284c7;           /* Sky 600 */
  --color-on-primary: #ffffff;

  /* Customize Surfaces */
  --color-surface: #ffffff;
  --color-surface-dark: #0f172a;
  --color-on-surface: #0f172a;

  /* Customize Focus & Hover Rings */
  --color-focusring: #0284c7;
  --color-hoverring: #0369a1;

  /* Brand Accent */
  --color-on-theme: #0284c7;
}
```

See [theme-values.md](./theme-values.md) for the complete reference of all semantic color tokens used across the components.

### 2. Dark Mode Customization

Dark mode is activated when the `.dark` class is present on `<html>` or `<body>`:

```css
@custom-variant dark (&:where(.dark, .dark *));
```

To adjust how components appear in dark mode, customize the variable overrides in the `.dark` block inside `@layer base` in [src/input.css](./src/input.css):

```css
@layer base {
  .dark {
    --color-surface: #0f172a;
    --color-surface-dark: #020617;
    --color-on-surface: #f8fafc;
    --color-primary: #38bdf8;
    --color-on-primary: #0f172a;
    --color-focusring: #38bdf8;
  }
}
```

### 3. Multiple Theme Variants

You can define multiple themes using CSS attribute selectors (such as `[data-theme="your-theme"]`). For example, [src/input.css](./src/input.css) includes pre-configured theme variants:
- **Default** (emerald/green brand)
- **`[data-theme="black-and-white"]`** (high-contrast monochrome)
- **`[data-theme="beacon-blue"]`** (navy ink, clean paper, warm beacon-orange highlights)

Add your own custom theme following this pattern:

```css
@layer base {
  [data-theme="my-brand"] {
    --color-surface: #fdfbf7;
    --color-on-surface: #1c1917;
    --color-primary: #7c3aed;
    --color-on-primary: #ffffff;
    --color-focusring: #7c3aed;
    --color-on-theme: #7c3aed;
  }

  [data-theme="my-brand"].dark {
    --color-surface: #1c1917;
    --color-on-surface: #fdfbf7;
    --color-primary: #a78bfa;
    --color-on-primary: #1c1917;
    --color-focusring: #a78bfa;
    --color-on-theme: #a78bfa;
  }
}
```

### 4. Customizing Typography & Breakpoints

In [src/input.css](./src/input.css) under `@theme`, you can override fonts and responsive breakpoints:

```css
@theme {
  /* Custom Font Families */
  --font-sans: 'Inter', system-ui, -apple-system, sans-serif;
  --font-serif: 'Merriweather', Georgia, serif;
  --font-mono: 'SFMono-Regular', Menlo, Monaco, Consolas, monospace;

  /* Custom Breakpoints */
  --breakpoint-sm: 640px;
  --breakpoint-md: 768px;
  --breakpoint-lg: 1024px;
  --breakpoint-xl: 1280px;
}
```

---

## Special Note: Theming Mermaid Diagrams

The `Mermaid` component renders diagrams client-side into SVGs using `agentic-mermaid` and Alpine.js (loaded via `/js/agentic-mermaid-component-lazy.js`).

Because Mermaid calculates SVG node fills, stroke colors, and font styles directly during client-side rendering, **Mermaid theme values must be set in the JavaScript file** (`agentic-mermaid-component-lazy.js`) rather than exclusively through CSS classes.

To style Mermaid diagrams for your brand, update the `THEME_PALETTES` dictionary in `agentic-mermaid-component-lazy.js` with your theme's colors (`bg`, `fg`, `accent`, `line`, `muted`, `surface`, `border`) and font settings for both `light` and `dark` modes:

```javascript
const THEME_PALETTES = {
  "my-brand": {
    light: {
      colors: {
        bg: "#ffffff",
        fg: "#1e293b",
        accent: "#0284c7",
        line: "#0284c7",
        muted: "#64748b",
        surface: "#f8fafc",
        border: "#cbd5e1",
      },
      font: "Inter, sans-serif",
      stroke: "crisp",
      strokeWidth: 1,
    },
    dark: {
      colors: {
        bg: "#0f172a",
        fg: "#f8fafc",
        accent: "#38bdf8",
        line: "#38bdf8",
        muted: "#94a3b8",
        surface: "#1e293b",
        border: "#334155",
      },
      font: "Inter, sans-serif",
      stroke: "crisp",
      strokeWidth: 1,
    },
  },
};
```

