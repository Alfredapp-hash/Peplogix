import CoreSpotlight
import UniformTypeIdentifiers

struct LibrarySearchDocument: Sendable, Hashable {
    let id: String
    let title: String
    let summary: String
    let keywords: [String]
}

actor SpotlightLibraryIndex {
    private let index = CSSearchableIndex(name: "com.peplogix.library")

    func replaceAll(with documents: [LibrarySearchDocument]) async throws {
        try await index.deleteAllSearchableItems()
        let items = documents.map { document in
            let attributes = CSSearchableItemAttributeSet(contentType: .text)
            attributes.title = document.title
            attributes.displayName = document.title
            attributes.contentDescription = document.summary
            attributes.keywords = document.keywords
            return CSSearchableItem(
                uniqueIdentifier: document.id,
                domainIdentifier: "peplogix.library",
                attributeSet: attributes
            )
        }
        try await index.indexSearchableItems(items)
    }
}
