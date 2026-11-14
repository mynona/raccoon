// Preview app only. A language switch is remembered in a cookie and the page is rendered again,
// because demo content (HTML, markdown) can only be translated on the server.

(function () {
  var first = document.documentElement.lang;
  new MutationObserver(function () {
    var l = document.documentElement.lang;
    if (l === first) return;
    document.cookie = 'preview-lang=' + l + '; path=/; max-age=31536000';
    var u = new URL(location.href);
    u.searchParams.delete('lang');
    location.replace(u.toString());
  }).observe(document.documentElement, {
    attributes: true,
    attributeFilter: ['lang'],
  });
})();
