import Foundation

/// Configuration data for a `<source>` element within a `<picture>` tag.
public struct ImageSourcesData: Sendable, Equatable {

    /// Optional MIME type of the resource (e.g. `"image/avif"` or `"image/webp"`).
    public let type: String?
    /// Optional media query string (e.g. `"(min-width: 768px)"`).
    public let media: String?
    /// Comma-separated list of image candidate URLs with width or pixel density descriptors.
    public let srcSet: String
    /// Optional CSS sizes list describing the rendered width of the image.
    public let sizes: String?

    /// Creates a new configuration instance for `ImageSourcesData`.
    ///
    /// - Parameters:
    ///   - type: Optional MIME type of the resource (e.g. `"image/avif"` or `"image/webp"`).
    ///   - media: Optional media query string (e.g. `"(min-width: 768px)"`).
    ///   - srcSet: Comma-separated list of image candidate URLs with width or pixel density descriptors.
    ///   - sizes: Optional CSS sizes list describing the rendered width of the image.
    public init(
        type: String? = nil,
        media: String? = nil,
        srcSet: String,
        sizes: String? = nil
    ) {
        self.type = type
        self.media = media
        self.srcSet = srcSet
        self.sizes = sizes
    }
}

extension ImageSourcesData {

    /// Generates standard AVIF and WebP sources for processed S3 blog images.
    ///
    /// Generates `<source>` entries for `image/avif` (first, for optimal compression)
    /// and `image/webp` (second, for broad modern browser support), matching the Lambda S3 convention:
    /// `{baseUrl}{folder}/{imageId}-{width}w.{format}`
    ///
    /// - Parameters:
    ///   - baseUrl: Base AWS public URL.
    ///   - folder: S3 subpath/prefix where processed images reside (defaults to `"processed/blog"`).
    ///   - imageId: UUID or identifier string for the image.
    ///   - widths: Array of widths in pixels (defaults to `[576, 768, 1280, 2560]`).
    ///   - sizes: CSS sizes descriptor for responsive layout (defaults to `"(min-width: 1280px) 1280px, (min-width: 768px) 768px, 100vw"`).
    /// - Returns: An array containing AVIF and WebP `ImageSourcesData` configurations, or empty if `imageId` is empty.
    public static func s3BlogSources(
        baseUrl: String,
        folder: String = "processed/blog",
        imageId: String,
        widths: [Int] = [576, 768, 1280, 2560],
        sizes: String? =
            "100vw"
    ) -> [ImageSourcesData] {
        let trimmedId = imageId.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedId.isEmpty else { return [] }

        let normalizedBase = baseUrl.hasSuffix("/") ? baseUrl : "\(baseUrl)/"
        let trimmedFolder = folder.trimmingCharacters(
            in: CharacterSet(charactersIn: "/")
        )
        let prefix = trimmedFolder.isEmpty ? "" : "\(trimmedFolder)/"
        let basePath = "\(normalizedBase)\(prefix)\(trimmedId)"

        let avifSrcset = widths.map { "\(basePath)-\($0)w.avif \($0)w" }
            .joined(
                separator: ", "
            )
        let webpSrcset = widths.map { "\(basePath)-\($0)w.webp \($0)w" }
            .joined(
                separator: ", "
            )

        return [
            ImageSourcesData(
                type: "image/avif",
                srcSet: avifSrcset,
                sizes: sizes
            ),
            ImageSourcesData(
                type: "image/webp",
                srcSet: webpSrcset,
                sizes: sizes
            ),
        ]
    }

    /// Automatically derives AVIF and WebP sources from a blog image link matching the S3 structure:
    /// `{host}/blog/{id}.{ext}` -> `{host}/processed/blog/{id}-{width}w.{format}`
    ///
    /// - Parameters:
    ///   - link: Original blog image link URL.
    ///   - widths: Array of widths in pixels (defaults to `[576, 768, 1280, 2560]`).
    ///   - sizes: CSS sizes descriptor for responsive layout (defaults to `"(min-width: 1280px) 1280px, (min-width: 768px) 768px, 100vw"`).
    /// - Returns: An array containing AVIF and WebP sources, or empty if not a blog image.
    public static func deriveFromBlogLink(
        _ link: String,
        widths: [Int] = [576, 768, 1280, 2560],
        sizes: String? =
            "100vw"
    ) -> [ImageSourcesData] {
        guard let blogRange = link.range(of: "/blog/") else {
            return []
        }

        // Avoid re-processing if already a processed URL
        guard !link.contains("/processed/") else {
            return []
        }

        let prefix = String(link[..<blogRange.lowerBound])
        let remaining = String(link[blogRange.upperBound...])

        let fileComponents =
            remaining.split(separator: "?", maxSplits: 1).first.map(String.init)
            ?? remaining
        let filenameWithExt =
            fileComponents.split(separator: "/").last.map(String.init)
            ?? fileComponents

        // Don't generate raster alternatives for SVG
        guard !filenameWithExt.lowercased().hasSuffix(".svg") else {
            return []
        }

        let parts = filenameWithExt.split(separator: ".")
        guard parts.count >= 2 else {
            return []
        }

        let imageId = parts.dropLast().joined(separator: ".")
        guard !imageId.isEmpty else {
            return []
        }

        return s3BlogSources(
            baseUrl: prefix,
            folder: "processed/blog",
            imageId: imageId,
            widths: widths,
            sizes: sizes
        )
    }
}
