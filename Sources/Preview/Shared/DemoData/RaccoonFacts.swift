import Foundation

/// Illustrative raccoon facts used by the DataTable preview. Values are sample data, not scientific records.
struct RaccoonFact: Codable, Sendable {
    let id: Int
    let name: String
    let range: String
    let description: String
    let description_html: String
    let habitat: String
    let body_length_cm: Int
    let weight_kg: Double
    let first_described: String
    let last_surveyed: String
    let nocturnal: Bool
    let status: String
}

enum RaccoonFacts {

    static let habitats = [
        "Forest", "Wetland", "Coast", "Urban", "Mountain", "Island",
    ]

    static let statuses = [
        "Least concern", "Near threatened", "Vulnerable", "Endangered",
        "Critically endangered",
    ]

    private struct Taxon {
        let name: String
        let scientific: String
        let range: String
        let status: String
        let length: Int
        let weight: Double
        let year: Int
    }

    private static let taxa: [Taxon] = [
        Taxon(
            name: "Common raccoon",
            scientific: "Procyon lotor",
            range: "North America",
            status: "Least concern",
            length: 60,
            weight: 6.5,
            year: 1758
        ),
        Taxon(
            name: "Crab-eating raccoon",
            scientific: "Procyon cancrivorus",
            range: "Central and South America",
            status: "Least concern",
            length: 58,
            weight: 5.5,
            year: 1798
        ),
        Taxon(
            name: "Cozumel raccoon",
            scientific: "Procyon pygmaeus",
            range: "Cozumel, Mexico",
            status: "Critically endangered",
            length: 52,
            weight: 3.5,
            year: 1901
        ),
        Taxon(
            name: "Tres Marías raccoon",
            scientific: "Procyon insularis",
            range: "Tres Marías Islands, Mexico",
            status: "Endangered",
            length: 55,
            weight: 4.2,
            year: 1898
        ),
        Taxon(
            name: "Guadeloupe raccoon",
            scientific: "Procyon minor",
            range: "Guadeloupe",
            status: "Near threatened",
            length: 56,
            weight: 4.8,
            year: 1898
        ),
        Taxon(
            name: "Barbados raccoon",
            scientific: "Procyon gloveralleni",
            range: "Barbados",
            status: "Vulnerable",
            length: 54,
            weight: 4.0,
            year: 1930
        ),
        Taxon(
            name: "Bahamas raccoon",
            scientific: "Procyon maynardi",
            range: "Bahamas",
            status: "Vulnerable",
            length: 53,
            weight: 3.9,
            year: 1898
        ),
        Taxon(
            name: "Florida Keys raccoon",
            scientific: "Procyon lotor auspicatus",
            range: "Florida Keys, USA",
            status: "Near threatened",
            length: 51,
            weight: 3.6,
            year: 1912
        ),
        Taxon(
            name: "Hilton Head raccoon",
            scientific: "Procyon lotor litoreus",
            range: "South Carolina coast, USA",
            status: "Least concern",
            length: 59,
            weight: 6.1,
            year: 1936
        ),
        Taxon(
            name: "Pacific Northwest raccoon",
            scientific: "Procyon lotor pacificus",
            range: "Pacific Northwest, USA",
            status: "Least concern",
            length: 63,
            weight: 7.2,
            year: 1900
        ),
        Taxon(
            name: "Gulf Coast raccoon",
            scientific: "Procyon lotor megalodus",
            range: "Gulf of Mexico coast",
            status: "Least concern",
            length: 61,
            weight: 6.9,
            year: 1929
        ),
        Taxon(
            name: "Nicaraguan raccoon",
            scientific: "Procyon lotor dickeyi",
            range: "Central America",
            status: "Endangered",
            length: 57,
            weight: 5.0,
            year: 1914
        ),
    ]

    private static func escape(_ text: String) -> String {
        text.replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
    }

    /// Years covered by an ISO date property, used to bound date pickers to the data.
    static func years(of date: KeyPath<RaccoonFact, String>) -> ClosedRange<Int> {
        let years = all.compactMap { Int($0[keyPath: date].prefix(4)) }
        return (years.min() ?? 1900)...(years.max() ?? 2100)
    }

    /// 72 records: every taxon in six habitats.
    static let all: [RaccoonFact] = {
        var records: [RaccoonFact] = []
        for (taxonIndex, taxon) in taxa.enumerated() {
            for (habitatIndex, habitat) in habitats.enumerated() {
                let index = taxonIndex * habitats.count + habitatIndex
                let month = (index * 5) % 12 + 1
                let day = (index * 7) % 28 + 1
                let date = String(
                    format: "%04d-%02d-%02d",
                    taxon.year + habitatIndex,
                    month,
                    day
                )
                let weight =
                    ((taxon.weight + Double((index * 13) % 15) / 10 - 0.7) * 10)
                    .rounded() / 10
                let sentence =
                    "Illustrative sample for the \(habitat.lowercased()) habitat."
                records.append(
                    RaccoonFact(
                        id: index + 1,
                        name: "\(taxon.name) (\(habitat))",
                        range: taxon.range,
                        description:
                            "**Scientific name:** *\(taxon.scientific)*. \(sentence)",
                        description_html:
                            "<strong>Scientific name:</strong> <em>\(escape(taxon.scientific))</em>. \(escape(sentence))",
                        habitat: habitat,
                        body_length_cm: taxon.length + (index * 7) % 9 - 4,
                        weight_kg: weight,
                        first_described: date,
                        last_surveyed: String(format: "2025-%02d-01", index % 12 + 1),
                        nocturnal: index % 4 != 0,
                        status: taxon.status
                    )
                )
            }
        }
        return records
    }()
}
