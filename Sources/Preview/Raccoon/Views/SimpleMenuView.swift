import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct SimpleMenuView: TemplateRepresentable {

    let variants: [PreviewVariant<SimpleMenuData>] = [
        #previewVariant(
            tr(
                "Action Menu with Text Trigger",
                [
                    "de": "Aktionsmenü mit Text-Auslöser",
                    "fr": "Menu d'actions avec déclencheur textuel",
                    "es": "Menú de acciones con activador de texto",
                    "it": "Menu azioni con trigger di testo",
                    "pt": "Menu de ações com acionador de texto",
                    "nl": "Actiemenu met teksttrigger",
                    "da": "Handlingsmenu med tekst-udløser",
                    "sv": "Åtgärdsmeny med textutlösare",
                    "nb": "Handlingsmeny med tekstutløser",
                    "fi": "Toimintovalikko tekstilaukaisimella",
                    "is": "Aðgerðavalmynd með textakveikju",
                    "el": "Μενού ενεργειών με έναυσμα κειμένου",
                    "tr": "Metin tetikleyicili eylem menüsü",
                    "hu": "Műveleti menü szöveges indítóval",
                    "hr": "Izbornik radnji s tekstualnim okidačem",
                    "pl": "Menu akcji z wyzwalaczem tekstowym",
                    "sk": "Ponuka akcií s textovým spúšťačom",
                    "cs": "Nabídka akcí s textovým spouštěčem",
                    "lb": "Aktiounsmenü mat Text-Ausléiser",
                ]
            ),
            SimpleMenuData(
                ariaLabel: tr(
                    "Actions",
                    de: "Aktionen",
                    fr: "Actions",
                    es: "Acciones",
                    it: "Azioni"
                ),
                triggerText: tr(
                    "Actions",
                    de: "Aktionen",
                    fr: "Actions",
                    es: "Acciones",
                    it: "Azioni"
                ),
                options: [
                    SimpleMenuOption(
                        id: "edit",
                        title: tr(
                            "Edit item",
                            de: "Element bearbeiten",
                            fr: "Modifier l'élément",
                            es: "Editar elemento",
                            it: "Modifica elemento"
                        ),
                        clickAction: "alert('Edit clicked')"
                    ),
                    SimpleMenuOption(
                        id: "duplicate",
                        title: tr(
                            "Duplicate",
                            de: "Duplizieren",
                            fr: "Dupliquer",
                            es: "Duplicar",
                            it: "Duplica"
                        ),
                        clickAction: "alert('Duplicate clicked')"
                    ),
                    SimpleMenuOption(
                        id: "archive",
                        title: tr(
                            "Archive",
                            de: "Archivieren",
                            fr: "Archiver",
                            es: "Archivar",
                            it: "Archivia"
                        ),
                        clickAction: "alert('Archive clicked')"
                    ),
                ],
                width: "w-48"
            )
        ),
        #previewVariant(
            tr(
                "SSR Link Mode with Selected Checkmark",
                [
                    "de": "SSR-Link-Modus mit ausgewähltem Häkchen",
                    "fr": "Mode lien SSR avec coche sélectionnée",
                    "es": "Modo de enlace SSR con marca seleccionada",
                    "it": "Modalità link SSR con segno di spunta selezionato",
                    "pt": "Modo de link SSR com marca selecionada",
                    "nl": "SSR-linkmodus met geselecteerd vinkje",
                    "da": "SSR-linktilstand med valgt flueben",
                    "sv": "SSR-länkläge med vald bock",
                    "nb": "SSR-lenkemodus med valgt hake",
                    "fi": "SSR-linkkitila valitulla valintamerkillä",
                    "is": "SSR-tenglahamur með völdu gátmerki",
                    "el": "Λειτουργία συνδέσμου SSR με επιλεγμένο σημάδι επιλογής",
                    "tr": "Seçili onay işaretli SSR bağlantı modu",
                    "hu": "SSR hivatkozás mód kijelölt pipával",
                    "hr": "Način SSR veze s odabranom kvačicom",
                    "pl": "Tryb linków SSR z zaznaczonym znacznikiem wyboru",
                    "sk": "Režim odkazu SSR s vybranou fajkou",
                    "cs": "Režim odkazu SSR s vybraným zaškrtnutím",
                    "lb": "SSR-Link-Modus mat ausgewieltem Haischen",
                ]
            ),
            SimpleMenuData(
                ariaLabel: tr(
                    "Page size",
                    de: "Seitengröße",
                    fr: "Taille de page",
                    es: "Tamaño de página",
                    it: "Dimensione pagina"
                ),
                triggerText: tr(
                    "25 items",
                    de: "25 Einträge",
                    fr: "25 éléments",
                    es: "25 elementos",
                    it: "25 elementi"
                ),
                options: [
                    SimpleMenuOption(
                        id: "10",
                        title: tr(
                            "10 items",
                            de: "10 Einträge",
                            fr: "10 éléments",
                            es: "10 elementos",
                            it: "10 elementi"
                        ),
                        isSelected: false,
                        href: "/preview/simple-menu?per=10"
                    ),
                    SimpleMenuOption(
                        id: "25",
                        title: tr(
                            "25 items",
                            de: "25 Einträge",
                            fr: "25 éléments",
                            es: "25 elementos",
                            it: "25 elementi"
                        ),
                        isSelected: true,
                        href: "/preview/simple-menu?per=25"
                    ),
                    SimpleMenuOption(
                        id: "50",
                        title: tr(
                            "50 items",
                            de: "50 Einträge",
                            fr: "50 éléments",
                            es: "50 elementos",
                            it: "50 elementi"
                        ),
                        isSelected: false,
                        href: "/preview/simple-menu?per=50"
                    ),
                ],
                width: "w-36"
            )
        ),
        #previewVariant(
            tr(
                "Icon-Only Palette Trigger",
                [
                    "de": "Paletten-Auslöser nur als Icon",
                    "fr": "Déclencheur palette en icône seule",
                    "es": "Activador de paleta solo icono",
                    "it": "Trigger tavolozza solo icona",
                    "pt": "Acionador de paleta apenas ícone",
                    "nl": "Alleen pictogram palettrigger",
                    "da": "Kun ikon palette-udløser",
                    "sv": "Endast ikon palettutlösare",
                    "nb": "Kun ikon palettutløser",
                    "fi": "Vain kuvake -palettilaukaisin",
                    "is": "Aðeins tákn litaspjaldskveikja",
                    "el": "Έναυσμα παλέτας μόνο με εικονίδιο",
                    "tr": "Yalnızca simge palet tetikleyicisi",
                    "hu": "Csak ikon paletta indító",
                    "hr": "Okidač palete samo s ikonom",
                    "pl": "Wyzwalacz palety tylko jako ikona",
                    "sk": "Spúšťač palety iba ako ikona",
                    "cs": "Spouštěč palety pouze jako ikona",
                    "lb": "Paletten-Ausléiser nëmmen als Ikon",
                ]
            ),
            SimpleMenuData(
                ariaLabel: tr(
                    "Color theme",
                    de: "Farbschema",
                    fr: "Thème de couleurs",
                    es: "Tema de color",
                    it: "Tema colore"
                ),
                options: [
                    SimpleMenuOption(
                        id: "theme-default",
                        title: "emerald-mine",
                        isSelected: true,
                        clickAction: "alert('emerald-mine theme')"
                    ),
                    SimpleMenuOption(
                        id: "theme-bw",
                        title: "Black & White",
                        isSelected: false,
                        clickAction: "alert('black-and-white theme')"
                    ),
                ],
                width: "w-48",
                triggerIcon: .palette2,
                hasTriggerChevron: false
            )
        ),
        #previewVariant(
            tr(
                "Right-Aligned Menu with Option Icons",
                [
                    "de": "Rechtsbündiges Menü mit Options-Icons",
                    "fr": "Menu aligné à droite avec icônes d'options",
                    "es": "Menú alineado a la derecha con iconos de opción",
                    "it": "Menu allineato a destra con icone delle opzioni",
                    "pt": "Menu alinhado à direita com ícones de opção",
                    "nl": "Rechts uitgelijnd menu met optiepictogrammen",
                    "da": "Højrejusteret menu med valgmulighedsikoner",
                    "sv": "Högerjusterad meny med alternativikoner",
                    "nb": "Høyrejustert meny med alternativikoner",
                    "fi": "Oikealle tasattu valikko vaihtoehtokuvakkeilla",
                    "is": "Hægrijöfnuð valmynd með valkostartáknum",
                    "el": "Δεξιά στοιχισμένο μενού με εικονίδια επιλογών",
                    "tr": "Seçenek simgeli sağa hizalı menü",
                    "hu": "Jobbra zárt menü opcióikonokkal",
                    "hr": "Desno poravnati izbornik s ikonama opcija",
                    "pl": "Wyrównane do prawej menu z ikonami opcji",
                    "sk": "Vpravo zarovnaná ponuka s ikonami možností",
                    "cs": "Vpravo zarovnaná nabídka s ikonami možností",
                    "lb": "Rietsbünnegt Menü mat Optiouns-Ikonen",
                ]
            ),
            SimpleMenuData(
                ariaLabel: tr(
                    "User options",
                    de: "Benutzeroptionen",
                    fr: "Options utilisateur",
                    es: "Opciones de usuario",
                    it: "Opzioni utente"
                ),
                triggerText: tr(
                    "Profile",
                    de: "Profil",
                    fr: "Profil",
                    es: "Perfil",
                    it: "Profilo"
                ),
                options: [
                    SimpleMenuOption(
                        id: "account",
                        title: tr(
                            "Account settings",
                            de: "Kontoeinstellungen",
                            fr: "Paramètres du compte",
                            es: "Ajustes de la cuenta",
                            it: "Impostazioni account"
                        ),
                        clickAction: "alert('Account')",
                        icon: .person_fill
                    ),
                    SimpleMenuOption(
                        id: "cms",
                        title: "CMS",
                        clickAction: "alert('CMS')",
                        icon: .card_heading
                    ),
                    SimpleMenuOption(
                        id: "logout",
                        title: tr(
                            "Sign out",
                            de: "Abmelden",
                            fr: "Se déconnecter",
                            es: "Cerrar sesión",
                            it: "Esci"
                        ),
                        clickAction: "alert('Sign out')",
                        icon: .box_arrow_left
                    ),
                ],
                align: .left,
                width: "w-48"
            )
        ),
    ]

    func makeHtml(ctx: SimpleMenuData) -> String {
        let html = renderFragments(SimpleMenu(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {
        Basic(title: "Simple Menu") {
            Div {
                showComponentTitle("Simple Menu")

                for variant in variants {
                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div {
                            SimpleMenu(variant.data).render()
                        }
                        .class("mb-32 mt-4")
                    }
                }
            }
            .class("mt-4 space-y-6")
        }
        .render()
    }
}
