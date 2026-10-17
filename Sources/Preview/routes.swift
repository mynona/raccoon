import Vapor

func routes(_ app: Application) throws {
    // Pure Raccoon core components and Home
    try app.register(collection: RaccoonPreviewController())

    // Mock/simulation endpoints (uploads, fake search)
    try app.register(collection: SimulationController())
}
