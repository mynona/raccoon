import Foundation
import Raccoon
import Vapor

/// Handles single and multiple file uploads for the component preview.
///
/// Simulates server-side receipt of uploads and displays feedback on screen
/// via `Toast` notifications in Alpine.js upon redirect.
public struct FileUploadController: RouteCollection, Sendable {

    public init() {}

    public func boot(routes: RoutesBuilder) throws {
        let preview = routes.grouped("preview")
        preview.get("file-upload", use: getSingle)
        preview.post("file-upload", use: postSingle)
        preview.get("multiple-file-upload", use: getMultiple)
        preview.post("multiple-file-upload", use: postMultiple)
    }

    @Sendable
    func getSingle(_ request: Request) async throws -> Response {
        var toasts: [ToastItemData] = []
        if let success = request.query[String.self, at: "success"], success == "1" {
            let filename = request.query[String.self, at: "filename"] ?? "File"
            toasts.append(
                ToastItemData(
                    type: .success,
                    title: LocalizedText("preview.upload.success.title", "Upload Successful"),
                    text: LocalizedText(
                        "preview.upload.single.success.text",
                        "Single file upload received successfully: \(filename)"
                    )
                )
            )
        } else if let error = request.query[String.self, at: "error"] {
            let errorText: String = switch error {
            case "no_file": "Please select an image to upload."
            case "too_large": "The file exceeds the 4MB limit."
            default: "An error occurred during upload."
            }
            toasts.append(
                ToastItemData(
                    type: .error,
                    title: LocalizedText("preview.upload.error.title", "Upload Failed"),
                    text: LocalizedText(verbatim: errorText)
                )
            )
        }
        return request.templates.renderHtml(FileUploadView(toasts: toasts))
    }

    @Sendable
    func postSingle(_ request: Request) async throws -> Response {
        do {
            let dto = try request.content.decode(SimulationController.SingleUploadDto.self)
            guard let image = dto.image, image.data.readableBytes > 0 else {
                return request.redirect(to: "/preview/file-upload?error=no_file")
            }

            let files = [
                SimulationController.UploadedFileInfo(
                    fieldName: "image",
                    filename: image.filename,
                    sizeInBytes: image.data.readableBytes,
                    contentType: image.contentType?.description
                )
            ]
            await SimulationController.UploadStore.shared.add(
                SimulationController.ReceivedUpload(
                    route: "/preview/file-upload",
                    fields: dto.alt_text.map { ["alt_text": $0] } ?? [:],
                    files: files,
                    receivedAt: Date()
                )
            )

            let filename = image.filename.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? image.filename
            return request.redirect(to: "/preview/file-upload?success=1&filename=\(filename)")
        } catch {
            return request.redirect(to: "/preview/file-upload?error=failed")
        }
    }

    @Sendable
    func getMultiple(_ request: Request) async throws -> Response {
        var toasts: [ToastItemData] = []
        if let success = request.query[String.self, at: "success"], success == "1" {
            let count = request.query[Int.self, at: "count"] ?? 1
            toasts.append(
                ToastItemData(
                    type: .success,
                    title: LocalizedText("preview.upload.success.title", "Upload Successful"),
                    text: LocalizedText(
                        "preview.upload.multiple.success.text",
                        "Multiple file upload received successfully (\(count) file(s))."
                    )
                )
            )
        } else if let error = request.query[String.self, at: "error"] {
            let errorText: String = switch error {
            case "no_file": "Please select at least one file to upload."
            case "too_large": "The uploaded files exceed the 4MB limit."
            default: "An error occurred during upload."
            }
            toasts.append(
                ToastItemData(
                    type: .error,
                    title: LocalizedText("preview.upload.error.title", "Upload Failed"),
                    text: LocalizedText(verbatim: errorText)
                )
            )
        }
        return request.templates.renderHtml(MultipleFileUploadView(toasts: toasts))
    }

    @Sendable
    func postMultiple(_ request: Request) async throws -> Response {
        do {
            let dto = try request.content.decode(SimulationController.MultipleUploadDto.self)
            guard let files = dto.files, !files.isEmpty, files.contains(where: { $0.data.readableBytes > 0 }) else {
                return request.redirect(to: "/preview/multiple-file-upload?error=no_file")
            }

            let uploadedFiles = files.filter { $0.data.readableBytes > 0 }.map { file in
                SimulationController.UploadedFileInfo(
                    fieldName: "files",
                    filename: file.filename,
                    sizeInBytes: file.data.readableBytes,
                    contentType: file.contentType?.description
                )
            }

            await SimulationController.UploadStore.shared.add(
                SimulationController.ReceivedUpload(
                    route: "/preview/multiple-file-upload",
                    fields: dto.alt_text.map { ["alt_text": $0] } ?? [:],
                    files: uploadedFiles,
                    receivedAt: Date()
                )
            )

            return request.redirect(to: "/preview/multiple-file-upload?success=1&count=\(uploadedFiles.count)")
        } catch {
            return request.redirect(to: "/preview/multiple-file-upload?error=failed")
        }
    }
}
