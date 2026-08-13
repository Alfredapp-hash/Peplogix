import Foundation

struct SourceRecord: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var publisher: String
    var publicationDate: Date?
    var urlString: String
    var doi: String?
    var pmid: String?
    var license: String?
    var attributionRequired: Bool
    var retrievedAt: Date

    init(
        id: UUID = UUID(),
        title: String,
        publisher: String,
        publicationDate: Date? = nil,
        urlString: String,
        doi: String? = nil,
        pmid: String? = nil,
        license: String? = nil,
        attributionRequired: Bool = false,
        retrievedAt: Date = .now
    ) {
        self.id = id
        self.title = title
        self.publisher = publisher
        self.publicationDate = publicationDate
        self.urlString = urlString
        self.doi = doi
        self.pmid = pmid
        self.license = license
        self.attributionRequired = attributionRequired
        self.retrievedAt = retrievedAt
    }
}
