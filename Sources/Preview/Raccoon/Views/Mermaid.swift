import HTML
import Raccoon
import SGML
import SVG
import Vapor
import WebBuilders

struct MermaidView: TemplateRepresentable {

    let variants: [(String, MermaidData)] = [
        (
            """
            // Flowchart
            """,
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
        (
            """
            // State diagram
            """,
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
        (
            """
            // Sequence
            """,
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
        (
            """
            // Timeline
            """,
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
        (
            """
            // Class
            """,
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
        (
            """
            // ER diagram
            """,
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
        (
            """
            // User Journey
            """,
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
        (
            """
            // Architecture
            """,
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
        (
            """
            // xychart
            """,
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
        (
            """
            // pie chart
            """,
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
        (
            """
            // quadrant chart
            """,
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
        (
            """
            // gantt chart
            """,
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
        (
            """
            // Mindmap
            """,
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
        (
            """
            // GitGraph
            """,
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

        (
            """
            // Radar chart
            """,
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

        (
            """
            // Sankey
            """,
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

        (
            """
            // Paket
            """,
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

        (
            """
            // Kanban board
            """,
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

        (
            """
            // Treemap
            """,
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

        (
            """
            // Event modeling
            """,
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

                for (label, ctx) in variants {

                    showVariantTitle(label, ctx)

                    showComponentPreview(
                        data: label + "\n\n" + prettySwift(ctx),
                        html: makeHtml(ctx: ctx)
                    ) {
                        Div { Mermaid(ctx).render() }
                            .class("mb-4 mt-12")
                    }

                }

            }
            .class("mt-4 space-y-6")

        }
        .render()

    }
}
