---
name: swift-vapor

# Description: When to trigger, what it does
# This skill should trigger whenever Swift code is created or reviewed for server-side applications using the Vapor framework (minimum version: 4), or when best practices for Swift server development, Vapor, or Swift testing are requested. Use this skill for any backend Swift code, API, or service, and always apply it when the user mentions Vapor, server-side Swift, or backend Swift development. Always use this skill as a reference whenever you add or review any new unit, integration, or other test in a Vapor-based Swift project. It ensures all tests follow the latest best practices and patterns for maintainability and reliability.
description: >
  Enables writing and reviewing Swift server-side applications following the standards proposed on https://docs.vapor.codes (minimum version: 4) and the swift-format rules in this workspace. Also includes best practices for the Swift testing framework (https://developer.apple.com/documentation/testing/). Always use this skill when creating or reviewing Swift backend code, especially with Vapor.
compatibility:
  - Swift >= 6.2
  - Vapor >= 4
  - swift-format (workspace configuration)
  - Swift Testing framework (latest)
---

# Swift-on-Server (Vapor) Skill

## Best Practices
- Structure projects using Vapor’s conventions (Sources/App, Public, etc.)
- Use environment variables and configuration files for secrets and deployment settings
- Prefer dependency injection for testability and modularity
- Validate all incoming data and handle errors gracefully
- Use async/await and non-blocking APIs for scalability
- Write clear, maintainable, and well-documented code
- Document all public symbols and APIs using triple-slash (///) comments, following the [Swift-DocC documentation guidelines](https://www.swift.org/documentation/docc/writing-symbol-documentation-in-your-source-files)
- Follow Swift API Design Guidelines
- Use migrations for database schema changes
- Secure endpoints with authentication and proper CORS settings
- Log requests, errors, and important events
- Apply swift-format rules as configured in the workspace

## Testing

### Running Tests

When asked to build or to test an application, always run:

```
swift build && swift test
```

#### Test Client Race Condition Workaround

In some environments, especially with VaporTesting and async/await, there can be a race condition where the test client sends requests before the application is fully ready (routes and middleware registered). This can cause intermittent 404s or test flakiness.

**Workaround:** Add a short sleep (e.g., `try await Task.sleep(nanoseconds: 500_000_000)`) after app boot and before sending requests in your test. This ensures the app is fully ready. This is especially important for tests involving middlewares or complex route registration.

**Real-world example from ExtendPathMiddlewareTests.swift:**

```swift
@Test("redirectsToTrailingSlash", arguments: ["/reader"])
func redirectsToTrailingSlash(path: String) async throws {
    try await withApp { app in
        /// Temporary deliberate pause to avoid a race between test client requests and app route/middleware
        /// registration in the test harness. Some test runners may send the request before the application
        /// is fully ready, causing intermittent 404s. This sleep is a pragmatic, conservative workaround:
        /// - Duration: 500 ms (500_000_000 ns) chosen to be safe on CI and local machines.
        try await Task.sleep(nanoseconds: 500_000_000)
        try await app.testing().test(.GET, path) { res async in
            #expect(res.status == .movedPermanently, "Expected 301 for \(path), got \(res.status)")
        }
    }
}
```

This workaround is pragmatic and helps avoid CI and local race conditions until the test harness guarantees app readiness. Always consider this for tests involving middleware or complex route setups.

#### VaporTesting async/await closure best practice

**Do not mix the old `afterResponse:` parameter with the new async trailing closure in `.test`.**

- Use only the trailing async closure: `app.testing().test(.GET, "/path") { res async in ... }`
- Do NOT use `afterResponse:` with the new async/await API. Mixing both can cause errors or double-handling.
- The trailing closure fully replaces `afterResponse:` for inspecting responses in tests.

This prevents confusion and ensures compatibility with the latest Swift Testing and VaporTesting APIs.


### MCP DTO Structure & Usage

All MCP endpoint payloads and responses use canonical DTOs from `Sources/App/Modules/MCPService/DTO/`.

**Key DTOs and their purpose:**

- `MCPRequest`: Top-level JSON-RPC request for MCP endpoints. Contains `jsonrpc`, `id`, `method`, and `params`.
- `MCPRequestParameters`: Parameters for MCP tool calls. Fields: `name` (tool name), `arguments` (dictionary of argument name to value, wrapped in `MCPAnyEncodable`).
- `MCPAnyEncodable`: Wrapper for encoding arbitrary argument values in tool calls.
- `MCPResultResponse`: Canonical JSON-RPC result envelope. Contains `id`, `jsonrpc`, and a `result` with a list of `content` items (each with `text` and `type`).
- `MCPResultTextArticlesResponse`: Decoded from the `.text` field of a result for article-related endpoints. Contains metadata and a `DTOArticleCollection`.
- `MCPResultTextStoriesResponse`: Decoded from the `.text` field of a result for story-related endpoints. Contains metadata and a `DTOStoryCollection`.
- `DTOArticleCollection`: List of articles (`DTOArticleDetails`) and total count.
- `DTOArticleDetails`: Full details for a single article (UUID, title, summary, tags, author, markdown body, etc.).
- `DTOArticleOverview`: Short summary for an article (used in story listings).
- `DTOStoryCollection`: List of stories (`DTOStory`) and total count.
- `DTOStory`: Full details for a story, including articles (`DTOArticleOverview`).
- `DTOResource`: Represents a single resource for the `resources/list` endpoint (URI, name, title, description, etc.).
- `DTOResourceCollection`: List of resources for the `resources/list` endpoint.
- `DTOCategory`, `DTOCategoryCollection`: Category metadata and collections.

**Usage patterns:**

- For MCP tool endpoints, construct requests using `MCPRequest` and `MCPRequestParameters`.
- Use `MCPAnyEncodable` to wrap argument values for tool calls.
- Always decode responses using the correct `MCPResultResponse` and the appropriate wrapper (e.g., `MCPResultTextStoriesResponse`, `MCPResultTextArticlesResponse`).
- For batch/array payloads, decode the `.text` field as a JSON string, then decode to the correct DTO.

**Example:**

```swift
let req = MCPRequest(
    jsonrpc: "2.0",
    id: "1",
    method: "tools/call",
    params: MCPRequestParameters(
        name: "list_articles",
        arguments: [:]
    )
)
```

See the DTO files for full field lists and details.
- Use `.compactMap` and `.map` to extract fields (e.g., UUIDs, slugs) from collections in tests.
- Assert on both the count and content of returned collections for round-trip tests.

#### Example: List and Get Articles Integration Test

```swift
@Test("list_and_get_articles")
func listAndGetArticles() async throws {
    try await withApp { app in
        let mcpReqListArticles = MCPRequest(
            jsonrpc: "2.0",
            id: "1",
            method: "tools/call",
            params: MCPRequestParameters(
                name: "list_articles",
                arguments: [:]
            )
        )
        // ...send request, decode response as MCPResultTextStoriesResponse...
        // Extract up to 3 article UUIDs from the story with the most articles:
        let uuids = articles.compactMap { $0.article_uuid?.uuidString }.prefix(3)
        // ...use uuids in a get_articles_by_uuids call...
    }
}
```

## Handling Port Already in Use Errors

If you encounter the error:

```
[ WARNING ] bind(descriptor:ptr:bytes:): Address already in use) (errno: 48)
Swift/ErrorType.swift:254: Fatal error: Error raised at top level: bind(descriptor:ptr:bytes:): Address already in use) (errno: 48)
```

This means a Swift/Vapor server instance is already running on the requested port (usually 8080). **Never try to run the server on a different port to work around this.**

**Instead, always kill the existing process that is using the port, then start your server again on the intended port.**

- On macOS/Linux, you can find and kill the process with:
  ```sh
  lsof -i :8080
  kill <PID>
  ```
- After killing the process, run `swift run` again.

This ensures you do not have multiple conflicting server instances and always use the correct port for development and testing.

## Integration Testing Patterns

### Microservice API Call Testing
- Use `withApp { app in ... }` to boot the Vapor app for each test.
- Create a `Request` with `Request(application: app, on: app.eventLoopGroup.next())` for dependency injection.
- Call your microservice API methods directly (e.g., `Microservices.getAccessToken(...)`, `Microservices.callApiWithoutPayload(...)`).
- Use `#expect(...)` for assertions (from Swift Testing).

Example:
```swift
@Test("getAccessToken returns a valid token")
func testGetAccessToken() async throws {
    try await withApp { app in
        let req = Request(application: app, on: app.eventLoopGroup.next())
        let token = try await Microservices.getAccessToken(scope: .apiCms, req)
        #expect(token != nil && !(token ?? "").isEmpty)
    }
}
```


## Test Framework Policy

**Never use the old XCTest framework. Only use the latest Swift Testing framework for all tests.**

All new and existing tests must:
- Use `@Test`, `@Suite`, and the Swift Testing framework
- Never import or subclass XCTestCase
- Never use `XCTAssert`, `XCTFail`, or any XCTest assertion
- Always use `#expect` and the Swift Testing assertion style

## Renaming an MCP Tool Endpoint (Checklist)

When renaming an MCP tool endpoint (e.g., `get_articles_by_uuids` → `get_article_details_by_uuids`), always:

1. **Update the ToolName enum**
   - Change the case name and raw value in `ToolName` (e.g., `case getArticlesByUUIDs = "get_articles_by_uuids"` → `case getArticleDetailsByUUIDs = "get_article_details_by_uuids"`).
2. **Update all tool call enums**
   - Change cases in `ToolCall` (e.g., `.getArticlesByUUIDs` → `.getArticleDetailsByUUIDs`).
3. **Update request/argument structs**
   - Rename structs like `ToolGetArticlesByUUIDsRequest` to match the new tool name.
4. **Update handler functions**
   - Rename handler functions (e.g., `handleGetArticlesByUUIDs` → `handleGetArticleDetailsByUUIDs`).
5. **Update tool registration**
   - Change the tool registration in `MCPService.swift` (e.g., `getArticlesByUUIDsTool` → `getArticleDetailsByUUIDsTool`, and the schema name string).
6. **Update all string-based tool name checks**
   - Update all string literals (e.g., `"get_articles_by_uuids"` → `"get_article_details_by_uuids"`) in switches, schemas, and docs.
7. **Update all tests**
   - Change all test requests and assertions to use the new tool name and argument keys.
8. **Update documentation**
   - Update all doc comments and skill docs to reference the new tool name.
9. **Run all tests**
   - Always run `swift test` after refactor. Fix all compile and test errors.

**Never leave old tool names in code, schemas, or tests.**

Example commit message:
```
refactor: Rename get_articles_by_uuids tool to get_article_details_by_uuids
- Update ToolName, ToolCall, request structs, handlers, schemas, and tests
- Update all string keys and docs
- All tests passing
```

> See MCPToolTests.swift for canonical test patterns after renaming.

# Test Application Bootstrapping and Environment Configuration

### Using `withApp` for Test Isolation

All integration tests must use the `withApp` helper to boot a fresh Vapor `Application` for each test. This ensures isolation and prevents state leakage between tests. The canonical pattern is:

```swift
try await withApp(configure: self.configure) { app in
    // test logic using `app`
}
```

The `withApp` helper is defined as:

```swift
/// Boots a test `Application`, executes the provided body, then shuts the app down.
func withApp(_ body: (Application) async throws -> Void) async throws {
  let app = try await Application.make(.testing)
  app.logger.logLevel = .debug
  try configure(app)
  try await app.asyncBoot()
  try await body(app)
  try await app.asyncShutdown()
}
```

### Fetching Environment Variables for Test Configuration

When configuring Redis or other services for integration tests, always fetch connection details from environment variables at test startup. This ensures tests are portable and do not hardcode secrets or hostnames. Example:

```swift
let redisTestHostname: String? = Environment.get("REDIS_TEST_HOSTNAME")
let redisTestPort: Int? = Environment.get("REDIS_TEST_PORT").flatMap(Int.init)
let redisTestPassword: String? = Environment.get("REDIS_TEST_PASSWORD")

guard let redisTestHostname, let redisTestPort, let redisTestPassword else {
    throw Abort(.internalServerError, reason: "Missing Redis test configuration in environment variables")
}

app.redis.configuration = try RedisConfiguration(
    hostname: redisTestHostname,
    port: redisTestPort,
    password: redisTestPassword
)
```

Always ensure your `.env` file or CI environment provides these variables. Never hardcode credentials in test code.



## WebComponent Library: Rendering

### Rendering Pattern

All components implement `TemplateRepresentable`:

```swift
public protocol TemplateRepresentable {
    @Builder<Element>
    func render() -> [Element]
}
```

Usage: instantiate with a `*Data` struct, then call `.render()`:

```swift
Accordion(AccordionData(label: "Title", htmlText: "<p>Body</p>")).render()
```

### Available Page Templates

Wrap component output in a page template depending on the target section:

| Template | Context struct | Use for |
|---|---|---|
| `TemplateFrontend` | `ContextTemplateFrontend` | Public-facing pages |
| `TemplateCms` | `ContextTemplateCms` | CMS / admin pages |
| `TemplateAuth` | `ContextTemplateAuth` | Login / auth pages |

`ContextTemplateFrontend` fields: `seo: Seo`, `menuHeader: [API_MenuItem]?`, `menuFooter: [API_MenuItem]?`, `menuActive: String?`, `sidebar: API_Sidebar?`, `matomoStatus: MatomoStatus = .BANNER`, `matomoPageType: MatomoPageType = .trackPageView`, `authResult: AuthorizationResult`

### Shared Enums and Types

These types are used across many components:

| Type | Values |
|---|---|
| `ComponentState` | `.enabled`, `.disabled`, `.hidden`, `.info` |
| `ComponentSize` | `.sm`, `.base`, `.xl` |
| `ComponentPosition` | `.top`, `.right`, `.bottom`, `.left` |
| `MatomoStatus` | `.ACCEPTED`, `.DECLINED`, `.BANNER`, `.DEACTIVATED` |
| `ActionButtonType` | `.primary`, `.secondary`, `.tertiary`, `.warning`, `.icon` |
| `FieldValidationType` | `.firstLastName`, `.email`, `.url`, `.integer`, `.amount`, `.phoneNumber`, `.ip4vAddress`, `.friendlyUrl`, `.custom(pattern:message:)` |
| `SvgIcon` | Many cases — e.g. `.book`, `.lightbulb`, `.arrow_right_circle`. See `Sources/WebComponents/Svg/SvgIcon.swift` for full list. |
| `API_OptionContext` | From `raumnebenan_api_dto` — value/title pair for select/checkbox options |
| `LabelData` | Shared label config: `id: String`, `title: String?`, `required: Bool = true`, `xhtml: String?`, `position: Position = .left`, `size: ComponentSize = .base`, `isDisabled: Bool = false` |
| `ErrorMessageData` | Inline error display: `errorMessages: [String]?`, `id: String?`, `hasIcon: Bool = false` |
| `HelperTextData` | Hint text below inputs: `id: String`, `title: String?` |

---
## WebComponent Library: Component Reference

All components live in `Sources/WebComponents/Components/`. Each component struct is named `ComponentName` and takes a `ComponentNameData` initializer. Call `.render(request)` to get `[Element]` for embedding in a page.

> **Critical:** There is NO `tw` prefix on component or data struct names. Always use `Accordion`, `AccordionData` — never `twAccordion` or `twAccordionContext`.

| Component | Swift struct | Data struct | Key fields (with defaults) |
|---|---|---|---|
| **Accordion** | `Accordion` | `AccordionData` | `label: String`<br>`htmlText: String?`<br>`hasBorder: Bool = true`<br>`matomoStatus: MatomoStatus = .DECLINED` |
| **ActionButton** | `ActionButton` | `ActionButtonData` | `id: String = ""`<br>`htmlType: HTML.Button.Types = .submit`<br>`buttonType: ActionButtonType = .primary`<br>`label: String?`<br>`tooltip: String?`<br>`tooltipPosition: ComponentPosition?`<br>`ariaLabel: String?`<br>`state: ActionButtonState = .enabled`<br>`icon: SvgIcon?`<br>`size: ComponentSize = .base`<br>`hasFullWidth: Bool = false`<br>`action: String?`<br>`bindAction: String?`<br>`clickAction: String?`<br>`method: HTML.MethodAttributeValue?`<br>`matomoStatus: MatomoStatus = .DEACTIVATED`<br>`contentTracker: MatomoContentTracker` |
| **ArticleFigure** | `ArticleFigure` | `ArticleFigureData` | `key: String` (S3/image key)<br>`altText: String`<br>`width: Double?`<br>`height: Double?`<br>`link: String` (URL)<br>`caption: String?`<br>`isCarouselImage: Bool = false`<br>`isLazyLoaded: Bool = true` |
| **ArticleOverview** | `ArticleOverview` | `ArticleOverviewData` | `summary: String`<br>`readingTime: Int?`<br>`totalWords: Int?`<br>`publishingDate: Date?`<br>`lastUpdateDate: Date?`<br>`tags: [API_Tags_Get]?`<br>`accordion: AccordionData?`<br>`downloadLinkForTextMarkdownFiles: String?`<br>`matomoStatus: MatomoStatus = .DECLINED` |
| **AudioPlayer** | `AudioPlayer` | `AudioPlayerData` | `title: String?`<br>`disclaimer: String?`<br>`linkToTheAudioFile: String`<br>`hasProgressBar: Bool = true` |
| **Avatar** | `Avatar` | `AvatarData` | `firstName: String?`<br>`lastName: String?`<br>`picture: String?` (URL) |
| **Badge** | `Badge` | `BadgeData` | `id: String`<br>`title: String`<br>`counter: Int?`<br>`isLink: Bool = false` |
| **Breadcrumb** | `Breadcrumb` | `BreadcrumbData` | `paths: [BreadcrumbPath]?`<br>`hasHome: Bool = false`<br>(`BreadcrumbPath`: `title`, `href`, `hreflang`, `isCurrentPathSegment: Bool = false`) |
| **ByMeACoffee** | `ByMeACoffee` | `ByMeACoffeeData` | `dataSlug: String`<br>`imageSrc: String`<br>`imageHeight: Int = 60`<br>`imageWidth: Int = 210` |
| **Check** (checkbox) | `Check` | `CheckData` | `id: String`<br>`label: String?`<br>`name: String?`<br>`isSelected: Bool = false`<br>`errorMessages: ErrorMessageData?`<br>`helperText: HelperTextData?`<br>`state: ComponentState = .enabled` |
| **CheckboxSelect** | `CheckboxSelect` | `CheckboxSelectData` | `key: String`<br>`label: LabelData?`<br>`values: [API_OptionContext]`<br>`errorMessages: ErrorMessageData?`<br>`helperText: HelperTextData?`<br>`hasSearch: Bool = true`<br>`hasSelectAll: Bool = true` |
| **CodeBlock** | `CodeBlock` | `CodeBlockData` | `code: String` |
| **CookieBanner** | `CookieBanner` | `CookieBannerData` | `url: String` (current page URL)<br>`matomoStatus: MatomoStatus = .BANNER` |
| **CopyToClipboard** | `CopyToClipboard` | `CopyToClipboardData` | `key: String = "copy-####"` (form field name)<br>`value: String` (text to copy)<br>`orientation: Orientation = .horizontal` (`.horizontal` or `.vertical`) |
| **DatePicker** | `DatePicker` | `DatePickerData` | `id: String`<br>`label: LabelData?`<br>`value: Date`<br>`errorMessages: ErrorMessageData?`<br>`state: ComponentState`<br>`backgroundColor: String?` |
| **Definition** | `Definition` | `DefinitionData` | `icon: SvgIcon = .book`<br>`term: String`<br>`definition: String` |
| **DeleteModal** | `DeleteModal` | `DeleteModalData` | `deletionRedirect: String`<br>`csrfToken: String?` |
| **ErrorMessage** | `ErrorMessage` | `ErrorMessageData` | `errorMessages: [String]?`<br>`id: String?`<br>`hasIcon: Bool = false` |
| **FileUpload** | `FileUpload` | `FileUploadData` | `id: String`<br>`label: LabelData?`<br>`errorMessages: ErrorMessageData?` |
| **HelperText** | `HelperText` | `HelperTextData` | `id: String`<br>`title: String?` |
| **HiddenField** | `HiddenField` | `HiddenFieldData` | `key: String`<br>`value: String?`<br>`state: ComponentState = .disabled` |
| **HyperLink** | `HyperLink` | `HyperLinkData` | `label: String?`<br>`ariaLabel: String?`<br>`tooltip: String?`<br>`href: String`<br>`hreflang: String?`<br>`icon: SvgIcon?`<br>`iconSize: Int? = 16`<br>`isFocusable: Bool`<br>`isUnderlined: Bool`<br>`align: Alignment? = .left` (`.left`, `.center`)<br>`contentTracker: MatomoContentTracker` |
| **InputField** | `InputField` | `InputFieldData` | `id: String`<br>`label: LabelData?`<br>`placeholder: String?`<br>`type: HTML.Input.Types = .text`<br>`value: String?`<br>`errorMessages: ErrorMessageData?`<br>`helperText: HelperTextData?`<br>`backgroundColor: String?`<br>`autocomplete: String = "off"`<br>`validation: FieldValidationType?`<br>`isMaskedInMatomo: Bool = false` |
| **InputList** | `InputList` | `InputListData` | `key: String`<br>`label: LabelData?`<br>`values: [String]?`<br>`validationType: ValidationType` (`.url`, `.email`, `.amount`, `.custom(pattern:message:)`)<br>`errorMessages: ErrorMessageData?`<br>`helperText: HelperTextData?` |
| **KeyTakeaways** | `KeyTakeaways` | `KeyTakeawaysData` | `icon: SvgIcon = .lightbulb`<br>`title: String`<br>`contentAsMarkdown: String` |
| **KeyboardKey** | `KeyboardKey` | `KeyboardKeyData` | `key: KbdKey` (`.shift`, `.ctrl`, `.command`, `.option`, `.cursorUp`, `.cursorDown`, `.cursorLeft`, `.cursorRight`, `.backspace`, `.capslock`, `.intend`, `.text(String)`)<br>`hasBorder: Bool = true` |
| **Label** | `Label` | `LabelData` | `id: String`<br>`title: String?`<br>`required: Bool = true`<br>`xhtml: String?`<br>`position: Position = .left`<br>`size: ComponentSize = .base`<br>`isDisabled: Bool = false` |
| **LinkButton** | `LinkButton` | `LinkButtonData` | `label: String?`<br>`ariaLabel: String`<br>`href: String`<br>`hreflang: String?`<br>`icon: SvgIcon?`<br>`iconSize: Int? = 16`<br>`buttonType: ActionButtonType`<br>`hasFullWidth: Bool = false`<br>`matomoStatus: MatomoStatus = .DECLINED`<br>`contentTracker: MatomoContentTracker` |
| **LinkList** | `LinkList` | `LinkListData` | `icon: SvgIcon? = .arrow_right_circle`<br>`links: [String: String?]` (title → href)<br>`matomoStatus: MatomoStatus = .DECLINED`<br>`contentTracker: MatomoContentTracker` |
| **Logo** | `Logo` | `LogoData` | `lightInverted: Bool = false` |
| **MarkdownBlock** | `MarkdownBlock` | `MarkdownBlockData` | `markdown: String`<br>`isProse: Bool` (Tailwind prose styles) |
| **MultiSelect** | `MultiSelect` | `MultiSelectData` | `id: String`<br>`label: LabelData?`<br>`name: String`<br>`title: String?`<br>`values: [String]?` (selected)<br>`placeholder: String?`<br>`errorMessages: ErrorMessageData?`<br>`helperText: HelperTextData?`<br>`options: [API_OptionContext]?`<br>`state: ComponentState`<br>`backgroundColor: String?` |
| **Notification** | `Notification` | `NotificationData` | `title: String`<br>`text: String?`<br>`type: NotificationType` (`.success`, `.info`, `.warning`, `.error`) |
| **PasswordInput** | `PasswordInput` | `PasswordInputData` | `passwordLabel: LabelData`<br>`passwordKey: String = "password"`<br>`passwordErrorMessages: ErrorMessageData?`<br>`passwordHelperText: HelperTextData?`<br>`hasConfirmPassword: Bool = true`<br>`confirmLabel: LabelData?`<br>`confirmKey: String? = "confirmPassword"`<br>`confirmErrorMessages: ErrorMessageData?`<br>`confirmHelperText: HelperTextData?`<br>`commonWords: [String]` |
| **Quote** | `Quote` | `QuoteData` | `quote: String`<br>`citation: String?`<br>`hasQuotationMarks: Bool = true` |
| **Rating** | `Rating` | `RatingData` | `uuid: String`<br>`url: String` (API endpoint)<br>`ratingType: RatingType = .thumbsUpDown` (`.thumbsUpDown`, `.fiveStars`)<br>`question: String?`<br>`positiveFollowUpQuestion: String?`<br>`negativeFollowUpQuestion: String?` |
| **References** | `References` | `ReferencesData` | `title: String`<br>`contentAsMarkdown: String` |
| **SimpleTable** | `SimpleTable` | `SimpleTableData` | `meta: String` (JSON column definitions)<br>`rows: String` (JSON row data)<br>`caption: String?` |
| **SingleSelect** | `SingleSelect` | `SingleSelectData` | `id: String`<br>`label: LabelData?`<br>`name: String?`<br>`title: String?`<br>`value: String?` (selected)<br>`placeholder: String?`<br>`errorMessages: ErrorMessageData?`<br>`helperText: HelperTextData?`<br>`options: [API_OptionContext]?`<br>`state: ComponentState`<br>`backgroundColor: String?` |
| **Spacer** | `Spacer` | `SpacerData` | `space: UInt` (Tailwind `pb-N` class, range 1–9) |
| **TextAreaField** | `TextAreaField` | `TextAreaFieldData` | `id: String`<br>`label: LabelData?`<br>`placeholder: String?`<br>`rows: UInt = 4`<br>`value: String?`<br>`errorMessages: ErrorMessageData?`<br>`helperText: HelperTextData?`<br>`backgroundColor: String?`<br>`validation: FieldValidationType?`<br>`isMonospaced: Bool = false` |
| **ToggleSwitch** | `ToggleSwitch` | `ToggleSwitchData` | `id: String`<br>`label: LabelData?`<br>`isSelected: Bool`<br>`size: ComponentSize? = .base`<br>`state: ComponentState`<br>`apiURL: String?` (for AJAX toggle) |
| **Tooltip** | `Tooltip` | `TooltipData` | `id: String`<br>`text: String`<br>`hasArrow: Bool = true`<br>`position: ComponentPosition = .top` |
| **ViewMaskedSecret** | `ViewMaskedSecret` | `ViewMaskedSecretData` | `secret: String`<br>`revealCount: Int = 3` (chars visible when masked)<br>`revealDuration: Int = 3000` (ms visible after reveal)<br>`hasCopyToClipboard: Bool = true` |

### Usage Examples

```swift
// Basic component rendering
Accordion(
    AccordionData(
        label: "What is product thinking?",
        htmlText: "<p>Product thinking means solving the <em>right</em> problems.</p>",
        hasBorder: true,
        matomoStatus: .DECLINED
    )
).render(request)

// Form component with label, error, and helper text
InputField(
    InputFieldData(
        id: "email",
        label: LabelData(id: "email", title: "Email address", required: true),
        placeholder: "you@example.com",
        type: .email,
        value: "prefilled@example.com",
        errorMessages: ErrorMessageData(["Must be a valid email"], hasIcon: true),
        helperText: HelperTextData(id: "email-hint", title: "We'll never share your email."),
        validation: .email
    )
).render(request)

// Select component with options
SingleSelect(
    SingleSelectData(
        id: "country",
        label: LabelData(id: "country", title: "Country"),
        name: "country",
        value: "DE",
        options: [
            API_OptionContext(value: "DE", title: "Germany"),
            API_OptionContext(value: "AT", title: "Austria"),
        ],
        state: .enabled
    )
).render(request)

// Wrapping components in a page template
TemplateFrontend(
    ContextTemplateFrontend(
        seo: seo,
        menuHeader: menuItems,
        matomoStatus: .DECLINED,
        authResult: authResult
    )
) {
    Div {
        Accordion(AccordionData(label: "FAQ", htmlText: "<p>Answer</p>")).render(request)
    }
    .class("container mx-auto")
}
```

---
For usage examples per component, see `Sources/WebComponents/Components/`. Each component follows this pattern: create a `*Data` struct, instantiate the component, and call `.render(request)` to get HTML output.
