/// Texts of the Preview app that no Raccoon component renders. They live here so that the validation test
/// checks them like every other built-in text (the Preview scans `Sources/Preview` for the keys).
extension Translations {
    static let preview: [String: [String: String]] = [
        "preview": [
            "en": "Preview",
            "de": "Vorschau",
            "fr": "Aperçu",
            "es": "Vista previa",
            "it": "Anteprima",
        ],
        "tabsLabel": [
            "en": "Preview, API, and HTML code",
            "de": "Vorschau, API und HTML-Code",
            "fr": "Aperçu, API et code HTML",
            "es": "Vista previa, API y código HTML",
            "it": "Anteprima, API e codice HTML",
        ],
        "filterPlaceholder": [
            "en": "Filter components...",
            "de": "Komponenten filtern …",
            "fr": "Filtrer les composants…",
            "es": "Filtrar componentes…",
            "it": "Filtra i componenti…",
        ],
        "filterLabel": [
            "en": "Filter components",
            "de": "Komponenten filtern",
            "fr": "Filtrer les composants",
            "es": "Filtrar componentes",
            "it": "Filtra i componenti",
        ],
        "sectionComponents": [
            "en": "Components",
            "de": "Komponenten",
            "fr": "Composants",
            "es": "Componentes",
            "it": "Componenti",
        ],
        "pageTitle": [
            "en": "Preview – {{title}}",
            "de": "Vorschau – {{title}}",
            "fr": "Aperçu – {{title}}",
            "es": "Vista previa – {{title}}",
            "it": "Anteprima – {{title}}",
        ],
        "homeTitle": [
            "en": "{{name}} Component Preview",
            "de": "{{name}}-Komponentenvorschau",
            "fr": "Aperçu des composants {{name}}",
            "es": "Vista previa de componentes de {{name}}",
            "it": "Anteprima dei componenti di {{name}}",
        ],
        "overview": [
            "en": "Overview",
            "de": "Übersicht",
            "fr": "Aperçu général",
            "es": "Resumen",
            "it": "Panoramica",
        ],
        "homeIntro": [
            "en":
                "Welcome to the {{name}} component and template preview environment. Select a component or template from the sidebar to inspect its rendering, data model, and HTML output.",
            "de":
                "Willkommen in der Vorschauumgebung für {{name}}-Komponenten und -Templates. Wähle in der Seitenleiste eine Komponente oder ein Template aus, um Darstellung, Datenmodell und HTML-Ausgabe zu prüfen.",
            "fr":
                "Bienvenue dans l'environnement d'aperçu des composants et modèles {{name}}. Sélectionnez un composant ou un modèle dans la barre latérale pour inspecter son rendu, son modèle de données et sa sortie HTML.",
            "es":
                "Te damos la bienvenida al entorno de vista previa de componentes y plantillas de {{name}}. Selecciona un componente o una plantilla en la barra lateral para inspeccionar su renderizado, su modelo de datos y su salida HTML.",
            "it":
                "Benvenuto nell'ambiente di anteprima di componenti e template di {{name}}. Seleziona un componente o un template dalla barra laterale per esaminarne il rendering, il modello di dati e l'output HTML.",
        ],
        "kitTitle": [
            "en": "{{name}} UI Kit",
            "de": "{{name}} UI-Kit",
            "fr": "Kit d'interface {{name}}",
            "es": "Kit de interfaz de {{name}}",
            "it": "Kit UI {{name}}",
        ],
        "kitText": [
            "en": "Core domain-agnostic UI components ({{count}} components).",
            "de":
                "Zentrale, fachlich neutrale UI-Komponenten ({{count}} Komponenten).",
            "fr":
                "Composants d'interface de base, indépendants du domaine ({{count}} composants).",
            "es":
                "Componentes de interfaz básicos e independientes del dominio ({{count}} componentes).",
            "it":
                "Componenti UI di base, indipendenti dal dominio ({{count}} componenti).",
        ],
        "browse": [
            "en": "Browse {{name}} components",
            "de": "{{name}}-Komponenten durchsuchen",
            "fr": "Parcourir les composants {{name}}",
            "es": "Explorar los componentes de {{name}}",
            "it": "Sfoglia i componenti di {{name}}",
        ],
        "simulateError": [
            "en": "Simulate an error",
            "de": "Fehler simulieren",
            "fr": "Simuler une erreur",
            "es": "Simular un error",
            "it": "Simula un errore",
        ],
        "backToNormal": [
            "en": "Back to normal",
            "de": "Zurück zum Normalzustand",
            "fr": "Retour à la normale",
            "es": "Volver a la normalidad",
            "it": "Torna alla normalità",
        ],
        "dataTableIntro": [
            "en":
                "Rows are loaded from /simulation/raccoons, which answers after half a second. Sorting, filtering and paging run in that endpoint. ",
            "de":
                "Die Zeilen werden von /simulation/raccoons geladen, das nach einer halben Sekunde antwortet. Sortieren, Filtern und Blättern laufen in diesem Endpunkt. ",
            "fr":
                "Les lignes sont chargées depuis /simulation/raccoons, qui répond après une demi-seconde. Le tri, le filtrage et la pagination s'exécutent dans ce point de terminaison. ",
            "es":
                "Las filas se cargan desde /simulation/raccoons, que responde tras medio segundo. La ordenación, el filtrado y la paginación se ejecutan en ese endpoint. ",
            "it":
                "Le righe vengono caricate da /simulation/raccoons, che risponde dopo mezzo secondo. Ordinamento, filtro e paginazione vengono eseguiti in quell'endpoint. ",
        ],
        "uploadSingle": [
            "en": "Test live single upload against fake endpoint:",
            "de": "Einzelnen Upload live gegen einen Fake-Endpunkt testen:",
            "fr":
                "Tester le téléversement unique en direct sur un faux point de terminaison :",
            "es": "Probar la subida individual en vivo con un endpoint falso:",
            "it":
                "Prova il caricamento singolo dal vivo su un endpoint fittizio:",
        ],
        "uploadMultiple": [
            "en": "Test live multiple upload against fake endpoint:",
            "de": "Mehrfach-Upload live gegen einen Fake-Endpunkt testen:",
            "fr":
                "Tester le téléversement multiple en direct sur un faux point de terminaison :",
            "es": "Probar la subida múltiple en vivo con un endpoint falso:",
            "it":
                "Prova il caricamento multiplo dal vivo su un endpoint fittizio:",
        ],
        "scrollDepth": [
            "en": "Scroll Depth: ",
            "de": "Scrolltiefe: ",
            "fr": "Profondeur de défilement : ",
            "es": "Profundidad de desplazamiento: ",
            "it": "Profondità di scorrimento: ",
        ],
        "threshold": [
            "en": "80% Threshold: ",
            "de": "80-%-Schwelle: ",
            "fr": "Seuil de 80 % : ",
            "es": "Umbral del 80 %: ",
            "it": "Soglia dell'80%: ",
        ],
        "testBed": [
            "en": "Interactive Scroll Test Bed (80% Threshold)",
            "de": "Interaktiver Scroll-Testbereich (80-%-Schwelle)",
            "fr": "Banc d'essai de défilement interactif (seuil de 80 %)",
            "es":
                "Banco de pruebas de desplazamiento interactivo (umbral del 80 %)",
            "it":
                "Banco di prova interattivo dello scorrimento (soglia dell'80%)",
        ],
        "pageTop": [
            "en": "Page Top (0% scroll)",
            "de": "Seitenanfang (0 % gescrollt)",
            "fr": "Haut de page (0 % de défilement)",
            "es": "Parte superior de la página (0 % de desplazamiento)",
            "it": "Inizio pagina (0% di scorrimento)",
        ],
        "milestone": [
            "en": "Content milestone ~{{percent}}%",
            "de": "Inhalts-Meilenstein ~{{percent}} %",
            "fr": "Jalon de contenu ~{{percent}} %",
            "es": "Hito de contenido ~{{percent}} %",
            "it": "Traguardo del contenuto ~{{percent}}%",
        ],
        "reached": [
            "en": "80% SCROLL THRESHOLD REACHED",
            "de": "80-%-SCROLLSCHWELLE ERREICHT",
            "fr": "SEUIL DE DÉFILEMENT DE 80 % ATTEINT",
            "es": "UMBRAL DE DESPLAZAMIENTO DEL 80 % ALCANZADO",
            "it": "SOGLIA DI SCORRIMENTO DELL'80% RAGGIUNTA",
        ],
        "articleEnd": [
            "en": "Article End — In-Page Docking Spot",
            "de": "Artikelende – Andockstelle auf der Seite",
            "fr": "Fin de l'article — point d'ancrage dans la page",
            "es": "Fin del artículo — punto de anclaje en la página",
            "it": "Fine dell'articolo — punto di aggancio nella pagina",
        ],
        "pageBottom": [
            "en": "Page Bottom (100% scroll)",
            "de": "Seitenende (100 % gescrollt)",
            "fr": "Bas de page (100 % de défilement)",
            "es": "Parte inferior de la página (100 % de desplazamiento)",
            "it": "Fine pagina (100% di scorrimento)",
        ],
    ]
}
