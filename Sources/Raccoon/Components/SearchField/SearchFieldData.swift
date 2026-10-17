import Foundation

/// Configuration data for `SearchField`. Serves as the public API contract.
public struct SearchFieldData: Sendable {

    // MARK: - 1. Identity & Alpine Bindings

    /// Unique DOM identifier for the input element.
    public let id: String?

    /// Form field name attribute for the input element.
    public let name: String?

    /// Alpine.js variable name bound to the input value via `x-model`.
    public let bindModel: String

    /// Alpine.js reference name bound to the input element via `x-ref`.
    public let bindRef: String

    /// Optional Alpine.js expression to evaluate on keyup debounce (e.g. `"getData()"`).
    public let bindKeyup: String?

    /// Optional custom Alpine.js expression to evaluate when the clear button is clicked.
    /// When `nil`, defaults to clearing the model and refocusing the input via `$nextTick`.
    public let bindClearAction: String?

    /// Optional custom Alpine.js visibility expression for the clear button (`x-show`).
    /// When `nil`, defaults to `"{bindModel}.length > 0"`.
    public let bindClearShow: String?

    /// Optional tabindex attribute value for the input element.
    public let tabindex: String?

    // MARK: - 2. Content & Accessibility

    /// Placeholder ghost text displayed when the input is empty.
    public let placeholder: String

    /// Accessible name for the search input (`aria-label`).
    public let ariaLabel: String

    /// Accessible name for the clear button (`aria-label`).
    public let clearAriaLabel: String

    /// Optional identifier of the element whose contents are controlled by this search input (`aria-controls`).
    public let ariaControls: String?

    /// Optional accessible title forwarded to the leading SVG icon.
    public let iconTitle: String?

    // MARK: - 3. Value & Options

    /// Pre-filled string value for the search input.
    public let value: String?

    // MARK: - 4. Feedback & Validation

    /// Optional error message configuration displayed below the search field.
    public let errorMessages: ErrorMessageData?

    /// Optional helper or hint text configuration displayed below the search field.
    public let helperText: HelperTextData?

    // MARK: - 5. Presentation & State

    /// Current interaction state of the search field (`.enabled`, `.disabled`, etc.).
    public let state: ComponentState

    /// Visual size variant of the search field (`.base` with 20px icons, or `.sm` with 16px icons).
    public let size: ComponentSize

    /// Whether to render the clear button when the search field has content.
    public let hasClearButton: Bool

    /// Whether the search field container has a transparent background (`bg-transparent`).
    public let hasTransparentBackground: Bool

    /// Optional Alpine.js boolean property name indicating a loading state (e.g. `"isLoading"`),
    /// which swaps the standard search icon with an animated loading icon.
    public let loadingBind: String?

    // MARK: - 6. Analytics & Tracking

    /// Matomo tracking consent status. Defaults to `.ACCEPTED` so components without a consent
    /// field reproduce unconditional clear button tracking when a `contentTracker` is provided.
    public let matomoStatus: MatomoStatus

    /// Optional Matomo content tracking configuration for the clear button.
    public let contentTracker: MatomoContentTracker?

    /// Creates a new configuration instance for `SearchField`.
    ///
    /// - Parameters:
    ///   - id: Unique DOM identifier for the input element.
    ///   - name: Form field name attribute for the input element.
    ///   - bindModel: Alpine.js variable name bound to the input value via `x-model`.
    ///   - bindRef: Alpine.js reference name bound to the input element via `x-ref`.
    ///   - bindKeyup: Optional Alpine.js expression to evaluate on keyup debounce.
    ///   - bindClearAction: Optional custom Alpine.js expression to evaluate on clear button click.
    ///   - bindClearShow: Optional custom Alpine.js visibility expression for the clear button.
    ///   - tabindex: Optional tabindex attribute value for the input element.
    ///   - placeholder: Placeholder ghost text displayed when the input is empty.
    ///   - ariaLabel: Accessible name for the search input (`aria-label`).
    ///   - clearAriaLabel: Accessible name for the clear button (`aria-label`).
    ///   - ariaControls: Optional identifier of the element controlled by this search input (`aria-controls`).
    ///   - iconTitle: Optional accessible title forwarded to the leading SVG icon.
    ///   - value: Pre-filled string value for the search input.
    ///   - errorMessages: Optional error message configuration displayed below the search field.
    ///   - helperText: Optional helper or hint text configuration displayed below the search field.
    ///   - state: Current interaction state of the search field.
    ///   - size: Visual size variant of the search field (`.base` or `.sm`).
    ///   - hasClearButton: Whether to render the clear button when the search field has content.
    ///   - hasTransparentBackground: Whether the container has a transparent background.
    ///   - loadingBind: Optional Alpine.js boolean property name indicating a loading state.
    ///   - matomoStatus: Matomo tracking consent status.
    ///   - contentTracker: Optional Matomo content tracking configuration for the clear button.
    public init(
        // 1. Identity & Alpine Bindings
        id: String? = nil,
        name: String? = nil,
        bindModel: String = "search",
        bindRef: String = "searchInput",
        bindKeyup: String? = nil,
        bindClearAction: String? = nil,
        bindClearShow: String? = nil,
        tabindex: String? = nil,

        // 2. Content & Accessibility
        placeholder: String = "Search",
        ariaLabel: String = "Search",
        clearAriaLabel: String = "Clear search",
        ariaControls: String? = nil,
        iconTitle: String? = nil,

        // 3. Value & Options
        value: String? = nil,

        // 4. Feedback & Validation
        errorMessages: ErrorMessageData? = nil,
        helperText: HelperTextData? = nil,

        // 5. Presentation & State
        state: ComponentState = .enabled,
        size: ComponentSize = .base,
        hasClearButton: Bool = true,
        hasTransparentBackground: Bool = false,
        loadingBind: String? = nil,

        // 6. Analytics & Tracking
        matomoStatus: MatomoStatus = .ACCEPTED,
        contentTracker: MatomoContentTracker? = nil
    ) {
        // 1. Identity & Alpine Bindings
        self.id = id
        self.name = name
        self.bindModel = bindModel
        self.bindRef = bindRef
        self.bindKeyup = bindKeyup
        self.bindClearAction = bindClearAction
        self.bindClearShow = bindClearShow
        self.tabindex = tabindex

        // 2. Content & Accessibility
        self.placeholder = placeholder
        self.ariaLabel = ariaLabel
        self.clearAriaLabel = clearAriaLabel
        self.ariaControls = ariaControls
        self.iconTitle = iconTitle

        // 3. Value & Options
        self.value = value

        // 4. Feedback & Validation
        self.errorMessages = errorMessages
        self.helperText = helperText

        // 5. Presentation & State
        self.state = state
        self.size = size
        self.hasClearButton = hasClearButton
        self.hasTransparentBackground = hasTransparentBackground
        self.loadingBind = loadingBind

        // 6. Analytics & Tracking
        self.matomoStatus = matomoStatus
        self.contentTracker = contentTracker
    }
}
