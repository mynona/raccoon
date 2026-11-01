import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct LinkButtonView: TemplateRepresentable {

    let variants: [PreviewVariant<LinkButtonData>] = [
        #previewVariant(
            tr(
                "Localized with Icon & Tooltip",
                [
                    "de": "Lokalisiert mit Icon & Tooltip",
                    "fr": "Localisé avec icône et infobulle",
                    "es": "Localizado con icono y tooltip",
                    "it": "Localizzato con icona e tooltip",
                    "pt": "Localizado com ícone e dica",
                    "nl": "Gelokaliseerd met pictogram & tooltip",
                    "da": "Lokaliseret med ikon og tooltip",
                    "sv": "Lokaliserad med ikon och verktygstips",
                    "nb": "Lokalisert med ikon og verktøytips",
                    "fi": "Lokalisoitu kuvakkeella ja työkaluvihjeellä",
                    "is": "Staðfært með tákni og vísbendingu",
                    "el": "Τοπικοποιημένο με εικονίδιο & επεξήγηση",
                    "tr": "Simgeli ve ipuçlu yerelleştirilmiş",
                    "hu": "Honosítva ikonnal és eszköztippel",
                    "hr": "Lokalizirano s ikonom i opisom",
                    "pl": "Zlokalizowane z ikoną i etykietą",
                    "sk": "Lokalizované s ikonou a popisom",
                    "cs": "Lokalizováno s ikonou a nápovědou",
                    "lb": "Lokaliséiert mat Ikon & Tooltip",
                ]
            ),
            LinkButtonData(
                label: tr(
                    "Save",
                    de: "Speichern",
                    fr: "Enregistrer",
                    es: "Guardar",
                    it: "Salva"
                ),
                tooltip: tr(
                    "Save your changes",
                    de: "Änderungen speichern",
                    fr: "Enregistrer vos modifications",
                    es: "Guardar los cambios",
                    it: "Salva le modifiche"
                ),
                tooltipPosition: .bottom,
                href: "#",
                buttonType: .primary,
                icon: .airplane,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Icon-Only Built-In Fallback",
                [
                    "de": "Nur Icon mit integriertem Fallback",
                    "fr": "Icône seule avec repli intégré",
                    "es": "Solo icono con respaldo integrado",
                    "it": "Solo icona con fallback integrato",
                    "pt": "Apenas ícone com alternativa integrada",
                    "nl": "Alleen pictogram met ingebouwde terugval",
                    "da": "Kun ikon med indbygget fallback",
                    "sv": "Endast ikon med inbyggd reserv",
                    "nb": "Kun ikon med innebygd reserveløsning",
                    "fi": "Vain kuvake sisäänrakennetulla varavaihtoehdolla",
                    "is": "Aðeins tákn með innbyggðum varakosti",
                    "el": "Μόνο εικονίδιο με ενσωματωμένη εφεδρεία",
                    "tr": "Yerleşik yedekli yalnızca simge",
                    "hu": "Csak ikon beépített tartalékkal",
                    "hr": "Samo ikona s ugrađenom zamjenom",
                    "pl": "Tylko ikona z wbudowaną alternatywą",
                    "sk": "Iba ikona so vstavanou zálohou",
                    "cs": "Pouze ikona s vestavěnou zálohou",
                    "lb": "Nëmmen Ikon mat agebautem Fallback",
                ]
            ),
            LinkButtonData(
                href: "#",
                buttonType: .icon,
                icon: nil,
                iconSize: nil,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Primary with Icon",
                [
                    "de": "Primär mit Icon",
                    "fr": "Principal avec icône",
                    "es": "Principal con icono",
                    "it": "Primario con icona",
                    "pt": "Primário com ícone",
                    "nl": "Primair met pictogram",
                    "da": "Primær med ikon",
                    "sv": "Primär med ikon",
                    "nb": "Primær med ikon",
                    "fi": "Ensisijainen kuvakkeella",
                    "is": "Aðalhnappur með tákni",
                    "el": "Πρωτεύον με εικονίδιο",
                    "tr": "Simgeli birincil",
                    "hu": "Elsődleges ikonnal",
                    "hr": "Primarno s ikonom",
                    "pl": "Główny z ikoną",
                    "sk": "Primárne s ikonou",
                    "cs": "Primární s ikonou",
                    "lb": "Primär mat Ikon",
                ]
            ),
            LinkButtonData(
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                tooltip: tr(
                    "Tooltip",
                    de: "Tooltip",
                    fr: "Infobulle",
                    es: "Información",
                    it: "Tooltip"
                ),
                tooltipPosition: .bottom,
                href: "#",
                buttonType: .primary,
                icon: .airplane,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Primary without Icon",
                [
                    "de": "Primär ohne Icon",
                    "fr": "Principal sans icône",
                    "es": "Principal sin icono",
                    "it": "Primario senza icona",
                    "pt": "Primário sem ícone",
                    "nl": "Primair zonder pictogram",
                    "da": "Primær uden ikon",
                    "sv": "Primär utan ikon",
                    "nb": "Primær uten ikon",
                    "fi": "Ensisijainen ilman kuvaketta",
                    "is": "Aðalhnappur án tákns",
                    "el": "Πρωτεύον χωρίς εικονίδιο",
                    "tr": "Simgesiz birincil",
                    "hu": "Elsődleges ikon nélkül",
                    "hr": "Primarno bez ikone",
                    "pl": "Główny bez ikony",
                    "sk": "Primárne bez ikony",
                    "cs": "Primární bez ikony",
                    "lb": "Primär ouni Ikon",
                ]
            ),
            LinkButtonData(
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                href: "#",
                buttonType: .primary,
                icon: nil,
                iconSize: nil,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Primary Full-Width",
                [
                    "de": "Primär in voller Breite",
                    "fr": "Principal pleine largeur",
                    "es": "Principal de ancho completo",
                    "it": "Primario a larghezza intera",
                    "pt": "Primário de largura total",
                    "nl": "Primair over volledige breedte",
                    "da": "Primær i fuld bredde",
                    "sv": "Primär i full bredd",
                    "nb": "Primær i full bredde",
                    "fi": "Ensisijainen täysleveä",
                    "is": "Aðalhnappur í fullri breidd",
                    "el": "Πρωτεύον πλήρους πλάτους",
                    "tr": "Tam genişlikli birincil",
                    "hu": "Elsődleges teljes szélességű",
                    "hr": "Primarno pune širine",
                    "pl": "Główny o pełnej szerokości",
                    "sk": "Primárne na celú šírku",
                    "cs": "Primární na celou šířku",
                    "lb": "Primär a voller Breet",
                ]
            ),
            LinkButtonData(
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                tooltip: tr(
                    "Tooltip",
                    de: "Tooltip",
                    fr: "Infobulle",
                    es: "Información",
                    it: "Tooltip"
                ),
                tooltipPosition: .bottom,
                href: "#",
                buttonType: .primary,
                icon: .airplane,
                iconSize: 16,
                hasFullWidth: true,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Primary Inverted",
                [
                    "de": "Primär invertiert",
                    "fr": "Principal inversé",
                    "es": "Principal invertido",
                    "it": "Primario invertito",
                    "pt": "Primário invertido",
                    "nl": "Primair geïnverteerd",
                    "da": "Primær inverteret",
                    "sv": "Primär inverterad",
                    "nb": "Primær invertert",
                    "fi": "Ensisijainen käänteinen",
                    "is": "Aðalhnappur umhverfur",
                    "el": "Πρωτεύον ανεστραμμένο",
                    "tr": "Ters birincil",
                    "hu": "Elsődleges invertált",
                    "hr": "Primarno invertirano",
                    "pl": "Główny odwrócony",
                    "sk": "Primárne invertované",
                    "cs": "Primární invertované",
                    "lb": "Primär invertéiert",
                ]
            ),
            LinkButtonData(
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                href: "#",
                buttonType: .primary,
                icon: .airplane,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        // secondary
        #previewVariant(
            tr(
                "Secondary with Icon",
                [
                    "de": "Sekundär mit Icon",
                    "fr": "Secondaire avec icône",
                    "es": "Secundario con icono",
                    "it": "Secondario con icona",
                    "pt": "Secundário com ícone",
                    "nl": "Secundair met pictogram",
                    "da": "Sekundær med ikon",
                    "sv": "Sekundär med ikon",
                    "nb": "Sekundær med ikon",
                    "fi": "Toissijainen kuvakkeella",
                    "is": "Aukahnappur með tákni",
                    "el": "Δευτερεύον με εικονίδιο",
                    "tr": "Simgeli ikincil",
                    "hu": "Másodlagos ikonnal",
                    "hr": "Sekundarno s ikonom",
                    "pl": "Drugorzędny z ikoną",
                    "sk": "Sekundárne s ikonou",
                    "cs": "Sekundární s ikonou",
                    "lb": "Sekundär mat Ikon",
                ]
            ),
            LinkButtonData(
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                href: "#",
                buttonType: .secondary,
                icon: .camera,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Secondary without Icon",
                [
                    "de": "Sekundär ohne Icon",
                    "fr": "Secondaire sans icône",
                    "es": "Secundario sin icono",
                    "it": "Secondario senza icona",
                    "pt": "Secundário sem ícone",
                    "nl": "Secundair zonder pictogram",
                    "da": "Sekundær uden ikon",
                    "sv": "Sekundär utan ikon",
                    "nb": "Sekundær uten ikon",
                    "fi": "Toissijainen ilman kuvaketta",
                    "is": "Aukahnappur án tákns",
                    "el": "Δευτερεύον χωρίς εικονίδιο",
                    "tr": "Simgesiz ikincil",
                    "hu": "Másodlagos ikon nélkül",
                    "hr": "Sekundarno bez ikone",
                    "pl": "Drugorzędny bez ikony",
                    "sk": "Sekundárne bez ikony",
                    "cs": "Sekundární bez ikony",
                    "lb": "Sekundär ouni Ikon",
                ]
            ),
            LinkButtonData(
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                href: "#",
                buttonType: .secondary,
                icon: nil,
                iconSize: nil,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Secondary Full-Width",
                [
                    "de": "Sekundär in voller Breite",
                    "fr": "Secondaire pleine largeur",
                    "es": "Secundario de ancho completo",
                    "it": "Secondario a larghezza intera",
                    "pt": "Secundário de largura total",
                    "nl": "Secundair over volledige breedte",
                    "da": "Sekundær i fuld bredde",
                    "sv": "Sekundär i full bredd",
                    "nb": "Sekundær i full bredde",
                    "fi": "Toissijainen täysleveä",
                    "is": "Aukahnappur í fullri breidd",
                    "el": "Δευτερεύον πλήρους πλάτους",
                    "tr": "Tam genişlikli ikincil",
                    "hu": "Másodlagos teljes szélességű",
                    "hr": "Sekundarno pune širine",
                    "pl": "Drugorzędny o pełnej szerokości",
                    "sk": "Sekundárne na celú šírku",
                    "cs": "Sekundární na celou šířku",
                    "lb": "Sekundär a voller Breet",
                ]
            ),
            LinkButtonData(
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                href: "#",
                buttonType: .secondary,
                icon: .camera,
                iconSize: 16,
                hasFullWidth: true,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Secondary Inverted",
                [
                    "de": "Sekundär invertiert",
                    "fr": "Secondaire inversé",
                    "es": "Secundario invertido",
                    "it": "Secondario invertito",
                    "pt": "Secundário invertido",
                    "nl": "Secundair geïnverteerd",
                    "da": "Sekundær inverteret",
                    "sv": "Sekundär inverterad",
                    "nb": "Sekundær invertert",
                    "fi": "Toissijainen käänteinen",
                    "is": "Aukahnappur umhverfur",
                    "el": "Δευτερεύον ανεστραμμένο",
                    "tr": "Ters ikincil",
                    "hu": "Másodlagos invertált",
                    "hr": "Sekundarno invertirano",
                    "pl": "Drugorzędny odwrócony",
                    "sk": "Sekundárne invertované",
                    "cs": "Sekundární invertované",
                    "lb": "Sekundär invertéiert",
                ]
            ),
            LinkButtonData(
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                href: "#",
                buttonType: .secondary,
                icon: .camera,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        // tertiary
        #previewVariant(
            tr(
                "Tertiary with Icon",
                [
                    "de": "Tertiär mit Icon",
                    "fr": "Tertiaire avec icône",
                    "es": "Terciario con icono",
                    "it": "Terziario con icona",
                    "pt": "Terciário com ícone",
                    "nl": "Tertiair met pictogram",
                    "da": "Tertiær med ikon",
                    "sv": "Tertiär med ikon",
                    "nb": "Tertiær med ikon",
                    "fi": "Kolmannen tason kuvakkeella",
                    "is": "Þriðja stigs með tákni",
                    "el": "Τριτεύον με εικονίδιο",
                    "tr": "Simgeli üçüncül",
                    "hu": "Harmadlagos ikonnal",
                    "hr": "Tercijarno s ikonom",
                    "pl": "Trzeciorzędny z ikoną",
                    "sk": "Terciárne s ikonou",
                    "cs": "Terciární s ikonou",
                    "lb": "Tertiär mat Ikon",
                ]
            ),
            LinkButtonData(
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                href: "#",
                buttonType: .tertiary,
                icon: .cake,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Tertiary without Icon",
                [
                    "de": "Tertiär ohne Icon",
                    "fr": "Tertiaire sans icône",
                    "es": "Terciario sin icono",
                    "it": "Terziario senza icona",
                    "pt": "Terciário sem ícone",
                    "nl": "Tertiair zonder pictogram",
                    "da": "Tertiær uden ikon",
                    "sv": "Tertiär utan ikon",
                    "nb": "Tertiær uten ikon",
                    "fi": "Kolmannen tason ilman kuvaketta",
                    "is": "Þriðja stigs án tákns",
                    "el": "Τριτεύον χωρίς εικονίδιο",
                    "tr": "Simgesiz üçüncül",
                    "hu": "Harmadlagos ikon nélkül",
                    "hr": "Tercijarno bez ikone",
                    "pl": "Trzeciorzędny bez ikony",
                    "sk": "Terciárne bez ikony",
                    "cs": "Terciární bez ikony",
                    "lb": "Tertiär ouni Ikon",
                ]
            ),
            LinkButtonData(
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                href: "#",
                buttonType: .tertiary,
                icon: nil,
                iconSize: nil,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Tertiary Full-Width",
                [
                    "de": "Tertiär in voller Breite",
                    "fr": "Tertiaire pleine largeur",
                    "es": "Terciario de ancho completo",
                    "it": "Terziario a larghezza intera",
                    "pt": "Terciário de largura total",
                    "nl": "Tertiair over volledige breedte",
                    "da": "Tertiær i fuld bredde",
                    "sv": "Tertiär i full bredd",
                    "nb": "Tertiær i full bredde",
                    "fi": "Kolmannen tason täysleveä",
                    "is": "Þriðja stigs í fullri breidd",
                    "el": "Τριτεύον πλήρους πλάτους",
                    "tr": "Tam genişlikli üçüncül",
                    "hu": "Harmadlagos teljes szélességű",
                    "hr": "Tercijarno pune širine",
                    "pl": "Trzeciorzędny o pełnej szerokości",
                    "sk": "Terciárne na celú šírku",
                    "cs": "Terciární na celou šířku",
                    "lb": "Tertiär a voller Breet",
                ]
            ),
            LinkButtonData(
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                href: "#",
                buttonType: .tertiary,
                icon: .cake,
                iconSize: 16,
                hasFullWidth: true,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Tertiary Inverted",
                [
                    "de": "Tertiär invertiert",
                    "fr": "Tertiaire inversé",
                    "es": "Terciario invertido",
                    "it": "Terziario invertito",
                    "pt": "Terciário invertido",
                    "nl": "Tertiair geïnverteerd",
                    "da": "Tertiær inverteret",
                    "sv": "Tertiär inverterad",
                    "nb": "Tertiær invertert",
                    "fi": "Kolmannen tason käänteinen",
                    "is": "Þriðja stigs umhverfur",
                    "el": "Τριτεύον ανεστραμμένο",
                    "tr": "Ters üçüncül",
                    "hu": "Harmadlagos invertált",
                    "hr": "Tercijarno invertirano",
                    "pl": "Trzeciorzędny odwrócony",
                    "sk": "Terciárne invertované",
                    "cs": "Terciární invertované",
                    "lb": "Tertiär invertéiert",
                ]
            ),
            LinkButtonData(
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                href: "#",
                buttonType: .tertiary,
                icon: .cake,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        // warning
        #previewVariant(
            tr(
                "Warning with Icon",
                [
                    "de": "Warnung mit Icon",
                    "fr": "Avertissement avec icône",
                    "es": "Advertencia con icono",
                    "it": "Avviso con icona",
                    "pt": "Aviso com ícone",
                    "nl": "Waarschuwing met pictogram",
                    "da": "Advarsel med ikon",
                    "sv": "Varning med ikon",
                    "nb": "Advarsel med ikon",
                    "fi": "Varoitus kuvakkeella",
                    "is": "Viðvörun með tákni",
                    "el": "Προειδοποίηση με εικονίδιο",
                    "tr": "Simgeli uyarı",
                    "hu": "Figyelmeztetés ikonnal",
                    "hr": "Upozorenje s ikonom",
                    "pl": "Ostrzeżenie z ikoną",
                    "sk": "Upozornenie s ikonou",
                    "cs": "Upozornění s ikonou",
                    "lb": "Warnung mat Ikon",
                ]
            ),
            LinkButtonData(
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                tooltip: tr(
                    "Tooltip",
                    de: "Tooltip",
                    fr: "Infobulle",
                    es: "Información",
                    it: "Tooltip"
                ),
                tooltipPosition: .bottom,
                href: "#",
                buttonType: .warning,
                icon: .tree,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Warning without Icon",
                [
                    "de": "Warnung ohne Icon",
                    "fr": "Avertissement sans icône",
                    "es": "Advertencia sin icono",
                    "it": "Avviso senza icona",
                    "pt": "Aviso sem ícone",
                    "nl": "Waarschuwing zonder pictogram",
                    "da": "Advarsel uden ikon",
                    "sv": "Varning utan ikon",
                    "nb": "Advarsel uten ikon",
                    "fi": "Varoitus ilman kuvaketta",
                    "is": "Viðvörun án tákns",
                    "el": "Προειδοποίηση χωρίς εικονίδιο",
                    "tr": "Simgesiz uyarı",
                    "hu": "Figyelmeztetés ikon nélkül",
                    "hr": "Upozorenje bez ikone",
                    "pl": "Ostrzeżenie bez ikony",
                    "sk": "Upozornenie bez ikony",
                    "cs": "Upozornění bez ikony",
                    "lb": "Warnung ouni Ikon",
                ]
            ),
            LinkButtonData(
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                href: "#",
                buttonType: .warning,
                icon: nil,
                iconSize: nil,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Warning Full-Width",
                [
                    "de": "Warnung in voller Breite",
                    "fr": "Avertissement pleine largeur",
                    "es": "Advertencia de ancho completo",
                    "it": "Avviso a larghezza intera",
                    "pt": "Aviso de largura total",
                    "nl": "Waarschuwing over volledige breedte",
                    "da": "Advarsel i fuld bredde",
                    "sv": "Varning i full bredd",
                    "nb": "Advarsel i full bredde",
                    "fi": "Varoitus täysleveä",
                    "is": "Viðvörun í fullri breidd",
                    "el": "Προειδοποίηση πλήρους πλάτους",
                    "tr": "Tam genişlikli uyarı",
                    "hu": "Figyelmeztetés teljes szélességű",
                    "hr": "Upozorenje pune širine",
                    "pl": "Ostrzeżenie o pełnej szerokości",
                    "sk": "Upozornenie na celú šírku",
                    "cs": "Upozornění na celou šířku",
                    "lb": "Warnung a voller Breet",
                ]
            ),
            LinkButtonData(
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                href: "#",
                buttonType: .warning,
                icon: .tree,
                iconSize: 16,
                hasFullWidth: true,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Warning Inverted",
                [
                    "de": "Warnung invertiert",
                    "fr": "Avertissement inversé",
                    "es": "Advertencia invertida",
                    "it": "Avviso invertito",
                    "pt": "Aviso invertido",
                    "nl": "Waarschuwing geïnverteerd",
                    "da": "Advarsel inverteret",
                    "sv": "Varning inverterad",
                    "nb": "Advarsel invertert",
                    "fi": "Varoitus käänteinen",
                    "is": "Viðvörun umhverf",
                    "el": "Προειδοποίηση ανεστραμμένη",
                    "tr": "Ters uyarı",
                    "hu": "Figyelmeztetés invertált",
                    "hr": "Upozorenje invertirano",
                    "pl": "Ostrzeżenie odwrócone",
                    "sk": "Upozornenie invertované",
                    "cs": "Upozornění invertované",
                    "lb": "Warnung invertéiert",
                ]
            ),
            LinkButtonData(
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                href: "#",
                buttonType: .warning,
                icon: .tree,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        // icon
        #previewVariant(
            tr(
                "Icon-Only Link",
                [
                    "de": "Link nur als Icon",
                    "fr": "Lien icône seule",
                    "es": "Enlace solo icono",
                    "it": "Collegamento solo icona",
                    "pt": "Link apenas ícone",
                    "nl": "Link alleen pictogram",
                    "da": "Link kun med ikon",
                    "sv": "Länk endast ikon",
                    "nb": "Lenke kun med ikon",
                    "fi": "Linkki vain kuvakkeena",
                    "is": "Tengill aðeins tákn",
                    "el": "Σύνδεσμος μόνο εικονίδιο",
                    "tr": "Yalnızca simge bağlantı",
                    "hu": "Csak ikon hivatkozás",
                    "hr": "Veza samo s ikonom",
                    "pl": "Link tylko jako ikona",
                    "sk": "Odkaz iba ako ikona",
                    "cs": "Odkaz pouze jako ikona",
                    "lb": "Link nëmmen als Ikon",
                ]
            ),
            LinkButtonData(
                label: nil,
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                tooltip: tr(
                    "Tooltip",
                    de: "Tooltip",
                    fr: "Infobulle",
                    es: "Información",
                    it: "Tooltip"
                ),
                tooltipPosition: .bottom,
                href: "#",
                buttonType: .icon,
                icon: .mouse,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Icon-Only Full-Width",
                [
                    "de": "Nur Icon in voller Breite",
                    "fr": "Icône seule pleine largeur",
                    "es": "Solo icono de ancho completo",
                    "it": "Solo icona a larghezza intera",
                    "pt": "Apenas ícone de largura total",
                    "nl": "Alleen pictogram over volledige breedte",
                    "da": "Kun ikon i fuld bredde",
                    "sv": "Endast ikon i full bredd",
                    "nb": "Kun ikon i full bredde",
                    "fi": "Vain kuvake täysleveä",
                    "is": "Aðeins tákn í fullri breidd",
                    "el": "Μόνο εικονίδιο πλήρους πλάτους",
                    "tr": "Tam genişlikli yalnızca simge",
                    "hu": "Csak ikon teljes szélességű",
                    "hr": "Samo ikona pune širine",
                    "pl": "Tylko ikona o pełnej szerokości",
                    "sk": "Iba ikona na celú šírku",
                    "cs": "Pouze ikona na celou šířku",
                    "lb": "Nëmmen Ikon a voller Breet",
                ]
            ),
            LinkButtonData(
                label: nil,
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                tooltip: tr(
                    "Tooltip",
                    de: "Tooltip",
                    fr: "Infobulle",
                    es: "Información",
                    it: "Tooltip"
                ),
                tooltipPosition: .top,
                href: "#",
                buttonType: .icon,
                icon: .mouse,
                iconSize: 16,
                hasFullWidth: true,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Icon-Only Inverted",
                [
                    "de": "Nur Icon invertiert",
                    "fr": "Icône seule inversée",
                    "es": "Solo icono invertido",
                    "it": "Solo icona invertito",
                    "pt": "Apenas ícone invertido",
                    "nl": "Alleen pictogram geïnverteerd",
                    "da": "Kun ikon inverteret",
                    "sv": "Endast ikon inverterad",
                    "nb": "Kun ikon invertert",
                    "fi": "Vain kuvake käänteinen",
                    "is": "Aðeins tákn umhverft",
                    "el": "Μόνο εικονίδιο ανεστραμμένο",
                    "tr": "Ters yalnızca simge",
                    "hu": "Csak ikon invertált",
                    "hr": "Samo ikona invertirano",
                    "pl": "Tylko ikona odwrócona",
                    "sk": "Iba ikona invertované",
                    "cs": "Pouze ikona invertované",
                    "lb": "Nëmmen Ikon invertéiert",
                ]
            ),
            LinkButtonData(
                label: nil,
                ariaLabel: tr(
                    "aria-label",
                    de: "Aria-Label",
                    fr: "Aria-label",
                    es: "Aria-label",
                    it: "Aria-label"
                ),
                href: "#",
                buttonType: .icon,
                icon: .mouse,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Multiline Text Wrapping with Icon",
                [
                    "de": "Mehrzeiliger Textumbruch mit Icon",
                    "fr": "Retour à la ligne multiligne avec icône",
                    "es": "Ajuste de texto multilínea con icono",
                    "it": "A capo multilinea con icona",
                    "pt": "Quebra de texto em várias linhas com ícone",
                    "nl": "Tekstomloop over meerdere regels met pictogram",
                    "da": "Tekstombrydning over flere linjer med ikon",
                    "sv": "Fler raders textbrytning med ikon",
                    "nb": "Flerlinjet tekstbryting med ikon",
                    "fi": "Monirivinen tekstinkierto kuvakkeella",
                    "is": "Margra lína textaskipting með tákni",
                    "el": "Αναδίπλωση κειμένου πολλών γραμμών με εικονίδιο",
                    "tr": "Simgeli çok satırlı metin kaydırma",
                    "hu": "Többsoros szövegtördelés ikonnal",
                    "hr": "Prijelom teksta u više redaka s ikonom",
                    "pl": "Wielowierszowe zawijanie tekstu z ikoną",
                    "sk": "Viacriadkové zalamovanie textu s ikonou",
                    "cs": "Víceřádkové zalamování textu s ikonou",
                    "lb": "Méizeilegen Textëmbroch mat Ikon",
                ]
            ),
            LinkButtonData(
                label:
                    tr(
                        "This is a very long link button label that exceeds container width and wraps onto multiple lines cleanly with vertical centering",
                        de:
                            "Dies ist eine sehr lange Link-Button-Beschriftung, die die Containerbreite überschreitet und sauber über mehrere Zeilen mit vertikaler Zentrierung umbricht",
                        fr:
                            "Ceci est un libellé de bouton lien très long qui dépasse la largeur du conteneur et s'étend proprement sur plusieurs lignes avec centrage vertical",
                        es:
                            "Esta es una etiqueta de botón de enlace muy larga que supera el ancho del contenedor y se distribuye limpiamente en varias líneas con centrado vertical",
                        it:
                            "Questa è un'etichetta molto lunga che supera la larghezza del contenitore e va a capo in modo ordinato su più righe con centratura verticale"
                    ),
                ariaLabel: tr(
                    "Detailed long link button",
                    de: "Ausführlicher langer Link-Button",
                    fr: "Long bouton lien détaillé",
                    es: "Botón de enlace largo y detallado",
                    it: "Pulsante link lungo e dettagliato"
                ),
                href: "#",
                buttonType: .primary,
                icon: .airplane,
                iconSize: 16,
                hasFullWidth: false,
                contentTracker: tracker
            )
        ),
    ]

    func makeHtml(ctx: LinkButtonData) -> String {
        let html = renderFragments(LinkButton(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("LinkButton")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { LinkButton(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
