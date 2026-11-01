import Foundation

public struct PreviewVariant<T: Sendable>: Sendable {
    public let label: String
    public let code: String
    public let data: T

    public init(label: String, code: String, data: T) {
        self.label = label
        self.code = code
        self.data = data
    }
}

@freestanding(expression)
public macro previewVariant<T>(
    _ label: String,
    _ value: T
) -> PreviewVariant<T> =
    #externalMacro(
        module: "PreviewMacros",
        type: "PreviewVariantMacro"
    )

@freestanding(expression)
public macro previewCode<T>(
    _ value: T
) -> (code: String, data: T) =
    #externalMacro(
        module: "PreviewMacros",
        type: "PreviewCodeMacro"
    )
