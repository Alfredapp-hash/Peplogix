import Foundation
import SwiftData

@Model
final class LogEntry {
    var id: UUID
    var itemName: String
    var amount: Double
    var unit: String
    var site: String
    var timestamp: Date
    var notes: String

    init(
        id: UUID = UUID(),
        itemName: String,
        amount: Double,
        unit: String,
        site: String,
        timestamp: Date = .now,
        notes: String = ""
    ) {
        self.id = id
        self.itemName = itemName
        self.amount = amount
        self.unit = unit
        self.site = site
        self.timestamp = timestamp
        self.notes = notes
    }
}
