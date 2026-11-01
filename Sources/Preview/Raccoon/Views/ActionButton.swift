import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct ButtonView: TemplateRepresentable {

    let variants: [PreviewVariant<ActionButtonData>] = [
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
            ActionButtonData(
                id: "btn-i18n",
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
                htmlType: .button,
                buttonType: .primary,
                icon: .airplane,
                matomoStatus: .DEACTIVATED,
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
            ActionButtonData(
                id: "btn-i18n-fallback",
                htmlType: .button,
                buttonType: .icon,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Full-Width Primary with Icon",
                [
                    "de": "Vollbreite primäre Schaltfläche mit Icon",
                    "fr": "Bouton principal pleine largeur avec icône",
                    "es": "Botón principal de ancho completo con icono",
                    "it": "Pulsante primario a larghezza intera con icona",
                    "pt": "Botão primário de largura total com ícone",
                    "nl": "Primaire knop over volledige breedte met pictogram",
                    "da": "Primær knap i fuld bredde med ikon",
                    "sv": "Primär knapp i full bredd med ikon",
                    "nb": "Primærknapp i full bredde med ikon",
                    "fi": "Täysleveä ensisijainen painike kuvakkeella",
                    "is": "Aðalhnappur í fullri breidd með tákni",
                    "el": "Πρωτεύον κουμπί πλήρους πλάτους με εικονίδιο",
                    "tr": "Simgeli tam genişlikli birincil düğme",
                    "hu": "Teljes szélességű elsődleges gomb ikonnal",
                    "hr": "Primarni gumb pune širine s ikonom",
                    "pl": "Przycisk główny o pełnej szerokości z ikoną",
                    "sk": "Primárne tlačidlo na celú šírku s ikonou",
                    "cs": "Primární tlačítko na celou šířku s ikonou",
                    "lb": "Primäre Knäppchen a voller Breet mat Ikon",
                ]
            ),
            ActionButtonData(
                id: "btn-1",
                clickAction: "alert('ClickAction fired');",
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "Aria-Label",
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
                htmlType: .submit,
                buttonType: .primary,
                state: .enabled,
                size: .base,
                hasFullWidth: true,
                icon: .airplane,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Primary with Matomo",
                [
                    "de": "Primäre Schaltfläche mit Matomo",
                    "fr": "Bouton principal avec Matomo",
                    "es": "Botón principal con Matomo",
                    "it": "Pulsante primario con Matomo",
                    "pt": "Botão primário com Matomo",
                    "nl": "Primaire knop met Matomo",
                    "da": "Primær knap med Matomo",
                    "sv": "Primär knapp med Matomo",
                    "nb": "Primærknapp med Matomo",
                    "fi": "Ensisijainen painike Matomolla",
                    "is": "Aðalhnappur með Matomo",
                    "el": "Πρωτεύον κουμπί με Matomo",
                    "tr": "Matomo ile birincil düğme",
                    "hu": "Elsődleges gomb Matomóval",
                    "hr": "Primarni gumb s Matomom",
                    "pl": "Przycisk główny z Matomo",
                    "sk": "Primárne tlačidlo s Matomom",
                    "cs": "Primární tlačítko s Matomem",
                    "lb": "Primäre Knäppchen mat Matomo",
                ]
            ),
            ActionButtonData(
                id: "btn-2",
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "Aria-Label",
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
                tooltipPosition: .right,
                htmlType: .submit,
                buttonType: .primary,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: nil,
                iconPosition: .left,
                matomoStatus: .ACCEPTED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Secondary Style",
                [
                    "de": "Sekundärer Stil",
                    "fr": "Style secondaire",
                    "es": "Estilo secundario",
                    "it": "Stile secondario",
                    "pt": "Estilo secundário",
                    "nl": "Secundaire stijl",
                    "da": "Sekundær stil",
                    "sv": "Sekundär stil",
                    "nb": "Sekundær stil",
                    "fi": "Toissijainen tyyli",
                    "is": "Auka stíll",
                    "el": "Δευτερεύον στυλ",
                    "tr": "İkincil stil",
                    "hu": "Másodlagos stílus",
                    "hr": "Sekundarni stil",
                    "pl": "Styl drugorzędny",
                    "sk": "Sekundárny štýl",
                    "cs": "Sekundární styl",
                    "lb": "Sekundäre Stil",
                ]
            ),
            ActionButtonData(
                id: "btn-3",
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "Aria-Label",
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
                tooltipPosition: .right,
                htmlType: .submit,
                buttonType: .secondary,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: nil,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Tertiary Style",
                [
                    "de": "Tertiärer Stil",
                    "fr": "Style tertiaire",
                    "es": "Estilo terciario",
                    "it": "Stile terziario",
                    "pt": "Estilo terciário",
                    "nl": "Tertiaire stijl",
                    "da": "Tertiær stil",
                    "sv": "Tertiär stil",
                    "nb": "Tertiær stil",
                    "fi": "Kolmannen tason tyyli",
                    "is": "Þriðja stigs stíll",
                    "el": "Τριτεύον στυλ",
                    "tr": "Üçüncül stil",
                    "hu": "Harmadlagos stílus",
                    "hr": "Tercijarni stil",
                    "pl": "Styl trzeciorzędny",
                    "sk": "Terciárny štýl",
                    "cs": "Terciární styl",
                    "lb": "Tertiäre Stil",
                ]
            ),
            ActionButtonData(
                id: "btn-8",
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "Aria-Label",
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
                tooltipPosition: .right,
                htmlType: .submit,
                buttonType: .tertiary,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: nil,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Warning Style",
                [
                    "de": "Warnstil",
                    "fr": "Style d'avertissement",
                    "es": "Estilo de advertencia",
                    "it": "Stile di avviso",
                    "pt": "Estilo de aviso",
                    "nl": "Waarschuwingsstijl",
                    "da": "Advarselsstil",
                    "sv": "Varningsstil",
                    "nb": "Advarselsstil",
                    "fi": "Varoitustyyli",
                    "is": "Viðvörunarstíll",
                    "el": "Στυλ προειδοποίησης",
                    "tr": "Uyarı stili",
                    "hu": "Figyelmeztető stílus",
                    "hr": "Stil upozorenja",
                    "pl": "Styl ostrzegawczy",
                    "sk": "Štýl upozornenia",
                    "cs": "Styl upozornění",
                    "lb": "Warnstil",
                ]
            ),
            ActionButtonData(
                id: "btn-12",
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "Aria-Label",
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
                tooltipPosition: .right,
                htmlType: .submit,
                buttonType: .warning,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: nil,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Icon-Only Cake with Tooltip",
                [
                    "de": "Kuchen-Icon mit Tooltip",
                    "fr": "Icône gâteau seule avec infobulle",
                    "es": "Solo icono pastel con información",
                    "it": "Solo icona torta con tooltip",
                    "pt": "Apenas ícone de bolo com dica",
                    "nl": "Alleen taart-pictogram met tooltip",
                    "da": "Kun kage-ikon med tooltip",
                    "sv": "Endast tårtikon med verktygstips",
                    "nb": "Kun kakeikon med verktøytips",
                    "fi": "Vain kakkukuvake työkaluvihjeellä",
                    "is": "Aðeins kökutákn með vísbendingu",
                    "el": "Μόνο εικονίδιο τούρτας με επεξήγηση",
                    "tr": "İpucu ile yalnızca pasta simgesi",
                    "hu": "Csak torta ikon eszköztippel",
                    "hr": "Samo ikona torte s opisom",
                    "pl": "Tylko ikona tortu z etykietą narzędzia",
                    "sk": "Iba ikona koláča s popisom",
                    "cs": "Pouze ikona dortu s nápovědou",
                    "lb": "Nëmmen Kuch-Ikon mat Tooltip",
                ]
            ),
            ActionButtonData(
                id: "btn-22",
                label: nil,
                ariaLabel: tr(
                    "Aria-Label",
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
                htmlType: .submit,
                buttonType: .icon,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: .cake,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Formaction Native POST Submission",
                [
                    "de": "Formaction native POST-Übermittlung",
                    "fr": "Soumission POST native via formaction",
                    "es": "Envío POST nativo con formaction",
                    "it": "Invio POST nativo con formaction",
                    "pt": "Envio POST nativo com formaction",
                    "nl": "Native POST-verzending via formaction",
                    "da": "Indbygget POST-afsendelse via formaction",
                    "sv": "Inbyggd POST-skickning via formaction",
                    "nb": "Innebygd POST-innsending via formaction",
                    "fi": "Natiivi POST-lähetys formactionilla",
                    "is": "Innbyggð POST-sending með formaction",
                    "el": "Εγγενής υποβολή POST μέσω formaction",
                    "tr": "Formaction ile yerel POST gönderimi",
                    "hu": "Natív POST küldés formactionnel",
                    "hr": "Izvorno POST slanje putem formactiona",
                    "pl": "Natywne przesyłanie POST przez formaction",
                    "sk": "Natívne odoslanie POST cez formaction",
                    "cs": "Nativní odeslání POST přes formaction",
                    "lb": "Formaction nativ POST-Iwwerdroung",
                ]
            ),
            ActionButtonData(
                id: "btn-action",
                action: "/preview-save",  // -> becomes formaction="/preview-save"
                method: .post,  // -> becomes formmethod="post"
                label: tr(
                    "Submit to /preview-save",
                    de: "An /preview-save senden",
                    fr: "Envoyer à /preview-save",
                    es: "Enviar a /preview-save",
                    it: "Invia a /preview-save"
                ),
                ariaLabel: tr(
                    "SubmitAction",
                    de: "Aktion absenden",
                    fr: "Action d'envoi",
                    es: "Acción de envío",
                    it: "Azione di invio"
                ),
                tooltip: tr(
                    "Submits form to server",
                    de: "Sendet das Formular an den Server",
                    fr: "Envoie le formulaire au serveur",
                    es: "Envía el formulario al servidor",
                    it: "Invia il modulo al server"
                ),
                tooltipPosition: .top,
                htmlType: .submit,
                buttonType: .secondary,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: nil,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Reactive Dynamic Formaction",
                [
                    "de": "Reaktive dynamische Formaction",
                    "fr": "Formaction dynamique réactive",
                    "es": "Formaction reactiva dinámica",
                    "it": "Formaction reattiva dinamica",
                    "pt": "Formaction dinâmico reativo",
                    "nl": "Reactieve dynamische formaction",
                    "da": "Reaktiv dynamisk formaction",
                    "sv": "Reaktiv dynamisk formaction",
                    "nb": "Reaktiv dynamisk formaction",
                    "fi": "Reaktiivinen dynaaminen formaction",
                    "is": "Hvarfgjörn kvik formaction",
                    "el": "Αντιδραστικό δυναμικό formaction",
                    "tr": "Reaktif dinamik formaction",
                    "hu": "Reaktív dinamikus formaction",
                    "hr": "Reaktivni dinamički formaction",
                    "pl": "Reaktywne dynamiczne formaction",
                    "sk": "Reaktívne dynamické formaction",
                    "cs": "Reaktivní dynamické formaction",
                    "lb": "Reaktiv dynamesch Formaction",
                ]
            ),
            ActionButtonData(
                id: "btn-bindAction",
                bindAction: "dynamicUrl",  // -> becomes x-bind:formaction="dynamicUrl"
                method: .post,
                label: tr(
                    "Submit to dynamic URL",
                    de: "An dynamische URL senden",
                    fr: "Envoyer à l'URL dynamique",
                    es: "Enviar a URL dinámica",
                    it: "Invia a URL dinamico"
                ),
                ariaLabel: tr(
                    "BindAction",
                    de: "Bindungsaktion",
                    fr: "Action liée",
                    es: "Acción vinculada",
                    it: "Azione associata"
                ),
                tooltip: tr(
                    "Reactive formaction via x-bind:formaction",
                    de: "Reaktive formaction über x-bind:formaction",
                    fr: "Formaction réactive via x-bind:formaction",
                    es: "Formaction reactiva mediante x-bind:formaction",
                    it: "Formaction reattiva tramite x-bind:formaction"
                ),
                tooltipPosition: .right,
                htmlType: .submit,
                buttonType: .tertiary,
                state: .enabled,
                size: .base,
                hasFullWidth: false,
                icon: nil,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Disabled Primary",
                [
                    "de": "Deaktiviert primär",
                    "fr": "Principal désactivé",
                    "es": "Principal deshabilitado",
                    "it": "Primario disabilitato",
                    "pt": "Primário desativado",
                    "nl": "Uitgeschakeld primair",
                    "da": "Deaktiveret primær",
                    "sv": "Inaktiverad primär",
                    "nb": "Deaktivert primær",
                    "fi": "Poistettu käytöstä ensisijainen",
                    "is": "Óvirkur aðalhnappur",
                    "el": "Απενεργοποιημένο πρωτεύον",
                    "tr": "Devre dışı birincil",
                    "hu": "Letiltott elsődleges",
                    "hr": "Onemogućeni primarni",
                    "pl": "Wyłączony główny",
                    "sk": "Zakázané primárne",
                    "cs": "Zakázané primární",
                    "lb": "Desaktivéiert primär",
                ]
            ),
            ActionButtonData(
                id: "btn-disabled-primary",
                clickAction: "alert('This must never fire');",
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "Disabled primary button",
                    de: "Deaktivierte primäre Schaltfläche",
                    fr: "Bouton principal désactivé",
                    es: "Botón principal deshabilitado",
                    it: "Pulsante primario disabilitato"
                ),
                tooltip: tr(
                    "Tooltip",
                    de: "Tooltip",
                    fr: "Infobulle",
                    es: "Información",
                    it: "Tooltip"
                ),
                tooltipPosition: .right,
                htmlType: .submit,
                buttonType: .primary,
                state: .disabled,
                size: .base,
                hasFullWidth: false,
                icon: .airplane,
                iconPosition: .left,
                matomoStatus: .DEACTIVATED,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Disabled Secondary",
                [
                    "de": "Deaktiviert sekundär",
                    "fr": "Secondaire désactivé",
                    "es": "Secundario deshabilitado",
                    "it": "Secondario disabilitato",
                    "pt": "Secundário desativado",
                    "nl": "Uitgeschakeld secundair",
                    "da": "Deaktiveret sekundær",
                    "sv": "Inaktiverad sekundär",
                    "nb": "Deaktivert sekundær",
                    "fi": "Poistettu käytöstä toissijainen",
                    "is": "Óvirkur aukahnappur",
                    "el": "Απενεργοποιημένο δευτερεύον",
                    "tr": "Devre dışı ikincil",
                    "hu": "Letiltott másodlagos",
                    "hr": "Onemogućeni sekundarni",
                    "pl": "Wyłączony drugorzędny",
                    "sk": "Zakázané sekundárne",
                    "cs": "Zakázané sekundární",
                    "lb": "Desaktivéiert sekundär",
                ]
            ),
            ActionButtonData(
                id: "btn-disabled-secondary",
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "Disabled secondary button",
                    de: "Deaktivierte sekundäre Schaltfläche",
                    fr: "Bouton secondaire désactivé",
                    es: "Botón secundario deshabilitado",
                    it: "Pulsante secondario disabilitato"
                ),
                buttonType: .secondary,
                state: .disabled,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Disabled Tertiary",
                [
                    "de": "Deaktiviert tertiär",
                    "fr": "Tertiaire désactivé",
                    "es": "Terciario deshabilitado",
                    "it": "Terziario disabilitato",
                    "pt": "Terciário desativado",
                    "nl": "Uitgeschakeld tertiair",
                    "da": "Deaktiveret tertiær",
                    "sv": "Inaktiverad tertiär",
                    "nb": "Deaktivert tertiær",
                    "fi": "Poistettu käytöstä kolmannen tason",
                    "is": "Óvirkur þriðja stigs",
                    "el": "Απενεργοποιημένο τριτεύον",
                    "tr": "Devre dışı üçüncül",
                    "hu": "Letiltott harmadlagos",
                    "hr": "Onemogućeni tercijarni",
                    "pl": "Wyłączony trzeciorzędny",
                    "sk": "Zakázané terciárne",
                    "cs": "Zakázané terciární",
                    "lb": "Desaktivéiert tertiär",
                ]
            ),
            ActionButtonData(
                id: "btn-disabled-tertiary",
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "Disabled tertiary button",
                    de: "Deaktivierte tertiäre Schaltfläche",
                    fr: "Bouton tertiaire désactivé",
                    es: "Botón terciario deshabilitado",
                    it: "Pulsante terziario disabilitato"
                ),
                buttonType: .tertiary,
                state: .disabled,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Disabled Warning",
                [
                    "de": "Deaktivierte Warnung",
                    "fr": "Avertissement désactivé",
                    "es": "Advertencia deshabilitada",
                    "it": "Avviso disabilitato",
                    "pt": "Aviso desativado",
                    "nl": "Uitgeschakelde waarschuwing",
                    "da": "Deaktiveret advarsel",
                    "sv": "Inaktiverad varning",
                    "nb": "Deaktivert advarsel",
                    "fi": "Poistettu käytöstä varoitus",
                    "is": "Óvirk viðvörun",
                    "el": "Απενεργοποιημένη προειδοποίηση",
                    "tr": "Devre dışı uyarı",
                    "hu": "Letiltott figyelmeztetés",
                    "hr": "Onemogućeno upozorenje",
                    "pl": "Wyłączone ostrzeżenie",
                    "sk": "Zakázané upozornenie",
                    "cs": "Zakázané upozornění",
                    "lb": "Desaktivéiert Warnung",
                ]
            ),
            ActionButtonData(
                id: "btn-disabled-warning",
                label: tr(
                    "Label",
                    de: "Beschriftung",
                    fr: "Libellé",
                    es: "Etiqueta",
                    it: "Etichetta"
                ),
                ariaLabel: tr(
                    "Disabled warning button",
                    de: "Deaktivierte Warn-Schaltfläche",
                    fr: "Bouton d'avertissement désactivé",
                    es: "Botón de advertencia deshabilitado",
                    it: "Pulsante di avviso disabilitato"
                ),
                buttonType: .warning,
                state: .disabled,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Disabled Icon-Only",
                [
                    "de": "Deaktiviert nur Icon",
                    "fr": "Icône seule désactivée",
                    "es": "Solo icono deshabilitado",
                    "it": "Solo icona disabilitato",
                    "pt": "Apenas ícone desativado",
                    "nl": "Alleen pictogram uitgeschakeld",
                    "da": "Kun ikon deaktiveret",
                    "sv": "Endast ikon inaktiverad",
                    "nb": "Kun ikon deaktivert",
                    "fi": "Vain kuvake poistettu käytöstä",
                    "is": "Aðeins tákn óvirkt",
                    "el": "Μόνο εικονίδιο απενεργοποιημένο",
                    "tr": "Yalnızca simge devre dışı",
                    "hu": "Csak ikon letiltva",
                    "hr": "Samo ikona onemogućeno",
                    "pl": "Tylko ikona wyłączona",
                    "sk": "Iba ikona zakázané",
                    "cs": "Pouze ikona zakázáno",
                    "lb": "Nëmmen Ikon desaktivéiert",
                ]
            ),
            ActionButtonData(
                id: "btn-disabled-icon",
                ariaLabel: tr(
                    "Disabled icon button",
                    de: "Deaktivierte Icon-Schaltfläche",
                    fr: "Bouton icône désactivé",
                    es: "Botón de icono deshabilitado",
                    it: "Pulsante con icona disabilitato"
                ),
                tooltip: tr(
                    "Tooltip",
                    de: "Tooltip",
                    fr: "Infobulle",
                    es: "Información",
                    it: "Tooltip"
                ),
                tooltipPosition: .bottom,
                buttonType: .icon,
                state: .disabled,
                icon: .cake,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Auto-Generated ID Tooltip Disambiguation (First)",
                [
                    "de": "Automatische ID-Tooltip-Eindeutigkeit (Erste)",
                    "fr": "Désambiguïsation d'infobulle par ID auto (Premier)",
                    "es": "Desambiguación de tooltip por ID automático (Primero)",
                    "it": "Disambiguazione tooltip con ID automatico (Primo)",
                    "pt": "Desambiguação de dica por ID automático (Primeiro)",
                    "nl": "Automatische ID-tooltip ondubbelzinnigheid (Eerste)",
                    "da": "Automatisk ID-tooltip entydighed (Første)",
                    "sv": "Automatisk ID-verktygstips särskiljning (Första)",
                    "nb": "Automatisk ID-verktøytips entydighet (Første)",
                    "fi": "Automaattinen ID-työkaluvihjeen erottelu (Ensimmäinen)",
                    "is": "Sjálfvirk ID vísbendingaaðgreining (Fyrsta)",
                    "el": "Αποσαφήνιση επεξήγησης αυτόματου αναγνωριστικού (Πρώτο)",
                    "tr": "Otomatik kimlikli ipucu ayrımı (İlk)",
                    "hu": "Automatikus azonosító eszköztipp egyértelműsítés (Első)",
                    "hr": "Razlučivanje opisa automatskim ID-om (Prvi)",
                    "pl": "Rozróżnienie etykiet z automatycznym ID (Pierwsze)",
                    "sk": "Rozlíšenie popisu s automatickým ID (Prvé)",
                    "cs": "Rozlišení nápovědy s automatickým ID (První)",
                    "lb": "Automatesch ID-Tooltip Eendeitegkeet (Éischt)",
                ]
            ),
            ActionButtonData(
                ariaLabel: tr(
                    "Icon button without id, first",
                    de: "Icon-Schaltfläche ohne ID, erste",
                    fr: "Bouton icône sans id, premier",
                    es: "Botón de icono sin id, primero",
                    it: "Pulsante con icona senza id, primo"
                ),
                tooltip: tr(
                    "Same tooltip text on all three",
                    de: "Gleicher Tooltip-Text bei allen dreien",
                    fr: "Même texte d'infobulle pour les trois",
                    es: "Mismo texto de información en los tres",
                    it: "Stesso testo del tooltip per tutti e tre"
                ),
                tooltipPosition: .top,
                buttonType: .tertiary,
                icon: .airplane,
                contentTracker: tracker
            )
        ),
        #previewVariant(
            tr(
                "Auto-Generated ID Tooltip Disambiguation (Second)",
                [
                    "de": "Automatische ID-Tooltip-Eindeutigkeit (Zweite)",
                    "fr": "Désambiguïsation d'infobulle par ID auto (Deuxième)",
                    "es": "Desambiguación de tooltip por ID automático (Segundo)",
                    "it": "Disambiguazione tooltip con ID automatico (Secondo)",
                    "pt": "Desambiguação de dica por ID automático (Segundo)",
                    "nl": "Automatische ID-tooltip ondubbelzinnigheid (Tweede)",
                    "da": "Automatisk ID-tooltip entydighed (Anden)",
                    "sv": "Automatisk ID-verktygstips särskiljning (Andra)",
                    "nb": "Automatisk ID-verktøytips entydighet (Andre)",
                    "fi": "Automaattinen ID-työkaluvihjeen erottelu (Toinen)",
                    "is": "Sjálfvirk ID vísbendingaaðgreining (Önnur)",
                    "el": "Αποσαφήνιση επεξήγησης αυτόματου αναγνωριστικού (Δεύτερο)",
                    "tr": "Otomatik kimlikli ipucu ayrımı (İkinci)",
                    "hu": "Automatikus azonosító eszköztipp egyértelműsítés (Második)",
                    "hr": "Razlučivanje opisa automatskim ID-om (Drugi)",
                    "pl": "Rozróżnienie etykiet z automatycznym ID (Drugie)",
                    "sk": "Rozlíšenie popisu s automatickým ID (Druhé)",
                    "cs": "Rozlišení nápovědy s automatickým ID (Druhé)",
                    "lb": "Automatesch ID-Tooltip Eendeitegkeet (Zweet)",
                ]
            ),
            ActionButtonData(
                ariaLabel: tr(
                    "Icon button without id, second",
                    de: "Icon-Schaltfläche ohne ID, zweite",
                    fr: "Bouton icône sans id, deuxième",
                    es: "Botón de icono sin id, segundo",
                    it: "Pulsante con icona senza id, secondo"
                ),
                tooltip: tr(
                    "Same tooltip text on all three",
                    de: "Gleicher Tooltip-Text bei allen dreien",
                    fr: "Même texte d'infobulle pour les drei",
                    es: "Mismo texto de información en los tres",
                    it: "Stesso testo del tooltip per tutti e tre"
                ),
                tooltipPosition: .top,
                buttonType: .tertiary,
                icon: .airplane,
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
            ActionButtonData(
                id: "btn-multiline",
                label:
                    tr(
                        "This is a very long button label that exceeds typical button widths and wraps across several lines with vertical centering",
                        de:
                            "Dies ist eine sehr lange Beschriftung, die übliche Schaltflächenbreiten überschreitet und über mehrere Zeilen umbricht, vertikal zentriert",
                        fr:
                            "Ceci est un libellé de bouton très long qui dépasse les largeurs habituelles et s'étend sur plusieurs lignes avec centrage vertical",
                        es:
                            "Esta es una etiqueta de botón muy larga que supera los anchos habituales y se distribuye en varias líneas con centrado vertical",
                        it:
                            "Questa è un'etichetta molto lunga che supera le larghezze abituali e va a capo su più righe con centratura verticale"
                    ),
                buttonType: .primary,
                size: .base,
                hasFullWidth: false,
                icon: .airplane,
                iconPosition: .left,
                contentTracker: tracker
            )
        ),
    ]

    func makeHtml(ctx: ActionButtonData) -> String {
        let html = renderFragments(ActionButton(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("ActionButton")

                for (index, variant) in variants.enumerated() {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        id: "btn-\(index)",
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Form {
                            Div { ActionButton(variant.data).render() }
                                .class("flex")
                        }
                        .setAttribute(
                            name: "x-data",
                            value: "{ dynamicUrl: 'something' }"
                        )
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
