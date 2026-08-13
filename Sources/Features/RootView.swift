import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            Text("Today")
                .tabItem { Label("Today", systemImage: "checkmark.circle") }
            Text("Library")
                .tabItem { Label("Library", systemImage: "books.vertical") }
            Text("Settings")
                .tabItem { Label("Settings", systemImage: "gearshape") }
        }
    }
}
