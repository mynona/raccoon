import HTML
import SGML
import WebBuilders

/// MatomoTracker
///
/// Emits the Matomo `<script>`, the form-tracking script and the no-JavaScript
/// fallback pixel. Renders nothing unless the status is `.ACCEPTED` or `.BANNER`.
///
public struct MatomoTracker: TemplateRepresentable {
    let data: MatomoTrackerData

    public init(
        _ data: MatomoTrackerData
    ) {
        self.data = data
    }

    var isEnabled: Bool {
        data.status == .ACCEPTED || data.status == .BANNER
    }

    private func userDimension() -> String {
        switch data.userState {
        case .none:
            return ""
        case .signedIn(let userID):
            return """
                _paq.push(['setUserId', '\(userID)']);
                _paq.push(['setCustomDimension', 1, 'signed-in']);
                """
        case .signedOut:
            return "_paq.push(['setCustomDimension', 1, 'not-signed-in']);"
        }
    }

    private func cookieDimension() -> String {
        // Cookie-less tracking with reduced heart beat time to avoid race conditions
        if data.status == .BANNER {
            return """
                _paq.push(['disableCookies']);
                _paq.push(['enableHeartBeatTimer', 15, 30]);
                """
        }
        return "_paq.push(['enableHeartBeatTimer', 5, 10]);"
    }

    private func trackerType() -> String {
        data.pageType == .trackPageView
            ? "_paq.push(['trackPageView']);"
            : "_paq.push(['trackSiteSearch','',false,false]);"
    }

    func generateTrackingCode() -> String {
        """
        var _paq = window._paq = window._paq || [];
        _paq.push(["setExcludedQueryParams", ["[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}"]]);
        \(userDimension())
        _paq.push(['setCustomDimension', 3, 'js']);
        \(cookieDimension())
        _paq.push(['appendToTrackingUrl', 'recMode=2']);
        \(trackerType())
        _paq.push(['trackVisibleContentImpressions']);
        _paq.push(['enableLinkTracking']);
        (function() {
          var u="\(data.trackerUrl)";
          _paq.push(['setTrackerUrl', u+'matomo.php']);
          _paq.push(['setSiteId', '\(data.siteId)']);
          var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
          g.async=true; g.src=u+'matomo.js'; s.parentNode.insertBefore(g,s);
        })();
        """
    }

    func noScriptPixelUrl() -> String {
        let base =
            "\(data.trackerUrl)matomo.php?idsite=\(data.siteId)&amp;rec=1"
        guard let canonicalPath = data.canonicalPath else {
            return
                "\(base)&dimension1=not-signed-in&dimension3=noscript&url=\(data.siteBaseUrl)"
        }
        return
            "\(base)&recMode=2&dimension1=not-signed-in&dimension3=noscript&url=\(data.siteBaseUrl)\(canonicalPath)"
    }

    @Builder<Element>
    public func render() -> [Element] {

        if isEnabled {

            Script(generateTrackingCode())
                .setAttribute(
                    name: "type",
                    value: "text/javascript"
                )

            // Matomo form tracking
            Script()
                .src("/js/formtracking.js")
                .setAttribute(
                    name: "type",
                    value: "text/javascript"
                )
                .flagAttribute("defer")

            // Track user with deactivated JavaScript
            Noscript {
                P {
                    Img(src: noScriptPixelUrl(), alt: "")
                        .style("border:0;")
                        .setAttribute(
                            name: "referrerpolicy",
                            value: "no-referrer-when-downgrade"
                        )
                }
            }
        }
    }
}
