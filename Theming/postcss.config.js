/**
 * PostCSS Configuration
 * 
 * PostCSS is a JavaScript plugin ecosystem for CSS transformations.
 * This config file tells PostCSS which plugins to load and how to configure them.
 * 
 * Tailwind CSS v4 uses @tailwindcss/postcss plugin to:
 * - Process @import 'tailwindcss' and directives in src/input.css
 * - Generate utility classes based on configuration
 * - Scan template files for class usage
 * - Output the final CSS built for production
 * 
 * When @tailwindcss/cli runs, it uses this PostCSS config automatically.
 */

export default {
  plugins: {
    // Tailwind CSS PostCSS plugin - processes Tailwind directives and generates CSS
    '@tailwindcss/postcss': {},
  },
};
