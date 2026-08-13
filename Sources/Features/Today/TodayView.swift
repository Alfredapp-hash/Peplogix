import SwiftUI
import SwiftData

struct TodayView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \LogEntry.timestamp, order: .reverse) private var entries: [LogEntry]
    @State private var showingAdd = false

    var body: some View {
        NavigationStack {
            List {
                if entries.isEmpty {
                    ContentUnavailableView("No entries yet", systemImage: "checkmark.circle")
                } else {
                    ForEach(entries) { entry in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(entry.itemName).font(.headline)
                            Text("\(entry.amount, specifier: \"%g\") \(entry.unit) • \(entry.site)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text(entry.timestamp, style: .relative)
                                .font(.caption)
                                .foregroundStyle(.tertiary)
                        }
                    }
                    .onDelete { offsets in
                        for index in offsets { modelContext.delete(entries[index]) }
                    }
                }
            }
            .navigationTitle("Today")
            .toolbar {
                Button { showingAdd = true } label: { Label("Add", systemImage: "plus") }
            }
            .sheet(isPresented: $showingAdd) { AddLogEntryView() }
        }
    }
}

private struct AddLogEntryView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var itemName = ""
    @State private var amount = ""
    @State private var unit = ""
    @State private var site = ""
    @State private var notes = ""

    var body: some View {
        NavigationStack {
            Form {
                TextField("Item", text: $itemName)
                TextField("Quantity", text: $amount).keyboardType(.decimalPad)
                TextField("Unit", text: $unit)
                TextField("Location", text: $site)
                TextField("Notes", text: $notes, axis: .vertical)
            }
            .navigationTitle("New Entry")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        guard let parsed = Double(amount), !itemName.isEmpty else { return }
                        modelContext.insert(LogEntry(itemName: itemName, amount: parsed, unit: unit, site: site, notes: notes))
                        dismiss()
                    }
                }
            }
        }
    }
}
