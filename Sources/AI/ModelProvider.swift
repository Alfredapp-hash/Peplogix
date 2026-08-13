import Foundation

protocol ModelProvider: Sendable {
    var name: String { get }
    var isAvailable: Bool { get async }
    func answer(question: String, context: [String]) async throws -> GroundedAnswer
}

struct DeterministicFallbackProvider: ModelProvider {
    let name = "Indexed Search"
    var isAvailable: Bool { get async { true } }

    func answer(question: String, context: [String]) async throws -> GroundedAnswer {
        guard !context.isEmpty else { return .insufficientEvidence }
        return GroundedAnswer(
            text: context.joined(separator: "\n\n"),
            citations: [],
            uncertaintyNotes: ["Generative model unavailable; showing retrieved context directly."],
            retrievalConfidence: 1
        )
    }
}
