# Theme values

Semantic color tokens defined in [src/input.css](src/input.css) and where they are used in the Swift sources
(`raccoon`, `raccoon-raumnebenan`, `blog`, `cms`, `oauth_server`, `oauth_client`).
Tokens are consumed as Tailwind utilities, e.g. `--color-on-surface` → `text-on-surface`, `bg-on-surface/20`.
Most utilities are defined once in `raccoon/Sources/Raccoon/Theme/CommonStyles/CommonStyles.swift` and reused by the components.

Supported themes:
- `raumnebenan` (default emerald / green brand theme)
- `black-and-white` (`[data-theme="black-and-white"]`, high-contrast monochrome)
- `beacon-blue` (`[data-theme="beacon-blue"]`, clean off-white paper, deep navy ink, cobalt blue links, and warm beacon-orange highlights for focus/hover rings and progress)

## Primary

| token | usage |
|---|---|
| `primary` | Primary button background and border (`CommonStyles.buttonBackgroundColorPrimary`, `buttonBorderPrimary`); left border of KeyTakeaway. |
| `primary-dim` | Checkbox/radio fill color (`text-primary-dim` in `CheckStyles`). |
| `on-primary` | Text on primary buttons (`CommonStyles.buttonTextColorPrimary`). |

## Secondary

| token | usage |
|---|---|
| `secondary` | Secondary button background (`CommonStyles.buttonBackgroundColorSecondary`). |
| `on-secondary` | Secondary button text and border (`buttonTextColorSecondary`, `buttonBorderSecondary`). |

## Tertiary

| token | usage |
|---|---|
| `tertiary` | Tertiary button background and border (`buttonBackgroundColorTertiary`, `buttonBorderTertiary`). |
| `on-tertiary` | Tertiary button text (`buttonTextColorTertiary`). |

## Icon

| token | usage |
|---|---|
| `icon` | Icon button background (`buttonBackgroundColorIcon`). |
| `on-icon` | Icon button glyph color (`buttonTextColorIcon`). |

## Disabled

| token | usage |
|---|---|
| `disabled` | Disabled button background (`disabled:bg-disabled`, `buttonBackgroundColorDisabled`); Dialog background and border (`DialogStyles`). |
| `on-disabled` | Disabled text (`textColorDisabled`) and border (`borderColorDisabled`); disabled checkbox (`CheckStyles`) and DatePicker text/ring. |

## Accent

| token | usage |
|---|---|
| `on-success` | Success text (`textColorSuccess`) and border (`borderColorSuccess`) for valid inputs (Rating, InputList, PasswordInput, SingleSelect); checked ToggleSwitch background (`bg-on-success`). |
| `on-theme` | Brand accent: link underline in `prose` (`decoration-on-theme`), `borderColorTheme`, Quote left border, AudioPlayer frame, Avatar border, ArticleOverview border, ArticleTitle text, blog Reader/PrivacyPolicy borders, oauth_server registration text. |

## Notifications

| token | usage |
|---|---|
| `surface-success` | Notification success background (`NotificationStyles`). |
| `on-surface-success` | Notification success text and border. |
| `surface-info` | Notification info background. |
| `on-surface-info` | Notification info text and border. |
| `surface-warning` | Notification warning background. |
| `on-surface-warning` | Notification warning text and border. |
| `surface-error` | Notification error background. |
| `on-surface-error` | Notification error text and border. |

## Rating

| token | usage |
|---|---|
| `surface-rating` | Rating component background (`RatingStyles`). |

## Hover and focus rings

| token | usage |
|---|---|
| `hoverring` | Ring on hover (`hover:ring-hoverring` in `hoverDefault`, `hoverDefaultCheckbox`) and on the active SingleSelect option. |
| `focusring` | Ring on focus (`focus-within:ring-focusring` in `focusDefault`, `focusDefaultCheckbox`). |

## Links

| token | usage |
|---|---|
| `link-active` | Text color of an active link (`HyperLinkStyles.active`). |
| `link-hover` | Text and underline on hover (`HyperLinkStyles.hover`). |
| `link-visited` | Visited link text (`HyperLinkStyles.visited`). |

## Error

| token | usage |
|---|---|
| `error` | Destructive ("warning") button background and border (`buttonBackgroundColorWarning`, `buttonBorderWarning`); error hover/focus rings (`hoverError`, `focusError`). |
| `on-error` | Text on destructive buttons (`buttonTextColorWarning`). |
| `on-error-variant` | Inline error text (`textColorError`) and border (`borderColorError`) on inputs. |

## Progress

| token | usage |
|---|---|
| `progressactive` | Active/completed Stepper segment (`CommonStyles.progressBarActive`). |
| `progressinactive` | Remaining Stepper segment (`CommonStyles.progressBarInactive`). |

## Surface

| token | usage |
|---|---|
| `surface` | Default background for cards, dialogs, selects, tabs, date picker, etc. (`backgroundLight`). |
| `surface-dark` | Dark container background (`backgroundDark`). |
| `on-surface` | Default body text (`textColorDefault`), default borders (`borderColorDefault`, `inputBorder`, Accordion, CodeBlock, DatePicker), prose text and list markers, Stepper hover fill (`bg-on-surface/20`), PageHeader text. |
| `on-surface-variant` | Headings `h1`–`h4` inside `prose`. |
| `on-surface-dim` | Input placeholder (`textColorPlaceholder`) and DatePicker secondary text. |
| `on-surface-bright` | Emphasized and input text (`textColorEmphasized`, `textColorInput`), `prose` links, Badge text/border, Stepper hover border. |
| `inverse-surface` | Tooltip background (`backgroundInverse`). |
| `on-inverse-surface` | Tooltip text (`textColorInverse`). |

## Outline

| token | usage |
|---|---|
| `outline` | Dividers (`divideColorDefault`, SingleSelect), KeyboardKey border, PageHeader border. |

## Shadow and scrim

| token | usage |
|---|---|
| `shadow` | Not used in the Swift sources yet. |
| `scrim` | Modal backdrop (`CommonStyles.backdropColor`, used by DeleteModal). |
