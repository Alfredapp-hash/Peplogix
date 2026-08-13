import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            TodayView()
                .tabItem { Label("Today", systemImage: "checkmark.circle") }
            LibraryView()
                .tabItem { Label("Library", systemImage: "books.vertical") }
            NavigationStack {
                List {
                    Section("Storage") {
                        Label("Local-first", systemImage: "lock.shield")
                    }
                }
                .navigationTitle("Settings")
            }
            .tabItem { Label("Settings", systemImage: "gearshape") }
        }
    }
}
