import Foundation
import SwiftData

@Model
final class LibraryRecord {
    var id: UUID
    var slug: String
    var title: String
    var beginnerText: String
    var intermediateText: String
    var advancedText: String
    var updatedAt: Date

    init(
        id: UUID = UUID(),
        slug: String,
        title: String,
        beginnerText: String,
        intermediateText: String,
        advancedText: String,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.slug = slug
        self.title = title
        self.beginnerText = beginnerText
        self.intermediateText = intermediateText
        self.advancedText = advancedText
        self.updatedAt = updatedAt
    }
}
