import Foundation
#if canImport(FoundationModels)
import FoundationModels

struct AppleFoundationModelProvider: ModelProvider {
    let name = "Apple Foundation Models"

    var isAvailable: Bool {
        get async {
            if case .available = SystemLanguageModel.default.availability {
                return true
            }
            return false
        }
    }

    func answer(question: String, context: [String]) async throws -> GroundedAnswer {
        guard await isAvailable else { return .insufficientEvidence }
        guard !context.isEmpty else { return .insufficientEvidence }

        let instructions = """
        Answer only from the supplied context. If the context does not support an answer, say that the indexed library does not contain enough evidence. Do not invent sources or facts.
        """
        let session = LanguageModelSession(instructions: instructions)
        let joinedContext = context.joined(separator: "\n\n---\n\n")
        let prompt = """
        Question: \(question)

        Indexed context:
        \(joinedContext)
        """
        let response = try await session.respond(to: prompt)

        return GroundedAnswer(
            text: response.content,
            citations: [],
            uncertaintyNotes: [],
            retrievalConfidence: 1
        )
    }
}
#endif
