import Foundation
import HTML
import SGML
import WebBuilders

/// MatomoTracker
///
/// Emits the Matomo tracker script (external, configured by `data-*` attributes). Renders nothing unless the
/// status is `.ACCEPTED` or `.BANNER`. It is the only Matomo script: page views, content clicks, forms and the
/// events of the widgets (`raccoon:track`) are all reported by it, and without it nothing is tracked.
///
/// There is no `<noscript>` pixel: it was only requested by crawlers that do not run JavaScript.
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
        if !data.customDimensions.isEmpty {
            attributes.append(("data-dimensions", dimensionsJSON()))
        }
        if !data.events.isEmpty {
            attributes.append(("data-events", eventsJSON()))
        }
        if data.resetsUser {
            attributes.append(("data-reset-user", "true"))
        }
        return attributes
    }

    private func json(_ value: some Encodable) -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.sortedKeys]
        guard let data = try? encoder.encode(value),
            let string = String(data: data, encoding: .utf8)
        else { return "" }
        return string
    }

    /// `{"4":"google"}`
    private func dimensionsJSON() -> String {
        json(
            Dictionary(
                uniqueKeysWithValues: data.customDimensions.map {
                    (String($0.key), $0.value)
                }
            )
        )
    }

    /// `[["login","success","google"]]`
    private func eventsJSON() -> String {
        json(
            data.events.map { event in
                [event.category, event.action] + (event.name.map { [$0] } ?? [])
            }
        )
    }

    /// The tracker is an external script configured by `data-*` attributes, so the page needs no inline script.
    private func trackerScript() -> Script {
        var script = Script().src("/js/raccoon-matomo-tracker.js")
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

    @Builder<Element>
    public func render() -> [Element] {

        if isEnabled {

            trackerScript()
        }
    }
}
