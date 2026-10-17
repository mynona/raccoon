import Foundation
import Vapor

public struct FakeSearchItemTags: Codable, Sendable {
    public let id: String?
    public let tag: String
    public let articleCount: Int?
    public let articles: [String]?

    public init(
        id: String? = nil,
        tag: String,
        articleCount: Int? = nil,
        articles: [String]? = nil
    ) {
        self.id = id
        self.tag = tag
        self.articleCount = articleCount
        self.articles = articles
    }
}

public struct FakeSearchItemStory: Codable, Sendable {
    public let id: String?
    public let title: String?
    public let friendly_url: String
    public let order: Int?
    public let status: String?

    public init(
        id: String? = nil,
        title: String? = nil,
        friendly_url: String,
        order: Int? = nil,
        status: String? = "PUBLISHED"
    ) {
        self.id = id
        self.title = title
        self.friendly_url = friendly_url
        self.order = order
        self.status = status
    }
}

public struct FakeSearchItemImageEmbedded: Codable, Sendable {
    public let id: String?
    public let height: Int?
    public let width: Int?
    public let checksum: String?
    public let full_link: String?
    public let file_path: String?
    public let alt_text: String?

    public init(
        id: String? = nil,
        height: Int? = nil,
        width: Int? = nil,
        checksum: String? = nil,
        full_link: String? = nil,
        file_path: String? = nil,
        alt_text: String? = nil
    ) {
        self.id = id
        self.height = height
        self.width = width
        self.checksum = checksum
        self.full_link = full_link
        self.file_path = file_path
        self.alt_text = alt_text
    }
}

public struct FakeSearchItemArticleTag: Codable, Sendable {
    public let id: String?
    public let tag: String

    public init(id: String? = nil, tag: String) {
        self.id = id
        self.tag = tag
    }
}

public struct FakeSearchItemArticle: Codable, Sendable {
    public let id: String?
    public let title: String
    public let friendly_url: String
    public let story: FakeSearchItemStory
    public let status: String?
    public let seo_description: String?
    public let date: String?
    public let last_update: String?
    public let order: Int?
    public let hasTextToSpeechFile: Bool?
    public let image: FakeSearchItemImageEmbedded?
    public let tags: [FakeSearchItemArticleTag]?

    public init(
        id: String? = nil,
        title: String,
        friendly_url: String,
        story: FakeSearchItemStory,
        status: String? = "PUBLISHED",
        seo_description: String? = nil,
        date: String? = nil,
        last_update: String? = nil,
        order: Int? = 0,
        hasTextToSpeechFile: Bool? = false,
        image: FakeSearchItemImageEmbedded? = nil,
        tags: [FakeSearchItemArticleTag]? = nil
    ) {
        self.id = id
        self.title = title
        self.friendly_url = friendly_url
        self.story = story
        self.status = status
        self.seo_description = seo_description
        self.date = date
        self.last_update = last_update
        self.order = order
        self.hasTextToSpeechFile = hasTextToSpeechFile
        self.image = image
        self.tags = tags
    }
}

public struct FakeSearchItemPage: Codable, Sendable {
    public let id: String?
    public let menu_title: String
    public let friendly_url: String
    public let navigation: String?
    public let status: String?
    public let order: Int?

    public init(
        id: String? = nil,
        menu_title: String,
        friendly_url: String,
        navigation: String? = "HEADER",
        status: String? = "PUBLISHED",
        order: Int? = 0
    ) {
        self.id = id
        self.menu_title = menu_title
        self.friendly_url = friendly_url
        self.navigation = navigation
        self.status = status
        self.order = order
    }
}

public struct FakeSearchItemDocument: Codable, Sendable {
    public let id: String
    public let title: String
    public let file_name: String?
    public let file_path: String?
    public let full_link: String?
    public let checksum: String?
    public let itemsCount: Int?

    public init(
        id: String,
        title: String,
        file_name: String? = nil,
        file_path: String? = nil,
        full_link: String? = nil,
        checksum: String? = nil,
        itemsCount: Int? = 0
    ) {
        self.id = id
        self.title = title
        self.file_name = file_name ?? "\(id).pdf"
        self.file_path = file_path ?? "downloads"
        self.full_link = full_link ?? "downloads/\(id).pdf"
        self.checksum = checksum
        self.itemsCount = itemsCount
    }
}

public struct FakeSearchItemImage: Codable, Sendable {
    public let id: String?
    public let full_link: String
    public let alt_text: String
    public let file_path: String?
    public let width: Int?
    public let height: Int?
    public let checksum: String?
    public let articles: [String]
    public let articlesCount: Int?

    public init(
        id: String? = nil,
        full_link: String,
        alt_text: String,
        file_path: String? = "blog",
        width: Int? = nil,
        height: Int? = nil,
        checksum: String? = nil,
        articles: [String] = [],
        articlesCount: Int? = nil
    ) {
        self.id = id
        self.full_link = full_link
        self.alt_text = alt_text
        self.file_path = file_path
        self.width = width
        self.height = height
        self.checksum = checksum
        self.articles = articles
        self.articlesCount = articlesCount ?? articles.count
    }
}

public struct FakeSearchItemGlossary: Codable, Sendable {
    public let id: String
    public let term: String
    public let definition: String
    public let status: String?
    public let createdAt: String?
    public let updatedAt: String?

    public init(
        id: String,
        term: String,
        definition: String,
        status: String? = "PUBLISHED",
        createdAt: String? = nil,
        updatedAt: String? = nil
    ) {
        self.id = id
        self.term = term
        self.definition = definition
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

public struct FakeSearchItemArticleSubItem: Codable, Sendable {
    public let id: String?
    public let title: String
    public let menu_title: String
    public let friendly_url: String

    public init(
        id: String? = nil,
        title: String,
        menu_title: String,
        friendly_url: String
    ) {
        self.id = id
        self.title = title
        self.menu_title = menu_title
        self.friendly_url = friendly_url
    }
}

public struct FakeSearchCollection<T: Codable & Sendable>: Codable, Sendable {
    public let total: Int
    public let count: Int
    public let items: [T]

    public init(items: [T] = []) {
        self.total = items.count
        self.count = items.count
        self.items = items
    }
}

public struct FakeSearchResults: Codable, Sendable {
    public let tags: FakeSearchCollection<FakeSearchItemTags>
    public let pages: FakeSearchCollection<FakeSearchItemPage>
    public let documents: FakeSearchCollection<FakeSearchItemDocument>
    public let images: FakeSearchCollection<FakeSearchItemImage>
    public let articles: FakeSearchCollection<FakeSearchItemArticle>
    public let glossary: FakeSearchCollection<FakeSearchItemGlossary>
    public let articleItems: FakeSearchCollection<FakeSearchItemArticleSubItem>

    public init(
        tags: [FakeSearchItemTags] = [],
        pages: [FakeSearchItemPage] = [],
        documents: [FakeSearchItemDocument] = [],
        images: [FakeSearchItemImage] = [],
        articles: [FakeSearchItemArticle] = [],
        glossary: [FakeSearchItemGlossary] = [],
        articleItems: [FakeSearchItemArticleSubItem] = []
    ) {
        self.tags = FakeSearchCollection(items: tags)
        self.pages = FakeSearchCollection(items: pages)
        self.documents = FakeSearchCollection(items: documents)
        self.images = FakeSearchCollection(items: images)
        self.articles = FakeSearchCollection(items: articles)
        self.glossary = FakeSearchCollection(items: glossary)
        self.articleItems = FakeSearchCollection(items: articleItems)
    }
}

extension DemoData {
    public static func fakeSearchResults(for query: String) -> FakeSearchResults
    {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        if q == "empty" || q == "none" {
            return FakeSearchResults()
        }

        let allTags = [
            FakeSearchItemTags(
                id: "3B336D7C-4029-48A3-B8D8-C2AC355085B6",
                tag: "user",
                articleCount: 1,
                articles: ["833FBA28-560B-4708-AF0E-DB1C25608EBB"]
            ),
            FakeSearchItemTags(
                id: "575BD4B6-072D-4231-A15D-2322486C419D",
                tag: "user-goals",
                articleCount: 1,
                articles: ["96B350DF-882D-4338-8FEE-689B87B42EC1"]
            ),
            FakeSearchItemTags(
                id: "07C83645-BAF6-46CB-B103-F0E9B3F93F82",
                tag: "user-journey",
                articleCount: 1,
                articles: ["96B350DF-882D-4338-8FEE-689B87B42EC1"]
            ),
            FakeSearchItemTags(
                id: "8344292E-50AC-48EE-8AE7-8E7A3A7B01D6",
                tag: "user-research",
                articleCount: 6,
                articles: [
                    "8F6DA248-86D3-4C20-9A09-1D0B6CC35C81",
                    "287FCBC1-E8B3-4850-B09D-B5F1AC2E99B5",
                    "C0485EAD-4FF3-40F2-9C9C-7572CAFE892B",
                    "23A6905F-F1E1-41A1-9E18-AEB26FC0BFA2",
                    "6F757AB4-88B8-4E9A-87D5-4389AF5DDB6D",
                    "48FEF9AE-1DBF-44EF-AC2E-13622E8BE4E8",
                ]
            ),
            FakeSearchItemTags(
                id: "45B19FDD-3CE6-4D43-8CAE-AC65187A6A5F",
                tag: "user-steps",
                articleCount: 1,
                articles: ["96B350DF-882D-4338-8FEE-689B87B42EC1"]
            ),
            FakeSearchItemTags(
                id: "E960E35B-D138-4ACD-9A88-6A1AD389FD50",
                tag: "user-story",
                articleCount: 1,
                articles: ["96B350DF-882D-4338-8FEE-689B87B42EC1"]
            ),
            FakeSearchItemTags(
                id: "1619B726-521F-410C-A0ED-2FB585B0E8F9",
                tag: "product",
                articleCount: 4,
                articles: [
                    "B075BC50-EB95-4643-8674-82C469E32A4C",
                    "65BB90D5-25DC-4E1B-9C89-DD16D7F936EA",
                    "4F5215F9-97CF-490A-8764-B2800CDA1F98",
                    "BBE90BE9-0F5A-4C83-9A82-D34A39E258C7",
                ]
            ),
            FakeSearchItemTags(
                id: "BA13B306-EA32-44FB-9226-24C05DC74563",
                tag: "strategy",
                articleCount: 3,
                articles: [
                    "95794D32-264A-4212-9E72-93FD8478C3FB",
                    "59275C9C-95E6-4784-A55C-F8F397CE0ACB",
                    "AAF721AB-2FC7-4688-AE17-0DA87E5EC5ED",
                ]
            ),
            FakeSearchItemTags(
                id: "tag-swift",
                tag: "swift",
                articleCount: 1,
                articles: ["getting-started-swift-web-components"]
            ),
            FakeSearchItemTags(
                id: "tag-vapor",
                tag: "vapor",
                articleCount: 1,
                articles: ["advanced-vapor-architecture"]
            ),
        ]

        let allPages = [
            FakeSearchItemPage(
                id: "C769CBEF-BFFF-473C-92E5-1884140F42F9",
                menu_title: "AI tools",
                friendly_url: "ai-tools",
                navigation: "HEADER",
                status: "PUBLISHED",
                order: 0
            ),
            FakeSearchItemPage(
                id: "1167C423-DEC6-4488-83CC-A25926803544",
                menu_title: "Accessibility",
                friendly_url: "accessibility-statement",
                navigation: "FOOTER",
                status: "PUBLISHED",
                order: 2
            ),
            FakeSearchItemPage(
                id: "7213BEEC-3F8E-11EC-8D56-3271A1D549EB",
                menu_title: "Imprint",
                friendly_url: "imprint",
                navigation: "FOOTER",
                status: "PUBLISHED",
                order: 1
            ),
            FakeSearchItemPage(
                id: "page-docs",
                menu_title: "Documentation",
                friendly_url: "docs",
                navigation: "HEADER",
                status: "PUBLISHED",
                order: 3
            ),
        ]

        let allArticles = [
            FakeSearchItemArticle(
                id: "95794D32-264A-4212-9E72-93FD8478C3FB",
                title: "Strategy Canvas (Value Differentiation)",
                friendly_url: "strategy-canvas",
                story: FakeSearchItemStory(
                    id: "BFCABC82-73D5-44B6-857E-1302D8648F4E",
                    title: "Identify Opportunities",
                    friendly_url: "identify-opportunities",
                    order: 2000,
                    status: "PUBLISHED"
                ),
                status: "PUBLISHED",
                seo_description: "Strategy Canvas",
                date: "2026-06-16T13:29:38Z",
                last_update: "2026-06-21T13:29:38Z",
                order: 1,
                hasTextToSpeechFile: false,
                tags: [
                    FakeSearchItemArticleTag(
                        id: "B6DFAFF5-2344-4D31-B4D7-0BFA645CD48B",
                        tag: "business-value"
                    ),
                    FakeSearchItemArticleTag(
                        id: "8C805D30-43D9-4D21-8E95-495E9F4C2CC9",
                        tag: "use-value"
                    ),
                    FakeSearchItemArticleTag(
                        id: "BA13B306-EA32-44FB-9226-24C05DC74563",
                        tag: "strategy"
                    ),
                    FakeSearchItemArticleTag(
                        id: "A508A118-9FF1-44C6-9645-E20497DD2BA6",
                        tag: "innovation"
                    ),
                ]
            ),
            FakeSearchItemArticle(
                id: "59275C9C-95E6-4784-A55C-F8F397CE0ACB",
                title: "Strategy Stack",
                friendly_url: "strategy-stack",
                story: FakeSearchItemStory(
                    id: "465AEE06-950F-4C9F-A7BB-C0503C349CC4",
                    title: "Vision, Strategy, Roadmap",
                    friendly_url: "vision-strategy",
                    order: 100,
                    status: "PUBLISHED"
                ),
                status: "PUBLISHED",
                seo_description: "Strategy Stack",
                date: "2026-06-14T10:53:37Z",
                last_update: "2026-06-25T18:22:06Z",
                order: 0,
                hasTextToSpeechFile: false,
                tags: [
                    FakeSearchItemArticleTag(
                        id: "BA13B306-EA32-44FB-9226-24C05DC74563",
                        tag: "strategy"
                    )
                ]
            ),
            FakeSearchItemArticle(
                id: "BBE90BE9-0F5A-4C83-9A82-D34A39E258C7",
                title: "Product Roadmap",
                friendly_url: "roadmap",
                story: FakeSearchItemStory(
                    id: "465AEE06-950F-4C9F-A7BB-C0503C349CC4",
                    title: "Vision, Strategy, Roadmap",
                    friendly_url: "vision-strategy",
                    order: 100,
                    status: "PUBLISHED"
                ),
                status: "PUBLISHED",
                seo_description: "Product Roadmap",
                date: "2026-04-25T00:00:00Z",
                last_update: "2026-04-26T13:41:03Z",
                order: 2,
                hasTextToSpeechFile: false,
                tags: [
                    FakeSearchItemArticleTag(
                        id: "1619B726-521F-410C-A0ED-2FB585B0E8F9",
                        tag: "product"
                    ),
                    FakeSearchItemArticleTag(
                        id: "BA13B306-EA32-44FB-9226-24C05DC74563",
                        tag: "strategy"
                    ),
                    FakeSearchItemArticleTag(
                        id: "D7F6EEF1-3161-4A73-82F3-CBCCDC791AF7",
                        tag: "roadmap"
                    ),
                ]
            ),
            FakeSearchItemArticle(
                id: "B075BC50-EB95-4643-8674-82C469E32A4C",
                title: "What is a Product?",
                friendly_url: "what-is-a-product",
                story: FakeSearchItemStory(
                    id: "F4D9C874-2003-474B-963A-EE34B2254889",
                    title: "What is Product Thinking?",
                    friendly_url: "product-thinking",
                    order: 5,
                    status: "PUBLISHED"
                ),
                status: "PUBLISHED",
                seo_description:
                    "This article provides an overview of what a digital product is, how it evolved over time and what product levels can be distinguished.",
                date: "2025-12-13T00:00:00Z",
                last_update: "2026-04-28T12:55:23Z",
                order: 0,
                hasTextToSpeechFile: true,
                tags: [
                    FakeSearchItemArticleTag(
                        id: "8C805D30-43D9-4D21-8E95-495E9F4C2CC9",
                        tag: "use-value"
                    ),
                    FakeSearchItemArticleTag(
                        id: "1619B726-521F-410C-A0ED-2FB585B0E8F9",
                        tag: "product"
                    ),
                ]
            ),
            FakeSearchItemArticle(
                id: "55946342-581C-425F-8A22-4C4D4158F542",
                title: "Opportunity Backlog",
                friendly_url: "opportunity-backlog",
                story: FakeSearchItemStory(
                    id: "0A701EFA-53E0-46CB-98AF-4BBE6D8E7F0C",
                    title: "Shape & Manage Opportunities",
                    friendly_url: "opportunity",
                    order: 2010,
                    status: "PUBLISHED"
                ),
                status: "PUBLISHED",
                seo_description:
                    "An opportunity backlog is a prioritized list of potential improvements or feature additions for a product.",
                date: "2025-01-11T00:00:00Z",
                last_update: "2026-06-20T08:48:08Z",
                order: 0,
                hasTextToSpeechFile: true,
                image: FakeSearchItemImageEmbedded(
                    id: "6CE6BEEC-1477-4331-8861-04906578AEDC",
                    height: 595,
                    width: 842,
                    checksum: "2448427572",
                    full_link: "blog/6CE6BEEC-1477-4331-8861-04906578AEDC.png",
                    file_path: "blog",
                    alt_text: "6-3-5 worksheet"
                ),
                tags: [
                    FakeSearchItemArticleTag(
                        id: "B6DFAFF5-2344-4D31-B4D7-0BFA645CD48B",
                        tag: "business-value"
                    ),
                    FakeSearchItemArticleTag(
                        id: "4639C01B-1D99-4ECC-8593-2BB539FAD1C0",
                        tag: "opportunity"
                    ),
                ]
            ),
            FakeSearchItemArticle(
                id: "833FBA28-560B-4708-AF0E-DB1C25608EBB",
                title: "What is a user?",
                friendly_url: "what-is-a-user",
                story: FakeSearchItemStory(
                    id: "638E91BC-84A4-4409-A885-73DDBD35CC94",
                    title: "Understanding Users",
                    friendly_url: "sense-toolbox",
                    order: 1000,
                    status: "PUBLISHED"
                ),
                status: "PUBLISHED",
                seo_description:
                    "The article clarifies the concept of a user across B2C and B2B contexts.",
                date: "2025-01-06T00:00:00Z",
                last_update: "2025-12-28T01:11:16Z",
                order: 0,
                hasTextToSpeechFile: true,
                tags: [
                    FakeSearchItemArticleTag(
                        id: "3B336D7C-4029-48A3-B8D8-C2AC355085B6",
                        tag: "user"
                    )
                ]
            ),
            FakeSearchItemArticle(
                id: "art-swift",
                title: "Getting Started with Swift Web Components",
                friendly_url: "getting-started-swift-web-components",
                story: FakeSearchItemStory(
                    id: "story-tutorials",
                    title: "Tutorials",
                    friendly_url: "tutorials",
                    order: 10,
                    status: "PUBLISHED"
                ),
                status: "PUBLISHED",
                seo_description: "Getting Started with Swift Web Components",
                date: "2026-01-01T00:00:00Z",
                last_update: "2026-06-01T00:00:00Z",
                order: 0,
                hasTextToSpeechFile: false,
                tags: [
                    FakeSearchItemArticleTag(id: "tag-swift", tag: "swift")
                ]
            ),
        ]

        let allDocuments = [
            FakeSearchItemDocument(
                id: "87393F56-D379-47FA-88F8-A1FBED01A2C4",
                title: "Opportunity Canvas",
                file_name: "87393F56-D379-47FA-88F8-A1FBED01A2C4.pdf",
                file_path: "downloads",
                full_link: "downloads/87393F56-D379-47FA-88F8-A1FBED01A2C4.pdf",
                checksum: "2200604654",
                itemsCount: 0
            ),
            FakeSearchItemDocument(
                id: "9E714F6E-5D2D-4512-A9AB-3518C8A408EE",
                title: "A guide to participate in fieldwork",
                file_name: "9E714F6E-5D2D-4512-A9AB-3518C8A408EE.pdf",
                file_path: "downloads",
                full_link: "downloads/9E714F6E-5D2D-4512-A9AB-3518C8A408EE.pdf",
                checksum: "651130725",
                itemsCount: 0
            ),
            FakeSearchItemDocument(
                id: "73B63247-3061-485D-88F6-738819D775E9",
                title: "Product Thinking Process",
                file_name: "73B63247-3061-485D-88F6-738819D775E9.pdf",
                file_path: "downloads",
                full_link: "downloads/73B63247-3061-485D-88F6-738819D775E9.pdf",
                checksum: "4187633126",
                itemsCount: 0
            ),
            FakeSearchItemDocument(
                id: "doc-spec-01",
                title: "Web Components Specification.pdf",
                file_name: "doc-spec-01.pdf",
                file_path: "downloads",
                full_link: "downloads/doc-spec-01.pdf",
                checksum: "123456",
                itemsCount: 0
            ),
        ]

        let allImages = [
            FakeSearchItemImage(
                id: "4D9C0322-CDB6-488D-8C2B-A57E5E269911",
                full_link: "blog/4D9C0322-CDB6-488D-8C2B-A57E5E269911.jpg",
                alt_text: "Building empathy with users",
                file_path: "blog",
                width: 1123,
                height: 542,
                checksum: "2842097145",
                articles: ["07A4FA80-859D-4D62-8738-4F4AEF661A59"],
                articlesCount: 1
            ),
            FakeSearchItemImage(
                id: "1944C243-9BB5-4EE4-8F1C-EBFFA5DBA77D",
                full_link: "blog/1944C243-9BB5-4EE4-8F1C-EBFFA5DBA77D.png",
                alt_text: "Instagram",
                file_path: "blog",
                width: 3508,
                height: 2480,
                checksum: "3507732574",
                articles: ["16F4BE4A-F951-4100-AC8E-76EE20C1A98C"],
                articlesCount: 1
            ),
            FakeSearchItemImage(
                id: "97404E60-E06B-4555-BA66-AF7B15F107A8",
                full_link: "blog/97404E60-E06B-4555-BA66-AF7B15F107A8.png",
                alt_text: "Kano Model - Must be",
                file_path: "blog",
                width: 3508,
                height: 2480,
                checksum: "2871088975",
                articles: ["8B1A0265-53DA-4617-B59D-C9A745EFB08A"],
                articlesCount: 1
            ),
            FakeSearchItemImage(
                id: "img-arch",
                full_link: "/images/raumnebenan.png",
                alt_text: "Preview Architecture Diagram",
                file_path: "images",
                width: 800,
                height: 600,
                checksum: "111222",
                articles: ["getting-started-swift-web-components"],
                articlesCount: 1
            ),
        ]

        let allGlossary = [
            FakeSearchItemGlossary(
                id: "47A5864D-8C59-413F-8B1A-9342541337F4",
                term: "Digital Product",
                definition:
                    "Unlike physical products, digital products are *intangible, infinitely replicable,* and *distributed instantly* at marginal cost.",
                status: "PUBLISHED",
                createdAt: "2026-07-03T15:48:34Z",
                updatedAt: "2026-07-12T15:24:33Z"
            ),
            FakeSearchItemGlossary(
                id: "glossary-vapor",
                term: "Vapor",
                definition:
                    "An HTTP web framework for Swift providing asynchronous networking via SwiftNIO."
            ),
            FakeSearchItemGlossary(
                id: "glossary-alpine",
                term: "Alpine.js",
                definition:
                    "A rugged, minimal tool for composing behavior directly in your markup."
            ),
        ]

        let allArticleItems: [FakeSearchItemArticleSubItem] = []

        if q.isEmpty {
            return FakeSearchResults(
                tags: allTags,
                pages: allPages,
                documents: allDocuments,
                images: allImages,
                articles: allArticles,
                glossary: allGlossary,
                articleItems: allArticleItems
            )
        }

        let filteredTags = allTags.filter { $0.tag.lowercased().contains(q) }
        let filteredArticles = allArticles.filter {
            $0.title.lowercased().contains(q)
                || $0.friendly_url.lowercased().contains(q)
                || ($0.seo_description?.lowercased().contains(q) ?? false)
        }
        let filteredPages = allPages.filter {
            $0.menu_title.lowercased().contains(q)
                || $0.friendly_url.lowercased().contains(q)
        }
        let filteredDocuments = allDocuments.filter {
            $0.title.lowercased().contains(q)
        }
        let filteredImages = allImages.filter {
            $0.alt_text.lowercased().contains(q)
        }
        let filteredGlossary = allGlossary.filter {
            $0.term.lowercased().contains(q)
                || $0.definition.lowercased().contains(q)
        }
        let filteredArticleItems = allArticleItems.filter {
            $0.title.lowercased().contains(q)
                || $0.menu_title.lowercased().contains(q)
        }

        return FakeSearchResults(
            tags: filteredTags,
            pages: filteredPages,
            documents: filteredDocuments,
            images: filteredImages,
            articles: filteredArticles,
            glossary: filteredGlossary,
            articleItems: filteredArticleItems
        )
    }
}
