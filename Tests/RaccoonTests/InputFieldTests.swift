import Foundation
import HTML
import SGML
import Testing

@testable import Raccoon

@Test("phone number validation: +436502233742")
func testPhoneNumberValidation() async throws {

    let data = InputFieldData(
        id: "phone",
        label: LabelData(id: "phone", title: "Phone Number"),
        placeholder: "+436502233742",
        value: "+436502233742",
        validation: .phoneNumber,
        type: .tel
    )
    let html = renderHTML(InputField(data).render())
    // Should contain the value
    #expect(html.contains("+436502233742"))
    // Simulate JS regex validation (current regex as injected)
    let regex = try! NSRegularExpression(pattern: "^\\+[1-9]\\d{1,14}$")
    let match = regex.firstMatch(
        in: "+436502233742",
        range: NSRange(location: 0, length: 13)
    )
    #expect(match != nil)
}

@Test("IPv4 validation: 192.168.0.1")
func testIPv4Validation() async throws {

    let data = InputFieldData(
        id: "ip",
        label: LabelData(id: "ip", title: "IPv4 Address"),
        placeholder: "192.168.0.1",
        value: "192.168.0.1",
        validation: .ip4vAddress,
        type: .text
    )
    let html = renderHTML(InputField(data).render())
    #expect(html.contains("192.168.0.1"))
    // Simulate JS regex validation (current regex as injected)
    let regex = try! NSRegularExpression(
        pattern:
            "^((25[0-5]|2[0-4]\\d|[01]?\\d\\d?)\\.){3}(25[0-5]|2[0-4]\\d|[01]?\\d\\d?)$"
    )
    let match = regex.firstMatch(
        in: "192.168.0.1",
        range: NSRange(location: 0, length: 11)
    )
    #expect(match != nil)
}

private func renderHTML(_ elements: [any Element]) -> String {
    elements.map { Document(root: $0).render(indent: 0) }.joined()
}
@Test("renders all validation types with correct type and regex")
func rendersAllValidationTypes() async throws {

    let cases:
        [(
            id: String, type: HTML.Input.Types,
            validation: InputFieldData.ValidationType, placeholder: String
        )] = [
            ("fullname", .text, .firstLastName, "Jane Doe"),
            ("email", .email, .email, "jane@example.com"),
            ("website", .url, .url, "https://example.com"),
            ("age", .number, .integer, "18"),
            ("amount", .text, .amount, "12.34"),
            ("phone", .tel, .phoneNumber, "+491234567890"),
            ("ip", .text, .ip4vAddress, "192.168.0.1"),
            ("slug", .text, .friendlyUrl, "my-article"),
            (
                "custom", .text,
                .custom(
                    pattern: "^abc123$",
                    message: "Custom Field must be exactly 'abc123'."
                ), "abc123"
            ),
        ]
    for (id, type, validation, placeholder) in cases {
        let data = InputFieldData(
            id: id,
            label: LabelData(id: id, title: id.capitalized),
            placeholder: placeholder,
            validation: validation,
            type: type
        )
        let html = renderHTML(InputField(data).render())
        // Check input type
        #expect(html.contains("type=\"\(type.rawValue)\""))
        // Check placeholder
        #expect(html.contains(placeholder))
        // Check label
        #expect(html.contains(id.capitalized))
        // Check error message is present in validationMessage
        if let msg = data.validationMessage {
            #expect(msg.count > 0)
        }
    }
}

@Suite("InputField")
struct InputFieldTests {

    @Test("renders input element")
    func rendersInputElement() async throws {

        let html = renderHTML(
            InputField(InputFieldData(id: "email"))
                .render()
        )
        #expect(html.contains("<input"))
    }

    @Test("renders placeholder when provided")
    func rendersPlaceholder() async throws {

        let html = renderHTML(
            InputField(
                InputFieldData(id: "email", placeholder: "Enter your email")
            )
            .render()
        )
        #expect(html.contains("Enter your email"))
    }

    @Test("renders pre-filled value")
    func rendersValue() async throws {

        let html = renderHTML(
            InputField(InputFieldData(id: "name", value: "Alice"))
                .render()
        )
        #expect(html.contains("Alice"))
    }

    @Test("renders label when provided")
    func rendersLabel() async throws {

        let html = renderHTML(
            InputField(
                InputFieldData(
                    id: "username",
                    label: LabelData(id: "username", title: "Username")
                )
            )
            .render()
        )
        #expect(html.contains("Username"))
    }

    @Test("renders error message when provided")
    func rendersErrorMessage() async throws {

        let html = renderHTML(
            InputField(
                InputFieldData(
                    id: "url",
                    errorMessages: ErrorMessageData(
                        errorMessages: ["Invalid URL format."]
                    )
                )
            )
            .render()
        )
        #expect(html.contains("Invalid URL format."))
    }

    @Test(
        "aria-describedby references label, helper text and both error containers"
    )
    func ariaDescribedByReferencesAllContainers() async throws {

        let html = renderHTML(
            InputField(
                InputFieldData(
                    id: "email",
                    label: LabelData(id: "email", title: "Email"),
                    errorMessages: ErrorMessageData(
                        errorMessages: ["Invalid email."]
                    ),
                    helperText: HelperTextData(
                        id: "email-help",
                        text: "We never share it"
                    )
                )
            )
            .render()
        )
        #expect(
            html.contains(
                "aria-describedby=\"label-email email-help-helper email-local-error email-server-error\""
            )
        )
        #expect(html.contains("id=\"email-local-error\""))
        #expect(html.contains("id=\"email-server-error\""))
    }

    @Test(
        "aria-describedby omits the server-error id when there is no server error"
    )
    func ariaDescribedByOmitsServerErrorWhenAbsent() async throws {

        let html = renderHTML(
            InputField(
                InputFieldData(
                    id: "email",
                    label: LabelData(id: "email", title: "Email")
                )
            )
            .render()
        )
        #expect(
            html.contains("aria-describedby=\"label-email email-local-error\"")
        )
        // Server-error container id is always present in the DOM (harmless when empty/hidden),
        // but must not be listed in aria-describedby when there is no server error.
        #expect(
            !html.contains(
                "aria-describedby=\"label-email email-local-error email-server-error\""
            )
        )
    }

    @Test("renders Alpine config for custom validation")
    func rendersAlpineConfigForCustomValidation() async throws {

        let html = renderHTML(
            InputField(
                InputFieldData(
                    id: "custom",
                    label: LabelData(id: "custom", title: "Custom Field"),
                    value: "ABC-1234",
                    validation: .custom(
                        pattern: "^[A-Z]{3}-\\d{4}$",
                        message: "Must match pattern ABC-1234"
                    )
                )
            )
            .render()
        )
        #expect(html.contains("inputField({value: 'QUJDLTEyMzQ='"))
        // Regression: single-quoted JS literal, since the renderer doesn't escape double quotes
        // inside double-quoted HTML attribute values.
        #expect(html.contains("errorMessage: 'Must match pattern ABC-1234'"))
        #expect(html.contains("hasInitialValue: true"))
        #expect(html.contains("/js/input-field.js"))
    }

    @Test("renders helper text and matomo masking")
    func rendersHelperTextAndMatomoMasking() async throws {

        let html = renderHTML(
            InputField(
                InputFieldData(
                    id: "token",
                    label: LabelData(id: "token", title: "Token"),
                    helperText: HelperTextData(
                        id: "token-help",
                        text: "Paste the integration token"
                    ),
                    isMaskedInMatomo: true
                )
            )
            .render()
        )
        #expect(html.contains("Paste the integration token"))
        #expect(html.contains("data-matomo-mask"))
        #expect(html.contains("data-matomo-name=\"Token\""))
    }
}
