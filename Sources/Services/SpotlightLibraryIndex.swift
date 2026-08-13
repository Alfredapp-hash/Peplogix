import CoreSpotlight
import UniformTypeIdentifiers

struct LibrarySearchDocument: Sendable, Hashable {
    let id: String
    let title: String
    let summary: String
    let keywords: [String]
}

struct LibrarySearchHit: Sendable, Hashable, Identifiable {
    let id: String
    let title: String
    let summary: String
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

    func search(_ query: String, limit: Int = 6) async throws -> [LibrarySearchHit] {
        let context = CSSearchQueryContext()
        context.fetchAttributes = ["title", "contentDescription"]
        context.maxResultCount = limit

        let escaped = query.replacingOccurrences(of: "\"", with: "")
        let search = CSSearchQuery(queryString: "textContent == \"*\(escaped)*\"cd", queryContext: context)
        var hits: [LibrarySearchHit] = []

        for try await result in search.results {
            let item = result.item
            hits.append(
                LibrarySearchHit(
                    id: item.uniqueIdentifier,
                    title: item.attributeSet.title ?? item.attributeSet.displayName ?? "Untitled",
                    summary: item.attributeSet.contentDescription ?? ""
                )
            )
        }

        return hits
    }
}
