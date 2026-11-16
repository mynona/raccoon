// Redirects to the page the visitor came from (stored by the layouts as localStorage "callerPage").
(function () {
  const callerPage = localStorage.getItem("callerPage") || "/home/";
  window.location.href = callerPage;
})();
