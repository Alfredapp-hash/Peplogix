import Foundation

struct GroundedAnswer: Sendable, Equatable {
    struct Citation: Sendable, Equatable, Identifiable {
        let id: String
        let title: String
        let urlString: String
    }

    let text: String
    let citations: [Citation]
    let uncertaintyNotes: [String]
    let retrievalConfidence: Double

    static let insufficientEvidence = GroundedAnswer(
        text: "I don't have enough indexed evidence to answer that reliably.",
        citations: [],
        uncertaintyNotes: ["No sufficiently relevant indexed records were available."],
        retrievalConfidence: 0
    )
}
