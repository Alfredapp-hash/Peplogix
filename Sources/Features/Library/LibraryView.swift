import SwiftUI
import SwiftData

struct LibraryView: View {
    @Query(sort: \LibraryRecord.title) private var records: [LibraryRecord]
    @State private var query = ""

    private var filtered: [LibraryRecord] {
        guard !query.isEmpty else { return records }
        return records.filter { $0.title.localizedCaseInsensitiveContains(query) }
    }

    var body: some View {
        NavigationStack {
            List(filtered) { record in
                NavigationLink(record.title) {
                    LibraryDetailView(record: record)
                }
            }
            .overlay {
                if records.isEmpty {
                    ContentUnavailableView("Library is empty", systemImage: "books.vertical")
                }
            }
            .navigationTitle("Library")
            .searchable(text: $query)
        }
    }
}

private struct LibraryDetailView: View {
    let record: LibraryRecord
    @State private var level = 0

    private var text: String {
        switch level {
        case 1: return record.intermediateText
        case 2: return record.advancedText
        default: return record.beginnerText
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Picker("Depth", selection: $level) {
                    Text("Basic").tag(0)
                    Text("Detail").tag(1)
                    Text("Reference").tag(2)
                }
                .pickerStyle(.segmented)
                Text(text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textSelection(.enabled)
            }
            .padding()
        }
        .navigationTitle(record.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
