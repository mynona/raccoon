import HTML
import Raccoon
import SGML
import Vapor

public struct RaccoonPreviewController: RouteCollection, Sendable {

    public init() {}

    public func boot(routes: RoutesBuilder) throws {
        routes.get(use: getHome)
        routes.get("preview", use: getHome)

        let preview = routes.grouped("preview")
        preview.get("accordion", use: getAccordion)
        preview.get("avatar", use: getAvatar)
        preview.get("audio-player", use: getAudioPlayer)
        preview.get("badge", use: getBadge)
        preview.get("breadcrumb", use: getBreadcrumb)
        preview.get("actionbutton", use: getButton)
        preview.get("by-me-a-coffee", use: getByMeACoffee)
        preview.get("carousel", use: getCarousel)
        preview.get("check", use: getCheckbox)
        preview.get("checkbox-select", use: getCheckboxSelect)
        preview.get("code-block", use: getCodeBlock)
        preview.get("copy-to-clipboard", use: getCopyToClipboard)
        preview.get("definition", use: getDefinition)
        preview.get("dark-light-mode-toggle", use: getDarkLightModeToggle)
        preview.get("date-picker", use: getDatePicker)
        preview.get("dropdown", use: getDropdown)
        preview.get("simple-menu", use: getSimpleMenu)
        preview.get("modal-delete", use: getModalDelete)
        preview.get("input-field", use: getInputField)
        preview.get("input-list", use: getInputList)
        preview.get("keyboard-key", use: getKbd)
        preview.get("key-takeaway", use: getKeyTakeaway)
        preview.get("label", use: getLabel)
        preview.get("skip-link", use: getSkipLink)
        preview.get("hyperlink", use: getLink)
        preview.get("link-button", use: getLinkButton)
        preview.get("link-list", use: getLinkList)
        preview.get("markdown-block", use: getMarkdownBlock)
        preview.get("multi-select", use: getMultiSelect)
        preview.get("notification", use: getNotification)
        preview.get("password-input", use: getPasswordInput)
        preview.get("pill", use: getPill)
        preview.get("quote", use: getQuote)
        preview.get("rating", use: getRating)
        preview.get("rating-floating", use: getRatingFloating)
        preview.get("references", use: getReferences)
        preview.get("simple-table", use: getSimpleTable)
        preview.get("single-select", use: getSingleSelect)
        preview.get("spacer", use: getSpacer)
        preview.get("stepper", use: getStepper)
        preview.get("tab-group", use: getTabGroup)
        preview.get("textarea-field", use: getTextareaField)
        preview.get("theme-switcher", use: getThemeSwitcher)
        preview.get("toggle-switch", use: getToggleSwitch)
        preview.get("tooltip", use: getTooltip)
        preview.get("cookie-banner", use: getCookieBanner)
        preview.get("error-message", use: getErrorMessage)
        preview.get("file-upload", use: getFileUpload)
        preview.get("multiple-file-upload", use: getMultipleFileUpload)
        preview.get("helper-text", use: getHelperText)
        preview.get("hidden-field", use: getHiddenField)
        preview.get("logo", use: getLogo)
        preview.get("view-masked-secret", use: getViewMaskedSecret)
        preview.get("icons", use: getIcons)
        preview.get("mermaid", use: getMermaid)
        preview.get("pagination", use: getPagination)
        preview.get("table-paginator", use: getTablePaginator)
        preview.get("glossary-entry", use: getGlossaryEntry)
        preview.get("glossary", use: getGlossary)

        try routes.register(collection: SearchFieldController())
    }

    @Sendable
    func getHome(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(HomeView())
        return view
    }

    @Sendable
    func getAvatar(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(AvatarView())
        return view
    }

    @Sendable
    func getAccordion(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(AccordionView())
        return view
    }

    @Sendable
    func getCarousel(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(CarouselView())
        return view
    }

    @Sendable
    func getAudioPlayer(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(AudioPlayerView())
        return view
    }

    @Sendable
    func getBadge(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(BadgeView())
        return view
    }

    @Sendable
    func getBreadcrumb(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(BreadcrumbView())
        return view
    }

    @Sendable
    func getButton(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(ButtonView())
        return view
    }

    @Sendable
    func getByMeACoffee(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(ByMeACoffeeView())
        return view
    }

    @Sendable
    func getCheckbox(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(CheckboxView())
        return view
    }

    @Sendable
    func getCheckboxSelect(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(CheckboxSelectView())
        return view
    }

    @Sendable
    func getCodeBlock(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(CodeBlockView())
        return view
    }

    @Sendable
    func getCopyToClipboard(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(CopyToClipboardView())
        return view
    }

    @Sendable
    func getDefinition(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(DefinitionView())
        return view
    }

    @Sendable
    func getGlossaryEntry(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(GlossaryEntryView())
        return view
    }

    @Sendable
    func getGlossary(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(GlossaryView())
        return view
    }

    @Sendable
    func getDatePicker(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(DatePickerView())
        return view
    }

    @Sendable
    func getDropdown(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(DropdownView())
        return view
    }

    @Sendable
    func getSimpleMenu(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(SimpleMenuView())
        return view
    }

    @Sendable
    func getModalDelete(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(ModalDeleteView())
        return view
    }

    @Sendable
    func getInputField(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(InputFieldView())
        return view
    }

    @Sendable
    func getInputList(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(InputListView())
        return view
    }

    @Sendable
    func getKbd(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(KbdView())
        return view
    }

    @Sendable
    func getKeyTakeaway(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(KeyTakeawayView())
        return view
    }

    @Sendable
    func getLabel(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(LabelView())
        return view
    }

    @Sendable
    func getSkipLink(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(SkipLinkView())
        return view
    }

    @Sendable
    func getLink(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(LinkView())
        return view
    }

    @Sendable
    func getLinkButton(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(LinkButtonView())
        return view
    }

    @Sendable
    func getLinkList(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(LinkListView())
        return view
    }

    @Sendable
    func getMarkdownBlock(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(MarkdownBlockView())
        return view
    }

    @Sendable
    func getMultiSelect(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(MultiSelectView())
        return view
    }

    @Sendable
    func getNotification(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(NotificationView())
        return view
    }

    @Sendable
    func getPasswordInput(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(PasswordInputView())
        return view
    }

    @Sendable
    func getPill(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(PillView())
        return view
    }

    @Sendable
    func getQuote(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(QuoteView())
        return view
    }

    @Sendable
    func getRating(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(RatingView())
        return view
    }

    @Sendable
    func getRatingFloating(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(RatingFloatingView())
        return view
    }

    @Sendable
    func getReferences(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(ReferencesView())
        return view
    }

    @Sendable
    func getSimpleTable(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(SimpleTableView())
        return view
    }

    @Sendable
    func getSingleSelect(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(SingleSelectView())
        return view
    }

    @Sendable
    func getSpacer(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(SpacerView())
        return view
    }

    @Sendable
    func getStepper(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(StepperView())
        return view
    }

    @Sendable
    func getTextareaField(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(TextareaFieldView())
        return view
    }

    @Sendable
    func getToggleSwitch(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(ToggleSwitchView())
        return view
    }

    @Sendable
    func getTooltip(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(TooltipView())
        return view
    }

    @Sendable
    func getCookieBanner(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(CookieBannerView())
        return view
    }

    @Sendable
    func getErrorMessage(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(ErrorMessageView())
        return view
    }

    @Sendable
    func getFileUpload(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(FileUploadView())
        return view
    }

    @Sendable
    func getMultipleFileUpload(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(MultipleFileUploadView())
        return view
    }

    @Sendable
    func getHelperText(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(HelperTextView())
        return view
    }

    @Sendable
    func getHiddenField(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(HiddenFieldView())
        return view
    }

    @Sendable
    func getLogo(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(LogoView())
        return view
    }

    @Sendable
    func getDarkLightModeToggle(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(DarkLightModeToggleView())
        return view
    }

    @Sendable
    func getViewMaskedSecret(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(ViewMasekedSecretView())
        return view
    }

    @Sendable
    func getIcons(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(IconsView())
        return view
    }

    @Sendable
    func getMermaid(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(MermaidView())
        return view
    }

    @Sendable
    func getPagination(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(PaginationView())
        return view
    }

    @Sendable
    func getTablePaginator(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(TablePaginatorView())
        return view
    }

    @Sendable
    func getTabGroup(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(TabGroupView())
        return view
    }

    @Sendable
    func getThemeSwitcher(_ request: Request) async throws -> Response {
        let view = request.templates.renderHtml(ThemeSwitcherView())
        return view
    }
}
