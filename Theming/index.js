/**
 * Alpine.js Bundle Configuration
 * 
 * This file initializes Alpine.js with the required plugins and makes it
 * globally available. The bundled output is used by Raccoon components
 * (such as SimpleMenu, Dropdown, DeleteModal, TablePaginator, etc.).
 * 
 * DO NOT remove the plugins below (@alpinejs/focus, @alpinejs/sort, @alpinejs/ui)
 * as core Raccoon components rely on them for accessible keyboard navigation,
 * focus trapping, list sorting, and UI controls.
 */

// Import Alpine.js core
import Alpine from 'alpinejs';

// Import required Alpine.js plugins
import focus from '@alpinejs/focus';
import sort from '@alpinejs/sort';
import ui from '@alpinejs/ui';

// Register plugins with Alpine
Alpine.plugin(focus);
Alpine.plugin(sort);
Alpine.plugin(ui);

// Make Alpine globally available for inline scripts and components
window.Alpine = Alpine;

// Initialize Alpine and start component discovery
Alpine.start();
