import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct MermaidView: TemplateRepresentable {

    let variants: [PreviewVariant<MermaidData>] = [
        #previewVariant(
            tr(
                "Flowchart",
                [
                    "de": "Flussdiagramm",
                    "fr": "Organigramme",
                    "es": "Diagrama de flujo",
                    "it": "Diagramma di flusso",
                    "pt": "Fluxograma",
                    "nl": "Stroomschema",
                    "da": "Rutediagram",
                    "sv": "Flödesschema",
                    "nb": "Flytskjema",
                    "fi": "Vuokaavio",
                    "is": "Flæðirit",
                    "el": "Διάγραμμα ροής",
                    "tr": "Akış şeması",
                    "hu": "Folyamatábra",
                    "hr": "Dijagram toka",
                    "pl": "Schemat blokowy",
                    "sk": "Vývojový diagram",
                    "cs": "Vývojový diagram",
                    "lb": "Flossdiagramm",
                ]
            ),
            MermaidData(
                diagram:
                    """
                    flowchart TD
                      A[Start] --> B{Decision?}
                      B -->|Yes| C[Do the thing]
                      B -->|No| D[Skip it]
                      C --> E[End]
                      D --> E
                    """,
                widthInPercent: 100
            )
        ),
        #previewVariant(
            tr(
                "State Diagram",
                [
                    "de": "Zustandsdiagramm",
                    "fr": "Diagramme d'état",
                    "es": "Diagrama de estado",
                    "it": "Diagramma di stato",
                    "pt": "Diagrama de estado",
                    "nl": "Tostandsdiagram",
                    "da": "Tilstandsdiagram",
                    "sv": "Tillståndsdiagram",
                    "nb": "Tilstandsdiagram",
                    "fi": "Tilakaavio",
                    "is": "Stöðurit",
                    "el": "Διάγραμμα κατάστασης",
                    "tr": "Durum şeması",
                    "hu": "Állapotdiagram",
                    "hr": "Dijagram stanja",
                    "pl": "Diagram stanów",
                    "sk": "Stavový diagram",
                    "cs": "Stavový diagram",
                    "lb": "Zoustandsdiagramm",
                ]
            ),
            MermaidData(
                diagram:
                    """
                    stateDiagram-v2
                      [*] --> Idle
                      Idle --> Processing: start
                      Processing --> Complete: done
                      Processing --> Failed: error
                      Failed --> Idle: retry
                      Complete --> [*]
                    """,
                widthInPercent: 100
            )
        ),
        #previewVariant(
            tr(
                "Sequence Diagram",
                [
                    "de": "Sequenzdiagramm",
                    "fr": "Diagramme de séquence",
                    "es": "Diagrama de secuencia",
                    "it": "Diagramma di sequenza",
                    "pt": "Diagrama de sequência",
                    "nl": "Sequentiediagram",
                    "da": "Sekvensdiagram",
                    "sv": "Sekvensdiagram",
                    "nb": "Sekvensdiagram",
                    "fi": "Sekvenssikaavio",
                    "is": "Rásrit",
                    "el": "Διάγραμμα ακολουθίας",
                    "tr": "Sıralama şeması",
                    "hu": "Szekvenciadiagram",
                    "hr": "Sekvencijski dijagram",
                    "pl": "Diagram sekwencji",
                    "sk": "Sekvenčný diagram",
                    "cs": "Sekvenční diagram",
                    "lb": "Sequenzdiagramm",
                ]
            ),
            MermaidData(
                diagram:
                    """
                    sequenceDiagram
                      participant User
                      participant App
                      participant API
                      User->>App: Click export
                      App->>API: Render SVG
                      API-->>App: SVG string
                      App-->>User: Download
                    """,
                widthInPercent: 100
            )
        ),
        #previewVariant(
            tr(
                "Timeline Diagram",
                [
                    "de": "Zeitachsendiagramm",
                    "fr": "Diagramme chronologique",
                    "es": "Línea de tiempo",
                    "it": "Cronologia",
                    "pt": "Linha do tempo",
                    "nl": "Tijdlijndiagram",
                    "da": "Tidslinjediagram",
                    "sv": "Tidslinjediagram",
                    "nb": "Tidslinjediagram",
                    "fi": "Aikajanakaavio",
                    "is": "Tímalínurit",
                    "el": "Χρονολόγιο",
                    "tr": "Zaman çizelgesi şeması",
                    "hu": "Idővonal-diagram",
                    "hr": "Vremenski dijagram",
                    "pl": "Oś czasu",
                    "sk": "Časový diagram",
                    "cs": "Časová osa",
                    "lb": "Zäitleischtendiagramm",
                ]
            ),
            MermaidData(
                diagram:
                    """
                    timeline
                      title Product roadmap
                      section Foundation
                      2024 Q1 : Prototype
                              : Parser coverage
                      section Launch
                      2024 Q2 : Public editor
                              : SVG export
                    """,
                widthInPercent: 100
            )
        ),
        #previewVariant(
            tr(
                "Class Diagram",
                [
                    "de": "Klassendiagramm",
                    "fr": "Diagramme de classes",
                    "es": "Diagrama de clases",
                    "it": "Diagramma delle classi",
                    "pt": "Diagrama de classes",
                    "nl": "Klassendiagram",
                    "da": "Klassediagram",
                    "sv": "Klassdiagram",
                    "nb": "Klassediagram",
                    "fi": "Luokkakaavio",
                    "is": "Klasarit",
                    "el": "Διάγραμμα κλάσεων",
                    "tr": "Sınıf şeması",
                    "hu": "Osztálydiagram",
                    "hr": "Dijagram klasa",
                    "pl": "Diagram klas",
                    "sk": "Triedny diagram",
                    "cs": "Diagram tříd",
                    "lb": "Klassendiagramm",
                ]
            ),
            MermaidData(
                diagram:
                    """
                    classDiagram
                      class Renderer {
                        <<abstract>>
                        +render(source) string
                      }
                      class SVGRenderer {
                        +render(source) string
                      }
                      class RenderPipeline {
                        +run(source) string
                      }
                      Renderer <|-- SVGRenderer
                      RenderPipeline *-- SVGRenderer : owns
                    """,
                widthInPercent: 100
            )
        ),
        #previewVariant(
            tr(
                "Entity Relationship Diagram",
                [
                    "de": "Entity-Relationship-Diagramm",
                    "fr": "Diagramme entité-association",
                    "es": "Diagrama entidad-relación",
                    "it": "Diagramma entità-relazione",
                    "pt": "Diagrama entidade-relacionamento",
                    "nl": "Entiteit-relatiediagram",
                    "da": "Entitet-relationsdiagram",
                    "sv": "Entitetsrelationsdiagram",
                    "nb": "Entitetsrelasjonsdiagram",
                    "fi": "Käsitekaavio (ER)",
                    "is": "Venslarit (ER)",
                    "el": "Διάγραμμα οντοτήτων-συσχετίσεων",
                    "tr": "Varlık bağıntı şeması",
                    "hu": "Egyed-kapcsolat diagram",
                    "hr": "Dijagram entiteti-veze",
                    "pl": "Diagram związków encji",
                    "sk": "Diagram entít a vzťahov",
                    "cs": "ER diagram",
                    "lb": "Entitéit-Relatiouns-Diagramm",
                ]
            ),
            MermaidData(
                diagram:
                    """
                    erDiagram
                      CUSTOMER {
                        string id PK
                        string email
                      }
                      ORDER {
                        string id PK
                        date created
                      }
                      LINE_ITEM {
                        string id PK
                        int quantity
                      }
                      CUSTOMER ||--o{ ORDER : places
                      ORDER ||--|{ LINE_ITEM : contains
                    """,
                widthInPercent: 100
            )
        ),
        #previewVariant(
            tr(
                "User Journey Diagram",
                [
                    "de": "User-Journey-Diagramm",
                    "fr": "Parcours utilisateur",
                    "es": "Recorrido del usuario",
                    "it": "Percorso utente",
                    "pt": "Jornada do usuário",
                    "nl": "Gebruikersreis-diagram",
                    "da": "Brugerrejsediagram",
                    "sv": "Användarresediagram",
                    "nb": "Brukerreisediagram",
                    "fi": "Käyttäjäpolkukaavio",
                    "is": "Notendaferlisrit",
                    "el": "Διαδρομή χρήστη",
                    "tr": "Kullanıcı yolculuğu şeması",
                    "hu": "Felhasználói út diagram",
                    "hr": "Dijagram korisničkog putovanja",
                    "pl": "Diagram ścieżki użytkownika",
                    "sk": "Diagram cesty používateľa",
                    "cs": "Diagram cesty uživatele",
                    "lb": "Benotzerrees-Diagramm",
                ]
            ),
            MermaidData(
                diagram:
                    """
                    journey
                      title Editor adoption
                      section Try
                        Open editor: 5: User
                        Load example: 4: User, Developer
                      section Share
                        Copy URL: 5: User
                        Export SVG: 4: Developer
                    """,
                widthInPercent: 100
            )
        ),
        #previewVariant(
            tr(
                "Architecture Diagram",
                [
                    "de": "Architekturdiagramm",
                    "fr": "Diagramme d'architecture",
                    "es": "Diagrama de arquitectura",
                    "it": "Diagramma di architettura",
                    "pt": "Diagrama de arquitetura",
                    "nl": "Architectuurdiagram",
                    "da": "Arkitekturdiagram",
                    "sv": "Arkitekturdiagram",
                    "nb": "Arkitekturdiagram",
                    "fi": "Arkkitehtuurikaavio",
                    "is": "Byggingarlagsrit",
                    "el": "Διάγραμμα αρχιτεκτονικής",
                    "tr": "Mimari şeması",
                    "hu": "Architektúra-diagram",
                    "hr": "Arhitekturni dijagram",
                    "pl": "Diagram architektury",
                    "sk": "Architektonický diagram",
                    "cs": "Diagram architektury",
                    "lb": "Architekturdiagramm",
                ]
            ),
            MermaidData(
                diagram:
                    """
                    architecture-beta
                      group app(cloud)[Application]
                      group data(database)[Data]
                      service web(server)[Web App] in app
                      service api(server)[API] in app
                      service db(database)[Postgres] in data
                      web:R --> L:api
                      api:R --> L:db
                    """,
                widthInPercent: 100
            )
        ),
        #previewVariant(
            tr(
                "XY Chart",
                [
                    "de": "XY-Diagramm",
                    "fr": "Graphique XY",
                    "es": "Gráfico XY",
                    "it": "Grafico XY",
                    "pt": "Gráfico XY",
                    "nl": "XY-grafiek",
                    "da": "XY-diagram",
                    "sv": "XY-diagram",
                    "nb": "XY-diagram",
                    "fi": "XY-kaavio",
                    "is": "XY-rit",
                    "el": "Διάγραμμα XY",
                    "tr": "XY grafiği",
                    "hu": "XY-diagram",
                    "hr": "XY grafikon",
                    "pl": "Wykres XY",
                    "sk": "XY graf",
                    "cs": "XY graf",
                    "lb": "XY-Diagramm",
                ]
            ),
            MermaidData(
                diagram:
                    """
                    xychart
                      title "Weekly renders"
                      x-axis [Mon, Tue, Wed, Thu, Fri]
                      y-axis "Renders" 0 --> 100
                      bar [25, 42, 58, 74, 88]
                      line [18, 35, 52, 70, 95]
                    """,
                widthInPercent: 100
            )
        ),
        #previewVariant(
            tr(
                "Pie Chart",
                [
                    "de": "Kreisdiagramm",
                    "fr": "Graphique circulaire",
                    "es": "Gráfico circular",
                    "it": "Grafico a torta",
                    "pt": "Gráfico de pizza",
                    "nl": "Cirkeldiagram",
                    "da": "Cirkeldiagram",
                    "sv": "Cirkeldiagram",
                    "nb": "Kakediagram",
                    "fi": "Ympyräkaavio",
                    "is": "Kökurit",
                    "el": "Κυκλικό διάγραμμα",
                    "tr": "Pasta grafiği",
                    "hu": "Kördiagram",
                    "hr": "Tortni grafikon",
                    "pl": "Wykres kołowy",
                    "sk": "Koláčový graf",
                    "cs": "Koláčový graf",
                    "lb": "Kreesdiagramm",
                ]
            ),
            MermaidData(
                diagram:
                    """
                    pie showData
                      title Export requests by format
                      "SVG" : 42
                      "PNG" : 28
                      "ASCII" : 18
                      "Unicode" : 12
                    """,
                widthInPercent: 100
            )
        ),
        #previewVariant(
            tr(
                "Quadrant Chart",
                [
                    "de": "Quadrantendiagramm",
                    "fr": "Graphique en quadrants",
                    "es": "Gráfico de cuadrantes",
                    "it": "Grafico a quadranti",
                    "pt": "Gráfico de quadrantes",
                    "nl": "Kwadrantendiagram",
                    "da": "Kvadrantdiagram",
                    "sv": "Kvadrantdiagram",
                    "nb": "Kvadrantdiagram",
                    "fi": "Nelikaavio",
                    "is": "Fjórðungsrit",
                    "el": "Διάγραμμα τεταρτημορίων",
                    "tr": "Dört kadran grafiği",
                    "hu": "Kvadráns-diagram",
                    "hr": "Kvadrantni grafikon",
                    "pl": "Wykres ćwiartkowy",
                    "sk": "Kvadrantový graf",
                    "cs": "Kvadrantový graf",
                    "lb": "Quadrantendiagramm",
                ]
            ),
            MermaidData(
                diagram:
                    """
                    quadrantChart
                      title Feature priorities
                      x-axis Low impact --> High impact
                      y-axis Low effort --> High effort
                      quadrant-1 Plan carefully
                      quadrant-2 Big bets
                      quadrant-3 Defer
                      quadrant-4 Quick wins
                      SVG export: [0.78, 0.28]
                      MCP setup: [0.62, 0.72]
                      Palette polish: [0.35, 0.24]
                    """,
                widthInPercent: 100
            )
        ),
        #previewVariant(
            tr(
                "Gantt Chart",
                [
                    "de": "Gantt-Diagramm",
                    "fr": "Diagramme de Gantt",
                    "es": "Diagrama de Gantt",
                    "it": "Diagramma di Gantt",
                    "pt": "Gráfico de Gantt",
                    "nl": "Gantt-diagram",
                    "da": "Gantt-diagram",
                    "sv": "Gantt-diagram",
                    "nb": "Gantt-diagram",
                    "fi": "Gantt-kaavio",
                    "is": "Gantt-rit",
                    "el": "Διάγραμμα Gantt",
                    "tr": "Gantt şeması",
                    "hu": "Gantt-diagram",
                    "hr": "Ganttov dijagram",
                    "pl": "Wykres Gantta",
                    "sk": "Ganttov diagram",
                    "cs": "Ganttův diagram",
                    "lb": "Gantt-Diagramm",
                ]
            ),
            MermaidData(
                diagram:
                    """
                    gantt
                      title Release train
                      dateFormat YYYY-MM-DD
                      excludes weekends
                      section Build
                        Completed task :done, des1, 2024-01-08, 2024-01-10
                        Active task    :active, des2, 2024-01-11, 3d
                        Future task    :des3, after des2, 5d
                      section Ship
                        Crit review    :crit, rev1, after des3, 2d
                        Release        :milestone, m1, after rev1, 0d
                    """,
                widthInPercent: 100
            )
        ),
        #previewVariant(
            tr(
                "Mindmap",
                [
                    "de": "Mindmap",
                    "fr": "Carte mentale",
                    "es": "Mapa mental",
                    "it": "Mappa mentale",
                    "pt": "Mapa mental",
                    "nl": "Mindmap",
                    "da": "Mindmap",
                    "sv": "Mindmap",
                    "nb": "Tankekart",
                    "fi": "Käsitekartta",
                    "is": "Hugarkort",
                    "el": "Χάρτης μυαλού",
                    "tr": "Zihin haritası",
                    "hu": "Gondolattérkép",
                    "hr": "Mentalna mapa",
                    "pl": "Mapa myśli",
                    "sk": "Myšlienková mapa",
                    "cs": "Myšlenková mapa",
                    "lb": "Gedankekaart",
                ]
            ),
            MermaidData(
                diagram:
                    """
                    mindmap
                      root((mindmap))
                        Origins
                          Long history
                          ::icon(fa fa-book)
                          Popularisation
                            British popular psychology author Tony Buzan
                        Research
                          On effectiveness<br/>and features
                          On Automatic creation
                            Uses
                                Creative techniques
                                Strategic planning
                                Argument mapping
                        Tools
                          Pen and paper
                          Mermaid

                    """,
                widthInPercent: 100
            )
        ),
        #previewVariant(
            tr(
                "Git Graph",
                [
                    "de": "Git-Graph",
                    "fr": "Graphe Git",
                    "es": "Gráfico Git",
                    "it": "Grafico Git",
                    "pt": "Gráfico Git",
                    "nl": "Git-grafiek",
                    "da": "Git-graf",
                    "sv": "Git-diagram",
                    "nb": "Git-graf",
                    "fi": "Git-kaavio",
                    "is": "Git-línurit",
                    "el": "Γράφημα Git",
                    "tr": "Git grafiği",
                    "hu": "Git-grafikon",
                    "hr": "Git grafikon",
                    "pl": "Wykres Gita",
                    "sk": "Git graf",
                    "cs": "Git graf",
                    "lb": "Git-Graf",
                ]
            ),
            MermaidData(
                diagram:
                    """
                    ---
                    title: Release train with backport
                    config:
                      gitGraph:
                        mainBranchName: main
                        mainBranchOrder: 0
                        showBranches: true
                        showCommitLabel: true
                        rotateCommitLabel: true
                    ---
                    gitGraph LR:
                      accTitle: Release history with feature merge and backport
                      accDescr: Develop and release branches diverge, main merges develop, and release cherry-picks the merge
                      commit id:"ROOT" tag:"v1.0.0" msg:"Foundation"
                      branch develop order:2
                      commit id:"API" type:HIGHLIGHT tag:"beta" msg:"Build API"
                      branch release order:3
                      commit id:"RC" type:REVERSE tag:"rc.1" msg:"Cut release candidate"
                      checkout develop
                      commit id:"UI" msg:"Finish interface"
                      checkout main
                      commit id:"HOTFIX" type:REVERSE msg:"Patch production"
                      merge develop id:"MERGE" tag:"v2.0.0" type:HIGHLIGHT
                      checkout release
                      cherry-pick id:"MERGE" parent:"UI" tag:"backport"
                      commit id:"PATCH" msg:"Verify release"
                    """
            )
        ),

        #previewVariant(
            tr(
                "Radar Chart",
                [
                    "de": "Netzdiagramm",
                    "fr": "Graphique radar",
                    "es": "Gráfico de radar",
                    "it": "Grafico radar",
                    "pt": "Gráfico de radar",
                    "nl": "Radardiagram",
                    "da": "Radardiagram",
                    "sv": "Radardiagram",
                    "nb": "Radardiagram",
                    "fi": "Tutkakaavio",
                    "is": "Radíuriti",
                    "el": "Διάγραμμα ραντάρ",
                    "tr": "Radar grafiği",
                    "hu": "Pókháló-diagram",
                    "hr": "Radarski grafikon",
                    "pl": "Wykres radarowy",
                    "sk": "Radarový graf",
                    "cs": "Paprskový graf",
                    "lb": "Netzdiagramm",
                ]
            ),
            MermaidData(
                diagram:
                    """
                    radar-beta
                      title Model comparison
                      axis speed["Speed"], accuracy["Accuracy"], cost["Cost"]
                      axis latency["Latency"], context["Context"], safety["Safety"]
                      curve a["Model A"]{4, 5, 3, 4, 4, 5}
                      curve b["Model B"]{5, 3, 4, 3, 5, 3}
                      graticule polygon
                      max 5
                    """,
                widthInPercent: 80,
                isCentered: true
            )
        ),

        #previewVariant(
            tr(
                "Sankey Diagram",
                [
                    "de": "Sankey-Diagramm",
                    "fr": "Diagramme de Sankey",
                    "es": "Diagrama de Sankey",
                    "it": "Diagramma di Sankey",
                    "pt": "Diagrama de Sankey",
                    "nl": "Sankey-diagram",
                    "da": "Sankey-diagram",
                    "sv": "Sankey-diagram",
                    "nb": "Sankey-diagram",
                    "fi": "Sankey-kaavio",
                    "is": "Sankey-rit",
                    "el": "Διάγραμμα Sankey",
                    "tr": "Sankey şeması",
                    "hu": "Sankey-diagram",
                    "hr": "Sankeyev dijagram",
                    "pl": "Diagram Sankeya",
                    "sk": "Sankeyov diagram",
                    "cs": "Sankeyův diagram",
                    "lb": "Sankey-Diagramm",
                ]
            ),
            MermaidData(
                diagram:
                    """
                    sankey-beta
                      Coal,Electricity,60
                      Gas,Electricity,80
                      Solar,Electricity,40
                      Electricity,Homes,120
                      Electricity,Industry,60
                    """,
                widthInPercent: 80,
                isCentered: true
            )
        ),

        #previewVariant(
            tr(
                "Packet Diagram",
                [
                    "de": "Paketdiagramm",
                    "fr": "Diagramme de paquets",
                    "es": "Diagrama de paquetes",
                    "it": "Diagramma di pacchetto",
                    "pt": "Diagrama de pacotes",
                    "nl": "Pakketdiagram",
                    "da": "Pakkediagram",
                    "sv": "Paketdiagram",
                    "nb": "Pakkediagram",
                    "fi": "Pakettikaavio",
                    "is": "Pakkadreifirit",
                    "el": "Διάγραμμα πακέτου",
                    "tr": "Paket şeması",
                    "hu": "Csomagdiagram",
                    "hr": "Paketni dijagram",
                    "pl": "Diagram pakietów",
                    "sk": "Balíkový diagram",
                    "cs": "Paketový diagram",
                    "lb": "Paketdiagramm",
                ]
            ),
            MermaidData(
                diagram:
                    """
                    packet
                    title UDP datagram
                    +16: "Source port"
                    +16: "Destination port"
                    +16: "Length"
                    +16: "Checksum"
                    +32: "Payload"
                    """,
                widthInPercent: 80,
                isCentered: true
            )
        ),

        #previewVariant(
            tr(
                "Kanban Board",
                [
                    "de": "Kanban-Board",
                    "fr": "Tableau Kanban",
                    "es": "Tablero Kanban",
                    "it": "Bacheca Kanban",
                    "pt": "Quadro Kanban",
                    "nl": "Kanban-bord",
                    "da": "Kanban-tavle",
                    "sv": "Kanban-tavla",
                    "nb": "Kanban-tavle",
                    "fi": "Kanban-taulu",
                    "is": "Kanban-tafla",
                    "el": "Πίνακας Kanban",
                    "tr": "Kanban panosu",
                    "hu": "Kanban-tábla",
                    "hr": "Kanban ploča",
                    "pl": "Tablica Kanban",
                    "sk": "Kanban nástenka",
                    "cs": "Kanbanová tabule",
                    "lb": "Kanban-Briet",
                ]
            ),
            MermaidData(
                diagram:
                    """
                    kanban
                      todo[To do]
                        packet[Packet family]@{ assigned: "Maya", priority: "High" }
                      doing[In progress]
                        kanban[Kanban family]@{ assigned: "Alex", ticket: "AM-409" }
                      done[Done]
                        research[Community research]
                    """,
                widthInPercent: 80,
                isCentered: true
            )
        ),

        #previewVariant(
            tr(
                "Treemap",
                [
                    "de": "Kacheldiagramm (Treemap)",
                    "fr": "Treemap",
                    "es": "Mapa de árbol",
                    "it": "Mappa ad albero",
                    "pt": "Mapa de árvore",
                    "nl": "Boomdiagram",
                    "da": "Trædiagram",
                    "sv": "Trädkarta",
                    "nb": "Trekart",
                    "fi": "Puukartta",
                    "is": "Trjákort",
                    "el": "Χάρτης δέντρου",
                    "tr": "Ağaç haritası",
                    "hu": "Faszerkezetes térkép",
                    "hr": "Stablokarta",
                    "pl": "Mapa drzewa",
                    "sk": "Stromová mapa",
                    "cs": "Stromová mapa",
                    "lb": "Kacheldiagramm",
                ]
            ),
            MermaidData(
                diagram:
                    """
                    treemap
                    title Product investment
                    "Build"
                      "Engineering": 60
                      "Design": 25
                    "Learn"
                      "Research": 30
                      "Analytics": 15
                    """,
                widthInPercent: 80,
                isCentered: true
            )
        ),

        #previewVariant(
            tr(
                "Event Modeling Diagram",
                [
                    "de": "Event-Modeling-Diagramm",
                    "fr": "Modélisation d'événements",
                    "es": "Modelado de eventos",
                    "it": "Modellazione eventi",
                    "pt": "Modelagem de eventos",
                    "nl": "Gebeurtenismodellering",
                    "da": "Hændelsesmodelleringsdiagram",
                    "sv": "Händelsemodelleringsdiagram",
                    "nb": "Hendelsesmodelleringsdiagram",
                    "fi": "Tapahtumamallinnus",
                    "is": "Atburðalíkangerð",
                    "el": "Μοντελοποίηση συμβάντων",
                    "tr": "Olay modelleme şeması",
                    "hu": "Eseménymodellezés",
                    "hr": "Modeliranje događaja",
                    "pl": "Modelowanie zdarzeń",
                    "sk": "Modelovanie udalostí",
                    "cs": "Modelování událostí",
                    "lb": "Event-Modelling-Diagramm",
                ]
            ),
            MermaidData(
                diagram:
                    """
                    eventmodeling
                    tf 01 ui CartUI
                    tf 02 cmd AddItem
                    tf 03 evt ItemAdded
                    tf 04 rmo CartItems
                    tf 05 ui CartUI
                    """,
                widthInPercent: 80,
                isCentered: true
            )
        ),

    ]

    func makeHtml(ctx: MermaidData) -> String {
        let html = renderFragments(Mermaid(ctx).render())
        let formattedHtml = prettyHTML(html)
        let escapedHtml = escapeHTML(formattedHtml)
        return escapedHtml
    }

    @Builder<Element>
    func render() -> [Element] {

        Basic {

            Div {

                showComponentTitle("Mermaid")

                for variant in variants {

                    showVariantTitle(variant.label, variant.data)

                    showComponentPreview(
                        data: variant.code,
                        html: makeHtml(ctx: variant.data)
                    ) {
                        Div { Mermaid(variant.data).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
