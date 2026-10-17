import HTML
import SGML
import SVG
import WebBuilders

/// DarkLightModeToggle
///
/// Self-contained: owns its Alpine state via `/js/darklightmode.js`, so the host
/// template needs nothing in scope. Alt+M toggles from anywhere on the page.
/// Wrap it in a positioned Div — the component does not own its placement.
///
public struct DarkLightModeToggle: TemplateRepresentable {
    let data: DarkLightModeToggleData
    typealias styles = DarkLightModeToggleStyles

    /// Must stay inline in `<head>`: it sets the `dark` class before first paint.
    /// Loading it via `src` would run too late and flash the wrong theme.
    public static let detectModeScript: String = """
        // detect-mode.js
        // set initial color scheme

        let explicitelyPreferScheme = false
        if (window.localStorage) {
            if (localStorage.getItem('colorMode') === 'dark') {
                document.documentElement.classList.add('dark')
                explicitelyPreferScheme = 'dark'
            } else if (localStorage.getItem('colorMode') === 'light') {
                document.documentElement.classList.remove('dark')
                explicitelyPreferScheme = 'light'
            }
        }

        if (localStorage.getItem("colorMode") === null) {
          if (explicitelyPreferScheme !== 'light' && window.matchMedia('(prefers-color-scheme:dark)').matches) {
              document.documentElement.classList.add('dark')
              localStorage.setItem('colorMode', 'dark')
          } else {
              localStorage.setItem('colorMode', 'light')
          }
        }
        """

    public init(
        _ data: DarkLightModeToggleData
    ) {
        self.data = data
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Dark light mode toggle")

        Script()
            .src("/js/darklightmode.js")
            .setAttribute(
                name: "type",
                value: "text/javascript"
            )

        Div {

            Button {

                Svg.icon(.sun, width: 16, height: 16)
                    .setAttribute(name: "x-show", value: "!lightMode")

                Svg.icon(.moon, width: 16, height: 16)
                    .setAttribute(name: "x-show", value: "lightMode")

            }
            .type(.button)
            .if(data.id != nil) {
                if let id = data.id {
                    return $0.id(id)
                }
                return $0
            }
            .ariaLabel("Switch dark and light mode")
            .flagAttribute("x-cloak")
            .setAttribute(name: "@click", value: "toggle()")
            .class(styles.button)
            // Matomo
            .if(data.matomoStatus == .ACCEPTED || data.matomoStatus == .BANNER)
            {

                $0
                    .flagAttribute("data-track-content")
                    .setAttribute(
                        name: "data-content-name",
                        value: "dark-lightmode"
                    )
                    .setAttribute(
                        name: "data-content-piece",
                        value: "toggle"
                    )
                    .setAttribute(
                        name: "data-content-target",
                        value: ""
                    )

            }

        }
        .setAttribute(
            name: "x-data",
            value: "darkLightModeToggle(\(data.matomoStatus == .ACCEPTED))"
        )
        // Alt+M / Option+M: modifier combo, checked in toggleFromKeyboard via event.code so it works on macOS where Option+M emits 'µ'.
        .setAttribute(
            name: "@keydown.window",
            value: "toggleFromKeyboard($event)"
        )
        .class(styles.container)
    }
}
