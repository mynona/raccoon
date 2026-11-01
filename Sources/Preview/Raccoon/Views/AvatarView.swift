import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct AvatarView: TemplateRepresentable {

    let variants: [PreviewVariant<AvatarData>] = [
        #previewVariant(
            tr(
                "Initials Small",
                [
                    "de": "Initialen klein",
                    "fr": "Initiales petites",
                    "es": "Iniciales pequeñas",
                    "it": "Iniziali piccole",
                    "pt": "Iniciais pequenas",
                    "nl": "Initialen klein",
                    "da": "Initialer små",
                    "sv": "Initialer små",
                    "nb": "Initialer små",
                    "fi": "Nimikirjaimet pienet",
                    "is": "Upphafsstafir litlir",
                    "el": "Αρχικά μικρά",
                    "tr": "Küçük baş harfler",
                    "hu": "Kis monogram",
                    "hr": "Mali inicijali",
                    "pl": "Inicjały małe",
                    "sk": "Iniciály malé",
                    "cs": "Iniciály malé",
                    "lb": "Initialen kleng",
                ]
            ),
            AvatarData(
                firstName: "Andreas",
                lastName: "Soller",
                size: .sm
            )
        ),
        #previewVariant(
            tr(
                "Initials Medium",
                [
                    "de": "Initialen mittel",
                    "fr": "Initiales moyennes",
                    "es": "Iniciales medianas",
                    "it": "Iniziali medie",
                    "pt": "Iniciais médias",
                    "nl": "Initialen middelgroot",
                    "da": "Initialer mellemstore",
                    "sv": "Initialer medelstora",
                    "nb": "Initialer mellomstore",
                    "fi": "Nimikirjaimet keskikokoiset",
                    "is": "Upphafsstafir meðalstórir",
                    "el": "Αρχικά μεσαία",
                    "tr": "Orta boy baş harfler",
                    "hu": "Közepes monogram",
                    "hr": "Srednji inicijali",
                    "pl": "Inicjały średnie",
                    "sk": "Iniciály stredné",
                    "cs": "Iniciály střední",
                    "lb": "Initialen mëttel",
                ]
            ),
            AvatarData(
                firstName: "Andreas",
                lastName: "Soller",
                size: .base
            )
        ),
        #previewVariant(
            tr(
                "Initials Extra Large",
                [
                    "de": "Initialen extra groß",
                    "fr": "Initiales très grandes",
                    "es": "Iniciales extragrandes",
                    "it": "Iniziali extra large",
                    "pt": "Iniciais extra grandes",
                    "nl": "Initialen extra groot",
                    "da": "Initialer ekstra store",
                    "sv": "Initialer extra stora",
                    "nb": "Initialer ekstra store",
                    "fi": "Nimikirjaimet erittäin suuret",
                    "is": "Upphafsstafir mjög stórir",
                    "el": "Αρχικά πολύ μεγάλα",
                    "tr": "Ekstra büyük baş harfler",
                    "hu": "Extra nagy monogram",
                    "hr": "Vrlo veliki inicijali",
                    "pl": "Inicjały bardzo duże",
                    "sk": "Iniciály extra veľké",
                    "cs": "Iniciály extra velké",
                    "lb": "Initialen extra grouss",
                ]
            ),
            AvatarData(
                firstName: "Andreas",
                lastName: "Soller",
                size: .xl
            )
        ),
        #previewVariant(
            tr(
                "Single Initial",
                [
                    "de": "Einzelne Initiale",
                    "fr": "Initiale unique",
                    "es": "Inicial única",
                    "it": "Iniziale singola",
                    "pt": "Inicial única",
                    "nl": "Enkele initiaal",
                    "da": "Enkelt initial",
                    "sv": "Enstaka initial",
                    "nb": "Enkelt initial",
                    "fi": "Yksittäinen nimikirjain",
                    "is": "Stakur upphafsstafur",
                    "el": "Μονό αρχικό",
                    "tr": "Tek baş harf",
                    "hu": "Egyetlen kezdőbetű",
                    "hr": "Jedan inicijal",
                    "pl": "Pojedynczy inicjał",
                    "sk": "Jedna iniciála",
                    "cs": "Jedna iniciála",
                    "lb": "Eenzel Initial",
                ]
            ),
            AvatarData(
                firstName: "Andreas"
            )
        ),
        #previewVariant(
            tr(
                "Placeholder Fallback",
                [
                    "de": "Platzhalter-Fallback",
                    "fr": "Repli de substitution",
                    "es": "Respaldo de marcador de posición",
                    "it": "Fallback segnaposto",
                    "pt": "Alternativa de espaço reservado",
                    "nl": "Plaatshouder-terugval",
                    "da": "Pladsholder-fallback",
                    "sv": "Platshållarreserv",
                    "nb": "Plassholder-reserveløsning",
                    "fi": "Paikkamerkin varavaihtoehto",
                    "is": "Staðgengill varakostur",
                    "el": "Εφεδρεία δεσμευτικού θέσης",
                    "tr": "Yer tutucu yedeği",
                    "hu": "Helyőrző tartalék",
                    "hr": "Zamjena za čuvar mjesta",
                    "pl": "Alternatywa dla symbolu zastępczego",
                    "sk": "Zástupná záloha",
                    "cs": "Zástupná záloha",
                    "lb": "Plazhalter-Fallback",
                ]
            ),
            AvatarData()
        ),
        #previewVariant(
            tr(
                "Image Picture",
                [
                    "de": "Profilbild",
                    "fr": "Image de profil",
                    "es": "Imagen de perfil",
                    "it": "Immagine del profilo",
                    "pt": "Imagem de perfil",
                    "nl": "Profielafbeelding",
                    "da": "Profilbillede",
                    "sv": "Profilbild",
                    "nb": "Profilbilde",
                    "fi": "Profiilikuva",
                    "is": "Prófílmynd",
                    "el": "Εικόνα προφίλ",
                    "tr": "Profil resmi",
                    "hu": "Profilkép",
                    "hr": "Profilna slika",
                    "pl": "Zdjęcie profilowe",
                    "sk": "Profilový obrázok",
                    "cs": "Profilový obrázek",
                    "lb": "Profilbild",
                ]
            ),
            AvatarData(
                picture:
                    "https://avatars.githubusercontent.com/u/12345678?v=4"
            )
        ),
    ]

    func makeHtml(ctx: AvatarData) -> String {
        let html = renderFragments(Avatar(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Avatar")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Avatar(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
