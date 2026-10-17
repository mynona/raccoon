import HTML
import SGML
import SVG
import WebBuilders

public struct PasswordInput: TemplateRepresentable {
    let data: PasswordInputData
    typealias styles = PasswordInputStyles
    typealias inputFieldStyles = InputFieldStyles
    typealias buttonStyles = ActionButtonStyles

    // Validation errors are intentionally only provided in English languages.
    let items = [
        ("hasUppercase", "At least one uppercase letter"),
        ("hasSpecial", "At least one special character"),
        ("hasMinLength", "Minimum of 12 characters"),
        ("hasDigit", "At least one digit"),
        ("hasLowercase", "At least one lowercase letter"),
        ("hasNoCommonWords", "Does not contain common words"),
    ]

    public init(
        _ data: PasswordInputData
    ) {
        self.data = data
    }

    func commonWordList() -> String {
        JavaScriptEscaper.jsonEncode(data.commonWords, fallback: "[]")
    }

    // MARK: confirm password

    @Builder<Element>
    func showConfirmField() -> [Element] {
        if data.hasConfirmPassword,
            let confirmLabel = data.confirmLabel,
            let confirmId = data.confirmId
        {
            Div {
                Label(confirmLabel).render()

                Input()
                    .id(confirmId)
                    .name(confirmId)
                    .if(confirmLabel.isRequired) {
                        $0.flagAttribute("required")
                    }
                    .setAttribute(
                        name: ":type",
                        value: "showConfirm ? 'text' : 'password'"
                    )
                    .setAttribute(
                        name: "x-model",
                        value: "confirmPassword"
                    )
                    .setAttribute(
                        name: "@input",
                        value: "userTouchedConfirmField = true"
                    )
                    .setAttribute(
                        name: "autocomplete",
                        value: "new-password"
                    )
                    .setAttribute(
                        name: "aria-describedby",
                        value: "label-\(confirmLabel.id)"
                    )
                    // maxlength=24 is intentionally. Although some password managers create passwords > 24 characters, for this component the maxlength is set to 24 characters
                    .setAttribute(
                        name: "maxlength",
                        value: "24"
                    )
                    .class(
                        "block w-full p-0 text-sm leading-6"
                    )
                    .addClass(inputFieldStyles.inputReset)
                    .addClass(inputFieldStyles.textColorInput)
                    .addClass(inputFieldStyles.textColorPlaceholder)
                    // Matomo
                    .flagAttribute("data-matomo-mask")

            }
            .class("w-full")
        }
    }

    @Builder<Element>
    func showConfirmButtonShowHidePassword() -> [Element] {
        Div {
            Svg.icon(.eye_slash, width: 16, height: 16)
                .setAttribute(
                    name: "@click",
                    value: "showConfirm = !showConfirm"
                )
                .setAttribute(
                    name: ":class",
                    value:
                        "{ 'hidden': showConfirm, 'block': !showConfirm }"
                )

            Svg.icon(.eye, width: 16, height: 16)
                .setAttribute(
                    name: "@click",
                    value: "showConfirm = !showConfirm"
                )
                .setAttribute(
                    name: ":class",
                    value:
                        "{ 'hidden': !showConfirm, 'block': showConfirm }"
                )

        }
        .tabIndex(0)
        .setAttribute(
            name: "@keydown",
            value:
                "if ($event.key === 'Enter' || $event.key === ' ') showConfirm = !showConfirm"
        )
        .addClass("cursor-pointer")
        .addClass(buttonStyles.font)
        .addClass(buttonStyles.textSizeBase)
        .addClass(buttonStyles.paddingIcon)
        .addClass(buttonStyles.textColorIcon)
        .addClass(buttonStyles.backgroundColorIcon)
        .addClass(buttonStyles.borderIcon)
        .addClass(CommonStyles.focusDefault)
        .addClass(CommonStyles.hoverDefault)
    }

    @Builder<Element>
    func showConfirmInputValidationIcon() -> [Element] {
        Svg.icon(.check_circle, width: 16, height: 16)
            .setAttribute(
                name: "x-show",
                value:
                    "confirmPassword.length > 0 && passwordsMatch"
            )
            .class("ml-3")
            .addClass(inputFieldStyles.textColorSuccess)

        Svg.icon(.dash_circle, width: 16, height: 16)
            .setAttribute(
                name: "x-show",
                value:
                    "confirmPassword.length > 0 && !passwordsMatch"
            )
            .class("ml-3")
            .addClass(inputFieldStyles.textColorError)
    }

    @Builder<Element>
    func showConfirmPasswordField() -> [Element] {
        if data.hasConfirmPassword {

            Div {

                Div {
                    showCapsLockIcon()
                    showConfirmField()
                }
                .class(
                    "flex flex-row items-center space-x-4 flex-grow min-w-[120px]"
                )
                //.class("flex flex-row space-x-4 w-full")

                Div {
                    showConfirmButtonShowHidePassword()
                    showConfirmInputValidationIcon()
                }
                .class(
                    "flex flex-row items-center space-x-2 flex-shrink-0 mt-2 mb-2 mobile-sm:mt-0 mobile-sm:mb-0 mobile-sm:basis-auto basis-full"
                )
                //.class("absolute inset-y-0 right-0 flex items-center pr-4")
            }
            .class(
                "flex flex-wrap items-center justify-between px-3 pb-1.5 pt-2.5"
            )
            //.class("relative px-3 pb-1.5 pt-2.5 mt-4")
            .addClass(inputFieldStyles.inputContainerBorder)
            .addClass(inputFieldStyles.inputContainerHover)
            .addClass(inputFieldStyles.inputContainerFocus)
            .setAttribute(
                name: ":class",
                value:
                    "confirmPassword.length === 0 ? '\(inputFieldStyles.borderColorDefault)' : (passwordsMatch ? '\(inputFieldStyles.borderColorSuccess)' : '\(inputFieldStyles.borderColorError)')"
            )

            Div {
                Span("Passwords don't match")
            }
            .class("text-sm mt-1")
            .addClass(inputFieldStyles.textColorError)
            .setAttribute(
                name: "x-show",
                value: "confirmPassword.length > 0 && !passwordsMatch"
            )
            .setAttribute(
                name: "x-transition.opacity",
                value: ""
            )

            if let fieldError = data.confirmErrorMessages {
                Div {
                    ErrorMessage(fieldError).render()
                }
                .setAttribute(
                    name: "x-show",
                    value: "confirmServerError && !userTouchedConfirmField"
                )
                .setAttribute(
                    name: "x-transition.opacity",
                    value: ""
                )
            }

            if let helperText = data.confirmHelperText {
                HelperText(helperText).render()
            }
        }
    }

    // MARK: password input

    @Builder<Element>
    func showCapsLockIcon() -> [Element] {
        Span {
            Svg.icon(.capslock, width: 16, height: 16)
        }
        .setAttribute(
            name: "x-show",
            value: "capsLock"
        )
        .class(inputFieldStyles.textColorDefault)
    }

    @Builder<Element>
    func showButtonGeneratePassword() -> [Element] {

        Button {
            Svg.icon(.magic, width: 16, height: 16)
        }
        .type(.button)
        .ariaLabel("Generate password")
        .setAttribute(
            name: "@click",
            value: "generatePassword()"
        )
        .addClass("cursor-pointer")
        .addClass(buttonStyles.font)
        .addClass(buttonStyles.textSizeBase)
        .addClass(buttonStyles.paddingIcon)
        .addClass(buttonStyles.textColorIcon)
        .addClass(buttonStyles.backgroundColorIcon)
        .addClass(buttonStyles.borderIcon)
        .addClass(CommonStyles.focusDefault)
        .addClass(CommonStyles.hoverDefault)
    }

    @Builder<Element>
    func showButtonShowHidePassword() -> [Element] {
        Div {
            Svg.icon(.eye_slash, width: 16, height: 16)
                .setAttribute(
                    name: "@click",
                    value: "showPassword = !showPassword"
                )
                .setAttribute(
                    name: ":class",
                    value:
                        "{ 'hidden': showPassword, 'block cursor-pointer': !showPassword }"
                )
                .class("cursor-pointer")

            Svg.icon(.eye, width: 16, height: 16)
                .setAttribute(
                    name: "@click",
                    value: "showPassword = !showPassword"
                )
                .setAttribute(
                    name: ":class",
                    value:
                        "{ 'hidden': !showPassword, 'block cursor-pointer': showPassword }"
                )
        }
        .tabIndex(0)  // tabIndex(0) set intentionally to avoid issues with certain browsers
        .setAttribute(
            name: "@keydown",
            value:
                "if ($event.key === 'Enter' || $event.key === ' ') showPassword = !showPassword"
        )
        .class("ml-3")
        .addClass("cursor-pointer")
        .addClass(buttonStyles.font)
        .addClass(buttonStyles.textSizeBase)
        .addClass(buttonStyles.paddingIcon)
        .addClass(buttonStyles.textColorIcon)
        .addClass(buttonStyles.backgroundColorIcon)
        .addClass(buttonStyles.borderIcon)
        .addClass(CommonStyles.focusDefault)
        .addClass(CommonStyles.hoverDefault)
    }

    @Builder<Element>
    func showInputValidationIcon() -> [Element] {
        Svg.icon(.check_circle, width: 16, height: 16)
            .setAttribute(
                name: "x-show",
                value: "validContent && !passwordServerError"
            )
            .class("ml-3")
            .addClass(inputFieldStyles.textColorSuccess)

        Svg.icon(.dash_circle, width: 16, height: 16)
            .setAttribute(
                name: "x-show",
                value:
                    "(passwordServerError && !userTouchedPasswordField) || (userTouchedPasswordField && password.length > 0 && !validContent)"
            )
            .class("ml-3")
            .addClass(inputFieldStyles.textColorError)
    }

    @Builder<Element>
    func showPasswordInputField() -> [Element] {
        Div {

            Label(data.passwordLabel).render()

            Input()
                .id(data.passwordId)
                .name(data.passwordId)
                .flagAttribute("\(data.passwordLabel.isRequired)")
                .setAttribute(
                    name: ":type",
                    value: "showPassword ? 'text' : 'password'"
                )
                .setAttribute(
                    name: "x-model",
                    value: "password"
                )
                .setAttribute(
                    name: "@input",
                    value:
                        "updateCriteria(); userTouchedPasswordField = true"
                )
                .setAttribute(
                    name: "autocomplete",
                    value: "new-password"
                )
                .setAttribute(
                    name: "aria-describedby",
                    value: "label-\(data.passwordLabel.id)"
                )
                .setAttribute(
                    name: ":aria-invalid",
                    value: "passwordServerError"
                )
                .setAttribute(
                    name: "maxlength",
                    value: "24"
                )
                .class(
                    "block w-full p-0 text-sm leading-6"
                )
                .addClass(inputFieldStyles.inputReset)
                .addClass(inputFieldStyles.textColorInput)
                .addClass(inputFieldStyles.textColorPlaceholder)
                // Matomo
                .flagAttribute("data-matomo-mask")

        }
        .class("w-full")
    }

    @Builder<Element>
    func showPasswordStrengthBar() -> [Element] {
        Div {
            (0..<items.count)
                .map { index in
                    Div {}
                        .setAttribute(
                            name: ":class",
                            value:
                                "criteria.count > \(index) ? '\(styles.passwordStrengthBarBackground)' : ''"
                        )
                        .class(
                            "h-2 w-full transition-colors duration-300"
                        )
                }
        }
        .class("flex basis-full py-2 mt-2")
    }

    @Builder<Element>
    func showPasswordField() -> [Element] {
        Div {

            Div {
                showCapsLockIcon()
                showPasswordInputField()
            }
            .class(
                "flex flex-row items-center space-x-4 flex-grow min-w-[120px]"
            )

            Div {
                showButtonGeneratePassword()
                showButtonShowHidePassword()
                showInputValidationIcon()
            }
            .class(
                "flex flex-row items-center space-x-2 flex-shrink-0 mt-2 mobile-sm:mt-0 mobile-sm:basis-auto basis-full"
            )

            showPasswordStrengthBar()

        }
        .class("flex flex-wrap items-center justify-between px-3 pb-1.5 pt-2.5")
        .addClass(inputFieldStyles.inputContainerBorder)
        .addClass(inputFieldStyles.inputContainerHover)
        .addClass(inputFieldStyles.inputContainerFocus)
        .setAttribute(
            name: ":class",
            value: """
                  (passwordServerError && !userTouchedPasswordField) || (userTouchedPasswordField && password.length > 0 && !validContent)
                    ? '\(inputFieldStyles.borderColorError)'
                    : (validContent
                      ? '\(inputFieldStyles.borderColorSuccess)'
                      : '\(inputFieldStyles.borderColorDefault)')
                """
        )

        if let fieldError = data.passwordErrorMessages {
            Div { ErrorMessage(fieldError).render() }
                .setAttribute(
                    name: "x-show",
                    value: "passwordServerError && !userTouchedPasswordField"
                )
                .setAttribute(
                    name: "x-transition.opacity",
                    value: ""
                )
        }

        if let helperText = data.passwordHelperText {
            HelperText(helperText).render()
        }
    }

    @Builder<Element>
    func showChecklist() -> [Element] {
        // checklist
        Div {
            let checklistItems = items.map { rule, label in
                Li {
                    Svg.icon(.check_circle)
                        .setAttribute(
                            name: ":class",
                            value:
                                "criteria.\(rule) ? '\(inputFieldStyles.textColorSuccess)' : 'hidden'"
                        )
                        .class("w-4 h-4 mr-2")
                    Svg.icon(.dash_circle)
                        .setAttribute(
                            name: ":class",
                            value:
                                "!criteria.\(rule) ? '\(inputFieldStyles.textColorError)' : 'hidden'"
                        )
                        .class("w-4 h-4 mr-2")
                    Span(label)
                }
                .class("flex items-center")
                .addClass(inputFieldStyles.textColorDefault)
            }
            Ul { checklistItems as [Element] }.class("space-y-1 text-sm")
        }
        .class("w-full py-4")
    }

    // MARK: main

    @Builder<Element>
    public func render() -> [Element] {

        DebugComment("PasswordField")

        Script()
            .src("/js/input-password.js")
            .setAttribute(
                name: "type",
                value: "text/javascript"
            )

        let hasPasswordServerError =
            (data.passwordErrorMessages?.errorMessages?.isEmpty == false)
        let hasConfirmServerError =
            (data.confirmErrorMessages?.errorMessages?.isEmpty == false)

        Div {

            showPasswordField()
            showChecklist()
            showConfirmPasswordField()
        }
        // CapsLock handled as global window listener. If there are multiple password input fields on a page all fields must display the caps lock indicator.
        .setAttribute(
            name: "@keydown.window",
            value: "capsLock = $event.getModifierState('CapsLock')"
        )
        .setAttribute(
            name: "@keyup.window",
            value: "capsLock = $event.getModifierState('CapsLock')"
        )
        .setAttribute(
            name: "x-data",
            value:
                "inputPassword({hasPasswordServerError: \(hasPasswordServerError ? "true" : "false"), hasConfirmServerError: \(hasConfirmServerError ? "true" : "false"), commonWords: \(JavaScriptEscaper.htmlAttributeEscape(commonWordList()))})"
        )
    }
}
