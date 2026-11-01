import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct LinkListView: TemplateRepresentable {

    let variants: [PreviewVariant<LinkListData>] = [
        #previewVariant(
            tr(
                "Standard Links with Disabled Fallback",
                [
                    "de": "Standard-Links mit Fallback für Deaktivierte",
                    "fr": "Liens standard avec repli désactivé",
                    "es": "Enlaces estándar con respaldo deshabilitado",
                    "it": "Collegamenti standard con fallback disabilitato",
                    "pt": "Links padrão com alternativa desativada",
                    "nl": "Standaard links met uitgeschakelde terugval",
                    "da": "Standardlinks med deaktiveret fallback",
                    "sv": "Standardlänkar med inaktiverad reserv",
                    "nb": "Standardlenker med deaktivert reserveløsning",
                    "fi": "Vakiolinkit käytöstä poistetulla varavaihtoehdolla",
                    "is": "Staðlaðir tenglar með óvirkum varakosti",
                    "el": "Τυπικοί σύνδεσμοι με εφεδρεία απενεργοποιημένου",
                    "tr": "Devre dışı bırakılmış yedekli standart bağlantılar",
                    "hu": "Szabványos hivatkozások letiltott tartalékkal",
                    "hr": "Standardne veze s onemogućenom zamjenom",
                    "pl": "Standardowe linki z wyłączoną alternatywą",
                    "sk": "Štandardné odkazy so zakázanou zálohou",
                    "cs": "Standardní odkazy se zakázanou zálohou",
                    "lb": "Standardlinke mat desaktivéiertem Fallback",
                ]
            ),
            LinkListData(
                links: [
                    tr(
                        "Getting started",
                        de: "Erste Schritte",
                        fr: "Premiers pas",
                        es: "Primeros pasos",
                        it: "Per iniziare"
                    ): "/start",
                    tr(
                        "Documentation",
                        de: "Dokumentation",
                        fr: "Documentation",
                        es: "Documentación",
                        it: "Documentazione"
                    ): "/docs",
                    tr("Blog", de: "Blog", fr: "Blog", es: "Blog", it: "Blog"):
                        "/blog",
                    tr(
                        "DeadLink",
                        de: "Toter Link",
                        fr: "Lien mort",
                        es: "Enlace roto",
                        it: "Link morto"
                    ): nil,
                ],
                icon: .arrow_right_circle,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Multiline Link Item Wrapping",
                [
                    "de": "Mehrzeiliger Link-Umbruch",
                    "fr": "Retour à la ligne de lien multiligne",
                    "es": "Ajuste de enlace multilínea",
                    "it": "A capo di collegamento multilinea",
                    "pt": "Quebra de link em várias linhas",
                    "nl": "Meerdere regels link-omloop",
                    "da": "Flerlinjet link-ombrydning",
                    "sv": "Fler raders länkbrytning",
                    "nb": "Flerlinjet lenkeombryting",
                    "fi": "Monirivinen linkin kierto",
                    "is": "Margra lína tenglaskipting",
                    "el": "Αναδίπλωση στοιχείου συνδέσμου πολλών γραμμών",
                    "tr": "Çok satırlı bağlantı kaydırma",
                    "hu": "Többsoros hivatkozáselem tördelés",
                    "hr": "Prijelom veze u više redaka",
                    "pl": "Wielowierszowe zawijanie elementu linku",
                    "sk": "Viacriadkové zalamovanie odkazu",
                    "cs": "Víceřádkové zalamování odkazu",
                    "lb": "Méizeilegen Linkëmbroch",
                ]
            ),
            LinkListData(
                links: [
                    tr(
                        "Comprehensive Guide to Building Distributed Microservices with Swift, Vapor and Modern Cloud Architecture Patterns",
                        de:
                            "Umfassender Leitfaden zum Aufbau verteilter Microservices mit Swift, Vapor und modernen Cloud-Architekturmustern",
                        fr:
                            "Guide complet pour créer des microservices distribués avec Swift, Vapor et des architectures cloud modernes",
                        es:
                            "Guía completa para crear microservicios distribuidos con Swift, Vapor y arquitecturas cloud modernas",
                        it:
                            "Guida completa alla creazione di microservizi distribuiti con Swift, Vapor e architetture cloud moderne"
                    ):
                        "/guide",
                    tr(
                        "Short Link",
                        de: "Kurzer Link",
                        fr: "Lien court",
                        es: "Enlace corto",
                        it: "Link breve"
                    ): "/short",
                ],
                icon: .arrow_right_circle,
                contentTracker: tracker
            )
        ),
    ]

    func makeHtml(ctx: LinkListData) -> String {
        let html = renderFragments(LinkList(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("LinkList")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { LinkList(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
