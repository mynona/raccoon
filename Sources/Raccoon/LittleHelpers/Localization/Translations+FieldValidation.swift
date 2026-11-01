extension Translations {
    static let fieldvalidation: [String: [String: String]] = [
        "firstLastName": [
            "en":
                "Must have at least 2 valid characters (no spaces at the start or end).",
            "de":
                "Muss mindestens 2 gültige Zeichen enthalten (keine Leerzeichen am Anfang oder Ende).",
            "fr":
                "Doit contenir au moins 2 caractères valides (sans espace au début ni à la fin).",
            "es":
                "Debe tener al menos 2 caracteres válidos (sin espacios al principio ni al final).",
            "it":
                "Deve avere almeno 2 caratteri validi (senza spazi all'inizio o alla fine).",
        ],
        "firstLastNameWithLabel": [
            "en":
                "{{label}} has less than 2 valid characters (no spaces at the start or end).",
            "de":
                "{{label}} hat weniger als 2 gültige Zeichen (keine Leerzeichen am Anfang oder Ende).",
            "fr":
                "{{label}} contient moins de 2 caractères valides (sans espace au début ni à la fin).",
            "es":
                "{{label}} tiene menos de 2 caracteres válidos (sin espacios al principio ni al final).",
            "it":
                "{{label}} ha meno di 2 caratteri validi (senza spazi all'inizio o alla fine).",
        ],
        "email": [
            "en": "This is not a valid email address.",
            "de": "Das ist keine gültige E-Mail-Adresse.",
            "fr": "Ce n'est pas une adresse e-mail valide.",
            "es": "No es una dirección de correo electrónico válida.",
            "it": "Non è un indirizzo e-mail valido.",
        ],
        "emailWithLabel": [
            "en": "{{label}} is not a valid email address.",
            "de": "{{label}} ist keine gültige E-Mail-Adresse.",
            "fr": "{{label}} n'est pas une adresse e-mail valide.",
            "es": "{{label}} no es una dirección de correo electrónico válida.",
            "it": "{{label}} non è un indirizzo e-mail valido.",
        ],
        "url": [
            "en": "This is not a valid URL starting with http:// or https://.",
            "de":
                "Das ist keine gültige URL, die mit http:// oder https:// beginnt.",
            "fr":
                "Ce n'est pas une URL valide commençant par http:// ou https://.",
            "es": "No es una URL válida que empiece por http:// o https://.",
            "it": "Non è un URL valido che inizia con http:// o https://.",
        ],
        "urlWithLabel": [
            "en":
                "{{label}} is not a valid URL starting with http:// or https://.",
            "de":
                "{{label}} ist keine gültige URL, die mit http:// oder https:// beginnt.",
            "fr":
                "{{label}} n'est pas une URL valide commençant par http:// ou https://.",
            "es":
                "{{label}} no es una URL válida que empiece por http:// o https://.",
            "it":
                "{{label}} non è un URL valido che inizia con http:// o https://.",
        ],
        "integer": [
            "en": "This is not a valid integer number.",
            "de": "Das ist keine gültige ganze Zahl.",
            "fr": "Ce n'est pas un nombre entier valide.",
            "es": "No es un número entero válido.",
            "it": "Non è un numero intero valido.",
        ],
        "integerWithLabel": [
            "en": "{{label}} is not a valid integer number.",
            "de": "{{label}} ist keine gültige ganze Zahl.",
            "fr": "{{label}} n'est pas un nombre entier valide.",
            "es": "{{label}} no es un número entero válido.",
            "it": "{{label}} non è un numero intero valido.",
        ],
        "amount": [
            "en": "This is not a valid amount with 2 decimal numbers.",
            "de": "Das ist kein gültiger Betrag mit 2 Dezimalstellen.",
            "fr": "Ce n'est pas un montant valide à 2 décimales.",
            "es": "No es un importe válido con 2 decimales.",
            "it": "Non è un importo valido con 2 decimali.",
        ],
        "amountWithLabel": [
            "en": "{{label}} is not a valid amount with 2 decimal numbers.",
            "de": "{{label}} ist kein gültiger Betrag mit 2 Dezimalstellen.",
            "fr": "{{label}} n'est pas un montant valide à 2 décimales.",
            "es": "{{label}} no es un importe válido con 2 decimales.",
            "it": "{{label}} non è un importo valido con 2 decimali.",
        ],
        "phoneNumber": [
            "en": "This is not a valid phone number (E.164 standard).",
            "de": "Das ist keine gültige Telefonnummer (E.164-Standard).",
            "fr": "Ce n'est pas un numéro de téléphone valide (norme E.164).",
            "es": "No es un número de teléfono válido (estándar E.164).",
            "it": "Non è un numero di telefono valido (standard E.164).",
        ],
        "phoneNumberWithLabel": [
            "en": "{{label}} is not a valid phone number (E.164 standard).",
            "de": "{{label}} ist keine gültige Telefonnummer (E.164-Standard).",
            "fr":
                "{{label}} n'est pas un numéro de téléphone valide (norme E.164).",
            "es":
                "{{label}} no es un número de teléfono válido (estándar E.164).",
            "it":
                "{{label}} non è un numero di telefono valido (standard E.164).",
        ],
        "ip4vAddress": [
            "en": "This is not a valid IPv4 address.",
            "de": "Das ist keine gültige IPv4-Adresse.",
            "fr": "Ce n'est pas une adresse IPv4 valide.",
            "es": "No es una dirección IPv4 válida.",
            "it": "Non è un indirizzo IPv4 valido.",
        ],
        "ip4vAddressWithLabel": [
            "en": "{{label}} is not a valid IPv4 address.",
            "de": "{{label}} ist keine gültige IPv4-Adresse.",
            "fr": "{{label}} n'est pas une adresse IPv4 valide.",
            "es": "{{label}} no es una dirección IPv4 válida.",
            "it": "{{label}} non è un indirizzo IPv4 valido.",
        ],
        "friendlyUrl": [
            "en": "This can only have lowercase letters and hyphens.",
            "de": "Darf nur Kleinbuchstaben und Bindestriche enthalten.",
            "fr": "Ne peut contenir que des lettres minuscules et des tirets.",
            "es": "Solo puede contener letras minúsculas y guiones.",
            "it": "Può contenere solo lettere minuscole e trattini.",
        ],
        "friendlyUrlWithLabel": [
            "en": "{{label}} can only have lowercase letters and hyphens.",
            "de":
                "{{label}} darf nur Kleinbuchstaben und Bindestriche enthalten.",
            "fr":
                "{{label}} ne peut contenir que des lettres minuscules et des tirets.",
            "es": "{{label}} solo puede contener letras minúsculas y guiones.",
            "it": "{{label}} può contenere solo lettere minuscole e trattini.",
        ],
    ]
}
