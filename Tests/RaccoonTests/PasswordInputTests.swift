import HTML
import SGML
import Testing

@testable import Raccoon

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}

@Suite("PasswordInput")
struct PasswordInputTests {
    @Test("renders password criteria list")
    func rendersPasswordCriteria() async throws {
        let html = renderHTML(
            PasswordInput(
                PasswordInputData(
                    passwordId: "password",
                    passwordLabel: LabelData(id: "password", title: "Password")
                )
            )
            .render()
        )
        #expect(html.contains("At least one uppercase letter"))
        #expect(html.contains("At least one special character"))
        #expect(html.contains("Minimum of 12 characters"))
        #expect(html.contains("At least one digit"))
        #expect(html.contains("At least one lowercase letter"))
        #expect(html.contains("Does not contain common words"))
    }

    @Test("renders confirm password field")
    func rendersConfirmPasswordField() async throws {
        let html = renderHTML(
            PasswordInput(
                PasswordInputData(
                    passwordId: "password",
                    passwordLabel: LabelData(id: "password", title: "Password")
                )
            )
            .render()
        )
        #expect(html.contains("Confirm password"))
    }

    @Test("renders error and success icons")
    func rendersErrorAndSuccessIcons() async throws {
        let html = renderHTML(
            PasswordInput(
                PasswordInputData(
                    passwordId: "password",
                    passwordLabel: LabelData(id: "password", title: "Password")
                )
            )
            .render()
        )
        #expect(html.contains("text-on-success"))
    }

    @Test("renders caps lock icon for accessibility")
    func rendersCapsLockIcon() async throws {
        let html = renderHTML(
            PasswordInput(
                PasswordInputData(
                    passwordId: "password",
                    passwordLabel: LabelData(id: "password", title: "Password")
                )
            )
            .render()
        )
        #expect(html.contains("capsLock"))
        #expect(html.contains("role=\"presentation\""))
    }

    @Test("renders password input element")
    func rendersPasswordInput() async throws {

        let html = renderHTML(
            PasswordInput(
                PasswordInputData(
                    passwordId: "password",
                    passwordLabel: LabelData(
                        id: "password",
                        title: "Password"
                    )
                )
            )
            .render()
        )
        #expect(html.contains("id=\"password\""))
        #expect(html.contains(":type=\"showPassword ? 'text' : 'password'\""))
    }

    @Test("renders label title")
    func rendersLabel() async throws {

        let html = renderHTML(
            PasswordInput(
                PasswordInputData(
                    passwordId: "pwd",
                    passwordLabel: LabelData(
                        id: "pwd",
                        title: "Secret password"
                    )
                )
            )
            .render()
        )
        #expect(html.contains("Secret password"))
    }

    @Test("renders toggle visibility button")
    func rendersVisibilityToggle() async throws {

        let html = renderHTML(
            PasswordInput(
                PasswordInputData(
                    passwordId: "password",
                    passwordLabel: LabelData(
                        id: "password",
                        title: "Password"
                    )
                )
            )
            .render()
        )
        #expect(html.contains("<button"))
    }

    @Test("renders Alpine config with common words and server errors")
    func rendersAlpineConfigWithCommonWordsAndServerErrors() async throws {

        let html = renderHTML(
            PasswordInput(
                PasswordInputData(
                    passwordId: "password",
                    passwordLabel: LabelData(id: "password", title: "Password"),
                    passwordErrorMessages: ErrorMessageData(
                        id: "pwd-err",
                        errorMessages: ["Weak password"],
                        hasIcon: false
                    ),
                    confirmErrorMessages: ErrorMessageData(
                        id: "confirm-err",
                        errorMessages: ["Mismatch"],
                        hasIcon: false
                    ),
                    commonWords: ["secret", "welcome"]
                )
            )
            .render()
        )
        #expect(
            html.contains(
                "inputPassword({hasPasswordServerError: true, hasConfirmServerError: true"
            )
        )
        // Regression: JSON array must be HTML-entity-escaped since it's embedded inside a
        // double-quoted x-data attribute (the renderer does not escape attribute values).
        #expect(
            html.contains(
                "commonWords: [&quot;secret&quot;,&quot;welcome&quot;]"
            )
                || html.contains(
                    "commonWords: [&quot;secret&quot;, &quot;welcome&quot;]"
                )
        )
        #expect(html.contains("Weak password"))
        #expect(html.contains("Mismatch"))
        #expect(html.contains("/js/input-password.js"))
    }

    @Test("omits confirm field when disabled")
    func omitsConfirmFieldWhenDisabled() async throws {

        let html = renderHTML(
            PasswordInput(
                PasswordInputData(
                    passwordId: "password",
                    passwordLabel: LabelData(id: "password", title: "Password"),
                    hasConfirmPassword: false
                )
            )
            .render()
        )
        #expect(!html.contains("Confirm password"))
        #expect(!html.contains("Passwords don't match"))
    }

    @Test("renders helper text and generator control")
    func rendersHelperTextAndGeneratorControl() async throws {

        let html = renderHTML(
            PasswordInput(
                PasswordInputData(
                    passwordId: "password",
                    passwordLabel: LabelData(id: "password", title: "Password"),
                    passwordHelperText: HelperTextData(
                        id: "pwd-help",
                        text: "Use a unique password"
                    ),
                    confirmHelperText: HelperTextData(
                        id: "confirm-help",
                        text: "Repeat the password"
                    )
                )
            )
            .render()
        )
        #expect(html.contains("Use a unique password"))
        #expect(html.contains("Repeat the password"))
        #expect(html.contains("Generate password"))
        #expect(html.contains("showPassword = !showPassword"))
    }
}
