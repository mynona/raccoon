import Foundation

/// Deterministic identifier generation, used as a safe replacement for `Int.random`
/// when a component needs a fallback id but no explicit one was provided.
///
/// `String.hashValue` is randomized per process launch in Swift, so it cannot be used
/// here either; this uses a fixed FNV-1a hash to stay stable across renders and restarts.
///
/// ## Generated ids are an implementation detail
///
/// Ids produced by ``unique(_:)`` are opaque and **not stable across renders**. They exist only
/// so a component can wire up its own internal `aria-*` and Alpine references. Do not target them
/// from external CSS/JS, use them as anchor targets, or persist them. If you need a stable id,
/// pass one explicitly to the component's `*Data` type.
public enum StableIdentifier {
    public static func hash(_ seed: String) -> Int {
        var hash: UInt64 = 14_695_981_039_346_656_037
        for byte in seed.utf8 {
            hash ^= UInt64(byte)
            hash = hash &* 1_099_511_628_211
        }
        return Int(hash % 1_000_000_000)
    }

    /// Collision-free fallback id for components rendered without an explicit id.
    ///
    /// The `hash(seed)` prefix keeps the id recognisable while debugging; the random suffix
    /// guarantees uniqueness even when two instances have identical content. 8 hex characters
    /// keep the birthday-collision probability below 1e-6 for a page full of identical components.
    public static func unique(_ seed: String) -> String {
        "\(hash(seed))-\(UUID().uuidString.prefix(8).lowercased())"
    }
}
