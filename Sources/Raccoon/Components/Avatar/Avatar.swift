import HTML
import SGML
import SVG
import WebBuilders

public struct Avatar: TemplateRepresentable {
    let data: AvatarData
    typealias styles = AvatarStyles

    public init(
        _ data: AvatarData
    ) {
        self.data = data
    }

    func generateInitials() -> String? {
        let initials = [data.firstName, data.lastName]
            .compactMap { $0?.first }
            .map { String($0).uppercased() }
            .joined()

        return initials.isEmpty ? nil : initials
    }

    func generateName() -> String? {
        let name = [data.firstName, data.lastName]
            .compactMap { $0 }
            .map { String($0).capitalized }
            .joined(separator: " ")

        return name.isEmpty ? nil : name
    }

    func getContainerSize() -> String {
        switch data.size {
        case .sm:
            return "size-8"
        case .base:
            return "size-10"
        case .xl:
            return "size-12"
        }
    }

    func getTextSize() -> String {
        switch data.size {
        case .sm:
            return styles.textSizeSmall
        case .base:
            return styles.textSizeBase
        case .xl:
            return styles.textSizeLarge
        }
    }

    func getIconSize() -> Int {
        switch data.size {
        case .sm:
            return 18
        case .base:
            return 24
        case .xl:
            return 30
        }
    }

    func createContainerStyles() -> String {
        "flex \(getContainerSize()) p-1 items-center justify-center overflow-hidden rounded-full"
    }

    @Builder<Element>
    public func render() -> [Element] {

        let container = createContainerStyles()

        DebugComment("Avatar")
        let initials = generateInitials()
        let name = generateName()
        let fallbackAlt = name != nil ? "\(name!)" : "Avatar"

        if let picture = data.picture {
            Img(src: picture, alt: fallbackAlt)
                .class(
                    "\(getContainerSize()) rounded-full object-cover object-center p-0.5"
                )
                .addClass(styles.imageBorder)
        }
        else if let initials {
            Span(initials)
                .role("img")
                .class(container)
                .addClass(styles.initialsFont)
                .addClass(styles.initialsText)
                .addClass(getTextSize())
                .addClass(styles.initialsBorder)
                .if(name != nil) {
                    $0.ariaLabel("\(name!)")
                }
        }
        else {
            let iconSize = getIconSize()
            Span { Svg.icon(.person_fill, width: iconSize, height: iconSize) }
                .role("img")
                .class(container)
                .addClass(styles.initialsFont)
                .addClass(styles.initialsText)
                .addClass(styles.initialsBorder)
                .ariaLabel("Generic avatar image")
        }
    }
}
