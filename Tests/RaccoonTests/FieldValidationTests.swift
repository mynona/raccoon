import Testing

@testable import Raccoon

@Suite("FieldValidation messages")
struct FieldValidationMessageTests {

    private let label = LabelData(id: "mail", title: "Email")

    @Test("a message with a label title starts with the title")
    func withLabel() {
        let message = FieldValidationType.email.errorMessage(
            labelTitle: label.title
        )
        #expect(message.english == "Email is not a valid email address.")
    }

    @Test("a message without a label starts with 'This'")
    func withoutLabel() {
        let message = FieldValidationType.email.errorMessage(labelTitle: nil)
        #expect(message.english == "This is not a valid email address.")
        let blank = FieldValidationType.email.errorMessage(
            labelTitle: LocalizedText(verbatim: "")
        )
        #expect(blank.english == "This is not a valid email address.")
    }

    @Test("the message is translated and the label is a variable")
    func translated() {
        let german = I18n.render(language: "de") {
            FieldValidationType.email.errorMessage(labelTitle: label.title)
                .resolved
        }
        #expect(german == "Email ist keine gültige E-Mail-Adresse.")
        let french = I18n.render(language: "fr") {
            FieldValidationType.integer.errorMessage(labelTitle: nil).resolved
        }
        #expect(french == "Ce n'est pas un nombre entier valide.")
    }

    @Test("a translated label title is used in the page language")
    func translatedLabel() {
        let title = LocalizedText(
            en: "Email",
            translations: ["de": "E-Mail"]
        )
        let german = I18n.render(language: "de") {
            FieldValidationType.email.errorMessage(labelTitle: title).resolved
        }
        #expect(german == "E-Mail ist keine gültige E-Mail-Adresse.")
    }

    @Test(
        "a custom message is returned as given, an invalid pattern gives none"
    )
    func custom() {
        let ok = FieldValidationType.custom(pattern: "^a$", message: "Only a")
        #expect(ok.errorMessage(labelTitle: nil).english == "Only a")
        let broken = FieldValidationType.custom(pattern: "(", message: "x")
        #expect(broken.errorMessage(labelTitle: nil).english.isEmpty)
    }

    @Test("every validation type has a message")
    func everyTypeHasAMessage() {
        let types: [FieldValidationType] = [
            .firstLastName, .email, .url, .integer, .amount, .phoneNumber,
            .ip4vAddress, .friendlyUrl,
        ]
        for type in types {
            #expect(!type.errorMessage(labelTitle: nil).english.isEmpty)
            #expect(!type.errorMessage(labelTitle: label.title).english.isEmpty)
        }
    }
}
