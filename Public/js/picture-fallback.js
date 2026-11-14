// V1.0

/* Fallback for <picture> images: if the image fails to load with the avif/webp <source> elements,
 * the sources are removed so the browser falls back to the plain <img src>.
 * One capturing listener for the whole page (the "error" event does not bubble), so the markup needs no
 * inline onerror attribute. */

// Guard against double registration if the script is included twice
if (!window.__pictureFallbackLoaded) {
  window.__pictureFallbackLoaded = true;

  document.addEventListener(
    'error',
    (event) => {
      const image = event.target;
      if (!(image instanceof HTMLImageElement)) return;
      const picture = image.closest('picture');
      if (picture) picture.querySelectorAll('source').forEach((source) => source.remove());
    },
    true
  );
}
