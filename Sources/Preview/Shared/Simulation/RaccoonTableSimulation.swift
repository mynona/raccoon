import Foundation
import Vapor

/// Backend simulation for the DataTable preview: sorts, filters and paginates `RaccoonFacts`
/// from query parameters, answers after half a second so the loading state is visible,
/// and fails with `?fail=1`.
extension SimulationController {

    struct RaccoonPage: Content {
        let items: [RaccoonFact]
        let total: Int
        let page: Int
        let per: Int
    }

    private struct FilterCondition {
        let key: String
        let op: String
        let value: String
    }

    @Sendable
    static func raccoons(_ req: Request) async throws -> Response {
        try await Task.sleep(for: .milliseconds(500))

        let items = queryItems(of: req)
        func value(_ name: String) -> String? {
            items.first { $0.name == name }?.value
        }

        if value("fail") == "1" {
            throw Abort(.internalServerError, reason: "Simulated data error")
        }

        let conditions = items.compactMap { item -> FilterCondition? in
            guard item.name.hasPrefix("filter["),
                let match = item.name.wholeMatch(
                    of: /filter\[(.+?)\]\[(.+?)\]/
                ),
                let itemValue = item.value
            else { return nil }
            return FilterCondition(
                key: String(match.1),
                op: String(match.2),
                value: itemValue
            )
        }
        let matchesAny = value("filterMode") == "or"

        var records = RaccoonFacts.all
        if let term = value("q")?.lowercased(), !term.isEmpty {
            records = records.filter {
                $0.name.lowercased().contains(term)
                    || $0.range.lowercased().contains(term)
            }
        }
        if !conditions.isEmpty {
            records = records.filter { record in
                let results = conditions.map { matches(record, $0) }
                return matchesAny
                    ? results.contains(true) : !results.contains(false)
            }
        }

        let sort = (value("sort") ?? "").split(separator: ":").map(String.init)
        if sort.count == 2 {
            let ascending = sort[1] != "desc"
            records.sort { lhs, rhs in
                let order = compare(lhs, rhs, key: sort[0])
                return order == .orderedSame
                    ? lhs.id < rhs.id
                    : (order == .orderedAscending) == ascending
            }
        }

        let per = min(max(Int(value("per") ?? "") ?? 20, 1), 100)
        let page = max(Int(value("page") ?? "") ?? 1, 1)
        let start = min((page - 1) * per, records.count)
        let slice = Array(records[start..<min(start + per, records.count)])

        let response = Response(status: .ok)
        try response.content.encode(
            RaccoonPage(
                items: slice,
                total: records.count,
                page: page,
                per: per
            ),
            as: .json
        )
        return response
    }

    // Browser URLSearchParams encodes spaces as "+", which URLComponents keeps literally
    private static func queryItems(of req: Request) -> [URLQueryItem] {
        let raw = (req.url.query ?? "")
            .replacingOccurrences(of: "+", with: "%20")
        return URLComponents(string: "?" + raw)?.queryItems ?? []
    }

    private static func matches(
        _ record: RaccoonFact,
        _ condition: FilterCondition
    ) -> Bool {
        switch condition.key {
        case "name":
            return record.name.localizedCaseInsensitiveContains(condition.value)
        case "range":
            return record.range.localizedCaseInsensitiveContains(
                condition.value
            )
        case "habitat": return record.habitat == condition.value
        case "status": return record.status == condition.value
        case "nocturnal": return record.nocturnal == (condition.value == "true")
        case "body_length_cm":
            guard let number = Int(condition.value) else { return true }
            return compare(record.body_length_cm, number, condition.op)
        case "weight_kg":
            guard let number = Double(condition.value) else { return true }
            return compare(record.weight_kg, number, condition.op)
        case "last_surveyed":
            return compare(record.last_surveyed, condition.value, condition.op)
        case "first_described":
            if condition.op == "between" {
                let bounds = condition.value.split(
                    separator: ",",
                    omittingEmptySubsequences: false
                )
                guard bounds.count == 2 else { return true }
                return record.first_described >= bounds[0]
                    && record.first_described <= bounds[1]
            }
            return compare(
                record.first_described,
                condition.value,
                condition.op
            )
        default: return true
        }
    }

    private static func compare<T: Comparable>(_ lhs: T, _ rhs: T, _ op: String)
        -> Bool
    {
        switch op {
        case "gt": lhs > rhs
        case "gte": lhs >= rhs
        case "lt": lhs < rhs
        case "lte": lhs <= rhs
        case "neq": lhs != rhs
        default: lhs == rhs
        }
    }

    private static func compare(
        _ lhs: RaccoonFact,
        _ rhs: RaccoonFact,
        key: String
    ) -> ComparisonResult {
        func order<T: Comparable>(_ a: T, _ b: T) -> ComparisonResult {
            a == b
                ? .orderedSame
                : (a < b ? .orderedAscending : .orderedDescending)
        }
        switch key {
        case "name": return order(lhs.name, rhs.name)
        case "range": return order(lhs.range, rhs.range)
        case "habitat": return order(lhs.habitat, rhs.habitat)
        case "body_length_cm":
            return order(lhs.body_length_cm, rhs.body_length_cm)
        case "weight_kg": return order(lhs.weight_kg, rhs.weight_kg)
        case "first_described":
            return order(lhs.first_described, rhs.first_described)
        case "nocturnal":
            return order(lhs.nocturnal ? 1 : 0, rhs.nocturnal ? 1 : 0)
        case "status":
            return order(
                RaccoonFacts.statuses.firstIndex(of: lhs.status) ?? 0,
                RaccoonFacts.statuses.firstIndex(of: rhs.status) ?? 0
            )
        default: return .orderedSame
        }
    }
}
