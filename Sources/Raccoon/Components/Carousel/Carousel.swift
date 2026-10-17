import HTML
import SGML
import WebBuilders

public struct Carousel: TemplateRepresentable {
    let data: CarouselData
    typealias styles = CarouselStyles
    typealias buttonStyles = ActionButtonStyles

    public init(
        _ data: CarouselData,
    ) {
        self.data = data
    }

    @Builder<Element>
    func showKeyboardKeys() -> [Element] {
        DebugComment("Carousel keyboard keys")
        Div {

            KeyboardKey(
                KeyboardKeyData(key: .text("esc"))
            )
            .render()

            Span {
                KeyboardKey(
                    KeyboardKeyData(key: .cursorLeft)
                )
                .render()
            }
            .setAttribute(name: "x-show", value: "showNavigation")

            Span {
                KeyboardKey(
                    KeyboardKeyData(key: .cursorRight)
                )
                .render()
            }
            .setAttribute(name: "x-show", value: "showNavigation")

        }
        .class(
            "flex items-stretch items-center space-x-2 h-8 absolute left-5 top-8 z-20"
        )
        .addClass(styles.textColorKeyboardKeys)
    }

    @Builder<Element>
    func showCloseButton() -> [Element] {

        DebugComment("Carousel close button")
        Button {

            Svg.icon(.x_lg, width: 20, height: 20)
                .setAttribute(name: "role", value: "presentation")

        }
        .type(.button)
        .setAttribute(name: "x-on:click", value: "close()")
        .setAttribute(name: "aria-label", value: "Close image gallery")
        .setAttribute(name: "x-ref", value: "closeCarousel")
        .class(
            "absolute right-5 top-12 z-20 flex rounded-full -translate-y-1/2 items-center justify-center p-2 transition"
        )
        .addClass(buttonStyles.iconButton)
        .addClass(styles.backgroundColorIcon)
        // Matomo
        .if(data.matomoStatus == .ACCEPTED || data.matomoStatus == .BANNER) {

            $0
                .flagAttribute("data-track-content")
                .setAttribute(name: "data-content-name", value: "carousel")
                .setAttribute(name: "data-content-piece", value: "button.close")
                .setAttribute(name: "data-content-target", value: "")

        }
    }

    @Builder<Element>
    func showPreviousButton() -> [Element] {
        // MARK: carousel-previous
        DebugComment("Carousel previous button")

        Button {

            Svg.icon(.chevron_left, width: 20, height: 20)
                .setAttribute(name: "role", value: "presentation")

        }
        .type(.button)
        .setAttribute(name: "aria-label", value: "previous slide")
        .setAttribute(name: "x-on:click", value: "previous()")
        .setAttribute(name: "x-show", value: "showNavigation")
        .class(
            "absolute left-5 top-1/2 z-20 flex rounded-full -translate-y-1/2 items-center justify-center p-2 transition"
        )
        .addClass(buttonStyles.iconButton)
        .addClass(styles.backgroundColorIcon)
        // Matomo
        .if(data.matomoStatus == .ACCEPTED || data.matomoStatus == .BANNER) {

            $0
                .flagAttribute("data-track-content")
                .setAttribute(name: "data-content-name", value: "carousel")
                .setAttribute(
                    name: "data-content-piece",
                    value: "button.previous"
                )
                .setAttribute(name: "data-content-target", value: "")

        }
    }

    @Builder<Element>
    func showNextButton() -> [Element] {
        DebugComment("Carousel next button")
        Button {

            Svg.icon(.chevron_right, width: 20, height: 20)
                .setAttribute(name: "role", value: "presentation")

        }
        .type(.button)
        .setAttribute(name: "aria-label", value: "next slide")
        .setAttribute(name: "x-on:click", value: "next()")
        .setAttribute(name: "x-show", value: "showNavigation")
        .class(
            "absolute right-5 top-1/2 z-20 flex rounded-full -translate-y-1/2 items-center justify-center p-2 transition"
        )
        .addClass(buttonStyles.iconButton)
        .addClass(styles.backgroundColorIcon)
        // Matomo
        .if(data.matomoStatus == .ACCEPTED || data.matomoStatus == .BANNER) {

            $0
                .flagAttribute("data-track-content")
                .setAttribute(name: "data-content-name", value: "carousel")
                .setAttribute(name: "data-content-piece", value: "button.next")
                .setAttribute(name: "data-content-target", value: "")

        }
    }

    @Builder<Element>
    func showIndicators() -> [Element] {
        DebugComment("Carousel indicators")
        Div {

            Template {

                Button {}
                    .setAttribute(
                        name: "x-on:click",
                        value: "currentSlideIndex = index + 1"
                    )
                    .setAttribute(
                        name: "x-bind:class",
                        value:
                            "[currentSlideIndex === index + 1 ? 'bg-neutral-600 dark:bg-neutral-300' : 'bg-neutral-600/50 dark:bg-neutral-300/50']"
                    )
                    .setAttribute(
                        name: "x-bind:aria-label",
                        value: "'slide ' + (index + 1)"
                    )
                    .class("size-2 cursor-pointer rounded-full transition")
                    .addClass(styles.backgroundColorIndicators)
                    .addClass(styles.cursorPointer)
                    .addClass(buttonStyles.focusDefault)
                    .addClass(buttonStyles.hoverDefault)
                    // Matomo
                    .if(
                        data.matomoStatus == .ACCEPTED
                            || data.matomoStatus == .BANNER
                    ) {

                        $0
                            .flagAttribute("data-track-content")
                            .setAttribute(
                                name: "data-content-name",
                                value: "carousel"
                            )
                            .setAttribute(
                                name: "data-content-piece",
                                value: "button.indicator"
                            )
                            .setAttribute(
                                name: "data-content-target",
                                value: ""
                            )

                    }

            }
            .setAttribute(name: "x-for", value: "(slide, index) in slides")

        }
        .setAttribute(name: "role", value: "group")
        .setAttribute(name: "aria-label", value: "slides")
        .setAttribute(name: "x-show", value: "showIndicators")
        .class(
            "absolute bottom-4 left-0 right-0 flex justify-center z-20 flex rounded-md gap-4 md:gap-3 px-1.5 py-1 md:px-2"
        )
    }

    @Builder<Element>
    func showSlides() -> [Element] {
        DebugComment("Carousel slides")
        Div {

            Template {

                Div {

                    Div {
                        Picture {
                            Source()
                                .type("image/avif")
                                .sizes(
                                    "(min-width: 1280px) 1280px, (min-width: 768px) 768px, 100vw"
                                )
                                .setAttribute(
                                    name: "x-bind:srcset",
                                    value: "slide.avifSrcSet || false"
                                )
                            Source()
                                .type("image/webp")
                                .sizes(
                                    "(min-width: 1280px) 1280px, (min-width: 768px) 768px, 100vw"
                                )
                                .setAttribute(
                                    name: "x-bind:srcset",
                                    value: "slide.webpSrcSet || false"
                                )
                            Img(src: "", alt: "")
                                .setAttribute(
                                    name: "x-ref",
                                    value: "currentImage"
                                )
                                .loading(.lazy)
                                .setAttribute(
                                    name: "x-bind:src",
                                    value: "slide.imgSrc"
                                )
                                .setAttribute(
                                    name: "x-bind:alt",
                                    value: "slide.imgAlt"
                                )
                                .setAttribute(
                                    name: "onerror",
                                    value:
                                        "this.onerror=null; this.closest('picture')?.querySelectorAll('source').forEach(s => s.remove());"
                                )
                                .class(
                                    "object-contain mx-auto dark:brightness-90 rounded-xs inset-0 object-cover w-full"
                                )
                                .addClass(styles.backgroundColorIndicators)
                        }
                    }
                    .class("relative w-full max-w-[90vw] max-h-[80vh]")

                    P {}
                        .setAttribute(name: "x-text", value: "slide.imgCaption")
                        .class("text-center mt-4")
                        .addClass(styles.textColorCaption)

                }
                .flagAttribute("x-cloak")
                .setAttribute(
                    name: "x-show",
                    value: "currentSlideIndex == index + 1"
                )
                .setAttribute(name: "role", value: "group")
                .flagAttribute("x-transition.opacity.duration.400ms")
                .class(
                    "absolute inset-0 flex flex-col items-center justify-center p-4"
                )

            }
            .setAttribute(name: "x-for", value: "(slide, index) in slides")

        }
        .class("relative w-full h-full flex items-center justify-center")
        .setAttribute(
            name: "x-on:touchstart",
            value: "handleTouchStart($event)"
        )
        .setAttribute(name: "x-on:touchmove", value: "handleTouchMove($event)")
        .setAttribute(name: "x-on:touchend", value: "handleTouchEnd()")
    }

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("Carousel")
        Script()
            .src("/js/carousel.js")
            .setAttribute(
                name: "type",
                value: "text/javascript"
            )

        Div {

            Div {

                Div {
                    showKeyboardKeys()
                    showCloseButton()
                    showPreviousButton()
                    showNextButton()
                    showSlides()
                    showIndicators()
                }
                .class("relative h-full flex flex-col justify-center")

            }
            .class("fixed w-full h-full inset-0 z-50 overflow-hidden")
            .addClass(styles.carouselBackdrop)
            .setAttribute(name: "x-show", value: "showCarousel")
            .setAttribute(name: "x-trap.noscroll", value: "showCarousel")

        }
        .setAttribute(
            name: "x-data",
            value:
                "carouselData(\(JavaScriptEscaper.htmlAttributeEscape(data.jsonSlides)))"
        )
        .setAttribute(
            name: "@keyup.escape.window",
            value: "showCarousel && close()"
        )
        .setAttribute(
            name: "@keyup.right.window",
            value: "showCarousel && next()"
        )
        .setAttribute(
            name: "@keyup.left.window",
            value: "showCarousel && previous()"
        )

    }
}
