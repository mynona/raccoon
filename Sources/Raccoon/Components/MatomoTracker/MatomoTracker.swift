import HTML
import SGML
import WebBuilders

/// MatomoTracker
///
/// Emits the Matomo tracker script (external, configured by `data-*` attributes),
/// the form-tracking script and the no-JavaScript
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

    private func scriptAttributes() -> [(name: String, value: String)] {
        var attributes: [(name: String, value: String)] = [
            ("data-tracker-url", data.trackerUrl),
            ("data-site-id", data.siteId),
            ("data-consent", data.status == .BANNER ? "banner" : "accepted"),
            (
                "data-page-type",
                data.pageType == .trackPageView ? "page-view" : "site-search"
            ),
        ]
        switch data.userState {
        case .none:
            break
        case .signedIn(let userID):
            attributes.append(("data-user-state", "signed-in"))
            attributes.append(("data-user-id", userID))
        case .signedOut:
            attributes.append(("data-user-state", "signed-out"))
        }
        return attributes
    }

    /// The tracker is an external script configured by `data-*` attributes, so the page needs no inline script.
    private func trackerScript() -> Script {
        var script = Script().src("/js/matomo-tracker.js")
            .setAttribute(name: "type", value: "text/javascript")
        for attribute in scriptAttributes() {
            // The HTML renderer does not escape attribute values
            script = script.setAttribute(
                name: attribute.name,
                value: JavaScriptEscaper.htmlAttributeEscape(attribute.value)
            )
        }
        return script
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

            trackerScript()

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
