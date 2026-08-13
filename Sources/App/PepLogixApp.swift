import SwiftUI
import SwiftData

@main
struct PepLogixApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [LogEntry.self, LibraryRecord.self])
    }
}
