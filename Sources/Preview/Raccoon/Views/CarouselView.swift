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
                id: "raccoon-sketch-branch",
                src: "/images/raccoon-sketch-branch.png",
                alt: tr(
                    "Raccoon standing on a mossy branch among forest leaves",
                    de: "Waschbär auf einem moosigen Ast zwischen Waldblättern",
                    fr: "Raton laveur debout sur une branche moussue parmi les feuilles",
                    es: "Mapache de pie sobre una rama con musgo entre hojas del bosque",
                    it: "Procione in piedi su un ramo muschioso tra le foglie della foresta"
                ),
                caption: tr(
                    "Raccoon on a branch",
                    de: "Waschbär auf einem Ast",
                    fr: "Raton laveur sur une branche",
                    es: "Mapache en una rama",
                    it: "Procione su un ramo"
                ),
                isS3Image: false
            ),
            CarouselItem(
                id: "raccoon-sketch-hollow",
                src: "/images/raccoon-sketch-hollow.png",
                alt: tr(
                    "Curious raccoon peeking from a hollow oak tree trunk",
                    de: "Neugieriger Waschbär, der aus einem hohlen Eichenstamm hervorschaut",
                    fr: "Raton laveur curieux observant depuis le tronc creux d'un chêne",
                    es: "Mapache curioso asomándose desde el tronco hueco de un roble",
                    it: "Procione curioso che fa capolino dal tronco cavo di una quercia"
                ),
                caption: tr(
                    "Curious raccoon in a tree hollow",
                    de: "Neugieriger Waschbär in einer Baumhöhle",
                    fr: "Raton laveur curieux dans un arbre creux",
                    es: "Mapache curioso en el hueco de un árbol",
                    it: "Procione curioso nella cavità di un albero"
                ),
                isS3Image: false
            ),
        ]
    )

    let galleryTwo = CarouselData(
        id: "carousel-gallery-two",
        carouselItems: [
            CarouselItem(
                id: "raccoon-sketch-stream",
                src: "/images/raccoon-sketch-stream.png",
                alt: tr(
                    "Raccoon washing wild berries by a flowing forest stream",
                    de: "Waschbär wäscht Waldbeeren an einem fließenden Waldbach",
                    fr: "Raton laveur lavant des baies sauvages au bord d'un ruisseau",
                    es: "Mapache lavando bayas silvestres junto a un arroyo en el bosque",
                    it: "Procione che lava bacche selvatiche vicino a un ruscello nel bosco"
                ),
                caption: tr(
                    "Raccoon washing berries by the stream",
                    de: "Waschbär wäscht Beeren am Bach",
                    fr: "Raton laveur lavant des baies au ruisseau",
                    es: "Mapache lavando bayas en el arroyo",
                    it: "Procione che lava bacche vicino al ruscello"
                ),
                isS3Image: false
            ),
            CarouselItem(
                id: "raccoon-sketch-fence",
                src: "/images/raccoon-sketch-fence.png",
                alt: tr(
                    "Raccoon perched on a rustic wooden fence post with oak leaves and acorns",
                    de: "Waschbär auf einem rustikalen Zaunpfahl mit Eichenlaub und Eicheln",
                    fr: "Raton laveur perché sur un poteau de clôture en bois avec des glands et feuilles de chêne",
                    es: "Mapache sobre un poste de valla de madera con hojas de roble y bellotas",
                    it: "Procione appollaiato su un palo di recinzione in legno con foglie di quercia e ghiande"
                ),
                caption: tr(
                    "Raccoon on a fence post",
                    de: "Waschbär auf einem Zaunpfahl",
                    fr: "Raton laveur sur un poteau de clôture",
                    es: "Mapache sobre un poste de valla",
                    it: "Procione su un palo di recinzione"
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
                    (tr(
                            "S3 Processed Images",
                            [
                                "de": "S3-verarbeitete Bilder",
                                "fr": "Images traitées par S3",
                                "es": "Imágenes procesadas por S3",
                                "it": "Immagini elaborate da S3",
                                "pt": "Imagens processadas pelo S3",
                                "nl": "Door S3 verwerkte afbeeldingen",
                                "da": "S3-behandlede billeder",
                                "sv": "S3-bearbetade bilder",
                                "nb": "S3-behandlede bilder",
                                "fi": "S3-käsitellyt kuvat",
                                "is": "S3-unnar myndir",
                                "el": "Επεξεργασμένες εικόνες S3",
                                "tr": "S3 tarafından işlenmiş görseller",
                                "hu": "S3 által feldolgozott képek",
                                "hr": "S3 obrađene slike",
                                "pl": "Obrazy przetworzone przez S3",
                                "sk": "Obrázky spracované cez S3",
                                "cs": "Obrázky zpracované přes S3",
                                "lb": "S3-veraarbecht Biller",
                            ]
                        ),
                        galleryS3
                    ),
                    (tr(
                            "Raccoon Sketch Gallery",
                            [
                                "de": "Waschbär-Skizzen-Galerie",
                                "fr": "Galerie d'esquisses de raton laveur",
                                "es": "Galería de bocetos de mapache",
                                "it": "Galleria di schizzi di procione",
                                "pt": "Galeria de esboços de guaxinim",
                                "nl": "Wasbeer schetsengalerij",
                                "da": "Vaskebjørn skitsegalleri",
                                "sv": "Tvättbjörn skissgalleri",
                                "nb": "Vaskebjørn skissemuseum",
                                "fi": "Pesukarhu luonnosgalleria",
                                "is": "Þvottabjörn teiknisafn",
                                "el": "Συλλογή σκίτσων ρακούν",
                                "tr": "Rakun çizimleri galerisi",
                                "hu": "Mosómedve vázlatgaléria",
                                "hr": "Galerija skica rakuna",
                                "pl": "Galeria szkiców szopa",
                                "sk": "Galéria skíc medvedíka čistotného",
                                "cs": "Galerie skic mývala",
                                "lb": "Wäschbier Skizzegalerie",
                            ]
                        ), galleryOne),
                    (tr(
                            "Second Gallery Instance",
                            [
                                "de": "Zweite Galerie-Instanz",
                                "fr": "Deuxième instance de galerie",
                                "es": "Segunda instancia de galería",
                                "it": "Seconda istanza della galleria",
                                "pt": "Segunda instância de galeria",
                                "nl": "Tweede galerij-instantie",
                                "da": "Anden galleri-instans",
                                "sv": "Andra galleri-instansen",
                                "nb": "Andre galleri-instans",
                                "fi": "Toinen galleria-instanssi",
                                "is": "Önnur myndasafnstilvik",
                                "el": "Δεύτερο στιγμιότυπο συλλογής",
                                "tr": "İkinci galeri örneği",
                                "hu": "Második galériapéldány",
                                "hr": "Druga instanca galerije",
                                "pl": "Druga instancja galerii",
                                "sk": "Druhá inštancia galérie",
                                "cs": "Druhá instance galerie",
                                "lb": "Zweet Galerie-Instanz",
                            ]
                        ),
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
