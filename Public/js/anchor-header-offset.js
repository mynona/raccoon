// V1.0

/* Anchor links (href="#id") scroll smoothly and leave room for the fixed header. */

// Guard against double registration if the script is included twice
if (!window.__anchorHeaderOffsetLoaded) {
  window.__anchorHeaderOffsetLoaded = true;

  document.addEventListener('DOMContentLoaded', () => {
    const header = document.querySelector('header');
    const headerHeight = header ? header.offsetHeight + 5 : 0;

    document.querySelectorAll('a[href^="#"]').forEach((anchor) => {
      anchor.addEventListener('click', function (event) {
        const target = document.querySelector(this.getAttribute('href'));
        if (!target) return;
        event.preventDefault();

        window.scrollTo({
          top: target.getBoundingClientRect().top - headerHeight + window.pageYOffset,
          behavior: 'smooth',
        });
      });
    });
  });
}
