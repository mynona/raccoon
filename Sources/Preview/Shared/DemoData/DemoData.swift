import Raccoon
import Vapor

public struct DemoData {

    public static let breadcrumbPaths: [BreadcrumbPath] = [
        BreadcrumbPath(
            title: "Donaudampfschifffahrtsgesellschaft",
            href: "/one",
            hreflang: "en-US"
        ),
        BreadcrumbPath(
            title: "Level 2",
            href: "/one/two",
            hreflang: "en-US"
        ),
        BreadcrumbPath(
            title: "Level 3",
            href: "/one/two/three",
            hreflang: "en-US",
            isCurrentPathSegment: true
        ),
    ]

    public static let optionList = [
        OptionValue(title: "Option A", value: "a"),
        OptionValue(
            title: "Option B",
            value: "b",
            selected: true
        ),
        OptionValue(title: "Option C", value: "c"),
    ]

    public static let markdownText: String =
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



        """

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
