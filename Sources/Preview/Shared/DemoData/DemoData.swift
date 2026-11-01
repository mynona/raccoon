import Raccoon
import Vapor

public struct DemoData {

    public static let breadcrumbPaths: [BreadcrumbPath] = [
        BreadcrumbPath(
            title: "Donaudampfschifffahrtsgesellschaft",
            href: "/one"
        ),
        BreadcrumbPath(
            title: tr(
                "Level 2",
                de: "Ebene 2",
                fr: "Niveau 2",
                es: "Nivel 2",
                it: "Livello 2"
            ),
            href: "/one/two"
        ),
        BreadcrumbPath(
            title: tr(
                "Level 3",
                de: "Ebene 3",
                fr: "Niveau 3",
                es: "Nivel 3",
                it: "Livello 3"
            ),
            href: "/one/two/three",
            isCurrentPathSegment: true
        ),
    ]

    public static let optionList = [
        OptionValue(
            title: tr(
                "Option A",
                de: "Option A",
                fr: "Option A",
                es: "Opción A",
                it: "Opzione A"
            ),
            value: "a"
        ),
        OptionValue(
            title: tr(
                "Option B",
                de: "Option B",
                fr: "Option B",
                es: "Opción B",
                it: "Opzione B"
            ),
            value: "b",
            selected: true
        ),
        OptionValue(
            title: tr(
                "Option C",
                de: "Option C",
                fr: "Option C",
                es: "Opción C",
                it: "Opzione C"
            ),
            value: "c"
        ),
    ]

    public static let markdownText: LocalizedText = tr(
        """
        # Heading 1

        Some text

        ## Heading 2

        Some text

        ### Heading 3

        Some text 

        #### Heading 4

        Some text

        ---

        **Unordered List with asterix:**
        * Item one
        * Item two
        * Item three

        **Unordered List with hyphen:**
        - Item one
        - Item two
        - Item three

        **Ordered List:**
        1. First item
        2. Second item
        3. Third item


        **Bold**


        *Italic*

        `Inline code`

        ```
        Multiline code block 
        Another line of code
        ```

        [Link](https://link)

        > Blockquote

        | Name | Age |
        |------|-----|
        | Max  | 32  |
        | Eva  | 29  |

        ![Alt text](/images/bmc-yellow.png)

        Term
        : Definition text

        - [x] Done
        - [ ] Not done
        - [x] Done
        - [ ] Not done


        ~~This is crossed out~~

        🔥 This is a heading with emoji




        """,
        de: """
            # Überschrift 1

            Etwas Text

            ## Überschrift 2

            Etwas Text

            ### Überschrift 3

            Etwas Text 

            #### Überschrift 4

            Etwas Text

            ---

            **Ungeordnete Liste mit Sternchen:**
            * Eintrag eins
            * Eintrag zwei
            * Eintrag drei

            **Ungeordnete Liste mit Bindestrichen:**
            - Eintrag eins
            - Eintrag zwei
            - Eintrag drei

            **Geordnete Liste:**
            1. Erster Eintrag
            2. Zweiter Eintrag
            3. Dritter Eintrag


            **Fett**


            *Kursiv*

            `Inline-Code`

            ```
            Multiline code block 
            Another line of code
            ```

            [Link](https://link)

            > Blockzitat

            | Name | Alter |
            |------|-----|
            | Max  | 32  |
            | Eva  | 29  |

            ![Alternativtext](/images/bmc-yellow.png)

            Begriff
            : Text der Definition

            - [x] Erledigt
            - [ ] Nicht erledigt
            - [x] Erledigt
            - [ ] Nicht erledigt


            ~~Das ist durchgestrichen~~

            🔥 Das ist eine Überschrift mit Emoji




            """,
        fr: """
            # Titre 1

            Du texte

            ## Titre 2

            Du texte

            ### Titre 3

            Du texte 

            #### Titre 4

            Du texte

            ---

            **Liste non ordonnée avec astérisques :**
            * Élément un
            * Élément deux
            * Élément trois

            **Liste non ordonnée avec tirets :**
            - Élément un
            - Élément deux
            - Élément trois

            **Liste ordonnée :**
            1. Premier élément
            2. Deuxième élément
            3. Troisième élément


            **Gras**


            *Italique*

            `Code en ligne`

            ```
            Multiline code block 
            Another line of code
            ```

            [Lien](https://link)

            > Citation

            | Nom | Âge |
            |------|-----|
            | Max  | 32  |
            | Eva  | 29  |

            ![Texte alternatif](/images/bmc-yellow.png)

            Terme
            : Texte de la définition

            - [x] Terminé
            - [ ] Non terminé
            - [x] Terminé
            - [ ] Non terminé


            ~~Ceci est barré~~

            🔥 Ceci est un titre avec emoji




            """,
        es: """
            # Encabezado 1

            Algo de texto

            ## Encabezado 2

            Algo de texto

            ### Encabezado 3

            Algo de texto 

            #### Encabezado 4

            Algo de texto

            ---

            **Lista sin orden con asteriscos:**
            * Elemento uno
            * Elemento dos
            * Elemento tres

            **Lista sin orden con guiones:**
            - Elemento uno
            - Elemento dos
            - Elemento tres

            **Lista ordenada:**
            1. Primer elemento
            2. Segundo elemento
            3. Tercer elemento


            **Negrita**


            *Cursiva*

            `Código en línea`

            ```
            Multiline code block 
            Another line of code
            ```

            [Enlace](https://link)

            > Cita en bloque

            | Nombre | Edad |
            |------|-----|
            | Max  | 32  |
            | Eva  | 29  |

            ![Texto alternativo](/images/bmc-yellow.png)

            Término
            : Texto de la definición

            - [x] Hecho
            - [ ] Pendiente
            - [x] Hecho
            - [ ] Pendiente


            ~~Esto está tachado~~

            🔥 Este es un encabezado con emoji




            """,
        it: """
            # Titolo 1

            Del testo

            ## Titolo 2

            Del testo

            ### Titolo 3

            Del testo 

            #### Titolo 4

            Del testo

            ---

            **Elenco non ordinato con asterischi:**
            * Elemento uno
            * Elemento due
            * Elemento tre

            **Elenco non ordinato con trattini:**
            - Elemento uno
            - Elemento due
            - Elemento tre

            **Elenco ordinato:**
            1. Primo elemento
            2. Secondo elemento
            3. Terzo elemento


            **Grassetto**


            *Corsivo*

            `Codice inline`

            ```
            Multiline code block 
            Another line of code
            ```

            [Link](https://link)

            > Citazione

            | Nome | Età |
            |------|-----|
            | Max  | 32  |
            | Eva  | 29  |

            ![Testo alternativo](/images/bmc-yellow.png)

            Termine
            : Testo della definizione

            - [x] Fatto
            - [ ] Da fare
            - [x] Fatto
            - [ ] Da fare


            ~~Questo è barrato~~

            🔥 Questo è un titolo con emoji




            """
    )

    public static let simpleTableMeta = """
        {\"hasIndexColumn\":true,\"columns\":[{\"key\":\"loop\",\"label\":\"Loop type\",\"type\":\"text\",\"align\":\"left\",\"sortable\":true},{\"key\":\"description\",\"label\":\"How it works\",\"type\":\"text\",\"align\":\"left\",\"sortable\":false},{\"key\":\"example\",\"label\":\"Examples\",\"type\":\"text\",\"align\":\"left\",\"sortable\":false}]}
        """
    public static let simpleTableRows = """
        [
            {\"loop\":\"UGC Loops\",\"description\":\"Users create content that attracts new users\",\"example\":\"Instagram, YouTube, Substack\"},
            {\"loop\":\"Viral Loops\",\"description\":\"Content spreads widely via social sharing\",\"example\":\"TikTok, WhatsApp\"},
            {\"loop\":\"Collaborative Loops\",\"description\":\"Users invite teammates to collaborate\",\"example\":\"Slack, Miro, LinkedIn\"},
            {\"loop\":\"Product Usage Loops\",\"description\":\"Product use itself pulls in others\",\"example\":\"Zoom, Dropbox\"},
            {\"loop\":\"Marketplace Loops\",\"description\":\"Buyers and sellers attract each other\",\"example\":\"Airbnb, Amazon\"},
            {\"loop\":\"Referral Loops\",\"description\":\"Users invite friends with rewards\",\"example\":\"Dropbox, Uber\"}
        ]
        """
}
