import Vapor

func routes(_ app: Application) throws {
    // Pure Raccoon core components and Home
    try app.register(collection: RaccoonPreviewController())

    // FormBuilder error summary with simulated server-side validation
    try app.register(collection: FormErrorSummaryController())
    try app.register(
        collection: FormErrorSummaryController(validationMethod: .submit)
    )

    // Mock/simulation endpoints (uploads, fake search)
    try app.register(collection: SimulationController())
}
