import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct TabGroupView: TemplateRepresentable {

    let variants: [PreviewVariant<TabGroupData>] = [
        #previewVariant(
            "Underline with Icons and Badges",
            TabGroupData(
                id: "tabs-underline-demo",
                ariaLabel: tr(
                    "Social Activity Tabs",
                    de: "Tabs für soziale Aktivitäten",
                    fr: "Onglets d'activité sociale",
                    es: "Pestañas de actividad social",
                    it: "Schede dell'attività social"
                ),
                tabs: [
                    TabItemData(
                        id: "groups",
                        label: tr(
                            "Groups",
                            de: "Gruppen",
                            fr: "Groupes",
                            es: "Grupos",
                            it: "Gruppi"
                        ),
                        content: .markdown(
                            tr(
                                "### Groups Overview\n\nYou are a member of **4 active groups**. Explore discussions, events, and shared files.",
                                de:
                                    "### Gruppenübersicht\n\nDu bist Mitglied von **4 aktiven Gruppen**. Entdecke Diskussionen, Veranstaltungen und geteilte Dateien.",
                                fr:
                                    "### Aperçu des groupes\n\nVous êtes membre de **4 groupes actifs**. Découvrez les discussions, événements et fichiers partagés.",
                                es:
                                    "### Resumen de grupos\n\nEres miembro de **4 grupos activos**. Explora debates, eventos y archivos compartidos.",
                                it:
                                    "### Panoramica dei gruppi\n\nSei membro di **4 gruppi attivi**. Esplora discussioni, eventi e file condivisi."
                            )
                        ),
                        isDefaultSelected: true,
                        icon: .people,
                        badgeCount: 4
                    ),
                    TabItemData(
                        id: "likes",
                        label: tr(
                            "Likes",
                            de: "Likes",
                            fr: "J'aime",
                            es: "Me gusta",
                            it: "Mi piace"
                        ),
                        content: .html(
                            tr(
                                "<p class='text-base leading-relaxed'>Your posts have received <strong>3,124 likes</strong> across all published articles.</p>",
                                de:
                                    "<p class='text-base leading-relaxed'>Deine Beiträge haben über alle veröffentlichten Artikel hinweg <strong>3.124 Likes</strong> erhalten.</p>",
                                fr:
                                    "<p class='text-base leading-relaxed'>Vos publications ont reçu <strong>3 124 j'aime</strong> sur l'ensemble des articles publiés.</p>",
                                es:
                                    "<p class='text-base leading-relaxed'>Tus publicaciones han recibido <strong>3.124 me gusta</strong> en todos los artículos publicados.</p>",
                                it:
                                    "<p class='text-base leading-relaxed'>I tuoi post hanno ricevuto <strong>3.124 mi piace</strong> in tutti gli articoli pubblicati.</p>"
                            )
                        ),
                        icon: .heart,
                        badgeCount: 3124
                    ),
                    TabItemData(
                        id: "comments",
                        label: tr(
                            "Comments",
                            de: "Kommentare",
                            fr: "Commentaires",
                            es: "Comentarios",
                            it: "Commenti"
                        ),
                        content: .markdown(
                            tr(
                                "### Recent Comments\n\n- *Great article on Swift server components!*\n- *Can you share more on Alpine.js integration?*",
                                de:
                                    "### Neueste Kommentare\n\n- *Toller Artikel über Swift-Serverkomponenten!*\n- *Kannst du mehr zur Alpine.js-Integration erzählen?*",
                                fr:
                                    "### Commentaires récents\n\n- *Super article sur les composants serveur Swift !*\n- *Pouvez-vous en dire plus sur l'intégration d'Alpine.js ?*",
                                es:
                                    "### Comentarios recientes\n\n- *¡Gran artículo sobre componentes de servidor en Swift!*\n- *¿Puedes contar más sobre la integración con Alpine.js?*",
                                it:
                                    "### Commenti recenti\n\n- *Ottimo articolo sui componenti server in Swift!*\n- *Puoi dire di più sull'integrazione con Alpine.js?*"
                            )
                        ),
                        icon: .chat_dots,
                        badgeCount: 243
                    ),
                    TabItemData(
                        id: "saved",
                        label: tr(
                            "Saved",
                            de: "Gespeichert",
                            fr: "Enregistrés",
                            es: "Guardados",
                            it: "Salvati"
                        ),
                        content: .html(
                            tr(
                                "<p class='text-base leading-relaxed'>You have <strong>32 bookmarks</strong> saved for later reading.</p>",
                                de:
                                    "<p class='text-base leading-relaxed'>Du hast <strong>32 Lesezeichen</strong> zum späteren Lesen gespeichert.</p>",
                                fr:
                                    "<p class='text-base leading-relaxed'>Vous avez <strong>32 favoris</strong> enregistrés pour une lecture ultérieure.</p>",
                                es:
                                    "<p class='text-base leading-relaxed'>Tienes <strong>32 marcadores</strong> guardados para leer más tarde.</p>",
                                it:
                                    "<p class='text-base leading-relaxed'>Hai <strong>32 segnalibri</strong> salvati per leggere più tardi.</p>"
                            )
                        ),
                        icon: .bookmark,
                        badgeCount: 32
                    ),
                ],
                variant: .underline
            )
        ),
        #previewVariant(
            "Pills with Disabled Tab",
            TabGroupData(
                id: "tabs-pills-demo",
                ariaLabel: tr(
                    "Framework View Tabs",
                    de: "Tabs für Framework-Ansichten",
                    fr: "Onglets de vue des frameworks",
                    es: "Pestañas de vista de frameworks",
                    it: "Schede di visualizzazione dei framework"
                ),
                tabs: [
                    TabItemData(
                        id: "swift",
                        label: "Swift",
                        content: .markdown(
                            "```swift\nlet message = \"Hello from Raccoon!\"\nprint(message)\n```"
                        ),
                        isDefaultSelected: true,
                        icon: .code_slash
                    ),
                    TabItemData(
                        id: "vapor",
                        label: "Vapor",
                        content: .markdown(
                            "```swift\napp.get(\"hello\") { req in\n    return \"Hello, world!\"\n}\n```"
                        ),
                        icon: .terminal
                    ),
                    TabItemData(
                        id: "alpine",
                        label: "Alpine.js",
                        content: .html(
                            "<pre class='p-3 bg-tertiary dark:bg-surface-dark border \(CommonStyles.borderColorDefault) rounded-md'><code>&lt;div x-data=\"{ open: false }\"&gt;...&lt;/div&gt;</code></pre>"
                        ),
                        icon: .layers
                    ),
                    TabItemData(
                        id: "archive",
                        label: tr(
                            "Archived",
                            de: "Archiviert",
                            fr: "Archivé",
                            es: "Archivado",
                            it: "Archiviato"
                        ),
                        content: .html(
                            tr(
                                "<p>This archive is currently read-only.</p>",
                                de:
                                    "<p>Dieses Archiv ist derzeit schreibgeschützt.</p>",
                                fr:
                                    "<p>Cette archive est actuellement en lecture seule.</p>",
                                es:
                                    "<p>Este archivo está actualmente en modo de solo lectura.</p>",
                                it:
                                    "<p>Questo archivio è attualmente di sola lettura.</p>"
                            )
                        ),
                        state: .disabled,
                        icon: .archive
                    ),
                ],
                variant: .pills
            )
        ),
        #previewVariant(
            "Vertical Pills Layout",
            TabGroupData(
                id: "tabs-vertical-pills-demo",
                ariaLabel: tr(
                    "Account Settings",
                    de: "Kontoeinstellungen",
                    fr: "Paramètres du compte",
                    es: "Ajustes de la cuenta",
                    it: "Impostazioni account"
                ),
                tabs: [
                    TabItemData(
                        id: "profile",
                        label: tr(
                            "Profile",
                            de: "Profil",
                            fr: "Profil",
                            es: "Perfil",
                            it: "Profilo"
                        ),
                        content: .markdown(
                            tr(
                                "### Public Profile\nManage your display name, bio, and avatar.",
                                de:
                                    "### Öffentliches Profil\nVerwalte deinen Anzeigenamen, deine Biografie und deinen Avatar.",
                                fr:
                                    "### Profil public\nGérez votre nom d'affichage, votre biographie et votre avatar.",
                                es:
                                    "### Perfil público\nAdministra tu nombre visible, tu biografía y tu avatar.",
                                it:
                                    "### Profilo pubblico\nGestisci il tuo nome visualizzato, la tua bio e il tuo avatar."
                            )
                        ),
                        isDefaultSelected: true,
                        icon: .person_circle
                    ),
                    TabItemData(
                        id: "security",
                        label: tr(
                            "Security",
                            de: "Sicherheit",
                            fr: "Sécurité",
                            es: "Seguridad",
                            it: "Sicurezza"
                        ),
                        content: .markdown(
                            tr(
                                "### Security Settings\nConfigure two-factor authentication and active session keys.",
                                de:
                                    "### Sicherheitseinstellungen\nKonfiguriere die Zwei-Faktor-Authentifizierung und die Schlüssel aktiver Sitzungen.",
                                fr:
                                    "### Paramètres de sécurité\nConfigurez l'authentification à deux facteurs et les clés de session actives.",
                                es:
                                    "### Ajustes de seguridad\nConfigura la autenticación en dos pasos y las claves de sesión activas.",
                                it:
                                    "### Impostazioni di sicurezza\nConfigura l'autenticazione a due fattori e le chiavi di sessione attive."
                            )
                        ),
                        icon: .shield_lock
                    ),
                    TabItemData(
                        id: "notifications",
                        label: tr(
                            "Notifications",
                            de: "Benachrichtigungen",
                            fr: "Notifications",
                            es: "Notificaciones",
                            it: "Notifiche"
                        ),
                        content: .markdown(
                            tr(
                                "### Notification Preferences\nChoose email and webhook alert frequencies.",
                                de:
                                    "### Benachrichtigungseinstellungen\nWähle die Häufigkeit von E-Mail- und Webhook-Benachrichtigungen.",
                                fr:
                                    "### Préférences de notification\nChoisissez la fréquence des alertes par e-mail et webhook.",
                                es:
                                    "### Preferencias de notificación\nElige la frecuencia de las alertas por correo electrónico y webhook.",
                                it:
                                    "### Preferenze di notifica\nScegli la frequenza degli avvisi via e-mail e webhook."
                            )
                        ),
                        icon: .bell,
                        badgeCount: 2
                    ),
                ],
                variant: .pills,
                orientation: .vertical
            )
        ),
        #previewVariant(
            "Vertical Underline Layout",
            TabGroupData(
                id: "tabs-vertical-underline-demo",
                ariaLabel: tr(
                    "Project Management Tabs",
                    de: "Tabs für das Projektmanagement",
                    fr: "Onglets de gestion de projet",
                    es: "Pestañas de gestión de proyectos",
                    it: "Schede di gestione dei progetti"
                ),
                tabs: [
                    TabItemData(
                        id: "tasks",
                        label: tr(
                            "Tasks",
                            de: "Aufgaben",
                            fr: "Tâches",
                            es: "Tareas",
                            it: "Attività"
                        ),
                        content: .markdown(
                            tr(
                                "### Active Tasks\nView pending sprint items and assignees.",
                                de:
                                    "### Aktive Aufgaben\nSieh dir offene Sprint-Einträge und ihre Verantwortlichen an.",
                                fr:
                                    "### Tâches actives\nConsultez les éléments de sprint en attente et leurs responsables.",
                                es:
                                    "### Tareas activas\nConsulta los elementos pendientes del sprint y sus responsables.",
                                it:
                                    "### Attività attive\nVisualizza gli elementi dello sprint in sospeso e i loro assegnatari."
                            )
                        ),
                        isDefaultSelected: true,
                        icon: .check2_square,
                        badgeCount: 7
                    ),
                    TabItemData(
                        id: "milestones",
                        label: tr(
                            "Milestones",
                            de: "Meilensteine",
                            fr: "Jalons",
                            es: "Hitos",
                            it: "Traguardi"
                        ),
                        content: .markdown(
                            tr(
                                "### Milestones\nTrack target release dates and progress.",
                                de:
                                    "### Meilensteine\nVerfolge geplante Veröffentlichungstermine und den Fortschritt.",
                                fr:
                                    "### Jalons\nSuivez les dates de sortie prévues et l'avancement.",
                                es:
                                    "### Hitos\nHaz seguimiento de las fechas de lanzamiento previstas y del progreso.",
                                it:
                                    "### Traguardi\nSegui le date di rilascio previste e l'avanzamento."
                            )
                        ),
                        icon: .flag
                    ),
                    TabItemData(
                        id: "reports",
                        label: tr(
                            "Reports",
                            de: "Berichte",
                            fr: "Rapports",
                            es: "Informes",
                            it: "Report"
                        ),
                        content: .markdown(
                            tr(
                                "### Analytics & Velocity\nReview sprint burn-down and throughput.",
                                de:
                                    "### Analysen & Velocity\nPrüfe Sprint-Burn-down und Durchsatz.",
                                fr:
                                    "### Analyses et vélocité\nExaminez le burn-down du sprint et le débit.",
                                es:
                                    "### Analítica y velocidad\nRevisa el burn-down del sprint y el rendimiento.",
                                it:
                                    "### Analisi e velocity\nRivedi il burn-down dello sprint e il throughput."
                            )
                        ),
                        icon: .graph_up,
                        badgeText: tr(
                            "New",
                            de: "Neu",
                            fr: "Nouveau",
                            es: "Nuevo",
                            it: "Nuovo"
                        )
                    ),
                ],
                variant: .underline,
                orientation: .vertical
            )
        ),
    ]

    func makeHtml(ctx: TabGroupData) -> String {
        let html = renderFragments(TabGroup(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {
        Basic {
            Div {
                showComponentTitle("TabGroup")

                for variant in variants {
                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { TabGroup(variant.data).render() }
                            .class("mb-4 mt-4")
                    }
                }
            }
            .class("mt-4 space-y-6")
        }
        .render()
    }
}
