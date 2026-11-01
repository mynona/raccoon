import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct CarouselView: TemplateRepresentable {

    let galleryS3 = CarouselData(
        id: "carousel-gallery-s3",
        carouselItems: [
            CarouselItem(
                id: "0160CBFD-23CE-40E8-88E8-4317FCD54BB0",
                src:
                    "https://raumnebenan-images.s3.eu-central-1.amazonaws.com/blog/0160CBFD-23CE-40E8-88E8-4317FCD54BB0.png",
                alt: tr(
                    "S3 responsive carousel example",
                    de: "Responsives S3-Karussell-Beispiel",
                    fr: "Exemple de carrousel S3 adaptatif",
                    es: "Ejemplo de carrusel S3 adaptable",
                    it: "Esempio di carosello S3 reattivo"
                ),
                caption: tr(
                    "S3 processed blog image (AVIF & WebP)",
                    de: "Verarbeitetes S3-Blogbild (AVIF & WebP)",
                    fr: "Image de blog traitée S3 (AVIF & WebP)",
                    es: "Imagen de blog procesada de S3 (AVIF y WebP)",
                    it: "Immagine del blog elaborata da S3 (AVIF e WebP)"
                ),
                isS3Image: true
            )
        ]
    )

    let galleryOne = CarouselData(
        id: "carousel-gallery-one",
        carouselItems: [
            CarouselItem(
                id: "sample-teal",
                src: "/images/sample-teal.svg",
                alt: tr(
                    "Plain teal sample image",
                    de: "Einfarbiges türkisfarbenes Beispielbild",
                    fr: "Image d'exemple turquoise unie",
                    es: "Imagen de ejemplo turquesa lisa",
                    it: "Immagine di esempio turchese tinta unita"
                ),
                caption: tr(
                    "Sample 1 – teal",
                    de: "Beispiel 1 – Türkis",
                    fr: "Exemple 1 – turquoise",
                    es: "Ejemplo 1 – turquesa",
                    it: "Esempio 1 – turchese"
                ),
                isS3Image: false
            ),
            CarouselItem(
                id: "sample-amber",
                src: "/images/sample-amber.svg",
                alt: tr(
                    "Plain amber sample image",
                    de: "Einfarbiges bernsteinfarbenes Beispielbild",
                    fr: "Image d'exemple ambre unie",
                    es: "Imagen de ejemplo ámbar lisa",
                    it: "Immagine di esempio ambra tinta unita"
                ),
                caption: tr(
                    "Sample 2 – amber",
                    de: "Beispiel 2 – Bernstein",
                    fr: "Exemple 2 – ambre",
                    es: "Ejemplo 2 – ámbar",
                    it: "Esempio 2 – ambra"
                ),
                isS3Image: false
            ),
        ]
    )

    let galleryTwo = CarouselData(
        id: "carousel-gallery-two",
        carouselItems: [
            CarouselItem(
                id: "sample-indigo",
                src: "/images/sample-indigo.svg",
                alt: tr(
                    "Plain indigo sample image",
                    de: "Einfarbiges indigofarbenes Beispielbild",
                    fr: "Image d'exemple indigo unie",
                    es: "Imagen de ejemplo índigo lisa",
                    it: "Immagine di esempio indaco tinta unita"
                ),
                caption: tr(
                    "Sample 3 – indigo",
                    de: "Beispiel 3 – Indigo",
                    fr: "Exemple 3 – indigo",
                    es: "Ejemplo 3 – índigo",
                    it: "Esempio 3 – indaco"
                ),
                isS3Image: false
            ),
            CarouselItem(
                id: "sample-rose",
                src: "/images/sample-rose.svg",
                alt: tr(
                    "Plain rose sample image",
                    de: "Einfarbiges rosafarbenes Beispielbild",
                    fr: "Image d'exemple rose unie",
                    es: "Imagen de ejemplo rosa lisa",
                    it: "Immagine di esempio rosa tinta unita"
                ),
                caption: tr(
                    "Sample 4 – rose",
                    de: "Beispiel 4 – Rosa",
                    fr: "Exemple 4 – rose",
                    es: "Ejemplo 4 – rosa",
                    it: "Esempio 4 – rosa"
                ),
                isS3Image: false
            ),
        ]
    )

    func makeHtml(ctx: CarouselData) -> String {
        escapeHTML(prettyHTML(renderFragments(Carousel(ctx).render())))
    }

    @Builder<Element>
    func showTriggers(_ data: CarouselData) -> [Element] {
        P(
            tr(
                "Open a slide, then close the carousel with Escape or the close button — focus must return to the trigger you used (visible focus ring).",
                de:
                    "Öffne eine Folie und schließe das Karussell mit Escape oder der Schließen-Schaltfläche — der Fokus muss zum auslösenden Element zurückkehren (sichtbarer Fokusring).",
                fr:
                    "Ouvrez une diapositive, puis fermez le carrousel avec Échap ou le bouton de fermeture — le focus doit revenir à l'élément déclencheur (anneau de focus visible).",
                es:
                    "Abre una diapositiva y cierra el carrusel con Escape o el botón de cierre: el foco debe volver al elemento que lo activó (anillo de foco visible).",
                it:
                    "Apri una diapositiva e chiudi il carosello con Esc o con il pulsante di chiusura: il focus deve tornare all'elemento che lo ha attivato (anello di focus visibile)."
            )
            .resolved
        )
        .class(["mb-2 text-sm", CommonStyles.textColorDefault].joined(separator: " "))

        Ul {
            for item in data.carouselItems {
                Li {
                    Button {
                        Img(src: item.src, alt: item.alt?.resolved ?? "")
                            .width(240)
                            .height(150)
                            .loading(.lazy)
                            .class("w-60 h-auto")
                    }
                    .type(.button)
                    .setAttribute(
                        name: "@click",
                        value:
                            "window.dispatchEvent(new CustomEvent('showCarousel', { detail: '\(item.id)' }));"
                    )
                    .ariaLabel(
                        tr(
                            "Open {{title}} in carousel",
                            de: "{{title}} im Karussell öffnen",
                            fr: "Ouvrir {{title}} dans le carrousel",
                            es: "Abrir {{title}} en el carrusel",
                            it: "Apri {{title}} nel carosello"
                        )
                        .with(variables: [
                            "title": item.caption?.resolved ?? item.id
                        ])
                        .resolved
                    )
                    .class("cursor-pointer")
                    .addClass(CommonStyles.focusDefault)
                }
            }
        }
        .class("flex flex-row flex-wrap gap-4 mb-4")
        .setAttribute(name: "x-data", value: "{}")
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Carousel")

                let variants: [(LocalizedText, CarouselData)] = [
                    (
                        "S3 Processed Images",
                        galleryS3
                    ),
                    ("Local SVG Gallery", galleryOne),
                    (
                        "Second Gallery Instance",
                        galleryTwo
                    ),
                ]

                for (label, data) in variants {

                    showVariantTitle(label, data)

                    showComponentPreview(
                        data: label.english,
                        html: makeHtml(ctx: data)
                    ) {
                        showTriggers(data)
                    }

                }

            }
            .class("mt-4 space-y-6")

            Carousel(galleryS3).render()
            Carousel(galleryOne).render()
            Carousel(galleryTwo).render()

        }
        .render()

    }
}
