import Vapor

struct SimulationController: RouteCollection, Sendable {

    public init() {}

    public func boot(routes: RoutesBuilder) throws {
        // simulate 200 success response
        routes.get("success") { @Sendable (_ req: Request) async throws -> Response in
            try await Self.success(req)
        }
        routes.post("success") { @Sendable (_ req: Request) async throws -> Response in
            try await Self.success(req)
        }

        // simulate search endpoint returning fake results
        routes.get("search") { @Sendable (_ req: Request) async throws -> Response in
            try await Self.simulateSearch(req)
        }
        routes.post("search") { @Sendable (_ req: Request) async throws -> Response in
            try await Self.simulateSearch(req)
        }

        // fake upload endpoint to verify single and multiple file uploads
        routes.post("upload") { @Sendable (_ req: Request) async throws -> Response in
            try await Self.fakeUpload(req)
        }
        routes.post("upload", "single") { @Sendable (_ req: Request) async throws -> Response in
            try await Self.fakeSingleUpload(req)
        }
        routes.post("upload", "multiple") { @Sendable (_ req: Request) async throws -> Response in
            try await Self.fakeMultipleUpload(req)
        }
        routes.post("api", "upload") { @Sendable (_ req: Request) async throws -> Response in
            try await Self.fakeUpload(req)
        }
    }

    @Sendable
    static func success(_ req: Request) async throws -> Response {
        Response(
            status: .ok,
            headers: ["Content-Type": "text/plain; charset=utf-8"],
            body: .init(string: "Success")
        )
    }

    @Sendable
    static func simulateSearch(_ req: Request) async throws -> Response {
        let query =
            req.query[String.self, at: "q"]?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? ""

        if query.lowercased() == "error" {
            throw Abort(
                .internalServerError,
                reason: "Simulated search server error"
            )
        }

        let fakeData = DemoData.fakeSearchResults(for: query)
        let response = Response(status: .ok)
        try response.content.encode(fakeData, as: .json)
        return response
    }

    struct UploadedFileInfo: Codable {
        let fieldName: String
        let filename: String
        let sizeInBytes: Int
        let contentType: String?
    }

    struct UploadResult: Codable {
        let status: String
        let alt_text: String?
        let message: String
        let files: [UploadedFileInfo]
    }

    struct SingleUploadDto: Codable {
        let alt_text: String?
        let image: File?

        init(alt_text: String? = nil, image: File? = nil) {
            self.alt_text = alt_text
            self.image = image
        }
    }

    struct MultipleUploadDto: Codable {
        let alt_text: String?
        let files: [File]?

        enum CodingKeys: String, CodingKey {
            case alt_text
            case files
            case filesArray = "files[]"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.alt_text = try container.decodeIfPresent(
                String.self,
                forKey: .alt_text
            )
            if let f = try container.decodeIfPresent(
                [File].self,
                forKey: .files
            ) {
                self.files = f
            }
            else if let f = try container.decodeIfPresent(
                [File].self,
                forKey: .filesArray
            ) {
                self.files = f
            }
            else if let single = try container.decodeIfPresent(
                File.self,
                forKey: .files
            ) {
                self.files = [single]
            }
            else if let single = try container.decodeIfPresent(
                File.self,
                forKey: .filesArray
            ) {
                self.files = [single]
            }
            else {
                self.files = nil
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(alt_text, forKey: .alt_text)
            try container.encodeIfPresent(files, forKey: .files)
        }
    }

    @Sendable
    static func fakeSingleUpload(_ req: Request) async throws -> Response {
        let dto = try req.content.decode(SingleUploadDto.self)
        var files: [UploadedFileInfo] = []
        if let image = dto.image {
            files.append(
                UploadedFileInfo(
                    fieldName: "image",
                    filename: image.filename,
                    sizeInBytes: image.data.readableBytes,
                    contentType: image.contentType?.description
                )
            )
        }

        let result = UploadResult(
            status: "success",
            alt_text: dto.alt_text,
            message: "Single file upload received successfully.",
            files: files
        )

        let response = Response(status: .ok)
        try response.content.encode(result, as: .json)
        return response
    }

    @Sendable
    static func fakeMultipleUpload(_ req: Request) async throws -> Response {
        let dto = try req.content.decode(MultipleUploadDto.self)
        var files: [UploadedFileInfo] = []
        if let fileList = dto.files {
            for file in fileList {
                files.append(
                    UploadedFileInfo(
                        fieldName: "files",
                        filename: file.filename,
                        sizeInBytes: file.data.readableBytes,
                        contentType: file.contentType?.description
                    )
                )
            }
        }

        let result = UploadResult(
            status: "success",
            alt_text: dto.alt_text,
            message:
                "Multiple file upload received successfully (\(files.count) file(s)).",
            files: files
        )

        let response = Response(status: .ok)
        try response.content.encode(result, as: .json)
        return response
    }

    @Sendable
    static func fakeUpload(_ req: Request) async throws -> Response {
        var uploadedFiles: [UploadedFileInfo] = []

        // Extract files from multipart form
        if let multipart = try? req.content.decode([String: File].self) {
            for (key, file) in multipart {
                uploadedFiles.append(
                    UploadedFileInfo(
                        fieldName: key,
                        filename: file.filename,
                        sizeInBytes: file.data.readableBytes,
                        contentType: file.contentType?.description
                    )
                )
            }
        }

        // Also handle array of files if field was e.g. "files[]" or multi
        if let multipartArrays = try? req.content.decode([String: [File]].self)
        {
            for (key, files) in multipartArrays {
                for file in files {
                    uploadedFiles.append(
                        UploadedFileInfo(
                            fieldName: key,
                            filename: file.filename,
                            sizeInBytes: file.data.readableBytes,
                            contentType: file.contentType?.description
                        )
                    )
                }
            }
        }

        let altText = try? req.content.get(String.self, at: "alt_text")

        let result = UploadResult(
            status: "success",
            alt_text: altText,
            message: "Successfully received \(uploadedFiles.count) file(s)",
            files: uploadedFiles
        )

        let response = Response(status: .ok)
        try response.content.encode(result, as: .json)
        return response
    }
}
