import Vapor

func routes(_ app: Application) throws {
    // Pure Raccoon core components and Home
    try app.register(collection: RaccoonPreviewController())

    // File upload simulation and preview handling
    try app.register(collection: FileUploadController())

    // FormBuilder error summary with simulated server-side validation
    try app.register(collection: FormErrorSummaryController())
    try app.register(
        collection: FormErrorSummaryController(validationMethod: .submit)
    )

    // Rating widget feedback endpoint (collects what the widget sends)
    try app.register(collection: RatingFeedbackController())

    // Mock/simulation endpoints (uploads, fake search)
    try app.register(collection: SimulationController())
}
