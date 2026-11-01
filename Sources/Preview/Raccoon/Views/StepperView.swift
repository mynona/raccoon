import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct StepperView: TemplateRepresentable {

    let variants: [PreviewVariant<StepperData>] = [
        #previewVariant(
            "Vertical Stepper with Descriptions",
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
            "Horizontal Compact Numbered Steps",
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
            "Horizontal Full-Width Flow",
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
            "Read-Only Vertical Timeline",
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
            "Horizontal Stepper with Tooltips",
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
            "Mixed Icons and Numbers (Step 1 Active)",
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
            "Mixed Icons and Numbers (Step 1 Completed)",
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
