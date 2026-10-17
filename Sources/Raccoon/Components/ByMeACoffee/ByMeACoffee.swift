import HTML
import SGML
import SVG
import WebBuilders

public struct ByMeACoffee: TemplateRepresentable {
    let data: ByMeACoffeeData
    typealias styles = ByMeACoffeeStyles

    public init(
        _ data: ByMeACoffeeData
    ) {
        self.data = data
    }

    @Builder<Element>
    public func render() -> [Element] {

        let bmc = "Buy me a coffee"

        DebugComment(bmc)
        Div {

            A {

                Img(
                    src: "\(data.imageSrc)",
                    alt: ""
                )
                .width(data.imageWidth)
                .height(data.imageHeight)
                .loading(.lazy)

            }
            .href("https://buymeacoffee.com/\(data.dataSlug)")
            .target(.blank)
            .setAttribute(
                name: "rel",
                value: "noopener noreferrer"
            )
            .class(styles.cornerRadiusMedium)
            .addClass(styles.focusReset)
            .addClass(styles.focusDefault)
            .addClass(styles.hoverDefault)
            .setAttribute(
                name: "aria-label",
                value: bmc
            )
            // Matomo
            .if(data.matomoStatus == .ACCEPTED || data.matomoStatus == .BANNER)
            {

                $0
                    .flagAttribute("data-track-content")
                    .setAttribute(
                        name: "data-content-name",
                        value: "feedback"
                    )
                    .setAttribute(
                        name: "data-content-piece",
                        value: "buymeacoffee"
                    )
                    .setAttribute(
                        name: "data-content-target",
                        value: "https://buymeacoffee.com/\(data.dataSlug)"
                    )

            }

        }
        .class("flex flex-initial")

    }

}
