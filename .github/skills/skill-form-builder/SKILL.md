---
name: skill-form-builder
description: How to use Raccoon's `FormBuilder` (FormBuilderData, FormField, FormGroupData, FormAction, FormLayout) and how it is applied in the consuming repos (cms, oauth_server, Raccoon's own DeleteModal and CookieBanner). Always use this skill when building, migrating, reviewing or testing any `<form>` in Raccoon or in an app that depends on Raccoon, or when changing the FormBuilder itself.
---

# FormBuilder

`FormBuilder` renders a complete `<form>` from an ordered list of fields and actions. It renders **only the form**: headings, steppers, breadcrumbs and page templates stay outside.

Code: `Sources/Raccoon/Components/FormBuilder/` (`FormBuilder`, `FormBuilderData`, `FormField`, `FormGroupData`, `FormAction`, `FormLayout`, `FormBuilderStyles`). Tests: `Tests/RaccoonTests/FormBuilderTests.swift`. Preview: `Sources/Preview/Raccoon/Views/FormBuilderView.swift` (`/preview/form-builder`) and `FormBuilderDialogView.swift` (`/preview/form-builder-dialog`).

## 1. API

```swift
FormBuilder(
    FormBuilderData(
        id: "login.with-email",          // DOM id, form name and Matomo form name: unique per page/app
        action: "/auth2/login-with-email/", // nil = submit to the current URL
        method: .post,                   // default; .get for navigation/consent forms
        ariaLabel: nil,                  // LocalizedText?
        csrfToken: context.csrfToken,    // renders hidden "X-CSRF-Token" when non-nil
        fields: [ /* FormField */ ],
        actions: [ /* FormAction */ ],
        errorMessages: formErrors,       // form-level errors only (e.g. failed login)
        layout: .page,                   // .page | .dialog | .banner (action alignment only)
        isTracked: true                  // adds data-matomo-name=<id>
    )
).render()
```

### `FormField` (rendered in the given order)

| Case | Component |
|---|---|
| `.input .textArea .password .check .checkboxSelect .radioGroup .dropdown .singleSelect .multiSelect .datePicker .inputList .hidden` | `InputField`, `TextAreaField`, `PasswordInput`, `Check`, `CheckboxSelect`, `RadioGroup`, `Dropdown`, `SingleSelect`, `MultiSelect`, `DatePicker`, `InputList`, `HiddenField` (each takes its own `*Data`) |
| `.singleFileUpload .multipleFileUpload` | upload components; **only these** make the form `enctype="multipart/form-data"` (also when nested in `.group`/`.row`) |
| `.group(FormGroupData)` | `<fieldset>` + `<legend>`; `isLegendVisible: false` (default) keeps the legend `sr-only` |
| `.row([FormField])` | fields side by side, stacked on small screens |
| `.custom(any TemplateRepresentable & Sendable)` | any other widget (e.g. an `Accordion`); must be a `Sendable` struct; uploads inside `.custom` are **not** detected |

### `FormAction` (rendered below the fields)

- `.button(ActionButtonData)`: default `htmlType: .submit`; use `.button` + `clickAction` for e.g. closing a dialog.
- `.link(LinkButtonData)`: a plain `<a>` (Cancel, "Already registered?"). **Never** use a GET-submit button for Cancel: it puts all field values and the CSRF token in the URL.

### Layouts

`.page` leading edge, wrapping row; `.dialog` trailing edge (column on mobile); `.banner` stacked on mobile, inline row from tablet.

### Always set automatically

`novalidate`, `method`, `id`, `name`, `action` (only if given), multipart `enctype`, hidden CSRF field, `aria-label` (localized), `data-matomo-name` (if `isTracked`), vertical rhythm `flex flex-col gap-y-4` (no wrapper `Div`s with `space-y-*` needed).

## 2. Rules for using it

1. **Field ids/names are the contract with the server.** Keep `id`/`name` identical to the DTO / `Validatable` field names; a migration to `FormBuilder` must not touch controllers, DTOs or contexts.
2. **CSRF:** pass `csrfToken:`; never add your own `X-CSRF-Token` field. The token is only *checked* if the route group has `CSRFProtectMiddleware`.
3. **Errors:** field errors go into each field's `errorMessages` (`ErrorMessageData`), form-level errors into `FormBuilderData.errorMessages`.
4. **Matomo:** `id` must be unique across forms. Mask sensitive input with `isMaskedInMatomo: true`. Use `isTracked: false` for admin forms that should not appear as Matomo forms.
5. **Texts** are `LocalizedText` (plain string literals or `LocalizedText(verbatim:)` are fine for app texts; see `skill-localization`).
6. **Button-only forms** (no inputs) are fine: `fields: []` with `method: .get`/`.post` and `.button` actions (used for the DeleteModal, the cookie banner and "go to sign in" pages).
7. Use the real field types, not `.custom`, for anything that must be detected (uploads) or that has a `FormField` case.
8. Public API changes follow `skill-component-data` (documented `init`, same ordering in properties/init/assignments); styles follow `skill-component-styles`.

## 3. How it is applied in the repos

Sibling repos live next to this one in `../` (`/Users/kaeru/Daten/Swift/Vapor/raumnebenan/`). They depend on `https://github.com/mynona/raccoon.git` (and `raccoon-raumnebenan`) pinned in `Package.swift`; **bump the pin to get FormBuilder changes** (`swift package resolve && swift build`).

### 3.1 raccoon (this repo)

- `DeleteModal`: `FormBuilder` with `fields: []`, `csrfToken`, `.post` and Yes/No `.button` actions (`showForm()`).
- `CookieBanner`: `FormBuilder` with `method: .get`, `fields: []`, `layout: .banner`. The GET is deliberate for the opt-in / opt-out redirects; do not change it to POST.
- Preview app: page form (group + `.row` + link action) and dialog form (`layout: .dialog`).

### 3.2 oauth_server (21 files use `FormBuilder(`)

Modules: `Auth/` (registration, e-mail validation, sign-in, 2FA, password forgotten/reset and completion pages), `CMS/` (client, role, server create/edit, user roles, user view), `UserProfile/`. Plans and mappings: `oauth_server/md/auth-forms.md`, `oauth_server/md/cms-forms.md`.

Pattern: the **view declares the whole `FormBuilderData` inline**, with `context.errors?.forKey("<field>")` mapped to `ErrorMessageData`:

```swift
FormBuilder(FormBuilderData(
    id: "cms.role-create", action: "/system/role-create", csrfToken: context.csrfToken,
    fields: [.group(FormGroupData(legend: "Role", fields: [
        .input(InputFieldData(id: "role", label: LabelData(id: "role", title: "Role"),
                              value: context.role,
                              errorMessages: ErrorMessageData(id: "role",
                                  errorMessages: context.errors?.forKey("role").map { $0.map { LocalizedText(verbatim: $0) } }),
                              type: .text, isMaskedInMatomo: true))
    ], isLegendVisible: true))],
    actions: [.button(ActionButtonData(label: "Save", buttonType: .primary, hasFullWidth: false,
                                       contentTracker: MatomoContentTracker(name: "role", piece: "button.save", target: "/system/role-create")))],
    layout: .page, isTracked: false))
.render()
```

- Auth forms: heading outside, `hasFullWidth: true` buttons, `.link` for "Forgot password?" / "Already registered?" (`ViewSignInEmail`), form-level error for failed login via `errorMessages`, `isMaskedInMatomo: true` on credentials/codes, hidden `token` as `.hidden`.
- Admin (CMS) forms: `.group` with `isLegendVisible: true`, `isTracked: false`.
- Action-only status pages: `fields: []`, `method: .get`, a single `.button`.

### 3.3 cms (4 direct users + shared helper)

Docs: `cms/md/cms-form-builder.md` (migration plan, all phases done) and the `raumnebenan-cms` skill (`cms/.github/skills/raumnebenan-cms/SKILL.md`, "Forms" section).

Pattern: **thin shared helpers + per-entity field functions**:

- `Templates/cmsForm.swift`:
  - `cmsForm(id:action:csrfToken:fields:actions:)`: `FormBuilder` in the page wrapper (`Div` with `x-data="{ open: false }"` and `my-8 p-4`; the `x-data` is for the DeleteModal in the action bar, keep it outside the form).
  - `cmsFormActions(label:cancelHref:)`: primary submit button + Cancel as `.link`.
- `Templates/formFields<Entity>.swift` (`Tag`, `Article`, `Story`, `Page`, `Image`, `Document`, `TTS`, `GlossaryEntry`, `Topic`): `func formFieldsTag(tag:errors:) -> [FormField]`, no CSRF parameter, fields wrapped in `.group(FormGroupData(legend:..., isLegendVisible: true))`.
- Views: `cmsForm(id: "tag-create", csrfToken: context.csrfToken, fields: formFieldsTag(...), actions: cmsFormActions(label: "Create", cancelHref: "/cms/tags"))`.
- Form ids are unique per form (`tag-create`, `article-edit`, `item-edit-<type>`).
- Direct `FormBuilder(` use: article-view create-item bar (data-driven, 19 POST actions), dashboard maintenance form (with CSRF token), feedbacks delete dialog (`layout: .dialog`).
- Dynamic form `item-edit` builds `[FormField]` per `ItemType`; non-field widgets go through `.custom(...)` in a `Sendable` wrapper struct (`TableJsonExample`).
- Gotchas: `MultiSelect` name must stay `tags[]`; uploads (image/document/tts) must use the real upload fields so multipart is set; `CSRFProtectMiddleware` is only on the story/tag/topic/glossary-entry route groups, so other forms render a token that is not yet verified.

### 3.4 Not using it (yet)

`raccoon-raumnebenan`, `blog`, `marketplace`, `library`: no `FormBuilder(` usage. When adding a form there, follow the oauth_server inline pattern (single form) or the cms helper pattern (many similar forms).

## 4. Adding or migrating a form: checklist

1. Pick a unique `id`; decide `method`, `action`, `layout`.
2. Map each existing field 1:1 to a `FormField` case; keep ids/names; wrap logical sections in `.group` (use `isLegendVisible: true` for visible section titles).
3. Replace manual CSRF fields, `Fieldset`/`Legend` markup, per-field `Div` wrappers and manual `enctype` with the builder features.
4. Cancel/secondary navigation = `.link`, not a GET-submit button.
5. Add tests that assert the rendered form: field `name=` list, `enctype` for upload forms, CSRF field, Cancel is an `<a>`, error messages under the right fields. Examples: `Tests/RaccoonTests/FormBuilderTests.swift`, `cms/Tests/AppTests/CmsFormTests.swift`, `oauth_server/Tests/AppTests/AuthFormTests.swift`.
6. Run `swift build && swift test` in the repo (`swift test --filter FormBuilderTests` in raccoon) and check the form manually: valid POST, invalid POST (errors + preserved values), missing CSRF, real upload, dark/light mode and mobile spacing.
