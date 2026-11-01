import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct StepperView: TemplateRepresentable {

    let variants: [PreviewVariant<StepperData>] = [
        #previewVariant(
            tr(
                "Vertical Stepper with Descriptions",
                [
                    "de": "Vertikaler Stepper mit Beschreibungen",
                    "fr": "Stepper vertical avec descriptions",
                    "es": "Stepper vertical con descripciones",
                    "it": "Stepper verticale con descrizioni",
                    "pt": "Passo a passo vertical com descrições",
                    "nl": "Verticale stepper met beschrijvingen",
                    "da": "Lodret stepper med beskrivelser",
                    "sv": "Vertikal stepper med beskrivningar",
                    "nb": "Vertikal stepper med beskrivelser",
                    "fi": "Pystysuuntainen askellin kuvauksilla",
                    "is": "Lóðréttur skrefastillir með lýsingum",
                    "el": "Κάθετος βηματιστής με περιγραφές",
                    "tr": "Açıklamalı dikey adım göstergesi",
                    "hu": "Függőleges léptető leírásokkal",
                    "hr": "Okomiti koračnik s opisima",
                    "pl": "Pionowy pasek kroków z opisami",
                    "sk": "Vertikálny krokový indikátor s popismi",
                    "cs": "Vertikální krokový indikátor s popisy",
                    "lb": "Vertikale Stepper mat Beschreiwungen",
                ]
            ),
            StepperData(
                id: "stepper-vertical",
                ariaLabel: tr(
                    "Account registration progress",
                    de: "Fortschritt der Kontoregistrierung",
                    fr: "Progression de l'inscription du compte",
                    es: "Progreso del registro de la cuenta",
                    it: "Avanzamento della registrazione dell'account"
                ),
                steps: [
                    StepperStepData(
                        id: "step-create-account",
                        title: tr(
                            "Create account",
                            de: "Konto erstellen",
                            fr: "Créer un compte",
                            es: "Crear cuenta",
                            it: "Crea account"
                        ),
                        description: "Vitae sed mi luctus laoreet.",
                        href: "#",
                        status: .complete
                    ),
                    StepperStepData(
                        id: "step-profile-info",
                        title: tr(
                            "Profile information",
                            de: "Profilinformationen",
                            fr: "Informations du profil",
                            es: "Información del perfil",
                            it: "Informazioni del profilo"
                        ),
                        description:
                            "Cursus semper viverra facilisis et et some more.",
                        href: "#",
                        status: .current
                    ),
                    StepperStepData(
                        id: "step-business-info",
                        title: tr(
                            "Business information",
                            de: "Geschäftsinformationen",
                            fr: "Informations sur l'entreprise",
                            es: "Información de la empresa",
                            it: "Informazioni aziendali"
                        ),
                        description: "Penatibus eu quis ante.",
                        href: "#",
                        status: .upcoming
                    ),
                    StepperStepData(
                        id: "step-theme",
                        title: tr(
                            "Theme",
                            de: "Design",
                            fr: "Thème",
                            es: "Tema",
                            it: "Tema"
                        ),
                        description: "Faucibus nec enim leo et.",
                        href: "#",
                        status: .upcoming
                    ),
                    StepperStepData(
                        id: "step-preview",
                        title: tr(
                            "Preview",
                            de: "Vorschau",
                            fr: "Aperçu",
                            es: "Vista previa",
                            it: "Anteprima"
                        ),
                        description:
                            "Iusto et officia maiores porro ad non quas.",
                        href: "#",
                        status: .upcoming
                    ),
                ],
                orientation: .vertical
            )
        ),
        #previewVariant(
            tr(
                "Horizontal Compact Numbered Steps",
                [
                    "de": "Horizontale kompakte nummerierte Schritte",
                    "fr": "Étapes numérotées compactes horizontales",
                    "es": "Pasos numerados compactos horizontales",
                    "it": "Passaggi numerati compatti orizzontali",
                    "pt": "Etapas numeradas compactas horizontais",
                    "nl": "Horizontale compacte genummerde stappen",
                    "da": "Vandrette kompakte nummererede trin",
                    "sv": "Horisontella kompakta numrerade steg",
                    "nb": "Horisontale kompakte nummererte trinn",
                    "fi": "Vaakasuuntaiset kompaktit numeroidut vaiheet",
                    "is": "Lárétt þétt númeruð skref",
                    "el": "Οριζόντια συμπαγή αριθμημένα βήματα",
                    "tr": "Yatay kompakt numaralandırılmış adımlar",
                    "hu": "Vízszintes kompakt számozott lépések",
                    "hr": "Vodoravni kompaktni numerirani koraci",
                    "pl": "Poziome zwarte ponumerowane kroki",
                    "sk": "Horizontálne kompaktné číslované kroky",
                    "cs": "Horizontální kompaktní číslované kroky",
                    "lb": "Horizontaalt kompakt nummeréiert Schrëtt",
                ]
            ),
            StepperData(
                id: "stepper-horizontal",
                ariaLabel: tr(
                    "Onboarding progress",
                    de: "Fortschritt des Onboardings",
                    fr: "Progression de l'intégration",
                    es: "Progreso de la incorporación",
                    it: "Avanzamento dell'onboarding"
                ),
                steps: [
                    StepperStepData(
                        id: "step-1",
                        title: tr(
                            "Step 1",
                            de: "Schritt 1",
                            fr: "Étape 1",
                            es: "Paso 1",
                            it: "Passaggio 1"
                        ),
                        href: "#",
                        status: .complete
                    ),
                    StepperStepData(
                        id: "step-2",
                        title: tr(
                            "Step 2",
                            de: "Schritt 2",
                            fr: "Étape 2",
                            es: "Paso 2",
                            it: "Passaggio 2"
                        ),
                        href: "#",
                        status: .complete
                    ),
                    StepperStepData(
                        id: "step-3",
                        title: tr(
                            "Step 3",
                            de: "Schritt 3",
                            fr: "Étape 3",
                            es: "Paso 3",
                            it: "Passaggio 3"
                        ),
                        href: "#",
                        status: .current
                    ),
                    StepperStepData(
                        id: "step-4",
                        title: tr(
                            "Step 4",
                            de: "Schritt 4",
                            fr: "Étape 4",
                            es: "Paso 4",
                            it: "Passaggio 4"
                        ),
                        href: "#",
                        status: .upcoming
                    ),
                    StepperStepData(
                        id: "step-5",
                        title: tr(
                            "Step 5",
                            de: "Schritt 5",
                            fr: "Étape 5",
                            es: "Paso 5",
                            it: "Passaggio 5"
                        ),
                        href: "#",
                        status: .upcoming
                    ),
                ],
                orientation: .horizontal
            )
        ),
        #previewVariant(
            tr(
                "Horizontal Full-Width Flow",
                [
                    "de": "Horizontaler Ablauf in voller Breite",
                    "fr": "Flux horizontal pleine largeur",
                    "es": "Flujo horizontal de ancho completo",
                    "it": "Flusso orizzontale a larghezza intera",
                    "pt": "Fluxo horizontal de largura total",
                    "nl": "Horizontale stroom over volledige breedte",
                    "da": "Vandret proces i fuld bredde",
                    "sv": "Horisontellt flöde i full bredd",
                    "nb": "Horisontal flyt i full bredde",
                    "fi": "Vaakasuuntainen täysleveä työnkulku",
                    "is": "Lárétt flæði í fullri breidd",
                    "el": "Οριζόντια ροή πλήρους πλάτους",
                    "tr": "Tam genişlikli yatay akış",
                    "hu": "Vízszintes teljes szélességű folyamat",
                    "hr": "Vodoravni tijek pune širine",
                    "pl": "Poziomy przepływ o pełnej szerokości",
                    "sk": "Horizontálny tok na celú šírku",
                    "cs": "Horizontální tok na celou šířku",
                    "lb": "Horizontaalt Oflaf a voller Breet",
                ]
            ),
            StepperData(
                id: "stepper-horizontal-full-width",
                ariaLabel: tr(
                    "Checkout flow progress",
                    de: "Fortschritt des Bestellvorgangs",
                    fr: "Progression du processus de paiement",
                    es: "Progreso del proceso de pago",
                    it: "Avanzamento del checkout"
                ),
                steps: [
                    StepperStepData(
                        id: "step-cart",
                        title: tr(
                            "Cart",
                            de: "Warenkorb",
                            fr: "Panier",
                            es: "Carrito",
                            it: "Carrello"
                        ),
                        href: "#",
                        status: .complete
                    ),
                    StepperStepData(
                        id: "step-shipping",
                        title: tr(
                            "Shipping",
                            de: "Versand",
                            fr: "Livraison",
                            es: "Envío",
                            it: "Spedizione"
                        ),
                        href: "#",
                        status: .complete
                    ),
                    StepperStepData(
                        id: "step-payment",
                        title: tr(
                            "Payment",
                            de: "Zahlung",
                            fr: "Paiement",
                            es: "Pago",
                            it: "Pagamento"
                        ),
                        href: "#",
                        status: .current
                    ),
                    StepperStepData(
                        id: "step-confirm",
                        title: tr(
                            "Confirmation",
                            de: "Bestätigung",
                            fr: "Confirmation",
                            es: "Confirmación",
                            it: "Conferma"
                        ),
                        href: "#",
                        status: .upcoming
                    ),
                ],
                orientation: .horizontal,
                hasFullWidth: true
            )
        ),
        #previewVariant(
            tr(
                "Read-Only Vertical Timeline",
                [
                    "de": "Schreibgeschützte vertikale Zeitleiste",
                    "fr": "Chronologie verticale en lecture seule",
                    "es": "Línea de tiempo vertical de solo lectura",
                    "it": "Cronologia verticale di sola lettura",
                    "pt": "Linha do tempo vertical somente leitura",
                    "nl": "Alleen-lezen verticale tijdlijn",
                    "da": "Skrivebeskyttet lodret tidslinje",
                    "sv": "Skrivskyddad vertikal tidslinje",
                    "nb": "Skrivebeskyttet vertikal tidslinje",
                    "fi": "Vain luku -pysty-aikajana",
                    "is": "Skrifvarin lóðrétt tímalína",
                    "el": "Κάθετο χρονολόγιο μόνο για ανάγνωση",
                    "tr": "Salt okunur dikey zaman çizelgesi",
                    "hu": "Csak olvasható függőleges idővonal",
                    "hr": "Okomita vremenska crta samo za čitanje",
                    "pl": "Oś czasu pionowa tylko do odczytu",
                    "sk": "Vertikálna časová os len na čítanie",
                    "cs": "Vertikální časová osa pouze pro čtení",
                    "lb": "Schreifgeschützt vertikal Zäitleischt",
                ]
            ),
            StepperData(
                id: "stepper-static-order",
                ariaLabel: tr(
                    "Order delivery tracking",
                    de: "Sendungsverfolgung der Bestellung",
                    fr: "Suivi de la livraison de la commande",
                    es: "Seguimiento de la entrega del pedido",
                    it: "Tracciamento della consegna dell'ordine"
                ),
                steps: [
                    StepperStepData(
                        title: tr(
                            "Order Placed",
                            de: "Bestellung aufgegeben",
                            fr: "Commande passée",
                            es: "Pedido realizado",
                            it: "Ordine effettuato"
                        ),
                        description: tr(
                            "Your order was successfully submitted.",
                            de:
                                "Deine Bestellung wurde erfolgreich aufgegeben.",
                            fr: "Votre commande a été envoyée avec succès.",
                            es: "Tu pedido se ha enviado correctamente.",
                            it: "Il tuo ordine è stato inviato con successo."
                        ),
                        status: .complete
                    ),
                    StepperStepData(
                        title: tr(
                            "In Preparation",
                            de: "In Vorbereitung",
                            fr: "En préparation",
                            es: "En preparación",
                            it: "In preparazione"
                        ),
                        description:
                            tr(
                                "Items are being packed in the fulfillment center.",
                                de:
                                    "Die Artikel werden im Logistikzentrum verpackt.",
                                fr:
                                    "Les articles sont emballés dans le centre logistique.",
                                es:
                                    "Los artículos se están empaquetando en el centro logístico.",
                                it:
                                    "Gli articoli vengono imballati nel centro logistico."
                            ),
                        status: .current
                    ),
                    StepperStepData(
                        title: tr(
                            "Shipped",
                            de: "Versendet",
                            fr: "Expédiée",
                            es: "Enviado",
                            it: "Spedito"
                        ),
                        description: tr(
                            "Package handed over to delivery courier.",
                            de: "Paket wurde an den Zustelldienst übergeben.",
                            fr: "Colis remis au transporteur.",
                            es: "Paquete entregado al servicio de mensajería.",
                            it: "Pacco consegnato al corriere."
                        ),
                        status: .upcoming
                    ),
                    StepperStepData(
                        title: tr(
                            "Delivered",
                            de: "Zugestellt",
                            fr: "Livrée",
                            es: "Entregado",
                            it: "Consegnato"
                        ),
                        description:
                            tr(
                                "Package delivered to your shipping address.",
                                de:
                                    "Paket wurde an deine Lieferadresse zugestellt.",
                                fr: "Colis livré à votre adresse de livraison.",
                                es:
                                    "Paquete entregado en tu dirección de envío.",
                                it:
                                    "Pacco consegnato al tuo indirizzo di spedizione."
                            ),
                        status: .upcoming
                    ),
                ],
                orientation: .vertical
            )
        ),
        #previewVariant(
            tr(
                "Horizontal Stepper with Tooltips",
                [
                    "de": "Horizontaler Stepper mit Tooltips",
                    "fr": "Stepper horizontal avec infobulles",
                    "es": "Stepper horizontal con información",
                    "it": "Stepper orizzontale con tooltip",
                    "pt": "Passo a passo horizontal com dicas",
                    "nl": "Horizontale stepper met tooltips",
                    "da": "Vandret stepper med tooltips",
                    "sv": "Horisontell stepper med verktygstips",
                    "nb": "Horisontal stepper med verktøytips",
                    "fi": "Vaakasuuntainen askellin työkaluvihjeillä",
                    "is": "Láréttur skrefastillir með vísbendingum",
                    "el": "Οριζόντιος βηματιστής με επεξηγήσεις",
                    "tr": "İpuçlu yatay adım göstergesi",
                    "hu": "Vízszintes léptető eszköztippekkel",
                    "hr": "Vodoravni koračnik s opisima",
                    "pl": "Poziomy pasek kroków z etykietami",
                    "sk": "Horizontálny krokový indikátor s popismi",
                    "cs": "Horizontální krokový indikátor s nápovědami",
                    "lb": "Horizontale Stepper mat Tooltipps",
                ]
            ),
            StepperData(
                id: "stepper-tooltips-demo",
                ariaLabel: tr(
                    "Deployment pipeline stages",
                    de: "Phasen der Deployment-Pipeline",
                    fr: "Étapes du pipeline de déploiement",
                    es: "Etapas del pipeline de despliegue",
                    it: "Fasi della pipeline di distribuzione"
                ),
                steps: [
                    StepperStepData(
                        id: "step-repository",
                        title: tr(
                            "Repository",
                            de: "Repository",
                            fr: "Dépôt",
                            es: "Repositorio",
                            it: "Repository"
                        ),
                        tooltip: tr(
                            "Step 1: Connect your Git repository",
                            de: "Schritt 1: Verbinde dein Git-Repository",
                            fr: "Étape 1 : connectez votre dépôt Git",
                            es: "Paso 1: conecta tu repositorio Git",
                            it: "Passaggio 1: collega il tuo repository Git"
                        ),
                        tooltipPosition: .top,
                        href: "#",
                        status: .complete
                    ),
                    StepperStepData(
                        id: "step-build",
                        title: tr(
                            "Build Configuration",
                            de: "Build-Konfiguration",
                            fr: "Configuration du build",
                            es: "Configuración de compilación",
                            it: "Configurazione della build"
                        ),
                        tooltip:
                            tr(
                                "Step 2: Define build settings & environment variables",
                                de:
                                    "Schritt 2: Definiere Build-Einstellungen & Umgebungsvariablen",
                                fr:
                                    "Étape 2 : définissez les paramètres de build et les variables d'environnement",
                                es:
                                    "Paso 2: define los ajustes de compilación y las variables de entorno",
                                it:
                                    "Passaggio 2: definisci le impostazioni di build e le variabili d'ambiente"
                            ),
                        tooltipPosition: .top,
                        href: "#",
                        status: .complete
                    ),
                    StepperStepData(
                        id: "step-deploy",
                        title: tr(
                            "Deployment",
                            de: "Deployment",
                            fr: "Déploiement",
                            es: "Despliegue",
                            it: "Distribuzione"
                        ),
                        tooltip: tr(
                            "Step 3: Deploy to production cluster",
                            de:
                                "Schritt 3: In den Produktions-Cluster deployen",
                            fr:
                                "Étape 3 : déployez sur le cluster de production",
                            es: "Paso 3: despliega en el clúster de producción",
                            it:
                                "Passaggio 3: distribuisci nel cluster di produzione"
                        ),
                        tooltipPosition: .top,
                        href: "#",
                        status: .current
                    ),
                    StepperStepData(
                        id: "step-verify",
                        title: tr(
                            "Verification",
                            de: "Überprüfung",
                            fr: "Vérification",
                            es: "Verificación",
                            it: "Verifica"
                        ),
                        tooltip: tr(
                            "Step 4: Run automated health checks",
                            de:
                                "Schritt 4: Automatisierte Gesundheitsprüfungen ausführen",
                            fr:
                                "Étape 4 : lancez les contrôles d'état automatisés",
                            es:
                                "Paso 4: ejecuta las comprobaciones de estado automatizadas",
                            it:
                                "Passaggio 4: esegui i controlli di integrità automatici"
                        ),
                        tooltipPosition: .top,
                        href: "#",
                        status: .upcoming
                    ),
                ],
                orientation: .horizontal
            )
        ),
        #previewVariant(
            tr(
                "Mixed Icons and Numbers (Step 1 Active)",
                [
                    "de": "Gemischte Icons und Nummern (Schritt 1 aktiv)",
                    "fr": "Icônes et numéros mixtes (Étape 1 active)",
                    "es": "Iconos y números mixtos (Paso 1 activo)",
                    "it": "Icone e numeri misti (Passo 1 attivo)",
                    "pt": "Ícones e números mistos (Etapa 1 ativa)",
                    "nl": "Gemengde pictogrammen en nummers (Stap 1 actief)",
                    "da": "Blandede ikoner og tal (Trin 1 aktivt)",
                    "sv": "Blandade ikoner och siffror (Steg 1 aktivt)",
                    "nb": "Blandede ikoner og tall (Trinn 1 aktivt)",
                    "fi": "Sekakuvakkeet ja numerot (Vaihe 1 aktiivinen)",
                    "is": "Blanduð tákn og tölur (Skref 1 virkt)",
                    "el": "Μικτά εικονίδια και αριθμοί (Βήμα 1 ενεργό)",
                    "tr": "Karışık simgeler ve numaralar (Adım 1 aktif)",
                    "hu": "Vegyes ikonok és számok (1. lépés aktív)",
                    "hr": "Miješane ikone i brojevi (Korak 1 aktivan)",
                    "pl": "Mieszane ikony i cyfry (Krok 1 aktywny)",
                    "sk": "Zmiešané ikony a čísla (Krok 1 aktívny)",
                    "cs": "Smíšené ikony a čísla (Krok 1 aktivní)",
                    "lb": "Gemëschten Ikonen an Zuelen (Schrëtt 1 aktiv)",
                ]
            ),
            StepperData(
                id: "stepper-custom-icons-step1",
                ariaLabel: tr(
                    "Registration steps with custom icons",
                    de: "Registrierungsschritte mit eigenen Icons",
                    fr: "Étapes d'inscription avec icônes personnalisées",
                    es: "Pasos de registro con iconos personalizados",
                    it: "Passaggi di registrazione con icone personalizzate"
                ),
                steps: [
                    StepperStepData(
                        id: "step-user-details",
                        title: tr(
                            "Account Details",
                            de: "Kontodetails",
                            fr: "Détails du compte",
                            es: "Detalles de la cuenta",
                            it: "Dettagli dell'account"
                        ),
                        tooltip: tr(
                            "Step 1: Enter your account information",
                            de: "Schritt 1: Gib deine Kontoinformationen ein",
                            fr:
                                "Étape 1 : saisissez les informations de votre compte",
                            es: "Paso 1: introduce la información de tu cuenta",
                            it:
                                "Passaggio 1: inserisci le informazioni del tuo account"
                        ),
                        href: "#",
                        status: .current,
                        stepNumber: 1
                    ),
                    StepperStepData(
                        id: "step-phone-verification",
                        title: tr(
                            "Verification",
                            de: "Überprüfung",
                            fr: "Vérification",
                            es: "Verificación",
                            it: "Verifica"
                        ),
                        tooltip: tr(
                            "Step 2: Verify your phone number",
                            de: "Schritt 2: Bestätige deine Telefonnummer",
                            fr: "Étape 2 : vérifiez votre numéro de téléphone",
                            es: "Paso 2: verifica tu número de teléfono",
                            it:
                                "Passaggio 2: verifica il tuo numero di telefono"
                        ),
                        href: "#",
                        status: .upcoming,
                        stepNumber: 2
                    ),
                    StepperStepData(
                        id: "step-invitation-email",
                        title: tr(
                            "Invitation",
                            de: "Einladung",
                            fr: "Invitation",
                            es: "Invitación",
                            it: "Invito"
                        ),
                        tooltip: tr(
                            "Step 3: Send email invite",
                            de: "Schritt 3: E-Mail-Einladung senden",
                            fr: "Étape 3 : envoyez l'invitation par e-mail",
                            es:
                                "Paso 3: envía la invitación por correo electrónico",
                            it: "Passaggio 3: invia l'invito via e-mail"
                        ),
                        href: "#",
                        status: .upcoming,
                        icon: .envelope_fill
                    ),
                ],
                orientation: .horizontal
            )
        ),
        #previewVariant(
            tr(
                "Mixed Icons and Numbers (Step 1 Completed)",
                [
                    "de": "Gemischte Icons und Nummern (Schritt 1 abgeschlossen)",
                    "fr": "Icônes et numéros mixtes (Étape 1 terminée)",
                    "es": "Iconos y números mixtos (Paso 1 completado)",
                    "it": "Icone e numeri misti (Passo 1 completato)",
                    "pt": "Ícones e números mistos (Etapa 1 concluída)",
                    "nl": "Gemengde pictogrammen en nummers (Stap 1 voltooid)",
                    "da": "Blandede ikoner og tal (Trin 1 fuldført)",
                    "sv": "Blandade ikoner och siffror (Steg 1 slutfört)",
                    "nb": "Blandede ikoner og tall (Trinn 1 fullført)",
                    "fi": "Sekakuvakkeet ja numerot (Vaihe 1 suoritettu)",
                    "is": "Blanduð tákn og tölur (Skref 1 lokið)",
                    "el": "Μικτά εικονίδια και αριθμοί (Βήμα 1 ολοκληρώθηκε)",
                    "tr": "Karışık simgeler ve numaralar (Adım 1 tamamlandı)",
                    "hu": "Vegyes ikonok és számok (1. lépés kész)",
                    "hr": "Miješane ikone i brojevi (Korak 1 dovršen)",
                    "pl": "Mieszane ikony i cyfry (Krok 1 ukończony)",
                    "sk": "Zmiešané ikony a čísla (Krok 1 dokončený)",
                    "cs": "Smíšené ikony a čísla (Krok 1 dokončen)",
                    "lb": "Gemëschten Ikonen an Zuelen (Schrëtt 1 ofgeschloss)",
                ]
            ),
            StepperData(
                id: "stepper-custom-icons-step2",
                ariaLabel: tr(
                    "Registration steps with completed tick",
                    de: "Registrierungsschritte mit Häkchen für erledigt",
                    fr: "Étapes d'inscription avec coche d'achèvement",
                    es: "Pasos de registro con marca de completado",
                    it: "Passaggi di registrazione con spunta di completamento"
                ),
                steps: [
                    StepperStepData(
                        id: "step-user-details-done",
                        title: tr(
                            "Account Details",
                            de: "Kontodetails",
                            fr: "Détails du compte",
                            es: "Detalles de la cuenta",
                            it: "Dettagli dell'account"
                        ),
                        tooltip: tr(
                            "Step 1: Completed",
                            de: "Schritt 1: Abgeschlossen",
                            fr: "Étape 1 : terminée",
                            es: "Paso 1: completado",
                            it: "Passaggio 1: completato"
                        ),
                        href: "#",
                        status: .complete,
                        stepNumber: 1
                    ),
                    StepperStepData(
                        id: "step-phone-verification-active",
                        title: tr(
                            "Verification",
                            de: "Überprüfung",
                            fr: "Vérification",
                            es: "Verificación",
                            it: "Verifica"
                        ),
                        tooltip: tr(
                            "Step 2: Verify your phone number",
                            de: "Schritt 2: Bestätige deine Telefonnummer",
                            fr: "Étape 2 : vérifiez votre numéro de téléphone",
                            es: "Paso 2: verifica tu número de teléfono",
                            it:
                                "Passaggio 2: verifica il tuo numero di telefono"
                        ),
                        href: "#",
                        status: .current,
                        stepNumber: 2
                    ),
                    StepperStepData(
                        id: "step-invitation-email-pending",
                        title: tr(
                            "Invitation",
                            de: "Einladung",
                            fr: "Invitation",
                            es: "Invitación",
                            it: "Invito"
                        ),
                        tooltip: tr(
                            "Step 3: Send email invite",
                            de: "Schritt 3: E-Mail-Einladung senden",
                            fr: "Étape 3 : envoyez l'invitation par e-mail",
                            es:
                                "Paso 3: envía la invitación por correo electrónico",
                            it: "Passaggio 3: invia l'invito via e-mail"
                        ),
                        href: "#",
                        status: .upcoming,
                        icon: .envelope_fill
                    ),
                ],
                orientation: .horizontal
            )
        ),
    ]

    func makeHtml(ctx: StepperData) -> String {
        let html = renderFragments(Stepper(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {
        Basic {
            Div {
                showComponentTitle("Stepper")

                for variant in variants {
                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Stepper(variant.data).render() }
                            .class("mb-4 mt-4")
                    }
                }
            }
            .class("mt-4 space-y-6")
        }
        .render()
    }
}
