import HTML
import SGML
import SVG
import WebBuilders

public struct Logo: TemplateRepresentable {
    let data: LogoData
    typealias buttonStyles = ActionButtonStyles

    public init(
        _ data: LogoData
    ) {
        self.data = data
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Logo")
        Div {

            A {
                Span { Svg.logo() }

            }
            .setAttribute(
                name: "aria-label",
                value: "Go to home"
            )
            .href(data.destination)
            .hrefLang(AppValues.lang)
            .class("inline-flex")
            .addClass("focus:outline-hidden focus-visible:outline-hidden")
            // Matomo
            .if(data.matomoStatus == .ACCEPTED || data.matomoStatus == .BANNER)
            {

                $0
                    .flagAttribute("data-track-content")
                    .setAttribute(
                        name: "data-content-name",
                        value: "logo"
                    )
                    .setAttribute(
                        name: "data-content-piece",
                        value: "button.home"
                    )
                    .setAttribute(
                        name: "data-content-target",
                        value: data.destination
                    )

            }

        }
        .class("inline-flex")
        .addClass(buttonStyles.iconButton)

    }
}
